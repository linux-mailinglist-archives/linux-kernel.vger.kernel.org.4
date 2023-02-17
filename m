Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7569A32B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBQAxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBQAxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:53:32 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E944AFC8;
        Thu, 16 Feb 2023 16:53:16 -0800 (PST)
X-QQ-mid: bizesmtp76t1676594995t3oi78ew
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Feb 2023 08:49:53 +0800 (CST)
X-QQ-SSF: 01200000000000C0T000000A0000000
X-QQ-FEAT: bhet8yMU7vlmY6nuENHCzNJu1BZZpDnRn9I+XyAaob1f8dWHf98iPQrpDZqXH
        saXuQiK7JfX4+FJfqSo0pANHueQ39kPgOQmPV+7/hAn2V/SOXd7Q5k4WCXpOCYTTMUm/1Tg
        kFRyl/FNxEq1JFEt0XGcoPA/dx12sbPDOU9L2dS93/hIsAInN2myDtZjNiOLQxoXbPurBvp
        fIU5W4KQ1Ux/5rSWVx5ivQGb6Xb1+I5COlKhiyo5nGqae/XaJv5Hv7zAmeoKKDbn13r+A/Y
        R1iSuadlTtKkEdykgqJe4rcmsOQRBqc29PLqjbmqeWUtBKk5nraoKf3iwl1j/is1RxmW9Ll
        ytcfjDeeI0Al4XlYDCWQIkKi0n0/0kS0ShmbDFb8mQzm9mZlDOKnLA40hi4cq8AYCb++qHU
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmer@rivosinc.com>, Willy Tarreau <w@1wt.eu>,
        Paul Burton <paulburton@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [RFC PATCH 5/5] nolibc: Record used syscalls in their own sections
Date:   Fri, 17 Feb 2023 08:49:25 +0800
Message-Id: <cbcbfbb37cabfd9aed6088c75515e4ea86006cff.1676594211.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1676594211.git.falcon@tinylab.org>
References: <cover.1676594211.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new section is added for every system call, the section is encoded
with the syscall name and syscall number. for example:

    .rodata.syscall.__NR_exit.4001
    .rodata.syscall.__NR_getpid.(4000+20)
    .rodata.syscall.__NR_kill.(4000+37)
    .rodata.syscall.__NR_write.(4000+4)
    .rodata.syscall.__NR_reboot.(4000+88)

Both such sections and the unused syscalls can be printed by the
-Wl,--print-gc-sections option of ld (with -ffunction-sections
-fdata-sections and -Wl,--gc-sections together):

    removing unused section '.text.sys_getpid' in file '/tmp/ccbRltF4.o'
    removing unused section '.text.sys_kill' in file '/tmp/ccbRltF4.o'
    removing unused section '.rodata.syscall.__NR_exit.4001' in file '/tmp/cc0vNiof.o'
    removing unused section '.rodata.syscall.__NR_getpid.(4000+20)' in file '/tmp/ccbRltF4.o'
    removing unused section '.rodata.syscall.__NR_kill.(4000+37)' in file '/tmp/ccbRltF4.o'
    removing unused section '.rodata.syscall.__NR_write.(4000+4)' in file '/tmp/ccbRltF4.o'
    removing unused section '.rodata.syscall.__NR_reboot.(4000+88)' in file '/tmp/ccbRltF4.o'

To get the used syscalls, we can use:

    the group of '.rodata.syscall.*' - the group of '.text.sys_*'

At last, we get:

    __NR_exit.4001
    __NR_write.(4000+4)
    __NR_reboot.(4000+88)

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile       |  2 +-
 tools/include/nolibc/arch-aarch64.h | 17 ++++---
 tools/include/nolibc/arch-arm.h     | 15 +++---
 tools/include/nolibc/arch-i386.h    | 17 ++++---
 tools/include/nolibc/arch-mips.h    | 15 +++---
 tools/include/nolibc/arch-riscv.h   | 17 ++++---
 tools/include/nolibc/arch-x86_64.h  | 17 ++++---
 tools/include/nolibc/arch.h         |  2 +
 tools/include/nolibc/record.h       | 77 +++++++++++++++++++++++++++++
 9 files changed, 138 insertions(+), 41 deletions(-)
 create mode 100644 tools/include/nolibc/record.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cfd06764b5ae..f06cbb24124e 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -26,7 +26,7 @@ endif
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
 all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
-             sys.h time.h types.h unistd.h
+             sys.h time.h types.h unistd.h record.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index f68baf8f395f..9f7f5f662cd3 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -62,7 +62,7 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0");                                   \
@@ -76,7 +76,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -91,7 +91,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -107,7 +107,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -124,7 +124,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -142,7 +142,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -161,7 +161,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+#define _my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
@@ -181,6 +181,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+#include "record.h"
+
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
@@ -194,6 +196,7 @@ __asm__ (".section .text\n"
     "bl main\n"                   // main() returns the status code, we'll exit with it.
     "mov x8, 93\n"                // NR_exit == 93
     "svc #0\n"
+    asm_record_exit(93)
     "");
 
 #endif // _NOLIBC_ARCH_AARCH64_H
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index f31be8e967d6..7e9f190b8d48 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -75,7 +75,7 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_OLD_SELECT
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0");                                   \
@@ -89,7 +89,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
@@ -104,7 +104,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
@@ -120,7 +120,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
@@ -137,7 +137,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
@@ -155,7 +155,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	register long _num __asm__ ("r7") = (num);                            \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
@@ -174,6 +174,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+#include "record.h"
+
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
@@ -199,6 +201,7 @@ __asm__ (".section .text\n"
     "bl main\n"                   // main() returns the status code, we'll exit with it.
     "movs r7, $1\n"               // NR_exit == 1
     "svc $0x00\n"
+    asm_record_exit(1)
     "");
 
 #endif // _NOLIBC_ARCH_ARM_H
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index d7e7212346e2..de8ea6b32cc4 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -63,7 +63,7 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_OLD_SELECT
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -77,7 +77,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -93,7 +93,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -110,7 +110,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -128,7 +128,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -147,7 +147,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
@@ -167,7 +167,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
+#define _my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
 ({								\
 	long _eax  = (long)(num);				\
 	long _arg6 = (long)(arg6); /* Always in memory */	\
@@ -190,6 +190,8 @@ struct sys_stat_struct {
 	_eax;							\
 })
 
+#include "record.h"
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -214,6 +216,7 @@ __asm__ (".section .text\n"
     "movl $1, %eax\n"           // NR_exit == 1
     "int $0x80\n"               // exit now
     "hlt\n"                     // ensure it does not
+    asm_record_exit(1)
     "");
 
 #endif // _NOLIBC_ARCH_I386_H
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 7380093ba9e7..719eef58b187 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -67,7 +67,7 @@ struct sys_stat_struct {
  *     don't have to experience issues with register constraints.
  */
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg4 __asm__ ("a3");                                   \
@@ -84,7 +84,7 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -103,7 +103,7 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -123,7 +123,7 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	register long _num __asm__ ("v0")  = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -144,7 +144,7 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -165,7 +165,7 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -188,6 +188,8 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
+#include "record.h"
+
 /* startup code, note that it's called __start on MIPS */
 __asm__ (".section .text\n"
     ".weak __start\n"
@@ -212,6 +214,7 @@ __asm__ (".section .text\n"
     "syscall\n"
     ".end __start\n"
     ".set pop\n"
+    asm_record_exit(4001)
     "");
 
 #endif // _NOLIBC_ARCH_MIPS_H
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a3bdd9803f8c..700d02860ecd 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -64,7 +64,7 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0");                                   \
@@ -78,7 +78,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
@@ -92,7 +92,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -108,7 +108,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -125,7 +125,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -143,7 +143,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -162,7 +162,7 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+#define _my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
 ({                                                                            \
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
@@ -182,6 +182,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+#include "record.h"
+
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
@@ -199,6 +201,7 @@ __asm__ (".section .text\n"
     "call  main\n"               // main() returns the status code, we'll exit with it.
     "li a7, 93\n"                // NR_exit == 93
     "ecall\n"
+    asm_record_exit(93)
     "");
 
 #endif // _NOLIBC_ARCH_RISCV_H
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 0e1e9eb8545d..5628b27a6f25 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -65,7 +65,7 @@ struct sys_stat_struct {
  *
  */
 
-#define my_syscall0(num)                                                      \
+#define _my_syscall0(num)                                                     \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -79,7 +79,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall1(num, arg1)                                                \
+#define _my_syscall1(num, arg1)                                               \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -95,7 +95,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
+#define _my_syscall2(num, arg1, arg2)                                         \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -112,7 +112,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
+#define _my_syscall3(num, arg1, arg2, arg3)                                   \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -130,7 +130,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+#define _my_syscall4(num, arg1, arg2, arg3, arg4)                             \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -149,7 +149,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+#define _my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -169,7 +169,7 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+#define _my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
@@ -190,6 +190,8 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
+#include "record.h"
+
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -210,6 +212,7 @@ __asm__ (".section .text\n"
     "mov $60, %eax\n"           // NR_exit == 60
     "syscall\n"                 // really exit
     "hlt\n"                     // ensure it does not return
+    asm_record_exit(60)
     "");
 
 #endif // _NOLIBC_ARCH_X86_64_H
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 4c6992321b0d..e0552934eb77 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -29,4 +29,6 @@
 #include "arch-riscv.h"
 #endif
 
+#include "record.h"
+
 #endif /* _NOLIBC_ARCH_H */
diff --git a/tools/include/nolibc/record.h b/tools/include/nolibc/record.h
new file mode 100644
index 000000000000..95e02092cecf
--- /dev/null
+++ b/tools/include/nolibc/record.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
+ */
+
+#ifndef _NOLIBC_RECORD_H
+#define _NOLIBC_RECORD_H
+
+/* To record syscalls used, please pass -DRECORD_SYSCALL to gcc */
+#ifdef RECORD_SYSCALL
+#define __asm_record_syscall(name, val) 				\
+	".pushsection .rodata.syscall." name "." #val ",\"a\"\n"	\
+	".word (" #val ")\n"     		              		\
+	".popsection\n"
+
+#define asm_record_syscall(num) __asm_record_syscall(#num, num)
+#define asm_record_exit(num) __asm_record_syscall("__NR_exit", num)
+
+#define record_syscall(name, val)	 				\
+({									\
+	__asm__ volatile (						\
+		__asm_record_syscall(name, val)				\
+	); 								\
+})
+
+#else /* RECORD_SYSCALL */
+#define asm_record_exit(num) ""
+#define record_syscall(name, val) do { } while (0)
+#endif /* !RECORD_SYSCALL */
+
+#define my_syscall0(num)						\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall0(num);						\
+})
+
+#define my_syscall1(num, arg1)						\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall1(num, arg1);					\
+})
+
+#define my_syscall2(num, arg1, arg2)					\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall2(num, arg1, arg2);					\
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)				\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall3(num, arg1, arg2, arg3);				\
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)			\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall4(num, arg1, arg2, arg3, arg4);			\
+})
+
+#ifdef _my_syscall5
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)			\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall5(num, arg1, arg2, arg3, arg4, arg5);		\
+})
+#endif
+
+#ifdef _my_syscall6
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)		\
+({									\
+	record_syscall(#num, num);					\
+	_my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6);		\
+})
+#endif
+
+#endif /* _NOLIBC_RECORD_H */
-- 
2.25.1

