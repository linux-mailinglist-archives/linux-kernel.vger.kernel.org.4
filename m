Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0526639ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbjAJH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjAJHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:25:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84EA94A94C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:25:15 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7ObF1003930;
        Tue, 10 Jan 2023 08:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 03/22] tools/nolibc: support thumb mode with frame pointers on ARM
Date:   Tue, 10 Jan 2023 08:24:15 +0100
Message-Id: <20230110072434.3863-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230110072434.3863-1-w@1wt.eu>
References: <20230110072434.3863-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Thumb mode, register r7 is normally used to store the frame pointer.
By default when optimizing at -Os there's no frame pointer so this works
fine. But if no optimization is set, then build errors occur, indicating
that r7 cannot not be used. It's difficult to cheat because it's the
compiler that is complaining, not the assembler, so it's not even possible
to report that the register was clobbered. The solution consists in saving
and restoring r7 around the syscall, but this slightly inflates the code.
The syscall number is passed via r6 which is never used by syscalls.

The current patch adds a few macroes which do that only in Thumb mode,
and which continue to directly assign the syscall number to register r7
in ARM mode. Now this always builds and works for all modes (tested on
Arm, Thumbv1, Thumbv2 modes, at -Os, -O0, -O0 -fomit-frame-pointer).
The code is very slightly inflated in thumb-mode without frame-pointers
compared to previously (e.g. 7928 vs 7864 bytes for nolibc-test) but at
least it's always operational. And it's possible to disable this mechanism
by setting NOLIBC_OMIT_FRAME_POINTER.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-arm.h | 60 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index e4ba77b0310f..ef94df2d93d5 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -70,20 +70,44 @@ struct sys_stat_struct {
  *     don't have to experience issues with register constraints.
  *   - the syscall number is always specified last in order to allow to force
  *     some registers before (gcc refuses a %-register at the last position).
+ *   - in thumb mode without -fomit-frame-pointer, r7 is also used to store the
+ *     frame pointer, and we cannot directly assign it as a register variable,
+ *     nor can we clobber it. Instead we assign the r6 register and swap it
+ *     with r7 before calling svc, and r6 is marked as clobbered.
+ *     We're just using any regular register which we assign to r7 after saving
+ *     it.
  *
  * Also, ARM supports the old_select syscall if newselect is not available
  */
 #define __ARCH_WANT_SYS_OLD_SELECT
 
+#if (defined(__THUMBEB__) || defined(__THUMBEL__)) && \
+    !defined(NOLIBC_OMIT_FRAME_POINTER)
+/* swap r6,r7 needed in Thumb mode since we can't use nor clobber r7 */
+#define _NOLIBC_SYSCALL_REG         "r6"
+#define _NOLIBC_THUMB_SET_R7        "eor r7, r6\neor r6, r7\neor r7, r6\n"
+#define _NOLIBC_THUMB_RESTORE_R7    "mov r7, r6\n"
+
+#else  /* we're in ARM mode */
+/* in Arm mode we can directly use r7 */
+#define _NOLIBC_SYSCALL_REG         "r7"
+#define _NOLIBC_THUMB_SET_R7        ""
+#define _NOLIBC_THUMB_RESTORE_R7    ""
+
+#endif /* end THUMB */
+
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0");                                   \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r"(_num)                                     \
+		: "r"(_arg1),                                                 \
+		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
 	);                                                                    \
 	_arg1;                                                                \
@@ -91,12 +115,14 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
 		: "r"(_arg1),                                                 \
 		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
@@ -106,13 +132,15 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
 		: "r"(_arg1), "r"(_arg2),                                     \
 		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
@@ -122,14 +150,16 @@ struct sys_stat_struct {
 
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
 		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
@@ -139,15 +169,17 @@ struct sys_stat_struct {
 
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
 		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
@@ -157,7 +189,7 @@ struct sys_stat_struct {
 
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
-	register long _num __asm__ ("r7") = (num);                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
@@ -165,8 +197,10 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
 	                                                                      \
 	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
-		: "=r" (_arg1)                                                \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "r"(_num)                                                   \
 		: "memory", "cc", "lr"                                        \
-- 
2.17.5

