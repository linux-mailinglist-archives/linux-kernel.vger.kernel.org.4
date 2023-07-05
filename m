Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962F17488A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGEP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjGEP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:57:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C10199F;
        Wed,  5 Jul 2023 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688572663; x=1720108663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPrqCHa2FLJ5lpv57i8/mYhnb39HakhDqlwDysa/GuU=;
  b=i38mztzJ7lDczMJmp7MHUGcPR5fBnb3Qt5/Izl3O3saweTT7Kv+F93q7
   WNSRZqMvIKsDAAvL71i7b3Nm8C/i/vOTZJbya0SiSVUH80IO8OzZTna7n
   o/FQ4+sn2rm/Atcxo/3LZBy3Yp5SGWdAppPy4qGBHv2UNGJ3FdLAMsswo
   nrhKlmhGBKWaLHvGAbSm8x/9BTpTCMLE6ZWjYd2yOKXDPXp5GKcivVlS7
   X9m16AIxT0yht/K68dI59fuA5h6tPS5UnZJ++uAg8ny5TPQHomChhf7VS
   ncBw3AVypUMLA8umdiLvD1izDRLEsb9khhS7XP4+oqHGkeQj9zhirUwQA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366863455"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="366863455"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789205576"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="789205576"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2023 08:57:38 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v4 3/9] iavf: drop page splitting and recycling
Date:   Wed,  5 Jul 2023 17:55:45 +0200
Message-ID: <20230705155551.1317583-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an intermediate step, remove all page splitting/recyclig code. Just
always allocate a new page and don't touch its refcount, so that it gets
freed by the core stack later.
Same for the "in-place" recycling, i.e. when an unused buffer gets
assigned to a first needs-refilling descriptor. In some cases, this
was leading to moving up to 63 &iavf_rx_buf structures around the ring
on a per-field basis -- not something wanted on hotpath.
The change allows to greatly simplify certain parts of the code:

Function: add/remove: 0/2 grow/shrink: 1/3 up/down: 3/-494 (-491)

Although the array of &iavf_rx_buf is barely used now and could be
replaced with just page pointer array, don't touch it now to not
complicate replacing it with libie Rx buffer struct later on.
No surprise perf loses up to 30% here, but that regression will go
away once PP lands.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 151 ++------------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |   8 --
 2 files changed, 13 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index a85b270fc769..789b10815d7f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -723,7 +723,7 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 				     DMA_FROM_DEVICE,
 				     IAVF_RX_DMA_ATTR);
 
-		__page_frag_cache_drain(rx_bi->page, rx_bi->pagecnt_bias);
+		__free_pages(rx_bi->page, iavf_rx_pg_order(rx_ring));
 
 		rx_bi->page = NULL;
 		rx_bi->page_offset = 0;
@@ -735,7 +735,6 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 	/* Zero out the descriptor ring */
 	memset(rx_ring->desc, 0, rx_ring->size);
 
-	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
@@ -791,7 +790,6 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 		goto err;
 	}
 
-	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
@@ -811,9 +809,6 @@ static inline void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
 {
 	rx_ring->next_to_use = val;
 
-	/* update next to alloc since we have filled the ring */
-	rx_ring->next_to_alloc = val;
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
 	 * applicable for weak-ordered memory model archs,
@@ -837,12 +832,6 @@ static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
 	struct page *page = bi->page;
 	dma_addr_t dma;
 
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page)) {
-		rx_ring->rx_stats.page_reuse_count++;
-		return true;
-	}
-
 	/* alloc new page for storage */
 	page = dev_alloc_pages(iavf_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
@@ -869,9 +858,6 @@ static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
 	bi->page = page;
 	bi->page_offset = IAVF_SKB_PAD;
 
-	/* initialize pagecnt_bias to 1 representing we fully own page */
-	bi->pagecnt_bias = 1;
-
 	return true;
 }
 
@@ -1103,91 +1089,6 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
 	return false;
 }
 
-/**
- * iavf_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: rx descriptor ring to store buffers on
- * @old_buff: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- **/
-static void iavf_reuse_rx_page(struct iavf_ring *rx_ring,
-			       struct iavf_rx_buffer *old_buff)
-{
-	struct iavf_rx_buffer *new_buff;
-	u16 nta = rx_ring->next_to_alloc;
-
-	new_buff = &rx_ring->rx_bi[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	new_buff->dma		= old_buff->dma;
-	new_buff->page		= old_buff->page;
-	new_buff->page_offset	= old_buff->page_offset;
-	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
-}
-
-/**
- * iavf_can_reuse_rx_page - Determine if this page can be reused by
- * the adapter for another receive
- *
- * @rx_buffer: buffer containing the page
- *
- * If page is reusable, rx_buffer->page_offset is adjusted to point to
- * an unused region in the page.
- *
- * For small pages, @truesize will be a constant value, half the size
- * of the memory at page.  We'll attempt to alternate between high and
- * low halves of the page, with one half ready for use by the hardware
- * and the other half being consumed by the stack.  We use the page
- * ref count to determine whether the stack has finished consuming the
- * portion of this page that was passed up with a previous packet.  If
- * the page ref count is >1, we'll assume the "other" half page is
- * still busy, and this page cannot be reused.
- *
- * For larger pages, @truesize will be the actual space used by the
- * received packet (adjusted upward to an even multiple of the cache
- * line size).  This will advance through the page by the amount
- * actually consumed by the received packets while there is still
- * space for a buffer.  Each region of larger pages will be used at
- * most once, after which the page will not be reused.
- *
- * In either case, if the page is reusable its refcount is increased.
- **/
-static bool iavf_can_reuse_rx_page(struct iavf_rx_buffer *rx_buffer)
-{
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
-	struct page *page = rx_buffer->page;
-
-	/* Is any reuse possible? */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((page_count(page) - pagecnt_bias) > 1))
-		return false;
-#else
-#define IAVF_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - IAVF_RXBUFFER_2048)
-	if (rx_buffer->page_offset > IAVF_LAST_OFFSET)
-		return false;
-#endif
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(!pagecnt_bias)) {
-		page_ref_add(page, USHRT_MAX);
-		rx_buffer->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
 /**
  * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -1216,13 +1117,6 @@ static void iavf_add_rx_frag(struct iavf_ring *rx_ring,
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->page_offset, size, truesize);
-
-	/* page is being used so we must update the page offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
 }
 
 /**
@@ -1250,9 +1144,6 @@ static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 
-	/* We have pulled a buffer for use, so decrement pagecnt_bias */
-	rx_buffer->pagecnt_bias--;
-
 	return rx_buffer;
 }
 
@@ -1293,23 +1184,15 @@ static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
 	skb_reserve(skb, IAVF_SKB_PAD);
 	__skb_put(skb, size);
 
-	/* buffer is used by skb, update page_offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
-
 	return skb;
 }
 
 /**
- * iavf_put_rx_buffer - Clean up used buffer and either recycle or free
+ * iavf_put_rx_buffer - Unmap used buffer
  * @rx_ring: rx descriptor ring to transact packets on
  * @rx_buffer: rx buffer to pull data from
  *
- * This function will clean up the contents of the rx_buffer.  It will
- * either recycle the buffer or unmap it and free the associated resources.
+ * This function will unmap the buffer after it's written by HW.
  */
 static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
 			       struct iavf_rx_buffer *rx_buffer)
@@ -1317,21 +1200,10 @@ static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
 	if (!rx_buffer)
 		return;
 
-	if (iavf_can_reuse_rx_page(rx_buffer)) {
-		/* hand second half of page back to the ring */
-		iavf_reuse_rx_page(rx_ring, rx_buffer);
-		rx_ring->rx_stats.page_reuse_count++;
-	} else {
-		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-				     iavf_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-	}
-
-	/* clear contents of buffer_info */
-	rx_buffer->page = NULL;
+	/* we are not reusing the buffer so unmap it */
+	dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
+			     iavf_rx_pg_size(rx_ring),
+			     DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
 }
 
 /**
@@ -1431,15 +1303,18 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		else
 			skb = iavf_build_skb(rx_ring, rx_buffer, size);
 
+		iavf_put_rx_buffer(rx_ring, rx_buffer);
+
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
-			if (rx_buffer && size)
-				rx_buffer->pagecnt_bias++;
+			__free_pages(rx_buffer->page,
+				     iavf_rx_pg_order(rx_ring));
+			rx_buffer->page = NULL;
 			break;
 		}
 
-		iavf_put_rx_buffer(rx_ring, rx_buffer);
+		rx_buffer->page = NULL;
 		cleaned_count++;
 
 		if (iavf_is_non_eop(rx_ring, rx_desc, skb))
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 4b412f7662e4..2170a77f8c8d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -266,12 +266,7 @@ struct iavf_tx_buffer {
 struct iavf_rx_buffer {
 	dma_addr_t dma;
 	struct page *page;
-#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
 	__u32 page_offset;
-#else
-	__u16 page_offset;
-#endif
-	__u16 pagecnt_bias;
 };
 
 struct iavf_queue_stats {
@@ -293,8 +288,6 @@ struct iavf_rx_queue_stats {
 	u64 non_eop_descs;
 	u64 alloc_page_failed;
 	u64 alloc_buff_failed;
-	u64 page_reuse_count;
-	u64 realloc_count;
 };
 
 enum iavf_ring_state_t {
@@ -374,7 +367,6 @@ struct iavf_ring {
 	struct iavf_q_vector *q_vector;	/* Backreference to associated vector */
 
 	struct rcu_head rcu;		/* to avoid race on free */
-	u16 next_to_alloc;
 	struct sk_buff *skb;		/* When iavf_clean_rx_ring_irq() must
 					 * return before it sees the EOP for
 					 * the current packet, we save that skb
-- 
2.41.0

