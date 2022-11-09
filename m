Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F06222A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKIDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiKIDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE795A9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uW859jypzBpKXzbjl1mx0hv6onZwUPSyaCvGWArWZW8=;
        b=ZF0As17lkScA9u5l2A8ApEfgHGFKnj8U1uxCzTtHSeICX/auHc7TUHJ3x5T7QGMHUCYWVc
        23gA24hWBcGb0s16r1bbgN2XXSRklg0AZIky/VFuzv0X/1qfU5ZXNh7z1Lh3pW7e04qGV3
        JGjxaKDSCVR9TGijPquMbwtNUe3mEi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-ZXfcfR-FPzekEwE6Jmfx3w-1; Tue, 08 Nov 2022 22:35:51 -0500
X-MC-Unique: ZXfcfR-FPzekEwE6Jmfx3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9A628339CE;
        Wed,  9 Nov 2022 03:35:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D7AB10197;
        Wed,  9 Nov 2022 03:35:46 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH RFC 2/3] mm/vmalloc.c: add flags to mark vm_map_ram area
Date:   Wed,  9 Nov 2022 11:35:33 +0800
Message-Id: <20221109033535.269229-3-bhe@redhat.com>
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

Through vmalloc API, a virtual kernel area is reserved for physical
address mapping. And vmap_area is used to track them, and vm_struct is
allocated to associate with the vmap_area to store more information and
passed out.

However, area reserved via vm_map_ram() is an exception. It doesn't have
vm_struct to associate with vmap_area. And we can't simply recognize the
vm_map_ram areas with '->vm == NULL' because the normal freeing path will
set va->vm = NULL before unmapping, please see function remove_vm_area().

Meanwhile, there are two types of vm_map_ram area. One is the whole
vmap_area being reserved and mapped at one time; the other is the
whole vmap_area with VMAP_BLOCK_SIZE size being reserved, while mapped
into split regions with smaller size several times.

To mark the area reserved through vm_map_ram(), add flags into the
union field of struct vmap_area to reuse the space since that union
space is free anyway if it's vm_map_ram area.

This is a preparatoin for later use.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..b739a60b73da 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -75,6 +75,7 @@ struct vmap_area {
 	union {
 		unsigned long subtree_max_size; /* in "free" tree */
 		struct vm_struct *vm;           /* in "busy" tree */
+		unsigned long flags; /* mark type of vm_map_ram area */
 	};
 };
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3fd3e6fe09..41d82dc07e13 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	spin_lock(&vmap_area_lock);
 	unlink_va(va, &vmap_area_root);
+	va->flags = 0;
 	spin_unlock(&vmap_area_lock);
 
 	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
@@ -1887,6 +1888,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 
 #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
 
+#define VMAP_RAM	0x1
+#define VMAP_BLOCK	0x2
+
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
@@ -1967,6 +1971,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		kfree(vb);
 		return ERR_CAST(va);
 	}
+	spin_lock(&vmap_area_lock);
+	va->flags = VMAP_RAM|VMAP_BLOCK;
+	spin_unlock(&vmap_area_lock);
 
 	vaddr = vmap_block_vaddr(va->va_start, 0);
 	spin_lock_init(&vb->lock);
@@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 		return;
 	}
 
-	va = find_vmap_area(addr);
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
 	BUG_ON(!va);
+	if (va)
+		va->flags &= ~VMAP_RAM;
+	spin_unlock(&vmap_area_lock);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
@@ -2269,6 +2280,10 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		if (IS_ERR(va))
 			return NULL;
 
+		spin_lock(&vmap_area_lock);
+		va->flags = VMAP_RAM;
+		spin_unlock(&vmap_area_lock);
+
 		addr = va->va_start;
 		mem = (void *)addr;
 	}
-- 
2.34.1

