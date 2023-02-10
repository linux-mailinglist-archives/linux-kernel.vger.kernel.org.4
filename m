Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACB692924
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjBJVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjBJVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:19:17 -0500
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCCC0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:18:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbtsRD1ly4MmHuz3K8pgOTgQ9ciqaNAhgw745M5z3qM=;
        b=B+1V8biNfQMjX3nsdY1+m73D5TjVw+j0Vl7kRfCdc1w7xSYfbVEyBvrta2xNYa6Fed0hwK
        4gpQsZv/7kDWYCx2cQrmYjS6QJKG+FhPekhF/wXcEw25xcCoYQRoQenFhU+NvRpIKzhCdw
        RIpjR+KRI2zLVti6o9s0FEnI3s7YTh0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 14/18] lib/stackdepot: rename next_pool_inited to next_pool_required
Date:   Fri, 10 Feb 2023 22:16:02 +0100
Message-Id: <484fd2695dff7a9bdc437a32f8a6ee228535aa02.1676063693.git.andreyknvl@google.com>
In-Reply-To: <cover.1676063693.git.andreyknvl@google.com>
References: <cover.1676063693.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Stack depot uses next_pool_inited to mark that either the next pool is
initialized or the limit on the number of pools is reached. However,
the flag name only reflects the former part of its purpose, which is
confusing.

Rename next_pool_inited to next_pool_required and invert its value.

Also annotate usages of next_pool_required with comments.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c4bc198c3d93..4df162a84bfe 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -96,8 +96,14 @@ static int pool_index;
 static size_t pool_offset;
 /* Lock that protects the variables above. */
 static DEFINE_RAW_SPINLOCK(pool_lock);
-/* Whether the next pool is initialized. */
-static int next_pool_inited;
+/*
+ * Stack depot tries to keep an extra pool allocated even before it runs out
+ * of space in the currently used pool.
+ * This flag marks that this next extra pool needs to be allocated and
+ * initialized. It has the value 0 when either the next pool is not yet
+ * initialized or the limit on the number of pools is reached.
+ */
+static int next_pool_required = 1;
 
 static int __init disable_stack_depot(char *str)
 {
@@ -222,10 +228,12 @@ EXPORT_SYMBOL_GPL(stack_depot_init);
 static void depot_init_pool(void **prealloc)
 {
 	/*
+	 * If the next pool is already initialized or the maximum number of
+	 * pools is reached, do not use the preallocated memory.
 	 * smp_load_acquire() here pairs with smp_store_release() below and
 	 * in depot_alloc_stack().
 	 */
-	if (smp_load_acquire(&next_pool_inited))
+	if (!smp_load_acquire(&next_pool_required))
 		return;
 
 	/* Check if the current pool is not yet allocated. */
@@ -243,10 +251,13 @@ static void depot_init_pool(void **prealloc)
 			*prealloc = NULL;
 		}
 		/*
+		 * At this point, either the next pool is initialized or the
+		 * maximum number of pools is reached. In either case, take
+		 * note that initializing another pool is not required.
 		 * This smp_store_release pairs with smp_load_acquire() above
 		 * and in stack_depot_save().
 		 */
-		smp_store_release(&next_pool_inited, 1);
+		smp_store_release(&next_pool_required, 0);
 	}
 }
 
@@ -271,11 +282,13 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		pool_index++;
 		pool_offset = 0;
 		/*
+		 * If the maximum number of pools is not reached, take note
+		 * that the next pool needs to initialized.
 		 * smp_store_release() here pairs with smp_load_acquire() in
 		 * stack_depot_save() and depot_init_pool().
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
-			smp_store_release(&next_pool_inited, 0);
+			smp_store_release(&next_pool_required, 1);
 	}
 
 	/* Assign the preallocated memory to a pool if required. */
@@ -406,14 +419,13 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		goto exit;
 
 	/*
-	 * Check if the current or the next stack pool need to be initialized.
-	 * If so, allocate the memory - we won't be able to do that under the
-	 * lock.
+	 * Check if another stack pool needs to be initialized. If so, allocate
+	 * the memory now - we won't be able to do that under the lock.
 	 *
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |next_pool_inited| in depot_alloc_stack() and depot_init_pool().
 	 */
-	if (unlikely(can_alloc && !smp_load_acquire(&next_pool_inited))) {
+	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
-- 
2.25.1

