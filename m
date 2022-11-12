Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20315626734
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 06:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiKLFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 00:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLFlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 00:41:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B25B5B9;
        Fri, 11 Nov 2022 21:41:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50C58B828AD;
        Sat, 12 Nov 2022 05:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD44C433D6;
        Sat, 12 Nov 2022 05:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668231668;
        bh=h5v5hN9bTBwVsyIV+aYUcCjEowuSsRchhaboUL7kJ14=;
        h=From:To:Cc:Subject:Date:From;
        b=rr8H0yKFVtlPtqvDoEpveRSVQnF4aBh2sd1MG1GIGa51MMEj8d+HQusslaVzpisjB
         Lux2qPQ8vloiIxGWmR6muh565u6I+tpZr+94VaqEsmf61BPashuRFvDBUd5g5fXOiH
         GI67VwHs60c/w6qmHHioppd4f8VJErV7SdVqjvVdlpnXstmuRJtFSYnVv8EtKZb80i
         LSxxqM9Tlvaq6OYO8zITVOnEipskvmlE+fTCMcw7t1st8tTdpNWTZ6HTOFalv3YDh9
         3RqfRfj4oaS+pU0BWWK8W/buNkwDIkZOjtzJwdyKbIMM5iNa1h5aHpQXNhUQDx+xue
         NgAf6tadiCQbA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [PATCH] tracing/eprobe: Fix eprobe filter to make a filter correctly
Date:   Sat, 12 Nov 2022 14:41:04 +0900
Message-Id: <166823166395.1385292.8931770640212414483.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index fe4833a7b7b3..1c3096ab2fe7 100644
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

