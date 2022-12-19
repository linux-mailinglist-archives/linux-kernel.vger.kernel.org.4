Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48C2651361
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLSTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLSTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:39:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78182271
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:35 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id i20so9152480qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9CWkSr3WJQIg3Hpa0/6JoxbXaOiaRi/0uZ7ETKMfLo=;
        b=fUFvIcSwToQSxJO3UE2uCouVtIVdaWT80bfHO58AlCWgZMj237921+63BQHWngK9xx
         A2G/Ad0qO0zDVymhXVObmoWeUgygJcKd+tuQuBWQtUBrPp3fhoTHzhxFMPxHTSDkaJft
         L4ctwYey9vc1nFSXFqBPtlAGcdD0694dHDgziD5vkfxj2Whan4hLbhm6lB+3uz9kwL3X
         h1en7MGAvx8My0bBiStJkuLtCtuO/j7XCipoldVaweAmxQX0ofyYKtFXztXSaCL0o8Wy
         PApuN/BOlx560qtN/cQLPrf6gxmjcyW2hwgh7BfyuwOcN7sMkK5lcp4GJkw0K+VfV2gZ
         dxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9CWkSr3WJQIg3Hpa0/6JoxbXaOiaRi/0uZ7ETKMfLo=;
        b=1WtQr5NMiVXI4gDkAcIT1lpxEaKgFPUox6UFZGyi+x879dfi7F+DOmQe6dvfKeZgdW
         KxlW2BOQAkZC1jSSF9kQ6eHdUmbcwNmwJinbxKVQPWnHNEzw3s0uFwADWz72Ya5T1sL8
         Fu5wuB91LwlzMG6u4c9r9J88sDR3dUTs+CkaCMYMzfcEVbDYbPIsVlKeUjsuiajWhERL
         7iHO+rk/IExcZaNEWvSHVVq+rzSgx4c7az8uLfpn/rym0ffvWzyaxNuw5Sb5fQcAhH+w
         dPjpGQjtXClmKDn5vpJeDJiFhjCLCcMha8HdvhgKysV36tQUDp6hg5bJsocIGth1f9tV
         JAeg==
X-Gm-Message-State: ANoB5pkK8158GHXnzXP/Bh8zTAgEBeXgs76EhZRHGF98yU/5+DngpVqE
        nj64fznyCoEi/8Psw/rUD/o3mdg5fw==
X-Google-Smtp-Source: AA0mqf6W0vpE2FQoOUoCz9WcOPyJVAPMLk1LGXNGN9V+wmbWle3U3Q2CBbUZdcLzn4aJ0pknxpCiig==
X-Received: by 2002:ac8:1019:0:b0:3a5:f949:76c3 with SMTP id z25-20020ac81019000000b003a5f94976c3mr46164583qti.59.1671478774284;
        Mon, 19 Dec 2022 11:39:34 -0800 (PST)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a269900b006fc447eebe5sm7654130qkp.27.2022.12.19.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:39:34 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/2] x86/signal: Move siginfo field tests
Date:   Mon, 19 Dec 2022 14:39:03 -0500
Message-Id: <20221219193904.190220-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219193904.190220-1-brgerst@gmail.com>
References: <20221219193904.190220-1-brgerst@gmail.com>
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

Move the tests to the appropriate signal_$(BITS).c file.

Convert them to use static_assert(), removing the need for a dummy
function.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/signal_32.c     | 127 +++++++++++++++++++++++
 arch/x86/kernel/signal_64.c     | 114 +++++++++++++++++++++
 arch/x86/kernel/signal_compat.c | 176 --------------------------------
 3 files changed, 241 insertions(+), 176 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 2553136cf39b..f042dcdf1f16 100644
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
@@ -377,3 +379,128 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
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
index ff9c55064223..9eea4e8f12ee 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -381,3 +381,117 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
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
index 879ef8c72f5c..c4e9b85f1869 100644
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
 
-- 
2.38.1

