Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0881692922
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBJVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjBJVSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:18:49 -0500
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3ED3028B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:18:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGvDrOxyRt5kOFDmqXD5ITBuCpaHJonxkPgV6Sd4X2o=;
        b=sVBTl7/5HAlYJsoNTAYJS7jHmyG0mwufQdpCh0QT0n6Tk9BlAh4+4jHAXFjNeAehSp09ID
        IEpp2QiI5YzquQvB0+kSXtzyz/47zqk8vIOAWAnjB9JeZRWKZTC7iXXkh/2GlVESua2t5Y
        R7dMt2pIa9/i109Fj4DEUmTYzXbV/98=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 13/18] lib/stackdepot: annotate depot_init_pool and depot_alloc_stack
Date:   Fri, 10 Feb 2023 22:16:01 +0100
Message-Id: <f80b02951364e6b40deda965b4003de0cd1a532d.1676063693.git.andreyknvl@google.com>
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

Clean up the exisiting comments and add new ones to depot_init_pool and
depot_alloc_stack.

As a part of the clean-up, remove mentions of which variable is accessed
by smp_store_release and smp_load_acquire: it is clear as is from the
code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d4d988276b91..c4bc198c3d93 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -218,32 +218,39 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
+/* Uses preallocated memory to initialize a new stack depot pool. */
 static void depot_init_pool(void **prealloc)
 {
 	/*
-	 * This smp_load_acquire() pairs with smp_store_release() to
-	 * |next_pool_inited| below and in depot_alloc_stack().
+	 * smp_load_acquire() here pairs with smp_store_release() below and
+	 * in depot_alloc_stack().
 	 */
 	if (smp_load_acquire(&next_pool_inited))
 		return;
+
+	/* Check if the current pool is not yet allocated. */
 	if (stack_pools[pool_index] == NULL) {
+		/* Use the preallocated memory for the current pool. */
 		stack_pools[pool_index] = *prealloc;
 		*prealloc = NULL;
 	} else {
-		/* If this is the last depot pool, do not touch the next one. */
+		/*
+		 * Otherwise, use the preallocated memory for the next pool
+		 * as long as we do not exceed the maximum number of pools.
+		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS) {
 			stack_pools[pool_index + 1] = *prealloc;
 			*prealloc = NULL;
 		}
 		/*
-		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_pool_inited| above and in stack_depot_save().
+		 * This smp_store_release pairs with smp_load_acquire() above
+		 * and in stack_depot_save().
 		 */
 		smp_store_release(&next_pool_inited, 1);
 	}
 }
 
-/* Allocation of a new stack in raw storage */
+/* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
 depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
@@ -252,28 +259,35 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 	required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
 
+	/* Check if there is not enough space in the current pool. */
 	if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
+		/* Bail out if we reached the pool limit. */
 		if (unlikely(pool_index + 1 >= DEPOT_MAX_POOLS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
+
+		/* Move on to the next pool. */
 		pool_index++;
 		pool_offset = 0;
 		/*
-		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_pool_inited| in stack_depot_save() and
-		 * depot_init_pool().
+		 * smp_store_release() here pairs with smp_load_acquire() in
+		 * stack_depot_save() and depot_init_pool().
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_inited, 0);
 	}
+
+	/* Assign the preallocated memory to a pool if required. */
 	if (*prealloc)
 		depot_init_pool(prealloc);
+
+	/* Check if we have a pool to save the stack trace. */
 	if (stack_pools[pool_index] == NULL)
 		return NULL;
 
+	/* Save the stack trace. */
 	stack = stack_pools[pool_index] + pool_offset;
-
 	stack->hash = hash;
 	stack->size = size;
 	stack->handle.pool_index = pool_index;
-- 
2.25.1

