Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3764F6D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLQB4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLQBzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2E4A5BE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671242099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uJ0J4mR/6OkkIc2w45IdSAQBabtBwURgx8VBlnBo3s=;
        b=RBzZrBFFFrqDH44ZcK4uB4IKEfA63YefRRGIgB7RPYvNPtLPPXNHeNhVuRW9dxQnHxW4Qj
        D0gFNAgbWkklqqUyk28VEWehA+5ZzF4+DGijrAQ/PZkm8+Sez6fLnmrMC11w81JJFvYokF
        YwGsYBm2ideSiX1DwwCc1VIlay7vgOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-0DN93yIENQmxRONjjR8X0Q-1; Fri, 16 Dec 2022 20:54:58 -0500
X-MC-Unique: 0DN93yIENQmxRONjjR8X0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9225B18A63EB;
        Sat, 17 Dec 2022 01:54:57 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF1BD400F5A;
        Sat, 17 Dec 2022 01:54:53 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, urezki@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Sat, 17 Dec 2022 09:54:31 +0800
Message-Id: <20221217015435.73889-4-bhe@redhat.com>
In-Reply-To: <20221217015435.73889-1-bhe@redhat.com>
References: <20221217015435.73889-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
these areas will be skipped.

Here, add a new function vb_vread() to read out areas managed by
vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
and handle them respectively.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 190f29bbaaa7..6612914459cf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3515,6 +3515,51 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 	return copied;
 }
 
+static void vb_vread(char *buf, char *addr, int count)
+{
+	char *start;
+	struct vmap_block *vb;
+	unsigned long offset;
+	unsigned int rs, re, n;
+
+	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+
+	spin_lock(&vb->lock);
+	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
+		spin_unlock(&vb->lock);
+		memset(buf, 0, count);
+		return;
+	}
+	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
+		if (!count)
+			break;
+		start = vmap_block_vaddr(vb->va->va_start, rs);
+		if (addr < start) {
+			if (count == 0)
+				break;
+			*buf = '\0';
+			buf++;
+			addr++;
+			count--;
+		}
+		/*it could start reading from the middle of used region*/
+		offset = offset_in_page(addr);
+		n = (re - rs + 1) << PAGE_SHIFT - offset;
+		if (n > count)
+			n = count;
+		aligned_vread(buf, start+offset, n);
+
+		buf += n;
+		addr += n;
+		count -= n;
+	}
+	spin_unlock(&vb->lock);
+
+	/* zero-fill the left dirty or free regions */
+	if (count)
+		memset(buf, 0, count);
+}
+
 /**
  * vread() - read vmalloc area in a safe way.
  * @buf:     buffer for reading data
@@ -3545,7 +3590,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
-	unsigned long n;
+	unsigned long n, size, flags;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3566,12 +3611,16 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!va->vm)
+		vm = va->vm;
+		flags = va->flags & VMAP_FLAGS_MASK;
+
+		if (!vm && !flags)
 			continue;
 
-		vm = va->vm;
-		vaddr = (char *) vm->addr;
-		if (addr >= vaddr + get_vm_area_size(vm))
+		vaddr = (char *) va->va_start;
+		size = flags ? va_size(va) : get_vm_area_size(vm);
+
+		if (addr >= vaddr + size)
 			continue;
 		while (addr < vaddr) {
 			if (count == 0)
@@ -3581,10 +3630,13 @@ long vread(char *buf, char *addr, unsigned long count)
 			addr++;
 			count--;
 		}
-		n = vaddr + get_vm_area_size(vm) - addr;
+		n = vaddr + size - addr;
 		if (n > count)
 			n = count;
-		if (!(vm->flags & VM_IOREMAP))
+
+		if ((flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
+			vb_vread(buf, addr, n);
+		else if ((flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
 			aligned_vread(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);
-- 
2.34.1

