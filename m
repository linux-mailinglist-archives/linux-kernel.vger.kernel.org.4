Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0D6222A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiKIDgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiKIDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C3E6B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbbRgpejA7sfz74mbd3BvkH0wE+DwK1tqMCX8jqv3XU=;
        b=aZurhOccs5cRnATbUB1fQe7BgguZbfchyoBFhCrjWO98ny2dKAbYXIK2PGibilgent5joM
        sKQe6jnsdvfEjDP6Pzunc4PPbuLMlHlm7r0veQ9dd8VG205F40f6WfxSnLNEemO27evoQf
        zBvuG4BzPM5481rwf8fgWrL+MAKXdy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-vGWf6ADhPLuE-5SDkR8Wmw-1; Tue, 08 Nov 2022 22:35:46 -0500
X-MC-Unique: vGWf6ADhPLuE-5SDkR8Wmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C8AA101A52A;
        Wed,  9 Nov 2022 03:35:46 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D78E610197;
        Wed,  9 Nov 2022 03:35:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH RFC 1/3] mm/vmalloc.c: add used_map into vmap_block to track space of vmap_block
Date:   Wed,  9 Nov 2022 11:35:32 +0800
Message-Id: <20221109033535.269229-2-bhe@redhat.com>
In-Reply-To: <20221109033535.269229-1-bhe@redhat.com>
References: <20221109033535.269229-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one vmap_block area, there could be three types of regions: used
region which is allocated through vb_alloc(), dirty region which is
freed through vb_free() and free region. Among them, only used region
has available data, while there's no way to track those used regions
currently.

Here, add bitmap field used_map into vmap_block, and set/clear it during
allocation or freeing regions of vmap_block area.

This is a preparatoin for later use.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..5d3fd3e6fe09 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1896,6 +1896,7 @@ struct vmap_block {
 	spinlock_t lock;
 	struct vmap_area *va;
 	unsigned long free, dirty;
+	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
 	unsigned long dirty_min, dirty_max; /*< dirty range */
 	struct list_head free_list;
 	struct rcu_head rcu_head;
@@ -1972,10 +1973,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
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
@@ -2081,6 +2084,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 		pages_off = VMAP_BBMAP_BITS - vb->free;
 		vaddr = vmap_block_vaddr(vb->va->va_start, pages_off);
 		vb->free -= 1UL << order;
+		bitmap_set(vb->used_map, pages_off, (1UL << order));
 		if (vb->free == 0) {
 			spin_lock(&vbq->lock);
 			list_del_rcu(&vb->free_list);
@@ -2114,6 +2118,9 @@ static void vb_free(unsigned long addr, unsigned long size)
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+	spin_lock(&vb->lock);
+	bitmap_clear(vb->used_map, offset, (1UL << order));
+	spin_unlock(&vb->lock);
 
 	vunmap_range_noflush(addr, addr + size);
 
-- 
2.34.1

