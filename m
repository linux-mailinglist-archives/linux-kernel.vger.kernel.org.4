Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8B6CF249
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjC2SiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC2SiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:38:05 -0400
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4813AB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:38:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680115078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0ZTLDK0+ErC3gsprSGJ+tiVFRHa88yHqEYRk0ERiZ0=;
        b=oP2VA3+D9Qr8dKR4UOrrmrc1+nxlHZsTDv96qHpFlLIIE0qAxFcHxNtGpjSuXYDtYGe7g0
        R9YJpt11ce2lsJJGHndi0vAWGx+Lrt1/J0xo2kovQdSX5r6myxaV5UGnajysVl3a/fkg9M
        5PYt++7HFPVvKJdr1l9qX0EEByPuMKk=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 3/5] arm64: mte: Rename TCO routines
Date:   Wed, 29 Mar 2023 20:37:46 +0200
Message-Id: <74d26337b2360733956114069e96ff11c296a944.1680114854.git.andreyknvl@google.com>
In-Reply-To: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
References: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

The TCO related routines are used in uaccess methods and
load_unaligned_zeropad() but are unrelated to both even if the naming
suggest otherwise.

Improve the readability of the code moving the away from uaccess.h and
pre-pending them with "mte".

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Chages v1->v2:
- Drop __ from mte_disable/enable_tco names, as those functions are to
  be exported to KASAN code.
---
 arch/arm64/include/asm/mte-kasan.h      | 81 +++++++++++++++++++++++++
 arch/arm64/include/asm/mte.h            | 12 ----
 arch/arm64/include/asm/uaccess.h        | 66 +++-----------------
 arch/arm64/include/asm/word-at-a-time.h |  4 +-
 4 files changed, 93 insertions(+), 70 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 9f79425fc65a..2e98028c1965 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -13,8 +13,73 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+/* Whether the MTE asynchronous mode is enabled. */
+DECLARE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
+
+static inline bool system_uses_mte_async_or_asymm_mode(void)
+{
+	return static_branch_unlikely(&mte_async_or_asymm_mode);
+}
+
+#else /* CONFIG_KASAN_HW_TAGS */
+
+static inline bool system_uses_mte_async_or_asymm_mode(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 #ifdef CONFIG_ARM64_MTE
 
+/*
+ * The Tag Check Flag (TCF) mode for MTE is per EL, hence TCF0
+ * affects EL0 and TCF affects EL1 irrespective of which TTBR is
+ * used.
+ * The kernel accesses TTBR0 usually with LDTR/STTR instructions
+ * when UAO is available, so these would act as EL0 accesses using
+ * TCF0.
+ * However futex.h code uses exclusives which would be executed as
+ * EL1, this can potentially cause a tag check fault even if the
+ * user disables TCF0.
+ *
+ * To address the problem we set the PSTATE.TCO bit in uaccess_enable()
+ * and reset it in uaccess_disable().
+ *
+ * The Tag check override (TCO) bit disables temporarily the tag checking
+ * preventing the issue.
+ */
+static inline void mte_disable_tco(void)
+{
+	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(0),
+				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
+}
+
+static inline void mte_enable_tco(void)
+{
+	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
+				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
+}
+
+/*
+ * These functions disable tag checking only if in MTE async mode
+ * since the sync mode generates exceptions synchronously and the
+ * nofault or load_unaligned_zeropad can handle them.
+ */
+static inline void __mte_disable_tco_async(void)
+{
+	if (system_uses_mte_async_or_asymm_mode())
+		mte_disable_tco();
+}
+
+static inline void __mte_enable_tco_async(void)
+{
+	if (system_uses_mte_async_or_asymm_mode())
+		mte_enable_tco();
+}
+
 /*
  * These functions are meant to be only used from KASAN runtime through
  * the arch_*() interface defined in asm/memory.h.
@@ -138,6 +203,22 @@ void mte_enable_kernel_asymm(void);
 
 #else /* CONFIG_ARM64_MTE */
 
+static inline void mte_disable_tco(void)
+{
+}
+
+static inline void mte_enable_tco(void)
+{
+}
+
+static inline void __mte_disable_tco_async(void)
+{
+}
+
+static inline void __mte_enable_tco_async(void)
+{
+}
+
 static inline u8 mte_get_ptr_tag(void *ptr)
 {
 	return 0xFF;
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 20dd06d70af5..c028afb1cd0b 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -178,14 +178,6 @@ static inline void mte_disable_tco_entry(struct task_struct *task)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
-/* Whether the MTE asynchronous mode is enabled. */
-DECLARE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
-
-static inline bool system_uses_mte_async_or_asymm_mode(void)
-{
-	return static_branch_unlikely(&mte_async_or_asymm_mode);
-}
-
 void mte_check_tfsr_el1(void);
 
 static inline void mte_check_tfsr_entry(void)
@@ -212,10 +204,6 @@ static inline void mte_check_tfsr_exit(void)
 	mte_check_tfsr_el1();
 }
 #else
-static inline bool system_uses_mte_async_or_asymm_mode(void)
-{
-	return false;
-}
 static inline void mte_check_tfsr_el1(void)
 {
 }
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5c7b2f9d5913..30ea7b5c3ccb 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -136,55 +136,9 @@ static inline void __uaccess_enable_hw_pan(void)
 			CONFIG_ARM64_PAN));
 }
 
-/*
- * The Tag Check Flag (TCF) mode for MTE is per EL, hence TCF0
- * affects EL0 and TCF affects EL1 irrespective of which TTBR is
- * used.
- * The kernel accesses TTBR0 usually with LDTR/STTR instructions
- * when UAO is available, so these would act as EL0 accesses using
- * TCF0.
- * However futex.h code uses exclusives which would be executed as
- * EL1, this can potentially cause a tag check fault even if the
- * user disables TCF0.
- *
- * To address the problem we set the PSTATE.TCO bit in uaccess_enable()
- * and reset it in uaccess_disable().
- *
- * The Tag check override (TCO) bit disables temporarily the tag checking
- * preventing the issue.
- */
-static inline void __uaccess_disable_tco(void)
-{
-	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(0),
-				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
-}
-
-static inline void __uaccess_enable_tco(void)
-{
-	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
-				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
-}
-
-/*
- * These functions disable tag checking only if in MTE async mode
- * since the sync mode generates exceptions synchronously and the
- * nofault or load_unaligned_zeropad can handle them.
- */
-static inline void __uaccess_disable_tco_async(void)
-{
-	if (system_uses_mte_async_or_asymm_mode())
-		 __uaccess_disable_tco();
-}
-
-static inline void __uaccess_enable_tco_async(void)
-{
-	if (system_uses_mte_async_or_asymm_mode())
-		__uaccess_enable_tco();
-}
-
 static inline void uaccess_disable_privileged(void)
 {
-	__uaccess_disable_tco();
+	mte_disable_tco();
 
 	if (uaccess_ttbr0_disable())
 		return;
@@ -194,7 +148,7 @@ static inline void uaccess_disable_privileged(void)
 
 static inline void uaccess_enable_privileged(void)
 {
-	__uaccess_enable_tco();
+	mte_enable_tco();
 
 	if (uaccess_ttbr0_enable())
 		return;
@@ -302,8 +256,8 @@ do {									\
 #define get_user	__get_user
 
 /*
- * We must not call into the scheduler between __uaccess_enable_tco_async() and
- * __uaccess_disable_tco_async(). As `dst` and `src` may contain blocking
+ * We must not call into the scheduler between __mte_enable_tco_async() and
+ * __mte_disable_tco_async(). As `dst` and `src` may contain blocking
  * functions, we must evaluate these outside of the critical section.
  */
 #define __get_kernel_nofault(dst, src, type, err_label)			\
@@ -312,10 +266,10 @@ do {									\
 	__typeof__(src) __gkn_src = (src);				\
 	int __gkn_err = 0;						\
 									\
-	__uaccess_enable_tco_async();					\
+	__mte_enable_tco_async();					\
 	__raw_get_mem("ldr", *((type *)(__gkn_dst)),			\
 		      (__force type *)(__gkn_src), __gkn_err, K);	\
-	__uaccess_disable_tco_async();					\
+	__mte_disable_tco_async();					\
 									\
 	if (unlikely(__gkn_err))					\
 		goto err_label;						\
@@ -388,8 +342,8 @@ do {									\
 #define put_user	__put_user
 
 /*
- * We must not call into the scheduler between __uaccess_enable_tco_async() and
- * __uaccess_disable_tco_async(). As `dst` and `src` may contain blocking
+ * We must not call into the scheduler between __mte_enable_tco_async() and
+ * __mte_disable_tco_async(). As `dst` and `src` may contain blocking
  * functions, we must evaluate these outside of the critical section.
  */
 #define __put_kernel_nofault(dst, src, type, err_label)			\
@@ -398,10 +352,10 @@ do {									\
 	__typeof__(src) __pkn_src = (src);				\
 	int __pkn_err = 0;						\
 									\
-	__uaccess_enable_tco_async();					\
+	__mte_enable_tco_async();					\
 	__raw_put_mem("str", *((type *)(__pkn_src)),			\
 		      (__force type *)(__pkn_dst), __pkn_err, K);	\
-	__uaccess_disable_tco_async();					\
+	__mte_disable_tco_async();					\
 									\
 	if (unlikely(__pkn_err))					\
 		goto err_label;						\
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index 1c8e4f2490bf..f3b151ed0d7a 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -55,7 +55,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
-	__uaccess_enable_tco_async();
+	__mte_enable_tco_async();
 
 	/* Load word from unaligned pointer addr */
 	asm(
@@ -65,7 +65,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	: "=&r" (ret)
 	: "r" (addr), "Q" (*(unsigned long *)addr));
 
-	__uaccess_disable_tco_async();
+	__mte_disable_tco_async();
 
 	return ret;
 }
-- 
2.25.1

