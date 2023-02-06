Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88068B785
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBFIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBFIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361117157
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cc8KcFYSac3hETCaiorDwaJuaLkn+gY3HkrQz3ErLWA=;
        b=BRYxDiScFFXISn5fpidbGU32dKk/OBc+BKlIuKLrZxjxMemPgHUyOcQQgXXGsM/UpWeCc0
        S0MwT9Hu0jFJgQwj6XpUB5EptscVwbkaoy2AYwhwAo5IEe+MyDaCMYhN4L2uj83oYGvk36
        BOCml2PnfWHXJ2PiIDrQNglQvXtD3x4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-OZuYdVm3Nn2c0Cg5-8Dgiw-1; Mon, 06 Feb 2023 03:40:37 -0500
X-MC-Unique: OZuYdVm3Nn2c0Cg5-8Dgiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 440483811F25;
        Mon,  6 Feb 2023 08:40:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 424E02166B2A;
        Mon,  6 Feb 2023 08:40:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Date:   Mon,  6 Feb 2023 16:40:15 +0800
Message-Id: <20230206084020.174506-3-bhe@redhat.com>
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

Through vmalloc API, a virtual kernel area is reserved for physical
address mapping. And vmap_area is used to track them, while vm_struct
is allocated to associate with the vmap_area to store more information
and passed out.

However, area reserved via vm_map_ram() is an exception. It doesn't have
vm_struct to associate with vmap_area. And we can't recognize the
vmap_area with '->vm == NULL' as a vm_map_ram() area because the normal
freeing path will set va->vm = NULL before unmapping, please see
function remove_vm_area().

Meanwhile, there are two kinds of handling for vm_map_ram area. One is
the whole vmap_area being reserved and mapped at one time through
vm_map_area() interface; the other is the whole vmap_area with
VMAP_BLOCK_SIZE size being reserved, while mapped into split regions
with smaller size via vb_alloc().

To mark the area reserved through vm_map_ram(), add flags field into
struct vmap_area. Bit 0 indicates this is vm_map_ram area created
through vm_map_ram() interface, while bit 1 marks out the type of
vm_map_ram area which makes use of vmap_block to manage split regions
via vb_alloc/free().

This is a preparation for later use.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..69250efa03d1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -76,6 +76,7 @@ struct vmap_area {
 		unsigned long subtree_max_size; /* in "free" tree */
 		struct vm_struct *vm;           /* in "busy" tree */
 	};
+	unsigned long flags; /* mark type of vm_map_ram area */
 };
 
 /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d6ff058ef4d0..ab4825050b5c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1589,7 +1589,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
-				int node, gfp_t gfp_mask)
+				int node, gfp_t gfp_mask,
+				unsigned long va_flags)
 {
 	struct vmap_area *va;
 	unsigned long freed;
@@ -1635,6 +1636,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_start = addr;
 	va->va_end = addr + size;
 	va->vm = NULL;
+	va->flags = va_flags;
 
 	spin_lock(&vmap_area_lock);
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
@@ -1913,6 +1915,10 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 
 #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
 
+#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
+#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
+#define VMAP_FLAGS_MASK		0x3
+
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
@@ -1988,7 +1994,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
-					node, gfp_mask);
+					node, gfp_mask,
+					VMAP_RAM|VMAP_BLOCK);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2297,7 +2304,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 	} else {
 		struct vmap_area *va;
 		va = alloc_vmap_area(size, PAGE_SIZE,
-				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
+				VMALLOC_START, VMALLOC_END,
+				node, GFP_KERNEL, VMAP_RAM);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -2537,7 +2545,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
-- 
2.34.1

