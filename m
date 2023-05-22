Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400370BB59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjEVLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjEVLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:14:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14D1BD3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:09:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so291570466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753739; x=1687345739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbQClwJJa5Q5OTrsV+8XOhbG6pyJZXEhMwzuSrOaxe4=;
        b=Ad+N9/BxXUiItff9Ka8gp9m6Ut+hvQw/iiM/znN/E/FjnWbeKMX497Feia+wUTQL7P
         nn0HMTXM+eAOwCIXtFoVtxCNH0LHncvSzMz7xzwQ1Srikc1cgV966ZS1qa7YdSUE18l3
         cG1SVgkhO1ucaJlN4YMO1/+KLZpOHs16VnpaYal4+QLxI/ktvW/6nIUZRewRfRy6T7uj
         t6Bkz1DHlo2XaUESkC1cNdMlQINss0j4ahV0Ld6LZrYiZAUobHEQcZF2xuwkm88kQ9RE
         EafR2f2o+2S2vnNz55Q7/rEKNFxFSEEhyB+7TfomnLLk3I+4DN8cvc7+ZtkoKPBd38H7
         HuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753739; x=1687345739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbQClwJJa5Q5OTrsV+8XOhbG6pyJZXEhMwzuSrOaxe4=;
        b=W9lBUUaziEYILHl3tGuuMchwrn5i6Eo4pq3Z5ljshPKtiOgI4YLIGqfc7WUa4ZnlTp
         8IEZuBuX7st7UB6jFh1ItqCI3L0+d9rO4+VOoKV4lv3D8g+S1uFn1WUW32q48byxYMCR
         RgLf7ovGbQGpACI3uHjrpqUnq/9zC7O1wIuPlvmQDMAPRHwr2IwR2CCdJ+PSJ+m6HHzY
         Rsxs/37NZN7g5nXwsMqElSVmy2qyuNcy8a5ZhX5aKcu2FHCQGnI2g9wtcqqjnsLGQqp2
         YtBLHROc4J6dVbvfVlFOpeqkgoJimiUOyxEKSjWAnPkU8vsp38rp41+7H9UXfebFrdtU
         2Zzg==
X-Gm-Message-State: AC+VfDzpmXVbb0c2YVj3m0ZgFmJUtMG8kobxUUErdn8uO7n0+NAJ9SnN
        DFd7QrTTlHZrzMfjafgM7YY=
X-Google-Smtp-Source: ACHHUZ4pAASV3ZfWJMFVdFF/6izNH1fGukazCQNkIlZEbt/DA1kUADDrO481FwKNM2C/1frFuAV8LA==
X-Received: by 2002:a17:907:1c07:b0:96f:d8a9:d045 with SMTP id nc7-20020a1709071c0700b0096fd8a9d045mr3465283ejc.59.1684753738602;
        Mon, 22 May 2023 04:08:58 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:58 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 8/9] mm: vmalloc: Offload free_vmap_area_lock global lock
Date:   Mon, 22 May 2023 13:08:48 +0200
Message-Id: <20230522110849.2921-9-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a fast path of allocation sequence, that consists
of per-cpu path and fallback mechanism which is used when a
request can not be accomplished by fast track.

A fast track pre-loads a chunk from a global vmap heap directly
into its per-cpu zone, following by clipping the chunk based on
allocation request.

This technique allows to offload a global free_vmap_area_lock
making an allocation path to be serialized to number of CPUs
in a system.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fe993c0561dd..8054b8bf6c18 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1642,6 +1642,93 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 		kmem_cache_free(vmap_area_cachep, va);
 }
 
+static unsigned long
+this_cpu_zone_alloc_fill(struct cpu_vmap_zone *z,
+	unsigned long size, unsigned long align,
+	gfp_t gfp_mask, int node)
+{
+	unsigned long addr = VMALLOC_END;
+	struct vmap_area *va;
+
+	/*
+	 * It still can race. One task sets a progress to
+	 * 1 a second one gets preempted on entry, the first
+	 * zeroed the progress flag and second proceed with
+	 * an extra prefetch.
+	 */
+	if (atomic_xchg(&z->fill_in_progress, 1))
+		return addr;
+
+	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
+	if (unlikely(!va))
+		goto out;
+
+	spin_lock(&free_vmap_area_lock);
+	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+		cvz_size, 1, VMALLOC_START, VMALLOC_END);
+	spin_unlock(&free_vmap_area_lock);
+
+	if (addr == VMALLOC_END) {
+		kmem_cache_free(vmap_area_cachep, va);
+		goto out;
+	}
+
+	va->va_start = addr;
+	va->va_end = addr + cvz_size;
+
+	fbl_lock(z, FREE);
+	va = merge_or_add_vmap_area_augment(va,
+		&fbl_root(z, FREE), &fbl_head(z, FREE));
+	addr = va_alloc(va, &fbl_root(z, FREE), &fbl_head(z, FREE),
+		size, align, VMALLOC_START, VMALLOC_END);
+	fbl_unlock(z, FREE);
+
+out:
+	atomic_set(&z->fill_in_progress, 0);
+	return addr;
+}
+
+static unsigned long
+this_cpu_zone_alloc(unsigned long size, unsigned long align, gfp_t gfp_mask, int node)
+{
+	struct cpu_vmap_zone *z = raw_cpu_ptr(&cpu_vmap_zone);
+	unsigned long extra = align > PAGE_SIZE ? align : 0;
+	unsigned long addr = VMALLOC_END, left = 0;
+
+	/*
+	 * It is disabled, fallback to a global heap.
+	 */
+	if (cvz_size == ULONG_MAX)
+		return addr;
+
+	/*
+	 * Any allocation bigger/equal than one half of
+	 * a zone-size will fallback to a global heap.
+	 */
+	if (cvz_size / (size + extra) < 3)
+		return addr;
+
+	if (RB_EMPTY_ROOT(&fbl_root(z, FREE)))
+		goto fill;
+
+	fbl_lock(z, FREE);
+	addr = __alloc_vmap_area(&fbl_root(z, FREE), &fbl_head(z, FREE),
+		size, align, VMALLOC_START, VMALLOC_END);
+
+	if (addr == VMALLOC_END)
+		left = get_subtree_max_size(fbl_root(z, FREE).rb_node);
+	fbl_unlock(z, FREE);
+
+fill:
+	/*
+	 * A low watermark is 3 pages.
+	 */
+	if (addr == VMALLOC_END && left < 4 * PAGE_SIZE)
+		addr = this_cpu_zone_alloc_fill(z, size, align, gfp_mask, node);
+
+	return addr;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -1678,11 +1765,21 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 */
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
+	/*
+	 * Fast path allocation, start with it.
+	 */
+	if (vstart == VMALLOC_START && vend == VMALLOC_END)
+		addr = this_cpu_zone_alloc(size, align, gfp_mask, node);
+	else
+		addr = vend;
+
 retry:
-	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
-	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
-		size, align, vstart, vend);
-	spin_unlock(&free_vmap_area_lock);
+	if (addr == vend) {
+		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
+		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+			size, align, vstart, vend);
+		spin_unlock(&free_vmap_area_lock);
+	}
 
 	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
 
@@ -1827,6 +1924,27 @@ purge_cpu_vmap_zone(struct cpu_vmap_zone *z)
 	return num_purged_areas;
 }
 
+static void
+drop_cpu_vmap_cache(struct cpu_vmap_zone *z)
+{
+	struct vmap_area *va, *n_va;
+	LIST_HEAD(free_head);
+
+	if (RB_EMPTY_ROOT(&fbl_root(z, FREE)))
+		return;
+
+	fbl_lock(z, FREE);
+	WRITE_ONCE(fbl(z, FREE, root.rb_node), NULL);
+	list_replace_init(&fbl_head(z, FREE), &free_head);
+	fbl_unlock(z, FREE);
+
+	spin_lock(&free_vmap_area_lock);
+	list_for_each_entry_safe(va, n_va, &free_head, list)
+		merge_or_add_vmap_area_augment(va,
+			&free_vmap_area_root, &free_vmap_area_list);
+	spin_unlock(&free_vmap_area_lock);
+}
+
 /*
  * Purges all lazily-freed vmap areas.
  */
@@ -1868,6 +1986,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		for_each_possible_cpu(i) {
 			z = per_cpu_ptr(&cpu_vmap_zone, i);
 			num_purged_areas += purge_cpu_vmap_zone(z);
+			drop_cpu_vmap_cache(z);
 		}
 	}
 
-- 
2.30.2

