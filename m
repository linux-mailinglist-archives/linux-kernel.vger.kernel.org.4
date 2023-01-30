Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0F680809
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjA3JAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjA3JAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:00:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138F1C58C;
        Mon, 30 Jan 2023 01:00:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso14732272pjj.1;
        Mon, 30 Jan 2023 01:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYvxj6z17+I1UUuoqPExd/8Gq1dgi0Y5+O/R0VeLmZI=;
        b=HhAcisqjUofBx26aobXuXtksntebFdJoybZ3mfjlmD8W/aU5S0hSHP5g+ej+0iFPIy
         mOiFVhJnJpNcl7eCDK2Omn/BnjJ+JhzxJoh6zSEpjveYSPQgqMcjv3F3PK7cCf6jYyrn
         d5gEBpl8CihJCutuNU9XDZO4KgZS9Ha7fQ8+DigRg4z4sylnF/hMMJsQVf2nJM4QYnDh
         bQnbAc7zyb/Vf4gSKeUbcc7V2q0kXhD3aRqUeLmN+hboAAqN0RlSzsOY1lJCuvN83ZVk
         LqlmFy0LsH4G3lhDQcYe4KfFbJKsAsAtFw/R+8LhygL9SQewW0Wa3FELQDU/5CXPm1e5
         hbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYvxj6z17+I1UUuoqPExd/8Gq1dgi0Y5+O/R0VeLmZI=;
        b=pnv8X/tczxy/RMTF+11dopLaiJk5Xyiz2Teym6QkTGBoIig1gkV45TogZam7t7UtNU
         1BVqzANFQm6an1O/+Wo2zamNm2t1J5NBaT1/I+6GsQiJOLKPqJ1WdZwhwUSokA2SFwpy
         jM9O1pRsPtCxG2QAUqbwIUtwyTxlPd7jegkpc7GlNS1peLl1q3mCUK71lWWquafARFg+
         M+ILaLEV0iS8p11NWhd7mZn/IjMpxH+M3jEehMtWoqCKvB4K2BLTqcqfJTcGNCmtnS5j
         QNmEPcCfj4slbS3r/cl59ZMWwhLuiQ/n9RCaV5GFkg6uyTtjBsfYcCNZ4IP2usifjsyQ
         O+Bg==
X-Gm-Message-State: AO0yUKVKUEBcjIOTc/vQT7dgfN6VxduOhQN1e3+whNSw7IRwGiZd3K+N
        HXPLltf4CdT3yfh3Zd8mvhM=
X-Google-Smtp-Source: AK7set+wHPCvRHklQ7ayPD/b6qBRObeY1WsR5zkRqbDL1l35gukOFBqU1HcQ1r5b4ESuKAFNt7gW4g==
X-Received: by 2002:a05:6a20:7da0:b0:bc:8a99:28c8 with SMTP id v32-20020a056a207da000b000bc8a9928c8mr9882462pzj.57.1675069216001;
        Mon, 30 Jan 2023 01:00:16 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902ccca00b0019623858afbsm7248002ple.71.2023.01.30.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:00:15 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, jpoimboe@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] samples: ftrace: Include the nospec-branch.h only for x86
Date:   Mon, 30 Jan 2023 16:59:54 +0800
Message-Id: <20230130085954.647845-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When other architectures without the nospec functionality write their
direct-call functions of samples/ftrace/*.c, the including of
asm/nospec-branch.h must be taken care to fix the no header file found
error in building process.

This commit (ee3e2469b346 "x86/ftrace: Make it call depth tracking aware")
file-globally includes asm/nospec-branch.h providing CALL_DEPTH_ACCOUNT
for only x86 direct-call functions.

It seems better to move the including to `#ifdef CONFIG_X86_64`.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
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
2.20.1

