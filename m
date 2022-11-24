Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE0637BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKXOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:48:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B958D906B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BCCB82839
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB67CC4347C;
        Thu, 24 Nov 2022 14:48:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDWZ-001WrT-2p;
        Thu, 24 Nov 2022 09:48:23 -0500
Message-ID: <20221124144823.750570677@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:47:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 2/6] tracing/user_events: Fix memory leak in user_event_create()
References: <20221124144752.427194398@goodmis.org>
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

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Before current_user_event_group(), it has allocated memory and save it
in @name, this should freed before return error.

Link: https://lkml.kernel.org/r/20221115014445.158419-1-xiujianfeng@huawei.com

Fixes: e5d271812e7a ("tracing/user_events: Move pages/locks into groups to prepare for namespaces")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..539b08ae7020 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1100,8 +1100,10 @@ static int user_event_create(const char *raw_command)
 
 	group = current_user_event_group();
 
-	if (!group)
+	if (!group) {
+		kfree(name);
 		return -ENOENT;
+	}
 
 	mutex_lock(&group->reg_mutex);
 
-- 
2.35.1


