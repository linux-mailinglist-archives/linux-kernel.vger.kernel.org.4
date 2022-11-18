Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5662F930
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiKRPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiKRPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:22:23 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6411CB08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:22:22 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id f20-20020a0564021e9400b00461ea0ce17cso3166171edf.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXs9oQxTshLyON7VsLwg1Sxn4Bm1fEFFQRofp2aAizY=;
        b=s8dI+I16xOEuDRsdf4jECwVTSX53sIE6vf0opOeUrkxo9ZQ7kt8qURebrLB39xuPpy
         oIvI36NbtUXmE9TmXxhhkyxfWZoRqkPYmkL7eedoNbia2Uk6z9P95RDl1QrWFdtbNiRz
         P5C22iiBvcecS8Akf5SMvRKUNYeSTXKQUXJN7s3nlIqlZmGfaTb1MWZ6xo4kLoBQvtZP
         tE73/bJFXmnqcH2qI/7zOzicZ5YMN6pZKcLnCmColPwRxGPFT79KtP4waHTCVdAj50FO
         XlAyrMxA3dW5B3XUIU2gSZ8QxB0JNno13lFk89nlQlotG9nGc3mztDMZrjO7Nc+NHfAs
         ZSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXs9oQxTshLyON7VsLwg1Sxn4Bm1fEFFQRofp2aAizY=;
        b=toXQeQEtbR3O6En25WBjdGBWr+5ieYjb1eUj6ruAmtCuI2aFMoPmiA6WL9yGKvk5SX
         qR5gYGnilz8Vl7rF1yn4Fy4Lw3wO2r+o08tvar7ZURTn0wUdWvYI49su0mwoEVYcs8lS
         SQHOB2/HiwVXoc91klRCdz/cW5tjh+Wdi8L+Mpwe/tOoQCFHEnTn2mgvu1vIQ5hxxpbK
         xcTW5C28hnOw924LaTr8LW+FJAne0Dm9T9DnQe/RmdTRYyVWn6WbrDozJpCWxWyFoIMj
         EYbb5uo1ppRZxe/gMT7LNBPAUsL/nfCmy28geWVCCIMl0VYazwEGn/6BLwvMg4dhpWwS
         z78g==
X-Gm-Message-State: ANoB5pniJRkeri41mfHFoVdkBbympMx7tJnNxbaQUYBlPbfGVQWKofRi
        sgAFbW/p+9AQYTFsdJgvJBg9ZKmKrg==
X-Google-Smtp-Source: AA0mqf6YMzqdbjEDOHFYJxLody0tJqiMo1GC59oUVha1/zglgOtJjcdY+JRvmhio/ZOtjQubIof6cJu/jA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:4799:a943:410e:976])
 (user=elver job=sendgmr) by 2002:a05:6402:f11:b0:467:8813:cab5 with SMTP id
 i17-20020a0564020f1100b004678813cab5mr6512139eda.369.1668784941290; Fri, 18
 Nov 2022 07:22:21 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:22:16 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221118152216.3914899-1-elver@google.com>
Subject: [PATCH] kfence: fix stack trace pruning
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>
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

Commit b14051352465 ("mm/sl[au]b: generalize kmalloc subsystem")
refactored large parts of the kmalloc subsystem, resulting in the stack
trace pruning logic done by KFENCE to no longer work.

While b14051352465 attempted to fix the situation by including
'__kmem_cache_free' in the list of functions KFENCE should skip through,
this only works when the compiler actually optimized the tail call from
kfree() to __kmem_cache_free() into a jump (and thus kfree() _not_
appearing in the full stack trace to begin with).

In some configurations, the compiler no longer optimizes the tail call
into a jump, and __kmem_cache_free() appears in the stack trace. This
means that the pruned stack trace shown by KFENCE would include kfree()
which is not intended - for example:

 | BUG: KFENCE: invalid free in kfree+0x7c/0x120
 |
 | Invalid free of 0xffff8883ed8fefe0 (in kfence-#126):
 |  kfree+0x7c/0x120
 |  test_double_free+0x116/0x1a9
 |  kunit_try_run_case+0x90/0xd0
 | [...]

Fix it by moving __kmem_cache_free() to the list of functions that may
be tail called by an allocator entry function, making the pruning logic
work in both the optimized and unoptimized tail call cases.

Fixes: b14051352465 ("mm/sl[au]b: generalize kmalloc subsystem")
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/report.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 7e496856c2eb..46ecea18c4ca 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -75,18 +75,23 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 
 		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
 		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
+		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_free") ||
 		    !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
 			/*
-			 * In case of tail calls from any of the below
-			 * to any of the above.
+			 * In case of tail calls from any of the below to any of
+			 * the above, optimized by the compiler such that the
+			 * stack trace would omit the initial entry point below.
 			 */
 			fallback = skipnr + 1;
 		}
 
-		/* Also the *_bulk() variants by only checking prefixes. */
+		/*
+		 * The below list should only include the initial entry points
+		 * into the slab allocators. Includes the *_bulk() variants by
+		 * checking prefixes.
+		 */
 		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
 		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_free") ||
 		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
 		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_alloc"))
 			goto found;
-- 
2.38.1.584.g0f3c55d4c2-goog

