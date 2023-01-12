Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A81666FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjALKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjALKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:45 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8655879
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:31:53 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id hp2-20020a1709073e0200b0084d47e3fe82so8446112ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LSkZFm2zhcJ11sH6VV/UUBhi7d17SDGndMSvaJIxOZI=;
        b=osDqB7oB9rliiSEwujnVRRlF2iLya0drTf/pDhu92kUkCg30pCF8TFT1zoQOR4sxof
         rQ/zRExf3uGEYMJLnCrYtgReLRAHWLcYQ1RtH/q4QvG5G9TTKt32LQLyr1J9mOujv62k
         JCsOMnQUJ0f0/46fBpXaS4x3rk4UOuiWnE1PsQRb71wyBl2SffSxNs5jCB75hKlG4z7y
         +UbLxQ+m0/phOR5KpY8E1S8LYGdxd4kEQul9sOPZ46HQQ4h3z7WD5mTStE1O9wNy5YMr
         cspLC3jr8JFMi+zRboBTrI9qpopxyybLjqw1gAbnZVDC/B9Zs5UzjAsesbGTV9RDtNg2
         DQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSkZFm2zhcJ11sH6VV/UUBhi7d17SDGndMSvaJIxOZI=;
        b=HkwhWymDeSuRJrwZxp8Di+rlFzN4MsjBC7kPGBrzKkT9obRTvgoH61UtCTckxEMpKE
         PGdjmH7FG4mfILhHJ1FTXRJRJ7f0zXeXcdItG5/G49Bdssbi4vyrunK0IPR70Om2wi2N
         eoHKluZGZ1HGyWz7I2ob8PFmxotplilpBPdbLUp3IgR+y6QM12w5+hBiJn/yTmRtRYIn
         DuFY8ds5ZJxNBBULIq+PWsYZCLoOJM9Y7boctHNS88cNe86NJ8ayQQbnQA6JWSm0bHYx
         rGMIDSexwl7XiIs2MrMRv57T3kXecW6bjc4qPB2PbqOWUnpdyWy1knJ/rmStGOBfwWC8
         T1dg==
X-Gm-Message-State: AFqh2kpjEpwEky6YIuONcMzru1m87OHCyATqXzN2ARUrDL4+QOmWliB+
        CwjZGZ3Qur5mQVVBTQx5bC3Sw5M0/Io=
X-Google-Smtp-Source: AMrXdXsiV3DmNxAS7ow1FffnVfftZlNGUXqJ+SVvKBpRxiv55Tp5gQYdKTozmOpocUEgNb+vEtR77ZqNiQc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c17f:273f:c35:6186])
 (user=glider job=sendgmr) by 2002:a17:906:b88d:b0:7c0:911e:199a with SMTP id
 hb13-20020a170906b88d00b007c0911e199amr5393223ejb.689.1673519511607; Thu, 12
 Jan 2023 02:31:51 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:31:47 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112103147.382416-1-glider@google.com>
Subject: [PATCH] kmsan: silence -Wmissing-prototypes warnings
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, elver@google.com,
        dvyukov@google.com, linux-mm@kvack.org, kasan-dev@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with W=1, the compiler reports numerous
warnings about the missing prototypes for KMSAN instrumentation hooks.

Because these functions are not supposed to be called explicitly by the
kernel code (calls to them are emitted by the compiler), they do not
have to be declared in the headers. Instead, we add forward declarations
right before the definitions to silence the warnings produced by
-Wmissing-prototypes.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202301020356.dFruA4I5-lkp@intel.com/T/
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/instrumentation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index 770fe02904f36..cf12e9616b243 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -38,7 +38,15 @@ get_shadow_origin_ptr(void *addr, u64 size, bool store)
 	return ret;
 }
 
+/*
+ * KMSAN instrumentation functions follow. They are not declared elsewhere in
+ * the kernel code, so they are preceded by prototypes, to silence
+ * -Wmissing-prototypes warnings.
+ */
+
 /* Get shadow and origin pointers for a memory load with non-standard size. */
+struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
+							uintptr_t size);
 struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
 							uintptr_t size)
 {
@@ -47,6 +55,8 @@ struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
 EXPORT_SYMBOL(__msan_metadata_ptr_for_load_n);
 
 /* Get shadow and origin pointers for a memory store with non-standard size. */
+struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
+							 uintptr_t size);
 struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
 							 uintptr_t size)
 {
@@ -59,12 +69,16 @@ EXPORT_SYMBOL(__msan_metadata_ptr_for_store_n);
  * with fixed size.
  */
 #define DECLARE_METADATA_PTR_GETTER(size)                                  \
+	struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(      \
+		void *addr);                                               \
 	struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(      \
 		void *addr)                                                \
 	{                                                                  \
 		return get_shadow_origin_ptr(addr, size, /*store*/ false); \
 	}                                                                  \
 	EXPORT_SYMBOL(__msan_metadata_ptr_for_load_##size);                \
+	struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(     \
+		void *addr);                                               \
 	struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(     \
 		void *addr)                                                \
 	{                                                                  \
@@ -86,6 +100,7 @@ DECLARE_METADATA_PTR_GETTER(8);
  * entering or leaving IRQ. We omit the check for kmsan_in_runtime() to ensure
  * the memory written to in these cases is also marked as initialized.
  */
+void __msan_instrument_asm_store(void *addr, uintptr_t size);
 void __msan_instrument_asm_store(void *addr, uintptr_t size)
 {
 	unsigned long ua_flags;
@@ -138,6 +153,7 @@ static inline void set_retval_metadata(u64 shadow, depot_stack_handle_t origin)
 }
 
 /* Handle llvm.memmove intrinsic. */
+void *__msan_memmove(void *dst, const void *src, uintptr_t n);
 void *__msan_memmove(void *dst, const void *src, uintptr_t n)
 {
 	depot_stack_handle_t origin;
@@ -162,6 +178,7 @@ void *__msan_memmove(void *dst, const void *src, uintptr_t n)
 EXPORT_SYMBOL(__msan_memmove);
 
 /* Handle llvm.memcpy intrinsic. */
+void *__msan_memcpy(void *dst, const void *src, uintptr_t n);
 void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
 {
 	depot_stack_handle_t origin;
@@ -188,6 +205,7 @@ void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
 EXPORT_SYMBOL(__msan_memcpy);
 
 /* Handle llvm.memset intrinsic. */
+void *__msan_memset(void *dst, int c, uintptr_t n);
 void *__msan_memset(void *dst, int c, uintptr_t n)
 {
 	depot_stack_handle_t origin;
@@ -217,6 +235,7 @@ EXPORT_SYMBOL(__msan_memset);
  * uninitialized value to memory. When reporting an error, KMSAN unrolls and
  * prints the whole chain of stores that preceded the use of this value.
  */
+depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin);
 depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
 {
 	depot_stack_handle_t ret = 0;
@@ -237,6 +256,7 @@ depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
 EXPORT_SYMBOL(__msan_chain_origin);
 
 /* Poison a local variable when entering a function. */
+void __msan_poison_alloca(void *address, uintptr_t size, char *descr);
 void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
 {
 	depot_stack_handle_t handle;
@@ -272,6 +292,7 @@ void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
 EXPORT_SYMBOL(__msan_poison_alloca);
 
 /* Unpoison a local variable. */
+void __msan_unpoison_alloca(void *address, uintptr_t size);
 void __msan_unpoison_alloca(void *address, uintptr_t size)
 {
 	if (!kmsan_enabled || kmsan_in_runtime())
@@ -287,6 +308,7 @@ EXPORT_SYMBOL(__msan_unpoison_alloca);
  * Report that an uninitialized value with the given origin was used in a way
  * that constituted undefined behavior.
  */
+void __msan_warning(u32 origin);
 void __msan_warning(u32 origin)
 {
 	if (!kmsan_enabled || kmsan_in_runtime())
@@ -303,6 +325,7 @@ EXPORT_SYMBOL(__msan_warning);
  * At the beginning of an instrumented function, obtain the pointer to
  * `struct kmsan_context_state` holding the metadata for function parameters.
  */
+struct kmsan_context_state *__msan_get_context_state(void);
 struct kmsan_context_state *__msan_get_context_state(void)
 {
 	return &kmsan_get_context()->cstate;
-- 
2.39.0.314.g84b9a713c41-goog

