Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6697670FA68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjEXPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbjEXPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC171A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684942412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN3mSK+PjIP6JAbZhfDAmtnx0lnfpAA82MAUedDHiDA=;
        b=bP62N1dupkuCW43Pb7TDZG9ocoOp2S5lyB2lhWFEX+jJLTNZkk+WbXl29K0T1G1+F9i6UI
        vBX/k5DkEWqhFn0X7rTLNFnjO5mOSp1v6TzfcnDvNxks2VDFGTiCAihCsPqn0BvbKAARKI
        RJwAFG32pMR6uzYvS9Nqto2XMnkDxz8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Arb27wHhPVquoWD2zvAqmw-1; Wed, 24 May 2023 11:33:28 -0400
X-MC-Unique: Arb27wHhPVquoWD2zvAqmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB53C3C0D185;
        Wed, 24 May 2023 15:33:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12905492B0B;
        Wed, 24 May 2023 15:33:22 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator alignment param a pow-of-2
Date:   Wed, 24 May 2023 16:33:02 +0100
Message-Id: <20230524153311.3625329-4-dhowells@redhat.com>
In-Reply-To: <20230524153311.3625329-1-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the page_frag_cache allocator's alignment parameter a power of 2
rather than a mask and give a warning if it isn't.

This means that it's consistent with {napi,netdec}_alloc_frag_align() and
allows __{napi,netdev}_alloc_frag_align() to be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jeroen de Borst <jeroendb@google.com>
cc: Catherine Sullivan <csully@google.com>
cc: Shailend Chand <shailend@google.com>
cc: Felix Fietkau <nbd@nbd.name>
cc: John Crispin <john@phrozen.org>
cc: Sean Wang <sean.wang@mediatek.com>
cc: Mark Lee <Mark-MC.Lee@mediatek.com>
cc: Lorenzo Bianconi <lorenzo@kernel.org>
cc: Matthias Brugger <matthias.bgg@gmail.com>
cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@fb.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Sagi Grimberg <sagi@grimberg.me>
cc: Chaitanya Kulkarni <kch@nvidia.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
cc: linux-arm-kernel@lists.infradead.org
cc: linux-mediatek@lists.infradead.org
cc: linux-nvme@lists.infradead.org
cc: linux-mm@kvack.org
---
 include/linux/gfp.h    |  4 ++--
 include/linux/skbuff.h | 22 ++++------------------
 mm/page_frag_alloc.c   |  8 +++++---
 net/core/skbuff.c      | 14 +++++++-------
 4 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 03504beb51e4..fa30100f46ad 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -306,12 +306,12 @@ struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
 extern void *page_frag_alloc_align(struct page_frag_cache *nc,
 				   unsigned int fragsz, gfp_t gfp_mask,
-				   unsigned int align_mask);
+				   unsigned int align);
 
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 			     unsigned int fragsz, gfp_t gfp_mask)
 {
-	return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return page_frag_alloc_align(nc, fragsz, gfp_mask, 1);
 }
 
 void page_frag_cache_clear(struct page_frag_cache *nc);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1b2ebf6113e0..41b63e72c6c3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3158,7 +3158,7 @@ void skb_queue_purge(struct sk_buff_head *list);
 
 unsigned int skb_rbtree_purge(struct rb_root *root);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *netdev_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 /**
  * netdev_alloc_frag - allocate a page fragment
@@ -3169,14 +3169,7 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
  */
 static inline void *netdev_alloc_frag(unsigned int fragsz)
 {
-	return __netdev_alloc_frag_align(fragsz, ~0u);
-}
-
-static inline void *netdev_alloc_frag_align(unsigned int fragsz,
-					    unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __netdev_alloc_frag_align(fragsz, -align);
+	return netdev_alloc_frag_align(fragsz, 1);
 }
 
 struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int length,
@@ -3236,18 +3229,11 @@ static inline void skb_free_frag(void *addr)
 	page_frag_free(addr);
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *napi_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 static inline void *napi_alloc_frag(unsigned int fragsz)
 {
-	return __napi_alloc_frag_align(fragsz, ~0u);
-}
-
-static inline void *napi_alloc_frag_align(unsigned int fragsz,
-					  unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __napi_alloc_frag_align(fragsz, -align);
+	return napi_alloc_frag_align(fragsz, 1);
 }
 
 struct sk_buff *__napi_alloc_skb(struct napi_struct *napi,
diff --git a/mm/page_frag_alloc.c b/mm/page_frag_alloc.c
index e02b81d68dc4..9d3f6fbd9a07 100644
--- a/mm/page_frag_alloc.c
+++ b/mm/page_frag_alloc.c
@@ -64,13 +64,15 @@ void page_frag_cache_clear(struct page_frag_cache *nc)
 EXPORT_SYMBOL(page_frag_cache_clear);
 
 void *page_frag_alloc_align(struct page_frag_cache *nc,
-		      unsigned int fragsz, gfp_t gfp_mask,
-		      unsigned int align_mask)
+			    unsigned int fragsz, gfp_t gfp_mask,
+			    unsigned int align)
 {
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
 
+	WARN_ON_ONCE(!is_power_of_2(align));
+
 	if (unlikely(!nc->va)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
@@ -129,7 +131,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
+	offset &= ~(align - 1);
 	nc->offset = offset;
 
 	return nc->va + offset;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f4a5b51aed22..cc507433b357 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -289,17 +289,17 @@ void napi_get_frags_check(struct napi_struct *napi)
 	local_bh_enable();
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
-	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align);
 }
-EXPORT_SYMBOL(__napi_alloc_frag_align);
+EXPORT_SYMBOL(napi_alloc_frag_align);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	void *data;
 
@@ -307,18 +307,18 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
-		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align);
 	} else {
 		struct napi_alloc_cache *nc;
 
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache);
-		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align);
 		local_bh_enable();
 	}
 	return data;
 }
-EXPORT_SYMBOL(__netdev_alloc_frag_align);
+EXPORT_SYMBOL(netdev_alloc_frag_align);
 
 static struct sk_buff *napi_skb_cache_get(void)
 {

