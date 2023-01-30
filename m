Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3B681BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjA3UvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjA3Uu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:57 -0500
Received: from out-123.mta0.migadu.com (out-123.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916272B0A5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57d540mJERXvBQP3H394VQ1KkYAn0jgbzOXp+cklDfk=;
        b=tFaC4h3ny4KHK6KzVpTLfphtX0wgv6hr2F1IlbR9lxqmNdFBdXy03CvsRXm9O6MKj4NsAn
        CTqvr8DlBi/FIBP/httW9sIeE7tRDO0I9xlzY7K90zPiYCGkwIi2vq/DRFu1UdbXz8pOf4
        xyLsJWVX1RFdwNDIWgGGCX387z78BgY=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 10/18] lib/stackdepot: rename init_stack_slab
Date:   Mon, 30 Jan 2023 21:49:34 +0100
Message-Id: <b756e381a3526c6e59cb68c53ac0f172ddd22776.1675111415.git.andreyknvl@google.com>
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

Rename init_stack_slab to depot_init_slab to align the name with
depot_alloc_stack.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index cddcf029e307..69b9316b0d4b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -220,7 +220,7 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-static bool init_stack_slab(void **prealloc)
+static bool depot_init_slab(void **prealloc)
 {
 	if (!*prealloc)
 		return false;
@@ -268,12 +268,12 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
 		 * |next_slab_inited| in stack_depot_save() and
-		 * init_stack_slab().
+		 * depot_init_slab().
 		 */
 		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
 			smp_store_release(&next_slab_inited, 0);
 	}
-	init_stack_slab(prealloc);
+	depot_init_slab(prealloc);
 	if (stack_slabs[depot_index] == NULL)
 		return NULL;
 
@@ -402,7 +402,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * lock.
 	 *
 	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
+	 * |next_slab_inited| in depot_alloc_stack() and depot_init_slab().
 	 */
 	if (unlikely(can_alloc && !smp_load_acquire(&next_slab_inited))) {
 		/*
@@ -438,7 +438,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * We didn't need to store this stack trace, but let's keep
 		 * the preallocated memory for the future.
 		 */
-		WARN_ON(!init_stack_slab(&prealloc));
+		WARN_ON(!depot_init_slab(&prealloc));
 	}
 
 	raw_spin_unlock_irqrestore(&depot_lock, flags);
-- 
2.25.1

