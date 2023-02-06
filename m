Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80868B782
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBFIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBFIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A317158
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnCrWWx4pp/03QuBJCB11gBYLXEsVuMTBc/8ULu0oDY=;
        b=gi76awTwhHCVj+5BH4F5H6c+T2LQIenU9dYbZyulWvqRf/wixmWjOyYawftBrwIMD6dBYR
        OFRND0BPF6t3XUPLJOtBQ44AAqgMEGMg03bHdEEE3ivE5OQw57Yh95c2nPvnADYiCHYt5A
        dCLKiK85xQXVRSgMaUYokoVNcWXvhQ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-qNwJhTElN9GeQaPmcH1H-w-1; Mon, 06 Feb 2023 03:40:32 -0500
X-MC-Unique: qNwJhTElN9GeQaPmcH1H-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74CF187B2A0;
        Mon,  6 Feb 2023 08:40:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC332166B2B;
        Mon,  6 Feb 2023 08:40:28 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 1/7] mm/vmalloc.c: add used_map into vmap_block to track space of vmap_block
Date:   Mon,  6 Feb 2023 16:40:14 +0800
Message-Id: <20230206084020.174506-2-bhe@redhat.com>
In-Reply-To: <20230206084020.174506-1-bhe@redhat.com>
References: <20230206084020.174506-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one vmap_block area, there could be three types of regions: region
being used which is allocated through vb_alloc(), dirty region which
is freed via vb_free() and free region. Among them, only used region
has available data. While there's no way to track those used regions
currently.

Here, add bitmap field used_map into vmap_block, and set/clear it during
allocation or freeing regions of vmap_block area.

This is a preparatoin for later use.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 428e0bee5c9c..d6ff058ef4d0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1922,6 +1922,7 @@ struct vmap_block {
 	spinlock_t lock;
 	struct vmap_area *va;
 	unsigned long free, dirty;
+	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
 	unsigned long dirty_min, dirty_max; /*< dirty range */
 	struct list_head free_list;
 	struct rcu_head rcu_head;
@@ -1998,10 +1999,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	vb->va = va;
 	/* At least something should be left free */
 	BUG_ON(VMAP_BBMAP_BITS <= (1UL << order));
+	bitmap_zero(vb->used_map, VMAP_BBMAP_BITS);
 	vb->free = VMAP_BBMAP_BITS - (1UL << order);
 	vb->dirty = 0;
 	vb->dirty_min = VMAP_BBMAP_BITS;
 	vb->dirty_max = 0;
+	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
 	vb_idx = addr_to_vb_idx(va->va_start);
@@ -2111,6 +2114,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 		pages_off = VMAP_BBMAP_BITS - vb->free;
 		vaddr = vmap_block_vaddr(vb->va->va_start, pages_off);
 		vb->free -= 1UL << order;
+		bitmap_set(vb->used_map, pages_off, (1UL << order));
 		if (vb->free == 0) {
 			spin_lock(&vbq->lock);
 			list_del_rcu(&vb->free_list);
@@ -2144,6 +2148,9 @@ static void vb_free(unsigned long addr, unsigned long size)
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+	spin_lock(&vb->lock);
+	bitmap_clear(vb->used_map, offset, (1UL << order));
+	spin_unlock(&vb->lock);
 
 	vunmap_range_noflush(addr, addr + size);
 
-- 
2.34.1

