Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3675637BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKXOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiKXOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C604134F26
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11F13B8284A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251CC43146;
        Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X5z-2F;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145046.573437905@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuang Wang <nashuiliang@gmail.com>
Subject: [for-next][PATCH 08/11] tracing/perf: Use strndup_user instead of kzalloc/strncpy_from_user
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuang Wang <nashuiliang@gmail.com>

This patch uses strndup_user instead of kzalloc + strncpy_from_user,
which makes the code more concise.

Link: https://lkml.kernel.org/r/20221121080831.707409-1-nashuiliang@gmail.com

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_perf.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 61e3a2620fa3..05e791241812 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -251,16 +251,12 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 	struct trace_event_call *tp_event;
 
 	if (p_event->attr.kprobe_func) {
-		func = kzalloc(KSYM_NAME_LEN, GFP_KERNEL);
-		if (!func)
-			return -ENOMEM;
-		ret = strncpy_from_user(
-			func, u64_to_user_ptr(p_event->attr.kprobe_func),
-			KSYM_NAME_LEN);
-		if (ret == KSYM_NAME_LEN)
-			ret = -E2BIG;
-		if (ret < 0)
-			goto out;
+		func = strndup_user(u64_to_user_ptr(p_event->attr.kprobe_func),
+				    KSYM_NAME_LEN);
+		if (IS_ERR(func)) {
+			ret = PTR_ERR(func);
+			return (ret == -EINVAL) ? -E2BIG : ret;
+		}
 
 		if (func[0] == '\0') {
 			kfree(func);
-- 
2.35.1


