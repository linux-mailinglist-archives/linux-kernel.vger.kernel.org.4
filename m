Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC4631647
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKTUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKTUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA04B6E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D9160D2B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E67C4314B;
        Sun, 20 Nov 2022 20:12:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqfu-00DiZ1-2v;
        Sun, 20 Nov 2022 15:12:22 -0500
Message-ID: <20221120201222.773967768@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:12:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>
Subject: [for-linus][PATCH 7/7] tracing/eprobe: Fix eprobe filter to make a filter correctly
References: <20221120201156.868430827@goodmis.org>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the eprobe filter was defined based on the eprobe's trace event
itself, it doesn't work correctly. Use the original trace event of
the eprobe when making the filter so that the filter works correctly.

Without this fix:

 # echo 'e syscalls/sys_enter_openat \
	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
 # echo 1 > events/eprobes/sys_enter_openat/enable
[  114.551550] event trace: Could not enable event sys_enter_openat
-bash: echo: write error: Invalid argument

With this fix:
 # echo 'e syscalls/sys_enter_openat \
	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
 # echo 1 > events/eprobes/sys_enter_openat/enable
 # tail trace
cat-241     [000] ...1.   266.498449: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
cat-242     [000] ...1.   266.977640: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0

Link: https://lore.kernel.org/all/166823166395.1385292.8931770640212414483.stgit@devnote3/

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Tested-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index e888446d80fa..123d2c0a6b68 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -643,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 	INIT_LIST_HEAD(&trigger->list);
 
 	if (ep->filter_str) {
-		ret = create_event_filter(file->tr, file->event_call,
+		ret = create_event_filter(file->tr, ep->event,
 					ep->filter_str, false, &filter);
 		if (ret)
 			goto error;
-- 
2.35.1


