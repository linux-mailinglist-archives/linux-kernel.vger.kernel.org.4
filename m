Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED51B681BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjA3UwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjA3UwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:52:10 -0500
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E63B3F5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:51:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlJNrgwkJjY9MAGqUmKKlmI8AUnL0lcVfhP1HY83LkM=;
        b=eYNx9UpTD8qASdAvQ2avXbDAzDV2XZyf2RCfcvrg11Z3tf9mCrYiiV6w1yAx9dx3/GBwYW
        pyvA7lWPKBOd+CbhHKC8yhjQP8SgvWhgeotaVOX7oF+PqX3R0B7OR1AjbnJRaZIq6CK/KL
        3u69jMJaEnaHOynRgJBlAMbH9ZxnhRg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 13/18] lib/stacktrace: drop impossible WARN_ON for depot_init_slab
Date:   Mon, 30 Jan 2023 21:49:37 +0100
Message-Id: <7e7434a0d4e8a71138aec2c8a3c69a4eebf49935.1675111415.git.andreyknvl@google.com>
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

depot_init_slab has two call sites:

1. In depot_alloc_stack with a potentially NULL prealloc.
2. In __stack_depot_save with a non-NULL prealloc.

At the same time depot_init_slab can only return false when prealloc is
NULL.

As the second call site makes sure that prealloc is not NULL, the WARN_ON
there can never trigger. Thus, drop the WARN_ON and also move the prealloc
check from depot_init_slab to its first call site.

Also change the return type of depot_init_slab to void as it now always
returns true.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index b946ba74fea0..d6be82a5c223 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -218,16 +218,14 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-static bool depot_init_slab(void **prealloc)
+static void depot_init_slab(void **prealloc)
 {
-	if (!*prealloc)
-		return false;
 	/*
 	 * This smp_load_acquire() pairs with smp_store_release() to
 	 * |next_slab_inited| below and in depot_alloc_stack().
 	 */
 	if (smp_load_acquire(&next_slab_inited))
-		return true;
+		return;
 	if (stack_slabs[slab_index] == NULL) {
 		stack_slabs[slab_index] = *prealloc;
 		*prealloc = NULL;
@@ -244,7 +242,6 @@ static bool depot_init_slab(void **prealloc)
 			smp_store_release(&next_slab_inited, 1);
 		}
 	}
-	return true;
 }
 
 /* Allocation of a new stack in raw storage */
@@ -271,7 +268,8 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		if (slab_index + 1 < DEPOT_MAX_SLABS)
 			smp_store_release(&next_slab_inited, 0);
 	}
-	depot_init_slab(prealloc);
+	if (*prealloc)
+		depot_init_slab(prealloc);
 	if (stack_slabs[slab_index] == NULL)
 		return NULL;
 
@@ -436,7 +434,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * We didn't need to store this stack trace, but let's keep
 		 * the preallocated memory for the future.
 		 */
-		WARN_ON(!depot_init_slab(&prealloc));
+		depot_init_slab(&prealloc);
 	}
 
 	raw_spin_unlock_irqrestore(&slab_lock, flags);
-- 
2.25.1

