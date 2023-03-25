Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73A6C8F13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCYPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCYPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:59 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACAA7126D9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjR6D008052;
        Sat, 25 Mar 2023 16:45:27 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 7/8] tools/nolibc: i386: add stackprotector support
Date:   Sat, 25 Mar 2023 16:45:15 +0100
Message-Id: <20230325154516.7995-8-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230325154516.7995-1-w@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Enable the new stackprotector support for i386.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-i386.h        | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index e8d0cf545bf1..2d98d78fd3f3 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -181,6 +181,8 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -188,9 +190,12 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   // initialize stack protector
+#endif
 		"pop %eax\n"                // argc   (first arg, %eax)
 		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
 		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e516e53775d4..ab99786c1e94 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -79,6 +79,7 @@ endif
 CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
 			$(call cc-option,-mstack-protector-guard=global) \
 			$(call cc-option,-fstack-protector-all)
+CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
 		$(call cc-option,-fno-stack-protector) \
-- 
2.17.5

