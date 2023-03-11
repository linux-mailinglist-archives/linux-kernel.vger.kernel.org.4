Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D866B55DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjCJXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjCJXnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:43:40 -0500
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472EF115DF1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:43:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678491817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FR0GMMMnNdReMCefH2++iHzkAdqxWWuGhtNaRaBked8=;
        b=irItE+Jgfq84/wI+LBBhF478xDum91DlaJ3tXbxceNY1XuIeNE7SUeo192nrF/ADVo32Nv
        Mj/JU3ixWvLjBranQUiClYjvymP9MlGX94edM0Nqg2NpmEY1d0xzpdJW3KDOTg+t03LIw+
        xlYUVAF+y/E5u7z5X5p0iduduPtLIuY=
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
Subject: [PATCH 2/5] kasan, arm64: rename tagging-related routines
Date:   Sat, 11 Mar 2023 00:43:30 +0100
Message-Id: <069ef5b77715c1ac8d69b186725576c32b149491.1678491668.git.andreyknvl@google.com>
In-Reply-To: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
References: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Rename arch_enable_tagging_sync/async/asymm to
arch_enable_tag_checks_sync/async/asymm, as the new name better reflects
their function.

Also rename kasan_enable_tagging to kasan_enable_hw_tags for the same
reason.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h |  6 +++---
 mm/kasan/hw_tags.c              | 12 ++++++------
 mm/kasan/kasan.h                | 10 +++++-----
 mm/kasan/kasan_test.c           |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..faf42bff9a60 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -261,9 +261,9 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define arch_enable_tagging_sync()		mte_enable_kernel_sync()
-#define arch_enable_tagging_async()		mte_enable_kernel_async()
-#define arch_enable_tagging_asymm()		mte_enable_kernel_asymm()
+#define arch_enable_tag_checks_sync()		mte_enable_kernel_sync()
+#define arch_enable_tag_checks_async()		mte_enable_kernel_async()
+#define arch_enable_tag_checks_asymm()		mte_enable_kernel_asymm()
 #define arch_force_async_tag_fault()		mte_check_tfsr_exit()
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index d1bcb0205327..b092e37b69a7 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -205,7 +205,7 @@ void kasan_init_hw_tags_cpu(void)
 	 * Enable async or asymm modes only when explicitly requested
 	 * through the command line.
 	 */
-	kasan_enable_tagging();
+	kasan_enable_hw_tags();
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
@@ -373,19 +373,19 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
 
 #endif
 
-void kasan_enable_tagging(void)
+void kasan_enable_hw_tags(void)
 {
 	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
-		hw_enable_tagging_async();
+		hw_enable_tag_checks_async();
 	else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
-		hw_enable_tagging_asymm();
+		hw_enable_tag_checks_asymm();
 	else
-		hw_enable_tagging_sync();
+		hw_enable_tag_checks_sync();
 }
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
-EXPORT_SYMBOL_GPL(kasan_enable_tagging);
+EXPORT_SYMBOL_GPL(kasan_enable_hw_tags);
 
 void kasan_force_async_fault(void)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b1895526d02f..a1613f5d7608 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -395,20 +395,20 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
-#define hw_enable_tagging_sync()		arch_enable_tagging_sync()
-#define hw_enable_tagging_async()		arch_enable_tagging_async()
-#define hw_enable_tagging_asymm()		arch_enable_tagging_asymm()
+#define hw_enable_tag_checks_sync()		arch_enable_tag_checks_sync()
+#define hw_enable_tag_checks_async()		arch_enable_tag_checks_async()
+#define hw_enable_tag_checks_asymm()		arch_enable_tag_checks_asymm()
 #define hw_force_async_tag_fault()		arch_force_async_tag_fault()
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
 #define hw_set_mem_tag_range(addr, size, tag, init) \
 			arch_set_mem_tag_range((addr), (size), (tag), (init))
 
-void kasan_enable_tagging(void);
+void kasan_enable_hw_tags(void);
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
-static inline void kasan_enable_tagging(void) { }
+static inline void kasan_enable_hw_tags(void) { }
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 627eaf1ee1db..a375776f9896 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -148,7 +148,7 @@ static void kasan_test_exit(struct kunit *test)
 	    kasan_sync_fault_possible()) {				\
 		if (READ_ONCE(test_status.report_found) &&		\
 		    !READ_ONCE(test_status.async_fault))		\
-			kasan_enable_tagging();				\
+			kasan_enable_hw_tags();				\
 		migrate_enable();					\
 	}								\
 	WRITE_ONCE(test_status.report_found, false);			\
-- 
2.25.1

