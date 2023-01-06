Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364B65FF21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAFKrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjAFKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:47:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89C6CFDF;
        Fri,  6 Jan 2023 02:47:44 -0800 (PST)
Date:   Fri, 06 Jan 2023 10:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673002061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AM1rfQ6CXzmXlFsPP6n7pmU4ruiG7jmdqSSiCb5zBms=;
        b=IFPN7n7gygXbTRxrvlq3eyxXNb5IsekbUl16Ha8kVlh99MpFEH4l1fT7kMqQCUrONE/1Iv
        kpDb7Wta4E/S2XVq/Gv0kR8Vtc2VGUAr9c5XtSDZYbxTvJis5/E9N+7E/b7LMqcNMdjA7E
        sw/WQL/7nJM3hBKRvrNL0jloUExjwkiOwomU+YWa+StFzxClX0MsxNnl74lxNZ8JEPZzyk
        xp7YbKQcqKNHpcennVr7fNAIITZOE81owrT1xaWGarp8vXrIxq7YPGzsqYrbgkWLkUfDgX
        MfVSUYxMhmOvflWvNiWx5f6B5Pk/0pDgGCeV56R0e/4pbsczK9iBTi1d9Bkj9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673002061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AM1rfQ6CXzmXlFsPP6n7pmU4ruiG7jmdqSSiCb5zBms=;
        b=+R8KGLEs+AclHqPlA4OeiY3BjkQkb2oNp+E9f5gDYwT/CiQyNowBtuwAtFP3QiNrt9bYul
        Rr4wRlG6I6wwcHDw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/signal: Move siginfo field tests
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221219193904.190220-2-brgerst@gmail.com>
References: <20221219193904.190220-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <167300206092.4906.1064342825353149183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f6e2a56c2bad10dd4381d5ab021332ef70d81990
Gitweb:        https://git.kernel.org/tip/f6e2a56c2bad10dd4381d5ab021332ef70d81990
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 19 Dec 2022 14:39:03 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Jan 2023 04:16:02 +01:00

x86/signal: Move siginfo field tests

Move the tests to the appropriate signal_$(BITS).c file.

Convert them to use static_assert(), removing the need for a dummy
function.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221219193904.190220-2-brgerst@gmail.com
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal_32.c     | 127 ++++++++++++++++++++++-
 arch/x86/kernel/signal_64.c     | 114 ++++++++++++++++++++-
 arch/x86/kernel/signal_compat.c | 176 +-------------------------------
 3 files changed, 241 insertions(+), 176 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 2553136..f042dcd 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -54,12 +54,14 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 }
 
 #define sigset32_t			compat_sigset_t
+#define siginfo32_t			compat_siginfo_t
 #define restore_altstack32		compat_restore_altstack
 #define unsafe_save_altstack32		unsafe_compat_save_altstack
 
 #else
 
 #define sigset32_t			sigset_t
+#define siginfo32_t			siginfo_t
 #define __NR_ia32_sigreturn		__NR_sigreturn
 #define __NR_ia32_rt_sigreturn		__NR_rt_sigreturn
 #define restore_altstack32		restore_altstack
@@ -377,3 +379,128 @@ Efault:
 	user_access_end();
 	return -EFAULT;
 }
+
+/*
+ * The siginfo_t structure and handing code is very easy
+ * to break in several ways.  It must always be updated when new
+ * updates are made to the main siginfo_t, and
+ * copy_siginfo_to_user32() must be updated when the
+ * (arch-independent) copy_siginfo_to_user() is updated.
+ *
+ * It is also easy to put a new member in the siginfo_t
+ * which has implicit alignment which can move internal structure
+ * alignment around breaking the ABI.  This can happen if you,
+ * for instance, put a plain 64-bit value in there.
+ */
+
+/*
+* If adding a new si_code, there is probably new data in
+* the siginfo.  Make sure folks bumping the si_code
+* limits also have to look at this code.  Make sure any
+* new fields are handled in copy_siginfo_to_user32()!
+*/
+static_assert(NSIGILL  == 11);
+static_assert(NSIGFPE  == 15);
+static_assert(NSIGSEGV == 9);
+static_assert(NSIGBUS  == 5);
+static_assert(NSIGTRAP == 6);
+static_assert(NSIGCHLD == 6);
+static_assert(NSIGSYS  == 2);
+
+/* This is part of the ABI and can never change in size: */
+static_assert(sizeof(siginfo32_t) == 128);
+
+/* This is a part of the ABI and can never change in alignment */
+static_assert(__alignof__(siginfo32_t) == 4);
+
+/*
+* The offsets of all the (unioned) si_fields are fixed
+* in the ABI, of course.  Make sure none of them ever
+* move and are always at the beginning:
+*/
+static_assert(offsetof(siginfo32_t, _sifields) == 3 * sizeof(int));
+
+static_assert(offsetof(siginfo32_t, si_signo) == 0);
+static_assert(offsetof(siginfo32_t, si_errno) == 4);
+static_assert(offsetof(siginfo32_t, si_code)  == 8);
+
+/*
+* Ensure that the size of each si_field never changes.
+* If it does, it is a sign that the
+* copy_siginfo_to_user32() code below needs to updated
+* along with the size in the CHECK_SI_SIZE().
+*
+* We repeat this check for both the generic and compat
+* siginfos.
+*
+* Note: it is OK for these to grow as long as the whole
+* structure stays within the padding size (checked
+* above).
+*/
+
+#define CHECK_SI_OFFSET(name)						\
+	static_assert(offsetof(siginfo32_t, _sifields) ==		\
+		      offsetof(siginfo32_t, _sifields.name))
+
+#define CHECK_SI_SIZE(name, size)					\
+	static_assert(sizeof_field(siginfo32_t, _sifields.name) == size)
+
+CHECK_SI_OFFSET(_kill);
+CHECK_SI_SIZE  (_kill, 2*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid) == 0xC);
+static_assert(offsetof(siginfo32_t, si_uid) == 0x10);
+
+CHECK_SI_OFFSET(_timer);
+#ifdef CONFIG_COMPAT
+/* compat_siginfo_t doesn't have si_sys_private */
+CHECK_SI_SIZE  (_timer, 3*sizeof(int));
+#else
+CHECK_SI_SIZE  (_timer, 4*sizeof(int));
+#endif
+static_assert(offsetof(siginfo32_t, si_tid)     == 0x0C);
+static_assert(offsetof(siginfo32_t, si_overrun) == 0x10);
+static_assert(offsetof(siginfo32_t, si_value)   == 0x14);
+
+CHECK_SI_OFFSET(_rt);
+CHECK_SI_SIZE  (_rt, 3*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid)   == 0x0C);
+static_assert(offsetof(siginfo32_t, si_uid)   == 0x10);
+static_assert(offsetof(siginfo32_t, si_value) == 0x14);
+
+CHECK_SI_OFFSET(_sigchld);
+CHECK_SI_SIZE  (_sigchld, 5*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid)    == 0x0C);
+static_assert(offsetof(siginfo32_t, si_uid)    == 0x10);
+static_assert(offsetof(siginfo32_t, si_status) == 0x14);
+static_assert(offsetof(siginfo32_t, si_utime)  == 0x18);
+static_assert(offsetof(siginfo32_t, si_stime)  == 0x1C);
+
+CHECK_SI_OFFSET(_sigfault);
+CHECK_SI_SIZE  (_sigfault, 4*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_addr) == 0x0C);
+
+static_assert(offsetof(siginfo32_t, si_trapno) == 0x10);
+
+static_assert(offsetof(siginfo32_t, si_addr_lsb) == 0x10);
+
+static_assert(offsetof(siginfo32_t, si_lower) == 0x14);
+static_assert(offsetof(siginfo32_t, si_upper) == 0x18);
+
+static_assert(offsetof(siginfo32_t, si_pkey) == 0x14);
+
+static_assert(offsetof(siginfo32_t, si_perf_data) == 0x10);
+static_assert(offsetof(siginfo32_t, si_perf_type) == 0x14);
+static_assert(offsetof(siginfo32_t, si_perf_flags) == 0x18);
+
+CHECK_SI_OFFSET(_sigpoll);
+CHECK_SI_SIZE  (_sigpoll, 2*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_band) == 0x0C);
+static_assert(offsetof(siginfo32_t, si_fd)   == 0x10);
+
+CHECK_SI_OFFSET(_sigsys);
+CHECK_SI_SIZE  (_sigsys, 3*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_call_addr) == 0x0C);
+static_assert(offsetof(siginfo32_t, si_syscall)   == 0x10);
+static_assert(offsetof(siginfo32_t, si_arch)      == 0x14);
+
+/* any new si_fields should be added here */
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index ff9c550..9eea4e8 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -381,3 +381,117 @@ badframe:
 	return 0;
 }
 #endif /* CONFIG_X86_X32_ABI */
+
+/*
+* If adding a new si_code, there is probably new data in
+* the siginfo.  Make sure folks bumping the si_code
+* limits also have to look at this code.  Make sure any
+* new fields are handled in copy_siginfo_to_user32()!
+*/
+static_assert(NSIGILL  == 11);
+static_assert(NSIGFPE  == 15);
+static_assert(NSIGSEGV == 9);
+static_assert(NSIGBUS  == 5);
+static_assert(NSIGTRAP == 6);
+static_assert(NSIGCHLD == 6);
+static_assert(NSIGSYS  == 2);
+
+/* This is part of the ABI and can never change in size: */
+static_assert(sizeof(siginfo_t) == 128);
+
+/* This is a part of the ABI and can never change in alignment */
+static_assert(__alignof__(siginfo_t) == 8);
+
+/*
+* The offsets of all the (unioned) si_fields are fixed
+* in the ABI, of course.  Make sure none of them ever
+* move and are always at the beginning:
+*/
+static_assert(offsetof(siginfo_t, si_signo) == 0);
+static_assert(offsetof(siginfo_t, si_errno) == 4);
+static_assert(offsetof(siginfo_t, si_code)  == 8);
+
+/*
+* Ensure that the size of each si_field never changes.
+* If it does, it is a sign that the
+* copy_siginfo_to_user32() code below needs to updated
+* along with the size in the CHECK_SI_SIZE().
+*
+* We repeat this check for both the generic and compat
+* siginfos.
+*
+* Note: it is OK for these to grow as long as the whole
+* structure stays within the padding size (checked
+* above).
+*/
+
+#define CHECK_SI_OFFSET(name)						\
+	static_assert(offsetof(siginfo_t, _sifields) == 		\
+		      offsetof(siginfo_t, _sifields.name))
+#define CHECK_SI_SIZE(name, size)					\
+	static_assert(sizeof_field(siginfo_t, _sifields.name) == size)
+
+CHECK_SI_OFFSET(_kill);
+CHECK_SI_SIZE  (_kill, 2*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid) == 0x10);
+static_assert(offsetof(siginfo_t, si_uid) == 0x14);
+
+CHECK_SI_OFFSET(_timer);
+CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
+static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
+static_assert(offsetof(siginfo_t, si_value)   == 0x18);
+
+CHECK_SI_OFFSET(_rt);
+CHECK_SI_SIZE  (_rt, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid)   == 0x10);
+static_assert(offsetof(siginfo_t, si_uid)   == 0x14);
+static_assert(offsetof(siginfo_t, si_value) == 0x18);
+
+CHECK_SI_OFFSET(_sigchld);
+CHECK_SI_SIZE  (_sigchld, 8*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid)    == 0x10);
+static_assert(offsetof(siginfo_t, si_uid)    == 0x14);
+static_assert(offsetof(siginfo_t, si_status) == 0x18);
+static_assert(offsetof(siginfo_t, si_utime)  == 0x20);
+static_assert(offsetof(siginfo_t, si_stime)  == 0x28);
+
+#ifdef CONFIG_X86_X32_ABI
+/* no _sigchld_x32 in the generic siginfo_t */
+static_assert(sizeof_field(compat_siginfo_t, _sifields._sigchld_x32) ==
+	      7*sizeof(int));
+static_assert(offsetof(compat_siginfo_t, _sifields) ==
+	      offsetof(compat_siginfo_t, _sifields._sigchld_x32));
+static_assert(offsetof(compat_siginfo_t, _sifields._sigchld_x32._utime)  == 0x18);
+static_assert(offsetof(compat_siginfo_t, _sifields._sigchld_x32._stime)  == 0x20);
+#endif
+
+CHECK_SI_OFFSET(_sigfault);
+CHECK_SI_SIZE  (_sigfault, 8*sizeof(int));
+static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
+
+static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
+
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
+
+static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
+
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
+
+static_assert(offsetof(siginfo_t, si_perf_data)	 == 0x18);
+static_assert(offsetof(siginfo_t, si_perf_type)	 == 0x20);
+static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
+
+CHECK_SI_OFFSET(_sigpoll);
+CHECK_SI_SIZE  (_sigpoll, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_band) == 0x10);
+static_assert(offsetof(siginfo_t, si_fd)   == 0x18);
+
+CHECK_SI_OFFSET(_sigsys);
+CHECK_SI_SIZE  (_sigsys, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_call_addr) == 0x10);
+static_assert(offsetof(siginfo_t, si_syscall)   == 0x18);
+static_assert(offsetof(siginfo_t, si_arch)      == 0x1C);
+
+/* any new si_fields should be added here */
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 879ef8c..c4e9b85 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -3,184 +3,8 @@
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
 
-/*
- * The compat_siginfo_t structure and handing code is very easy
- * to break in several ways.  It must always be updated when new
- * updates are made to the main siginfo_t, and
- * copy_siginfo_to_user32() must be updated when the
- * (arch-independent) copy_siginfo_to_user() is updated.
- *
- * It is also easy to put a new member in the compat_siginfo_t
- * which has implicit alignment which can move internal structure
- * alignment around breaking the ABI.  This can happen if you,
- * for instance, put a plain 64-bit value in there.
- */
-static inline void signal_compat_build_tests(void)
-{
-	int _sifields_offset = offsetof(compat_siginfo_t, _sifields);
-
-	/*
-	 * If adding a new si_code, there is probably new data in
-	 * the siginfo.  Make sure folks bumping the si_code
-	 * limits also have to look at this code.  Make sure any
-	 * new fields are handled in copy_siginfo_to_user32()!
-	 */
-	BUILD_BUG_ON(NSIGILL  != 11);
-	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 9);
-	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 6);
-	BUILD_BUG_ON(NSIGCHLD != 6);
-	BUILD_BUG_ON(NSIGSYS  != 2);
-
-	/* This is part of the ABI and can never change in size: */
-	BUILD_BUG_ON(sizeof(siginfo_t) != 128);
-	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
-
-	/* This is a part of the ABI and can never change in alignment */
-	BUILD_BUG_ON(__alignof__(siginfo_t) != 8);
-	BUILD_BUG_ON(__alignof__(compat_siginfo_t) != 4);
-
-	/*
-	 * The offsets of all the (unioned) si_fields are fixed
-	 * in the ABI, of course.  Make sure none of them ever
-	 * move and are always at the beginning:
-	 */
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields) != 3 * sizeof(int));
-#define CHECK_CSI_OFFSET(name)	  BUILD_BUG_ON(_sifields_offset != offsetof(compat_siginfo_t, _sifields.name))
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_signo) != 0);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_errno) != 4);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_code)  != 8);
-
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_signo) != 0);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_errno) != 4);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_code)  != 8);
-	 /*
-	 * Ensure that the size of each si_field never changes.
-	 * If it does, it is a sign that the
-	 * copy_siginfo_to_user32() code below needs to updated
-	 * along with the size in the CHECK_SI_SIZE().
-	 *
-	 * We repeat this check for both the generic and compat
-	 * siginfos.
-	 *
-	 * Note: it is OK for these to grow as long as the whole
-	 * structure stays within the padding size (checked
-	 * above).
-	 */
-#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((compat_siginfo_t *)0)->_sifields.name))
-#define CHECK_SI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((siginfo_t *)0)->_sifields.name))
-
-	CHECK_CSI_OFFSET(_kill);
-	CHECK_CSI_SIZE  (_kill, 2*sizeof(int));
-	CHECK_SI_SIZE   (_kill, 2*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid) != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid) != 0xC);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid) != 0x10);
-
-	CHECK_CSI_OFFSET(_timer);
-	CHECK_CSI_SIZE  (_timer, 3*sizeof(int));
-	CHECK_SI_SIZE   (_timer, 6*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_tid)     != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_overrun) != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_value)   != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_tid)     != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_overrun) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_value)   != 0x14);
-
-	CHECK_CSI_OFFSET(_rt);
-	CHECK_CSI_SIZE  (_rt, 3*sizeof(int));
-	CHECK_SI_SIZE   (_rt, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)   != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)   != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_value) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid)   != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid)   != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_value) != 0x14);
-
-	CHECK_CSI_OFFSET(_sigchld);
-	CHECK_CSI_SIZE  (_sigchld, 5*sizeof(int));
-	CHECK_SI_SIZE   (_sigchld, 8*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)    != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)    != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_status) != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_utime)  != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_stime)  != 0x28);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid)    != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid)    != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_status) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_utime)  != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_stime)  != 0x1C);
-
-#ifdef CONFIG_X86_X32_ABI
-	CHECK_CSI_OFFSET(_sigchld_x32);
-	CHECK_CSI_SIZE  (_sigchld_x32, 7*sizeof(int));
-	/* no _sigchld_x32 in the generic siginfo_t */
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields._sigchld_x32._utime)  != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields._sigchld_x32._stime)  != 0x20);
-#endif
-
-	CHECK_CSI_OFFSET(_sigfault);
-	CHECK_CSI_SIZE  (_sigfault, 4*sizeof(int));
-	CHECK_SI_SIZE   (_sigfault, 8*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr) != 0x0C);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_trapno) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_trapno) != 0x10);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_addr_lsb) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr_lsb) != 0x10);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_lower) != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_upper) != 0x28);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_lower) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_upper) != 0x18);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x24);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_flags) != 0x18);
-
-	CHECK_CSI_OFFSET(_sigpoll);
-	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
-	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_band) != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_fd)   != 0x10);
-
-	CHECK_CSI_OFFSET(_sigsys);
-	CHECK_CSI_SIZE  (_sigsys, 3*sizeof(int));
-	CHECK_SI_SIZE   (_sigsys, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_call_addr) != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_syscall)   != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_arch)      != 0x1C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_call_addr) != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_syscall)   != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_arch)      != 0x14);
-
-	/* any new si_fields should be added here */
-}
-
 void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 {
-	signal_compat_build_tests();
-
 	if (!act)
 		return;
 
