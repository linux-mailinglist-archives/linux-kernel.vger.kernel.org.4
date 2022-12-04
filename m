Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA92641A40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLDBcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiLDBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FF1B9F7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 17:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670117479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B30MFqWNu+rcOTLOH6gG9qPqyD6wQQ4N98WacTEX/8c=;
        b=L+HLHYdOQuD8ZpH2EpOOeFGnyE0siqcgpEd2UIbH/zOnFeO8d2uwR9hAGND47f7elm5ue1
        czrse5bouljW6oR0ZR03sz2sgUPDLakQuwhgU11vCpyk7XqM1MhdfpL4vbo5J0SZRsx9mz
        LJFlc24wORnL5allA86gWkpGID6i8fY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-Jh9T0IHRNhediakKabRqEg-1; Sat, 03 Dec 2022 20:31:15 -0500
X-MC-Unique: Jh9T0IHRNhediakKabRqEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B1C5101A52A;
        Sun,  4 Dec 2022 01:31:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250D5141511E;
        Sun,  4 Dec 2022 01:31:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, stephen.s.brennan@oracle.com, urezki@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v1 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Sun,  4 Dec 2022 09:30:42 +0800
Message-Id: <20221204013046.154960-4-bhe@redhat.com>
In-Reply-To: <20221204013046.154960-1-bhe@redhat.com>
References: <20221204013046.154960-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
 mm/vmalloc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d6f376060d83..e6b46da3e044 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3519,6 +3519,46 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 	return copied;
 }
 
+static void vb_vread(char *buf, char *addr, int count)
+{
+	char *start;
+	struct vmap_block *vb;
+	unsigned long offset;
+	unsigned int rs, re, n;
+
+	offset = ((unsigned long)addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
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
+		n = (re - rs + 1) << PAGE_SHIFT;
+		if (n > count)
+			n = count;
+		aligned_vread(buf, start, n);
+
+		buf += n;
+		addr += n;
+		count -= n;
+	}
+	spin_unlock(&vb->lock);
+}
+
 /**
  * vread() - read vmalloc area in a safe way.
  * @buf:     buffer for reading data
@@ -3549,7 +3589,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
-	unsigned long n;
+	unsigned long n, size, flags;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3570,12 +3610,16 @@ long vread(char *buf, char *addr, unsigned long count)
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
@@ -3585,10 +3629,13 @@ long vread(char *buf, char *addr, unsigned long count)
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

