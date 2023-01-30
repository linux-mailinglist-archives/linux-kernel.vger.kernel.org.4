Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E6A681BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjA3UwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjA3UwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:52:11 -0500
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907941B47
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:51:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2WDy/mEQLvnsHLslgORbsPKJysJoBtCH/6FUJBS3Gs=;
        b=g5/h01z3OWfSRlw1beHiwIL6fNUDX0iYu6MtlD/gLSgQhBt5T1xVKAwPQBKGTXJyigmSNM
        i1fbZwHKtli9NOUEtpO14qb9rNz2hYzP/sRDzf5riZ9Kbzr72tKm+GajdMspGquHMwwfM7
        HWQDdIeZPBmj+w12/quHXidzO+Bki8s=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 14/18] lib/stackdepot: annotate depot_init_slab and depot_alloc_stack
Date:   Mon, 30 Jan 2023 21:49:38 +0100
Message-Id: <3cf68a23da43cef0f8737f7a2c07f35ce6d841a7.1675111415.git.andreyknvl@google.com>
In-Reply-To: <cover.1675111415.git.andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
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

Clean up the exisiting comments and add new ones to depot_init_slab and
depot_alloc_stack.

As a part of the clean-up, remove mentions of which variable is accessed
by smp_store_release and smp_load_acquire: it is clear as is from the
code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d6be82a5c223..7282565722f2 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -218,33 +218,41 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
+/* Uses preallocated memory to initialize a new stack depot slab. */
 static void depot_init_slab(void **prealloc)
 {
 	/*
-	 * This smp_load_acquire() pairs with smp_store_release() to
-	 * |next_slab_inited| below and in depot_alloc_stack().
+	 * If the next slab is already initialized, do not use the
+	 * preallocated memory.
+	 * smp_load_acquire() here pairs with smp_store_release() below and
+	 * in depot_alloc_stack().
 	 */
 	if (smp_load_acquire(&next_slab_inited))
 		return;
+
+	/* Check if the current slab is not yet allocated. */
 	if (stack_slabs[slab_index] == NULL) {
+		/* Use the preallocated memory for the current slab. */
 		stack_slabs[slab_index] = *prealloc;
 		*prealloc = NULL;
 	} else {
-		/* If this is the last depot slab, do not touch the next one. */
+		/*
+		 * Otherwise, use the preallocated memory for the next slab
+		 * as long as we do not exceed the maximum number of slabs.
+		 */
 		if (slab_index + 1 < DEPOT_MAX_SLABS) {
 			stack_slabs[slab_index + 1] = *prealloc;
 			*prealloc = NULL;
 			/*
 			 * This smp_store_release pairs with smp_load_acquire()
-			 * from |next_slab_inited| above and in
-			 * stack_depot_save().
+			 * above and in stack_depot_save().
 			 */
 			smp_store_release(&next_slab_inited, 1);
 		}
 	}
 }
 
-/* Allocation of a new stack in raw storage */
+/* Allocates a new stack in a stack depot slab. */
 static struct stack_record *
 depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
@@ -253,28 +261,35 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 	required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
 
+	/* Check if there is not enough space in the current slab. */
 	if (unlikely(slab_offset + required_size > DEPOT_SLAB_SIZE)) {
+		/* Bail out if we reached the slab limit. */
 		if (unlikely(slab_index + 1 >= DEPOT_MAX_SLABS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
+
+		/* Move on to the next slab. */
 		slab_index++;
 		slab_offset = 0;
 		/*
-		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in stack_depot_save() and
-		 * depot_init_slab().
+		 * smp_store_release() here pairs with smp_load_acquire() in
+		 * stack_depot_save() and depot_init_slab().
 		 */
 		if (slab_index + 1 < DEPOT_MAX_SLABS)
 			smp_store_release(&next_slab_inited, 0);
 	}
+
+	/* Assign the preallocated memory to a slab if required. */
 	if (*prealloc)
 		depot_init_slab(prealloc);
+
+	/* Check if we have a slab to save the stack trace. */
 	if (stack_slabs[slab_index] == NULL)
 		return NULL;
 
+	/* Save the stack trace. */
 	stack = stack_slabs[slab_index] + slab_offset;
-
 	stack->hash = hash;
 	stack->size = size;
 	stack->handle.slab_index = slab_index;
-- 
2.25.1

