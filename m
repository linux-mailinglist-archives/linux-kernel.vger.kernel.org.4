Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05D36D18BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCaHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:37:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C2768B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:37:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so86215237edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680248249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+GCokEixfnjb0KDc+ixTXWvlGW6wj+Kz4azKab2G+4=;
        b=C0iwRqJ3uiq1194Wqj49Bb5cojtwdi0U0eOUlkL7/QXlm3wLdTPoju+5OIh5CBjiwt
         5/kgw6xt+Tdp42qLxcM2JWJnj16PqSvvl71uHh8VxOLHsaIlQOUV25bLr+8Nl7646A0q
         SLYn7wsUcQNuDeu+85b5enQrqSQyHiaN5nVHlZgkVA6H1Nnkx9IzLiY7uFRy8atiIA8F
         Y1vMvGNV5HN9cVcCMvAtqMATJi2DfgLFAbJWAkg/lV1H9nBIy/TeJtioSTGu6hTrjPtg
         qvBbPEemJIROQGDgvzTPEsuFaAmVFDUAet9bXAfZlpB/US+eAo9oSRKTIjJm4kZdxNIx
         FFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+GCokEixfnjb0KDc+ixTXWvlGW6wj+Kz4azKab2G+4=;
        b=rlWLZbYVZJgh7byFg/OXeyotgvJAbtTFZaamilR149Y0PB+iIZqNb8/TRs72DJbxQw
         sm11miZqCr2PlTFQKKzacbvORJt8vmj409y0E+s2tv8JWMv4/n0MnWvzx/oYh/8GCZB3
         vSXeiSU+jh091VZiWrwAwzTQ7hp27hqXHb+0CP2/YQp8uO8/Th100kUUBDo+NPG0jiv+
         10OD3jUeZklzddk9KFLSOpVyivxyxrxVB4YFAhLih8wo8z4hCElZVMmZ3XDXCnG6pq6Q
         guQfSwzTfGxgOMjMp31wvTtK0ONZ+eePWdDcLw73ZO+mW+9JxAH5x5Ua/2lxS/JIX+L+
         e3uQ==
X-Gm-Message-State: AAQBX9f4XVHHmL3586SFlhH5WALxnwI39wYujhDVz/5w65d/KUPzyG8u
        UO8noa7PVD5Hg35HGwFOC+s=
X-Google-Smtp-Source: AKy350ZOJQSX1gjZAMOgwMXd3tTvZegEvz+G6fSAJ5p5n5wcA8j3qyjV01Tqdm+IQWQG9V0NiZtVyw==
X-Received: by 2002:a17:907:c088:b0:931:2f49:c040 with SMTP id st8-20020a170907c08800b009312f49c040mr31542588ejc.51.1680248249513;
        Fri, 31 Mar 2023 00:37:29 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906600c00b0092bea699124sm682722ejj.106.2023.03.31.00.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:37:29 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] mm: vmalloc: Rename addr_to_vb_xarray() function
Date:   Fri, 31 Mar 2023 09:37:27 +0200
Message-Id: <20230331073727.6968-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short the name of the addr_to_vb_xarray() function to the
addr_to_vb_xa(). This aligns with other internal function
abbreviations.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 671d6d5d5b78..b8b646f8a00d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1945,7 +1945,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
  * used as a hash table. When used as a hash a 'cpu' passed to
  * per_cpu() is not actually a CPU but rather a hash index.
  *
- * A hash function is addr_to_vb_xarray() which hashes any address
+ * A hash function is addr_to_vb_xa() which hashes any address
  * to a specific index(in a hash) it belongs to. This then uses a
  * per_cpu() macro to access an array with generated index.
  *
@@ -1971,7 +1971,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
  * however xarray spinlocks protect against any contention that remains.
  */
 static struct xarray *
-addr_to_vb_xarray(unsigned long addr)
+addr_to_vb_xa(unsigned long addr)
 {
 	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
 
@@ -2048,7 +2048,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
-	xa = addr_to_vb_xarray(va->va_start);
+	xa = addr_to_vb_xa(va->va_start);
 	vb_idx = addr_to_vb_idx(va->va_start);
 	err = xa_insert(xa, vb_idx, vb, gfp_mask);
 	if (err) {
@@ -2070,7 +2070,7 @@ static void free_vmap_block(struct vmap_block *vb)
 	struct vmap_block *tmp;
 	struct xarray *xa;
 
-	xa = addr_to_vb_xarray(vb->va->va_start);
+	xa = addr_to_vb_xa(vb->va->va_start);
 	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
@@ -2193,7 +2193,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 
-	xa = addr_to_vb_xarray(addr);
+	xa = addr_to_vb_xa(addr);
 	vb = xa_load(xa, addr_to_vb_idx(addr));
 
 	spin_lock(&vb->lock);
@@ -3556,7 +3556,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * Area is split into regions and tracked with vmap_block, read out
 	 * each region and zero fill the hole between regions.
 	 */
-	xa = addr_to_vb_xarray((unsigned long) addr);
+	xa = addr_to_vb_xa((unsigned long) addr);
 	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
 	if (!vb)
 		goto finished;
-- 
2.30.2

