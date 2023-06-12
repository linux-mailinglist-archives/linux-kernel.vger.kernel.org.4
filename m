Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77272D126
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbjFLUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjFLUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270461FF9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C8362F2F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222A1C43322;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=bQS8cm6R4ZJj57jb4seR4/kdTmFK/qogLto2vrQ2RK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gvuc8+uYT+WCMgiB9xsi9XD7tpYo8Zq6fFhBt/EZw2SAoh8Ol5VXxiF1htD3HsNAh
         eJezIx3fKjwXlVsowJhWJPGhFua79KnPlRTK6pb+8lBPZ3+OMobgL2NUWJpLVzU5cv
         hcIYxaB4njxK6k8SX6RM9f/flHgseejA/rqyMZxcY/dKbdHl90+o46a5SX8irQj98Z
         oP0wRyHKAXnxkCw69P72lqI2eGtZ7aT71nA+3HQPHZUK9x0y+q/tzsXj/1Uy135SFj
         jFz58wjWAMBWP8dfU9Xe4jf44GbonmDGIU+VrEfJSQ5BqU7gmZYm+q7FBIuijy8oX7
         6RvLz+1g7HxMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1AD2CE3A7B; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 32/53] tools/nolibc: fix segfaults on compilers without attribute no_stack_protector
Date:   Mon, 12 Jun 2023 13:44:53 -0700
Message-Id: <20230612204514.292087-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Not all compilers, notably GCC < 10, have support for
__attribute__((no_stack_protector)).
Fall back to a mechanism that also works there.

Tested with GCC 9.5.0 from kernel.org crosstools.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-aarch64.h   |  2 +-
 tools/include/nolibc/arch-arm.h       |  2 +-
 tools/include/nolibc/arch-i386.h      |  2 +-
 tools/include/nolibc/arch-loongarch.h |  2 +-
 tools/include/nolibc/arch-mips.h      |  2 +-
 tools/include/nolibc/arch-riscv.h     |  2 +-
 tools/include/nolibc/arch-x86_64.h    |  2 +-
 tools/include/nolibc/compiler.h       | 10 ++++++++++
 tools/include/nolibc/stackprotector.h |  2 +-
 9 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 64ec65b4ee38..11f294a406b7 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -175,7 +175,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 924169522cf7..45b89ffe8247 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -202,7 +202,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 37f813912957..3d672d925e9e 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index d8ea7e787df4..ad3f266e7093 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -172,7 +172,7 @@ const unsigned long *_auxv __attribute__((weak));
 #endif
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 9860236e5340..db24e0837a39 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -182,7 +182,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) __start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 86616aeb77a0..a2e8564e66d6 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -180,7 +180,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 485a7ff72a87..6fc4d8392742 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 57da75cea799..beddc3665d69 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,4 +12,14 @@
 
 #endif /* defined(__SSP__) ... */
 
+#if defined(__has_attribute)
+#  if __has_attribute(no_stack_protector)
+#    define __no_stack_protector __attribute__((no_stack_protector))
+#  else
+#    define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
+#  endif
+#else
+#  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
+#endif /* defined(__has_attribute) */
+
 #endif /* _NOLIBC_COMPILER_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 0a89e2b89ca6..88f7b2d098ff 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -37,7 +37,7 @@ void __stack_chk_fail_local(void)
 __attribute__((weak,section(".data.nolibc_stack_chk")))
 uintptr_t __stack_chk_guard;
 
-__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
+__attribute__((weak,section(".text.nolibc_stack_chk"))) __no_stack_protector
 void __stack_chk_init(void)
 {
 	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
-- 
2.40.1

