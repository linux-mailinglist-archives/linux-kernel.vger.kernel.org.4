Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360636CF37E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjC2TqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC2Tpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240CA2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9BA61E21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B0C43442;
        Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjy-002Ri3-1x;
        Wed, 29 Mar 2023 15:45:50 -0400
Message-ID: <20230329194550.418276586@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 07/25] docs: tracing: Update fprobe documentation
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Update fprobe.rst for
 - the private entry_data argument
 - the return value of the entry handler
 - the nr_rethook_node field.

Link: https://lkml.kernel.org/r/167526701579.433354.3057889264263546659.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/fprobe.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index b64bec1ce144..40dd2fbce861 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -87,14 +87,16 @@ returns as same as unregister_ftrace_function().
 The fprobe entry/exit handler
 =============================
 
-The prototype of the entry/exit callback function is as follows:
+The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- void callback_func(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
 
-Note that both entry and exit callbacks have same ptototype. The @entry_ip is
-saved at function entry and passed to exit handler.
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+
+Note that the @entry_ip is saved at function entry and passed to exit handler.
+If the entry callback function returns !0, the corresponding exit callback will be cancelled.
 
 @fp
         This is the address of `fprobe` data structure related to this handler.
@@ -113,6 +115,12 @@ saved at function entry and passed to exit handler.
         to use @entry_ip. On the other hand, in the exit_handler, the instruction
         pointer of @regs is set to the currect return address.
 
+@entry_data
+        This is a local storage to share the data between entry and exit handlers.
+        This storage is NULL by default. If the user specify `exit_handler` field
+        and `entry_data_size` field when registering the fprobe, the storage is
+        allocated and passed to both `entry_handler` and `exit_handler`.
+
 Share the callbacks with kprobes
 ================================
 
-- 
2.39.1
