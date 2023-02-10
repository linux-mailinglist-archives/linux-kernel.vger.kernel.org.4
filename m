Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D6692921
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjBJVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjBJVSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:18:48 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6124106
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:18:20 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNTpFR8imhU+1RyFIUQnZTnn23HrW1qgGxbRYaqWOq4=;
        b=b9EI77+Lu2ejg1Id6cPrNsMBDYr8WIpJ2zMEg4RXlgJI+QYF6OL/oaxKk1OH2WIRdUewQW
        zBxE8rT/+Ts7luOzOazTc5KLDee/mIDM5G27VvuS9X7RoT9lIJeLwV8TTioXm6vGFwrCjU
        VRzh0cOmh0kJxe7ubs0kkTWdypYXNt4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 12/18] lib/stacktrace: drop impossible WARN_ON for depot_init_pool
Date:   Fri, 10 Feb 2023 22:16:00 +0100
Message-Id: <ce149f9bdcbc80a92549b54da67eafb27f846b7b.1676063693.git.andreyknvl@google.com>
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

depot_init_pool has two call sites:

1. In depot_alloc_stack with a potentially NULL prealloc.
2. In __stack_depot_save with a non-NULL prealloc.

At the same time depot_init_pool can only return false when prealloc is
NULL.

As the second call site makes sure that prealloc is not NULL, the WARN_ON
there can never trigger. Thus, drop the WARN_ON and also move the prealloc
check from depot_init_pool to its first call site.

Also change the return type of depot_init_pool to void as it now always
returns true.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 7f5f08bb6c3a..d4d988276b91 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -218,16 +218,14 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-static bool depot_init_pool(void **prealloc)
+static void depot_init_pool(void **prealloc)
 {
-	if (!*prealloc)
-		return false;
 	/*
 	 * This smp_load_acquire() pairs with smp_store_release() to
 	 * |next_pool_inited| below and in depot_alloc_stack().
 	 */
 	if (smp_load_acquire(&next_pool_inited))
-		return true;
+		return;
 	if (stack_pools[pool_index] == NULL) {
 		stack_pools[pool_index] = *prealloc;
 		*prealloc = NULL;
@@ -243,7 +241,6 @@ static bool depot_init_pool(void **prealloc)
 		 */
 		smp_store_release(&next_pool_inited, 1);
 	}
-	return true;
 }
 
 /* Allocation of a new stack in raw storage */
@@ -270,7 +267,8 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_inited, 0);
 	}
-	depot_init_pool(prealloc);
+	if (*prealloc)
+		depot_init_pool(prealloc);
 	if (stack_pools[pool_index] == NULL)
 		return NULL;
 
@@ -435,7 +433,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * We didn't need to store this stack trace, but let's keep
 		 * the preallocated memory for the future.
 		 */
-		WARN_ON(!depot_init_pool(&prealloc));
+		depot_init_pool(&prealloc);
 	}
 
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.25.1

