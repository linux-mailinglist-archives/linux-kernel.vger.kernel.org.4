Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BBC68B78C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBFIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjBFIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550F217145
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDthkt1yrsdVPAFblgfFdo4HNws2a1WpfRKMjlx3T68=;
        b=Wza+ghHrUUAPL77B6S7ekG/Bs4SQET6zBoV9ksNqbqhVYZeQbTqlYddLI8b6kxD67tl3qx
        juYDxW2SIeavfYtunI2xPtTp040wTy+4H6FPKanNr+p2r+/hHNTkgFQJo0lnXPt2K+rjkh
        9/nCVVqG/wnJesAXWn9KEdlwF5Qm5BI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-GfzowxhZMZyVQncuaXs6Yw-1; Mon, 06 Feb 2023 03:40:42 -0500
X-MC-Unique: GfzowxhZMZyVQncuaXs6Yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7C5858F0E;
        Mon,  6 Feb 2023 08:40:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14BF52166B2A;
        Mon,  6 Feb 2023 08:40:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Mon,  6 Feb 2023 16:40:16 +0800
Message-Id: <20230206084020.174506-4-bhe@redhat.com>
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

Currently, vread can read out vmalloc areas which is associated with
a vm_struct. While this doesn't work for areas created by vm_map_ram()
interface because it doesn't have an associated vm_struct. Then in vread(),
these areas are all skipped.

Here, add a new function vmap_ram_vread() to read out vm_map_ram areas.
The area created with vmap_ram_vread() interface directly can be handled
like the other normal vmap areas with aligned_vread(). While areas
which will be further subdivided and managed with vmap_block need
carefully read out page-aligned small regions and zero fill holes.

Reported-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Tested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 mm/vmalloc.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ab4825050b5c..4bb78ebd70f6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3544,6 +3544,68 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 	return copied;
 }
 
+static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
+{
+	char *start;
+	struct vmap_block *vb;
+	unsigned long offset;
+	unsigned int rs, re, n;
+
+	/*
+	 * If it's area created by vm_map_ram() interface directly, but
+	 * not further subdividing and delegating management to vmap_block,
+	 * handle it here.
+	 */
+	if (!(flags & VMAP_BLOCK)) {
+		aligned_vread(buf, addr, count);
+		return;
+	}
+
+	/*
+	 * Area is split into regions and tracked with vmap_block, read out
+	 * each region and zero fill the hole between regions.
+	 */
+	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+	if (!vb)
+		goto finished;
+
+	spin_lock(&vb->lock);
+	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
+		spin_unlock(&vb->lock);
+		goto finished;
+	}
+	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
+		if (!count)
+			break;
+		start = vmap_block_vaddr(vb->va->va_start, rs);
+		while (addr < start) {
+			if (count == 0)
+				goto unlock;
+			*buf = '\0';
+			buf++;
+			addr++;
+			count--;
+		}
+		/*it could start reading from the middle of used region*/
+		offset = offset_in_page(addr);
+		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
+		if (n > count)
+			n = count;
+		aligned_vread(buf, start+offset, n);
+
+		buf += n;
+		addr += n;
+		count -= n;
+	}
+unlock:
+	spin_unlock(&vb->lock);
+
+finished:
+	/* zero-fill the left dirty or free regions */
+	if (count)
+		memset(buf, 0, count);
+}
+
 /**
  * vread() - read vmalloc area in a safe way.
  * @buf:     buffer for reading data
@@ -3574,7 +3636,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
-	unsigned long n;
+	unsigned long n, size, flags;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3595,12 +3657,21 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!va->vm)
+		vm = va->vm;
+		flags = va->flags & VMAP_FLAGS_MASK;
+		/*
+		 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
+		 * be set together with VMAP_RAM.
+		 */
+		WARN_ON(flags == VMAP_BLOCK);
+
+		if (!vm && !flags)
 			continue;
 
-		vm = va->vm;
-		vaddr = (char *) vm->addr;
-		if (addr >= vaddr + get_vm_area_size(vm))
+		vaddr = (char *) va->va_start;
+		size = vm ? get_vm_area_size(vm) : va_size(va);
+
+		if (addr >= vaddr + size)
 			continue;
 		while (addr < vaddr) {
 			if (count == 0)
@@ -3610,10 +3681,13 @@ long vread(char *buf, char *addr, unsigned long count)
 			addr++;
 			count--;
 		}
-		n = vaddr + get_vm_area_size(vm) - addr;
+		n = vaddr + size - addr;
 		if (n > count)
 			n = count;
-		if (!(vm->flags & VM_IOREMAP))
+
+		if (flags & VMAP_RAM)
+			vmap_ram_vread(buf, addr, n, flags);
+		else if (!(vm->flags & VM_IOREMAP))
 			aligned_vread(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);
-- 
2.34.1

