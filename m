Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5BA692918
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjBJVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjBJVRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:17:37 -0500
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272112595
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:17:18 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdN0qpq7PVidlsBHChLWKkpFVAJ9uzHha5rImS4k+3M=;
        b=KLl8qvzoKbycCxdT4nCBIk0Y5JSFEiRTzE8rQ7hPWQgJyI6aNYe9J4JiYp9VP8KyQscvcE
        TnBdBtXz72gahKjUZfNLixZQ+HBoFx1lollCt6vbrb/4uXRxWFRj+bxxz26jLclDITfqn0
        lOVvAXmBPC4TV8M5PBP+IoohhLxIuWs=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 11/18] lib/stackdepot: rename init_stack_pool
Date:   Fri, 10 Feb 2023 22:15:59 +0100
Message-Id: <23106a3e291d8df0aba33c0e2fe86dc596286479.1676063693.git.andreyknvl@google.com>
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

Rename init_stack_pool to depot_init_pool to align the name with
depot_alloc_stack.

No functional changes.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 97bba462ee13..7f5f08bb6c3a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -218,7 +218,7 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-static bool init_stack_pool(void **prealloc)
+static bool depot_init_pool(void **prealloc)
 {
 	if (!*prealloc)
 		return false;
@@ -265,12 +265,12 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
 		 * |next_pool_inited| in stack_depot_save() and
-		 * init_stack_pool().
+		 * depot_init_pool().
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_inited, 0);
 	}
-	init_stack_pool(prealloc);
+	depot_init_pool(prealloc);
 	if (stack_pools[pool_index] == NULL)
 		return NULL;
 
@@ -399,7 +399,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * lock.
 	 *
 	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |next_pool_inited| in depot_alloc_stack() and init_stack_pool().
+	 * |next_pool_inited| in depot_alloc_stack() and depot_init_pool().
 	 */
 	if (unlikely(can_alloc && !smp_load_acquire(&next_pool_inited))) {
 		/*
@@ -435,7 +435,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * We didn't need to store this stack trace, but let's keep
 		 * the preallocated memory for the future.
 		 */
-		WARN_ON(!init_stack_pool(&prealloc));
+		WARN_ON(!depot_init_pool(&prealloc));
 	}
 
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.25.1

