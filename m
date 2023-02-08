Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7168E5B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBHB6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBHB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4E3EFF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A57B81BA0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34269C433A8;
        Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiF-006dOA-0l;
        Tue, 07 Feb 2023 20:57:31 -0500
Message-ID: <20230208015731.055452222@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Shuai <suagrfillet@gmail.com>
Subject: [for-next][PATCH 04/11] samples: ftrace: Include the nospec-branch.h only for x86
References: <20230208015633.791198913@goodmis.org>
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

From: Song Shuai <suagrfillet@gmail.com>

When other architectures without the nospec functionality write their
direct-call functions of samples/ftrace/*.c, the including of
asm/nospec-branch.h must be taken care to fix the no header file found
error in building process.

This commit (ee3e2469b346 "x86/ftrace: Make it call depth tracking aware")
file-globally includes asm/nospec-branch.h providing CALL_DEPTH_ACCOUNT
for only x86 direct-call functions.

It seems better to move the including to `#ifdef CONFIG_X86_64`.

Link: https://lore.kernel.org/linux-trace-kernel/20230130085954.647845-1-suagrfillet@gmail.com

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-modify.c       | 2 +-
 samples/ftrace/ftrace-direct-multi-modify.c | 2 +-
 samples/ftrace/ftrace-direct-multi.c        | 2 +-
 samples/ftrace/ftrace-direct-too.c          | 2 +-
 samples/ftrace/ftrace-direct.c              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index de5a0f67f320..d93abbcb1f4c 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -3,7 +3,6 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(void);
 extern void my_direct_func2(void);
@@ -26,6 +25,7 @@ static unsigned long my_ip = (unsigned long)schedule;
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
+#include <asm/nospec-branch.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index a825dbd2c9cf..b58c594efb51 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -3,7 +3,6 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(unsigned long ip);
 extern void my_direct_func2(unsigned long ip);
@@ -24,6 +23,7 @@ extern void my_tramp2(void *);
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
+#include <asm/nospec-branch.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index d955a2650605..c27cf130c319 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -5,7 +5,6 @@
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 #include <asm/asm-offsets.h>
-#include <asm/nospec-branch.h>
 
 extern void my_direct_func(unsigned long ip);
 
@@ -19,6 +18,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
+#include <asm/nospec-branch.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e13fb59a2b47..8139dce2a31c 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -4,7 +4,6 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct vm_area_struct *vma,
 			   unsigned long address, unsigned int flags);
@@ -21,6 +20,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
+#include <asm/nospec-branch.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1f769d0db20f..1d3d307ca33d 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -4,7 +4,6 @@
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -18,6 +17,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
+#include <asm/nospec-branch.h>
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
-- 
2.39.1
