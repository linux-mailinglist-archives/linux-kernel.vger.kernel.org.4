Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397BA6C8F10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCYPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCYPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:48 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8139312078
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjQbw008049;
        Sat, 25 Mar 2023 16:45:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4/8] tools/nolibc: add support for stack protector
Date:   Sat, 25 Mar 2023 16:45:12 +0100
Message-Id: <20230325154516.7995-5-w@1wt.eu>
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

This is useful when using nolibc for security-critical tools.
Using nolibc has the advantage that the code is easily auditable and
sandboxable with seccomp as no unexpected syscalls are used.
Using compiler-assistent stack protection provides another security
mechanism.

For this to work the compiler and libc have to collaborate.

This patch adds the following parts to nolibc that are required by the
compiler:

* __stack_chk_guard: random sentinel value
* __stack_chk_fail: handler for detected stack smashes

In addition an initialization function is added that randomizes the
sentinel value.

Only support for global guards is implemented.
Register guards are useful in multi-threaded context which nolibc does
not provide support for.

Link: https://lwn.net/Articles/584225/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile         |  4 +-
 tools/include/nolibc/nolibc.h         |  1 +
 tools/include/nolibc/stackprotector.h | 53 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/nolibc/stackprotector.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index ec57d3932506..9839feafd38a 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
-             string.h sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h stackprotector.h std.h stdint.h \
+             stdio.h stdlib.h string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b2bc48d3cfe4..04739a6293c4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -104,6 +104,7 @@
 #include "string.h"
 #include "time.h"
 #include "unistd.h"
+#include "stackprotector.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
new file mode 100644
index 000000000000..d119cbbbc256
--- /dev/null
+++ b/tools/include/nolibc/stackprotector.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Stack protector support for NOLIBC
+ * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_STACKPROTECTOR_H
+#define _NOLIBC_STACKPROTECTOR_H
+
+#include "arch.h"
+
+#if defined(NOLIBC_STACKPROTECTOR)
+
+#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
+#error "nolibc does not support stack protectors on this arch"
+#endif
+
+#include "sys.h"
+#include "stdlib.h"
+
+/* The functions in this header are using raw syscall macros to avoid
+ * triggering stack protector errors themselves
+ */
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail(void)
+{
+	pid_t pid;
+	my_syscall3(__NR_write, STDERR_FILENO, "!!Stack smashing detected!!\n", 28);
+	pid = my_syscall0(__NR_getpid);
+	my_syscall2(__NR_kill, pid, SIGABRT);
+	for (;;);
+}
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail_local(void)
+{
+	__stack_chk_fail();
+}
+
+__attribute__((weak,section(".data.nolibc_stack_chk")))
+uintptr_t __stack_chk_guard;
+
+__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
+void __stack_chk_init(void)
+{
+	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
+	/* a bit more randomness in case getrandom() fails */
+	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
+}
+#endif // defined(NOLIBC_STACKPROTECTOR)
+
+#endif // _NOLIBC_STACKPROTECTOR_H
-- 
2.17.5

