Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB955B7CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIMV1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:27:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F465578
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:27:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16853823pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AFkzWg6oY6zwYmMPvQd7paAg5Ld4YNqS/J6xvdpkf18=;
        b=KDBSiHtSpxwzz/LW7/sdUIu2O8PKHlfDHd7OTNlUuQLHb06Wi92fVR5560uWsdIvWd
         hWcH/4ZXqcN28NJJYZYHcMVC/gnMy88THRARJDmfAYGggGiIo8JaFKBX3G355vl9Zmdz
         QjCcV6dYlJKHgpKkJjvTuhJehlcSv5oqYx0bbJWI1ieqSuuNuEn0lQY2ExTJBPZ/FCLH
         Z2y2IsCKhcF+lHr7zzcz3T9H9UYM8YkSMGte14BNMYDBBLtywRkkybNqX01CYmfUCTt1
         m1husSSyy9nEIYahY02D3YqMu7fmX627y5dnI7HsQ51O5aniniXuMr4CebNRGXqOBydn
         bG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AFkzWg6oY6zwYmMPvQd7paAg5Ld4YNqS/J6xvdpkf18=;
        b=iLOfj9stcS0NjtdTcEsFxQky3cuZN4WSzf1Sz4FIr9oJlLHVgiTVBEejdsZDgzGH9M
         sr06m5PVLy3rkcFcR2+zPj1mgyE8a4yrxkGtY9hHNUSiCPCEe2PSi2EFm+NPaTnqt18Y
         Se9Vc/nT2dIK8RVO59qTHTLiGEAD72ERQ4hXQAtR3pd0sCI+i76bkV7lLNohrkPpYxIG
         3sJG0743xSwyrdGgnt1Iu6+L01M5ODBdzgMX4/lxNJqWcO5Sz8Ji1i7L64baqxa6JQd7
         pOz2VfJnuyPQxhVUofzcwPwGcNI11HERT5opWhYIE5FIDKagtwCiQDs8F7/8HZ8dvJxU
         SXEw==
X-Gm-Message-State: ACrzQf2Xqs/cwmrS3/u01bnXBIai+lZAQjubBazwtD+3SuAD8gsXeKY5
        OSpzfr9Np8GGQeCVNvAksvA=
X-Google-Smtp-Source: AMsMyM76p57ZoiGRQN1Eq+JhubTnEhD2OykOUSNf7yxBLfj8KfSCNhkB4pnOHOIkfB2+AK3lieordA==
X-Received: by 2002:a17:90b:4b43:b0:202:e09c:664d with SMTP id mi3-20020a17090b4b4300b00202e09c664dmr1234462pjb.120.1663104427093;
        Tue, 13 Sep 2022 14:27:07 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78bd3000000b0053b24b0fb88sm8392466pfd.65.2022.09.13.14.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 14:27:06 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall] functions
Date:   Tue, 13 Sep 2022 06:52:13 -0700
Message-Id: <20220913135213.720368-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Tracing - through ftrace function tracer and kprobes - of certain common
syscall functions is currently disabled. Setting kprobes on these
functions is specifically useful for debugging of syscall failures.

Such tracing is disabled since __do_sys_[syscall] functions are declared
as "inline".  "inline" in the kernel is actually defined as a macro that
in addition to using the inline keyword also disables tracing (notrace).
According to the comments in the code, tracing inline functions can
wreck havoc, which is probably true in some cases.

In practice, however, this might be too extensive. The compiler regards
the "inline" keyword only as a hint, which it is free to ignore. In
fact, in my builds gcc ignores the "inline" hint for many
__do_sys_[syscall] since some of these functions are quite big and
called from multiple locations (for compat). As a result, these
functions cannot be traced.

There are 3 possible solutions for enabling the tracing of
__do_sys_[syscall]:

1. Mark __do_sys_[syscall] as __always_inline instead of inline. This
   would increase the executable size, which might not be desired.

2. Remove the inline hint from __do_sys_[syscall]. Again, it might
   affect the generated code, inducing function call overhead for some
   syscalls.

3. Remove "notrace" from the "inline" macro definition, and require
   functions that cannot be traced to be marked explicitly as "notrace".
   This might be the most correct solution, which would also enable tracing
   of additional useful functions. But finding the functions that cannot
   be traced is not easy without some automation.

4. Avoid the use of "notrace" specifically for __do_sys_[syscall].

Use the last approach to enable the tracing of __do_sys_[syscall]
functions. Introduce an "inline_trace" macro that sets the "__inline"
keyword without "notrace". Use it for the syscall wrappers.

This enables the tracing of 54 useful functions on my build, for
instance, __do_sys_vmsplice(), __do_sys_mremap() and
__do_sys_process_madvise().

Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 8 ++++----
 include/linux/compat.h                 | 4 ++--
 include/linux/compiler_types.h         | 6 +++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 59358d1bf880..2673e3551aad 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -201,14 +201,14 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline_trace long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
 	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
 		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
 	}									\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+	static inline_trace long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
@@ -227,7 +227,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline_trace long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
 	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
@@ -237,7 +237,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
 		return ret;						\
 	}								\
-	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+	static inline_trace long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
 /*
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..4d786581219b 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -75,7 +75,7 @@
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline_trace long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
@@ -84,7 +84,7 @@
 		return ret;							\
 	}									\
 	__diag_pop();								\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+	static inline_trace long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* COMPAT_SYSCALL_DEFINEx */
 
 struct compat_iovec {
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a..d88bfcf387ea 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -152,8 +152,12 @@ struct ftrace_likely_data {
  * externally visible function. This makes extern inline behave as per gnu89
  * semantics rather than c99. This prevents multiple symbol definition errors
  * of extern inline functions at link time.
- * A lot of inline functions can cause havoc with function tracing.
+ *
+ * A lot of inline functions can cause havoc with function tracing. If the
+ * function is known to be safe for tracing, inline_trace can be used. Otherwise
+ * inline would prevent tracing.
  */
+#define inline_trace __inline __gnu_inline __inline_maybe_unused
 #define inline inline __gnu_inline __inline_maybe_unused notrace
 
 /*
-- 
2.25.1

