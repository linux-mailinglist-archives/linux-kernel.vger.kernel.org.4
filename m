Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB86222AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKIDhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKIDhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9ED10FDF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcTeN8CUp/OMny7mFhvKg/4OAsWnVU2lfPdAgkI4ha0=;
        b=IaGPsGQr+Douursi/qFC9SJu2W0V4oMbgivFLrytn8GmC4y4FWPyRSgGfIapAT+94xllT5
        H6J2Wduyb9q816aTABYEIQS2cjvTD/OFz5aeNiJU/X33qHiU+LtywBUIFGS8wMflESSb0d
        zlctVFne25JQrI22K1vekpv51c+2ubU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-p_3NSPWfPiGGUfTsv4bsoQ-1; Tue, 08 Nov 2022 22:35:55 -0500
X-MC-Unique: p_3NSPWfPiGGUfTsv4bsoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 616DD811E67;
        Wed,  9 Nov 2022 03:35:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D6C7AE5;
        Wed,  9 Nov 2022 03:35:51 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Wed,  9 Nov 2022 11:35:34 +0800
Message-Id: <20221109033535.269229-4-bhe@redhat.com>
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

Currently, vread() can read out vmalloc areas which is associated with
a vm_struct. While this doesn't work for areas created by vm_map_ram()
interface because it doesn't allocate a vm_struct. Then in vread(),
these areas will be skipped.

Here, add a new function vb_vread() to read out areas managed by
vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
and handle  them respectively.

Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Link: https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u
---
 mm/vmalloc.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 41d82dc07e13..5a8d5659bfb0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3518,6 +3518,46 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
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
@@ -3548,7 +3588,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
-	unsigned long n;
+	unsigned long n, size;
 
 	addr = kasan_reset_tag(addr);
 
@@ -3569,12 +3609,14 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!va->vm)
+		if (!(va->flags & VMAP_RAM) && !va->vm)
 			continue;
 
 		vm = va->vm;
-		vaddr = (char *) vm->addr;
-		if (addr >= vaddr + get_vm_area_size(vm))
+		vaddr = (char *) va->va_start;
+		size = vm ? get_vm_area_size(vm) : va_size(va);
+
+		if (addr >= vaddr + size)
 			continue;
 		while (addr < vaddr) {
 			if (count == 0)
@@ -3584,10 +3626,13 @@ long vread(char *buf, char *addr, unsigned long count)
 			addr++;
 			count--;
 		}
-		n = vaddr + get_vm_area_size(vm) - addr;
+		n = vaddr + size - addr;
 		if (n > count)
 			n = count;
-		if (!(vm->flags & VM_IOREMAP))
+
+		if ((va->flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
+			vb_vread(buf, addr, n);
+		else if ((va->flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
 			aligned_vread(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);
-- 
2.34.1

