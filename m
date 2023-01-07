Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33B4660F3A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjAGNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjAGNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:36:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54C60864
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB072B81889
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3F0C433D2;
        Sat,  7 Jan 2023 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098602;
        bh=jDX3E2PQhQPvX0J2ilfProXVJEOysimTyjHtfoXAKrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j63l3BArGK5g8ChqTf14LMXRdmF5671x8Vb7EGQQnEr8mB0/2GByglAZzZ5d17ysj
         Bss41ySv9vRpEEQj8QdUNtaengom+/7Xi0ZT1uoygoynSlBFsKA4B1lA19waoiK150
         ivEuFxLFDabT069OdQ+GivaaVwVpQD/ODWpuuG5hKBIfdLUF2wyBqNf/raHl+LILUa
         7toDmakEWtVcAC5e96ImFnWYo0DaTkjGlUM4u/jm8n8XZLCJzVPT5ul5U2rTELShq7
         ge4nFc28xr/vpsgwVBPWk9Me9nElj3bVR9CU2NmrTRvekICghtHJ+GlsIr2Vs6g+T0
         ksXew7JwGPjuQ==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next V6 7/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Sat,  7 Jan 2023 08:35:49 -0500
Message-Id: <20230107133549.4192639-8-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230107133549.4192639-1-guoren@kernel.org>
References: <20230107133549.4192639-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
the ftrace-direct*.c files in samples/ftrace/.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
 samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
 5 files changed, 140 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index de5a0f67f320..be7bf472c3c7 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -23,6 +23,39 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_RISCV
+
+asm ("	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi sp,sp,-16\n"
+"	sd   t0,0(sp)\n"
+"	sd   ra,8(sp)\n"
+"	call my_direct_func1\n"
+"	ld   t0,0(sp)\n"
+"	ld   ra,8(sp)\n"
+"	addi sp,sp,16\n"
+"	jr t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"	addi sp,sp,-16\n"
+"	sd   t0,0(sp)\n"
+"	sd   ra,8(sp)\n"
+"	call my_direct_func2\n"
+"	ld   t0,0(sp)\n"
+"	ld   ra,8(sp)\n"
+"	addi sp,sp,16\n"
+"	jr t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index d52370cad0b6..10884bf418f7 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
 extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func1\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"	jr t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func2\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"	jr t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index ec1088922517..a35bf43bf6d7 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"       jr t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e13fb59a2b47..3b62e33c2e6d 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-40\n"
+"       sd   a0,0(sp)\n"
+"       sd   a1,8(sp)\n"
+"       sd   a2,16(sp)\n"
+"       sd   t0,24(sp)\n"
+"       sd   ra,32(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   a1,8(sp)\n"
+"       ld   a2,16(sp)\n"
+"       ld   t0,24(sp)\n"
+"       ld   ra,32(sp)\n"
+"       addi sp,sp,40\n"
+"       jr t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1f769d0db20f..2cfe5a7d2d70 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+
+asm ("       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi sp,sp,-24\n"
+"       sd   a0,0(sp)\n"
+"       sd   t0,8(sp)\n"
+"       sd   ra,16(sp)\n"
+"       call my_direct_func\n"
+"       ld   a0,0(sp)\n"
+"       ld   t0,8(sp)\n"
+"       ld   ra,16(sp)\n"
+"       addi sp,sp,24\n"
+"       jr t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
-- 
2.36.1

