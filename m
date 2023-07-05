Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800187488B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGEP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjGEP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:58:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E371BC5;
        Wed,  5 Jul 2023 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688572698; x=1720108698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SRPJoZD8kr43w+ArQ77fxh60cwav/znYS7XCzbP0Rk=;
  b=TvhNBvZaTcZ0sSFBY1PD+TptZeU2RTpFo7Vfj3Lj7Fd+8JXQ8+AUzo0o
   qVeRPiRHAlPuFRBe8UdBHpDeHZ0763TS+R2XX3sWu0/WKtbIgc3x5o1p4
   ok+p8XoR+tj0oVQkaGpkm0IX/LE4AD+9/UkyCXpivhjz9Gw2ywDr1kA96
   veb0JZ/1M/Lck/dMs2gHkA/ZRqNu0q6XTLjgVb1ZdOHao0aX1gP1DZTR/
   KBgwXeZa5MuA7mOBHi0vWn2otg3/1Q8ndrBx9v5RE2jTK8TYep6lL/tFt
   1kQBi+Aduvm09SF2mSBx/KQXhKc6SNWAYZH5lVyzClVnXhNoEl+ImISQH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366863560"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="366863560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789205651"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="789205651"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2023 08:57:55 -0700
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
Subject: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
Date:   Wed,  5 Jul 2023 17:55:48 +0200
Message-ID: <20230705155551.1317583-7-aleksander.lobakin@intel.com>
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

Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
no custom recycling logics, it can easily be switched to using Page
Pool / libie API instead.
This allows to removing the whole dancing around headroom, HW buffer
size, and page order. All DMA-for-device is now done in the PP core,
for-CPU -- in the libie helper.
Use skb_mark_for_recycle() to bring back the recycling and restore the
performance. Speaking of performance: on par with the baseline and
faster with the PP optimization series applied. But the memory usage for
1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
every second descriptor.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  33 +--
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 247 +++++-------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  91 +------
 drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 -
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  19 +-
 5 files changed, 82 insertions(+), 310 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index db1ed13f11bb..39c6d83e80a1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/net/intel/libie/rx.h>
+
 #include "iavf.h"
 #include "iavf_prototype.h"
 #include "iavf_client.h"
@@ -698,32 +700,10 @@ static void iavf_configure_tx(struct iavf_adapter *adapter)
  **/
 static void iavf_configure_rx(struct iavf_adapter *adapter)
 {
-	unsigned int rx_buf_len = IAVF_RXBUFFER_2048;
 	struct iavf_hw *hw = &adapter->hw;
-	int i;
-
-	if (PAGE_SIZE < 8192) {
-		struct net_device *netdev = adapter->netdev;
 
-		/* For jumbo frames on systems with 4K pages we have to use
-		 * an order 1 page, so we might as well increase the size
-		 * of our Rx buffer to make better use of the available space
-		 */
-		rx_buf_len = IAVF_RXBUFFER_3072;
-
-		/* We use a 1536 buffer size for configurations with
-		 * standard Ethernet mtu.  On x86 this gives us enough room
-		 * for shared info and 192 bytes of padding.
-		 */
-		if (!IAVF_2K_TOO_SMALL_WITH_PADDING &&
-		    (netdev->mtu <= ETH_DATA_LEN))
-			rx_buf_len = IAVF_RXBUFFER_1536 - NET_IP_ALIGN;
-	}
-
-	for (i = 0; i < adapter->num_active_queues; i++) {
+	for (u32 i = 0; i < adapter->num_active_queues; i++)
 		adapter->rx_rings[i].tail = hw->hw_addr + IAVF_QRX_TAIL1(i);
-		adapter->rx_rings[i].rx_buf_len = rx_buf_len;
-	}
 }
 
 /**
@@ -1590,7 +1570,6 @@ static int iavf_alloc_queues(struct iavf_adapter *adapter)
 		rx_ring = &adapter->rx_rings[i];
 		rx_ring->queue_index = i;
 		rx_ring->netdev = adapter->netdev;
-		rx_ring->dev = &adapter->pdev->dev;
 		rx_ring->count = adapter->rx_desc_count;
 		rx_ring->itr_setting = IAVF_ITR_RX_DEF;
 	}
@@ -2562,11 +2541,7 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 	netdev->netdev_ops = &iavf_netdev_ops;
 	iavf_set_ethtool_ops(netdev);
-	netdev->watchdog_timeo = 5 * HZ;
-
-	/* MTU range: 68 - 9710 */
-	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
+	netdev->max_mtu = LIBIE_MAX_MTU;
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 789b10815d7f..d1491b481eac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -689,9 +689,6 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
  **/
 static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 {
-	unsigned long bi_size;
-	u16 i;
-
 	/* ring already cleared, nothing to do */
 	if (!rx_ring->rx_bi)
 		return;
@@ -701,40 +698,16 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 		rx_ring->skb = NULL;
 	}
 
-	/* Free all the Rx ring sk_buffs */
-	for (i = 0; i < rx_ring->count; i++) {
-		struct iavf_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
+	/* Free all the Rx ring buffers */
+	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
+		const struct libie_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
 
-		if (!rx_bi->page)
-			continue;
+		page_pool_put_full_page(rx_ring->pp, rx_bi->page, false);
 
-		/* Invalidate cache lines that may have been written to by
-		 * device so that we avoid corrupting memory.
-		 */
-		dma_sync_single_range_for_cpu(rx_ring->dev,
-					      rx_bi->dma,
-					      rx_bi->page_offset,
-					      rx_ring->rx_buf_len,
-					      DMA_FROM_DEVICE);
-
-		/* free resources associated with mapping */
-		dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
-				     iavf_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE,
-				     IAVF_RX_DMA_ATTR);
-
-		__free_pages(rx_bi->page, iavf_rx_pg_order(rx_ring));
-
-		rx_bi->page = NULL;
-		rx_bi->page_offset = 0;
+		if (unlikely(++i == rx_ring->count))
+			i = 0;
 	}
 
-	bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
-	memset(rx_ring->rx_bi, 0, bi_size);
-
-	/* Zero out the descriptor ring */
-	memset(rx_ring->desc, 0, rx_ring->size);
-
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
@@ -752,10 +725,13 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
 	rx_ring->rx_bi = NULL;
 
 	if (rx_ring->desc) {
-		dma_free_coherent(rx_ring->dev, rx_ring->size,
+		dma_free_coherent(rx_ring->pp->p.dev, rx_ring->size,
 				  rx_ring->desc, rx_ring->dma);
 		rx_ring->desc = NULL;
 	}
+
+	page_pool_destroy(rx_ring->pp);
+	rx_ring->pp = NULL;
 }
 
 /**
@@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
  **/
 int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 {
-	struct device *dev = rx_ring->dev;
-	int bi_size;
+	struct page_pool *pool;
+
+	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
+					 rx_ring->count);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	rx_ring->pp = pool;
 
 	/* warn if we are about to overwrite the pointer */
 	WARN_ON(rx_ring->rx_bi);
-	bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
-	rx_ring->rx_bi = kzalloc(bi_size, GFP_KERNEL);
+	rx_ring->rx_bi = kcalloc(rx_ring->count, sizeof(*rx_ring->rx_bi),
+				 GFP_KERNEL);
 	if (!rx_ring->rx_bi)
 		goto err;
 
@@ -781,22 +763,27 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 	/* Round up to nearest 4K */
 	rx_ring->size = rx_ring->count * sizeof(union iavf_32byte_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
-	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
+	rx_ring->desc = dma_alloc_coherent(pool->p.dev, rx_ring->size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc) {
-		dev_info(dev, "Unable to allocate memory for the Rx descriptor ring, size=%d\n",
+		dev_info(pool->p.dev, "Unable to allocate memory for the Rx descriptor ring, size=%d\n",
 			 rx_ring->size);
-		goto err;
+		goto err_free_buf;
 	}
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
 	return 0;
-err:
+
+err_free_buf:
 	kfree(rx_ring->rx_bi);
 	rx_ring->rx_bi = NULL;
+
+err:
+	page_pool_destroy(rx_ring->pp);
+
 	return -ENOMEM;
 }
 
@@ -818,49 +805,6 @@ static inline void iavf_release_rx_desc(struct iavf_ring *rx_ring, u32 val)
 	writel(val, rx_ring->tail);
 }
 
-/**
- * iavf_alloc_mapped_page - recycle or make a new page
- * @rx_ring: ring to use
- * @bi: rx_buffer struct to modify
- *
- * Returns true if the page was successfully allocated or
- * reused.
- **/
-static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
-				   struct iavf_rx_buffer *bi)
-{
-	struct page *page = bi->page;
-	dma_addr_t dma;
-
-	/* alloc new page for storage */
-	page = dev_alloc_pages(iavf_rx_pg_order(rx_ring));
-	if (unlikely(!page)) {
-		rx_ring->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 iavf_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IAVF_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_pages(page, iavf_rx_pg_order(rx_ring));
-		rx_ring->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	bi->dma = dma;
-	bi->page = page;
-	bi->page_offset = IAVF_SKB_PAD;
-
-	return true;
-}
-
 /**
  * iavf_receive_skb - Send a completed packet up the stack
  * @rx_ring:  rx ring in play
@@ -893,36 +837,29 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 {
 	u16 ntu = rx_ring->next_to_use;
 	union iavf_rx_desc *rx_desc;
-	struct iavf_rx_buffer *bi;
 
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
 		return false;
 
 	rx_desc = IAVF_RX_DESC(rx_ring, ntu);
-	bi = &rx_ring->rx_bi[ntu];
 
 	do {
-		if (!iavf_alloc_mapped_page(rx_ring, bi))
-			goto no_buffers;
+		dma_addr_t addr;
 
-		/* sync the buffer for use by the device */
-		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 rx_ring->rx_buf_len,
-						 DMA_FROM_DEVICE);
+		addr = libie_rx_alloc(rx_ring->pp, &rx_ring->rx_bi[ntu]);
+		if (unlikely(addr == DMA_MAPPING_ERROR))
+			goto no_buffers;
 
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
+		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
 		rx_desc++;
-		bi++;
 		ntu++;
 		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = IAVF_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_bi;
 			ntu = 0;
 		}
 
@@ -941,6 +878,8 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 	if (rx_ring->next_to_use != ntu)
 		iavf_release_rx_desc(rx_ring, ntu);
 
+	rx_ring->rx_stats.alloc_page_failed++;
+
 	/* make sure to come back via polling to try again after
 	 * allocation failure
 	 */
@@ -1091,9 +1030,8 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
 
 /**
  * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
- * @rx_ring: rx descriptor ring to transact packets on
- * @rx_buffer: buffer containing page to add
  * @skb: sk_buff to place the data into
+ * @rx_buffer: buffer containing page to add
  * @size: packet length from rx_desc
  *
  * This function will add the data contained in rx_buffer->page to the skb.
@@ -1101,111 +1039,52 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
  *
  * The function will then update the page offset.
  **/
-static void iavf_add_rx_frag(struct iavf_ring *rx_ring,
-			     struct iavf_rx_buffer *rx_buffer,
-			     struct sk_buff *skb,
+static void iavf_add_rx_frag(struct sk_buff *skb,
+			     const struct libie_rx_buffer *rx_buffer,
 			     unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = iavf_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(size + IAVF_SKB_PAD);
-#endif
-
-	if (!size)
-		return;
+	u32 hr = rx_buffer->page->pp->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
-			rx_buffer->page_offset, size, truesize);
-}
-
-/**
- * iavf_get_rx_buffer - Fetch Rx buffer and synchronize data for use
- * @rx_ring: rx descriptor ring to transact packets on
- * @size: size of buffer to add to skb
- *
- * This function will pull an Rx buffer from the ring and synchronize it
- * for use by the CPU.
- */
-static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ring,
-						 const unsigned int size)
-{
-	struct iavf_rx_buffer *rx_buffer;
-
-	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
-	prefetchw(rx_buffer->page);
-	if (!size)
-		return rx_buffer;
-
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      rx_buffer->dma,
-				      rx_buffer->page_offset,
-				      size,
-				      DMA_FROM_DEVICE);
-
-	return rx_buffer;
+			rx_buffer->offset + hr, size, rx_buffer->truesize);
 }
 
 /**
  * iavf_build_skb - Build skb around an existing buffer
- * @rx_ring: Rx descriptor ring to transact packets on
  * @rx_buffer: Rx buffer to pull data from
  * @size: size of buffer to add to skb
  *
  * This function builds an skb around an existing Rx buffer, taking care
  * to set up the skb correctly and avoid any memcpy overhead.
  */
-static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
-				      struct iavf_rx_buffer *rx_buffer,
+static struct sk_buff *iavf_build_skb(const struct libie_rx_buffer *rx_buffer,
 				      unsigned int size)
 {
-	void *va;
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = iavf_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(IAVF_SKB_PAD + size);
-#endif
+	struct page *page = rx_buffer->page;
+	u32 hr = page->pp->p.offset;
 	struct sk_buff *skb;
+	void *va;
 
-	if (!rx_buffer || !size)
-		return NULL;
 	/* prefetch first cache line of first page */
-	va = page_address(rx_buffer->page) + rx_buffer->page_offset;
-	net_prefetch(va);
+	va = page_address(page) + rx_buffer->offset;
+	net_prefetch(va + hr);
 
 	/* build an skb around the page buffer */
-	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
-	if (unlikely(!skb))
+	skb = napi_build_skb(va, rx_buffer->truesize);
+	if (unlikely(!skb)) {
+		page_pool_put_page(page->pp, page, size, true);
 		return NULL;
+	}
+
+	skb_mark_for_recycle(skb);
 
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, IAVF_SKB_PAD);
+	skb_reserve(skb, hr);
 	__skb_put(skb, size);
 
 	return skb;
 }
 
-/**
- * iavf_put_rx_buffer - Unmap used buffer
- * @rx_ring: rx descriptor ring to transact packets on
- * @rx_buffer: rx buffer to pull data from
- *
- * This function will unmap the buffer after it's written by HW.
- */
-static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
-			       struct iavf_rx_buffer *rx_buffer)
-{
-	if (!rx_buffer)
-		return;
-
-	/* we are not reusing the buffer so unmap it */
-	dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-			     iavf_rx_pg_size(rx_ring),
-			     DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
-}
-
 /**
  * iavf_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
@@ -1259,7 +1138,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 	bool failure = false;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
-		struct iavf_rx_buffer *rx_buffer;
+		struct libie_rx_buffer *rx_buffer;
 		union iavf_rx_desc *rx_desc;
 		unsigned int size;
 		u16 vlan_tag = 0;
@@ -1295,26 +1174,24 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		       IAVF_RXD_QW1_LENGTH_PBUF_SHIFT;
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
-		rx_buffer = iavf_get_rx_buffer(rx_ring, size);
+
+		rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
+		if (!libie_rx_sync_for_cpu(rx_buffer, size))
+			goto skip_data;
 
 		/* retrieve a buffer from the ring */
 		if (skb)
-			iavf_add_rx_frag(rx_ring, rx_buffer, skb, size);
+			iavf_add_rx_frag(skb, rx_buffer, size);
 		else
-			skb = iavf_build_skb(rx_ring, rx_buffer, size);
-
-		iavf_put_rx_buffer(rx_ring, rx_buffer);
+			skb = iavf_build_skb(rx_buffer, size);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
-			__free_pages(rx_buffer->page,
-				     iavf_rx_pg_order(rx_ring));
-			rx_buffer->page = NULL;
 			break;
 		}
 
-		rx_buffer->page = NULL;
+skip_data:
 		cleaned_count++;
 
 		if (iavf_is_non_eop(rx_ring, rx_desc, skb))
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 2170a77f8c8d..b13d878c74c6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -81,70 +81,8 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-/* Supported Rx Buffer Sizes (a multiple of 128) */
-#define IAVF_RXBUFFER_1536  1536  /* 128B aligned standard Ethernet frame */
-#define IAVF_RXBUFFER_2048  2048
-#define IAVF_RXBUFFER_3072  3072  /* Used for large frames w/ padding */
-#define IAVF_MAX_RXBUFFER   9728  /* largest size for single descriptor */
-
-#define IAVF_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
 #define iavf_rx_desc iavf_32byte_rx_desc
 
-#define IAVF_RX_DMA_ATTR \
-	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
-
-/* Attempt to maximize the headroom available for incoming frames.  We
- * use a 2K buffer for receives and need 1536/1534 to store the data for
- * the frame.  This leaves us with 512 bytes of room.  From that we need
- * to deduct the space needed for the shared info and the padding needed
- * to IP align the frame.
- *
- * Note: For cache line sizes 256 or larger this value is going to end
- *	 up negative.  In these cases we should fall back to the legacy
- *	 receive path.
- */
-#if (PAGE_SIZE < 8192)
-#define IAVF_2K_TOO_SMALL_WITH_PADDING \
-((NET_SKB_PAD + IAVF_RXBUFFER_1536) > SKB_WITH_OVERHEAD(IAVF_RXBUFFER_2048))
-
-static inline int iavf_compute_pad(int rx_buf_len)
-{
-	int page_size, pad_size;
-
-	page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
-	pad_size = SKB_WITH_OVERHEAD(page_size) - rx_buf_len;
-
-	return pad_size;
-}
-
-static inline int iavf_skb_pad(void)
-{
-	int rx_buf_len;
-
-	/* If a 2K buffer cannot handle a standard Ethernet frame then
-	 * optimize padding for a 3K buffer instead of a 1.5K buffer.
-	 *
-	 * For a 3K buffer we need to add enough padding to allow for
-	 * tailroom due to NET_IP_ALIGN possibly shifting us out of
-	 * cache-line alignment.
-	 */
-	if (IAVF_2K_TOO_SMALL_WITH_PADDING)
-		rx_buf_len = IAVF_RXBUFFER_3072 + SKB_DATA_ALIGN(NET_IP_ALIGN);
-	else
-		rx_buf_len = IAVF_RXBUFFER_1536;
-
-	/* if needed make room for NET_IP_ALIGN */
-	rx_buf_len -= NET_IP_ALIGN;
-
-	return iavf_compute_pad(rx_buf_len);
-}
-
-#define IAVF_SKB_PAD iavf_skb_pad()
-#else
-#define IAVF_2K_TOO_SMALL_WITH_PADDING false
-#define IAVF_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
-#endif
-
 /**
  * iavf_test_staterr - tests bits in Rx descriptor status and error fields
  * @rx_desc: pointer to receive descriptor (in le64 format)
@@ -263,12 +201,6 @@ struct iavf_tx_buffer {
 	u32 tx_flags;
 };
 
-struct iavf_rx_buffer {
-	dma_addr_t dma;
-	struct page *page;
-	__u32 page_offset;
-};
-
 struct iavf_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -311,16 +243,19 @@ enum iavf_ring_state_t {
 struct iavf_ring {
 	struct iavf_ring *next;		/* pointer to next ring in q_vector */
 	void *desc;			/* Descriptor ring memory */
-	struct device *dev;		/* Used for DMA mapping */
+	union {
+		struct page_pool *pp;	/* Used on Rx for buffer management */
+		struct device *dev;	/* Used on Tx for DMA mapping */
+	};
 	struct net_device *netdev;	/* netdev ring maps to */
 	union {
+		struct libie_rx_buffer *rx_bi;
 		struct iavf_tx_buffer *tx_bi;
-		struct iavf_rx_buffer *rx_bi;
 	};
 	DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
+	u8 __iomem *tail;
 	u16 queue_index;		/* Queue number of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
-	u8 __iomem *tail;
 
 	/* high bit set means dynamic, use accessors routines to read/write.
 	 * hardware only supports 2us resolution for the ITR registers.
@@ -329,9 +264,8 @@ struct iavf_ring {
 	 */
 	u16 itr_setting;
 
-	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
-	u16 rx_buf_len;
+	u16 count;			/* Number of descriptors */
 
 	/* used in interrupt processing */
 	u16 next_to_use;
@@ -398,17 +332,6 @@ struct iavf_ring_container {
 #define iavf_for_each_ring(pos, head) \
 	for (pos = (head).ring; pos != NULL; pos = pos->next)
 
-static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
-{
-#if (PAGE_SIZE < 8192)
-	if (ring->rx_buf_len > (PAGE_SIZE / 2))
-		return 1;
-#endif
-	return 0;
-}
-
-#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
-
 bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
 netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 3030ba330326..bb90d8f3ad7e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -10,8 +10,6 @@
 #include "iavf_adminq.h"
 #include "iavf_devids.h"
 
-#define IAVF_RXQ_CTX_DBUFF_SHIFT 7
-
 /* IAVF_MASK is a macro used on 32 bit registers */
 #define IAVF_MASK(mask, shift) ((u32)(mask) << (shift))
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index fdddc3588487..5341508b429f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/net/intel/libie/rx.h>
+
 #include "iavf.h"
 #include "iavf_prototype.h"
 #include "iavf_client.h"
@@ -269,14 +271,13 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
 void iavf_configure_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vsi_queue_config_info *vqci;
-	int i, max_frame = adapter->vf_res->max_mtu;
+	u32 i, max_frame = adapter->vf_res->max_mtu;
+	struct iavf_ring *rxq = adapter->rx_rings;
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
+	u32 hr, max_len;
 	size_t len;
 
-	if (max_frame > IAVF_MAX_RXBUFFER || !max_frame)
-		max_frame = IAVF_MAX_RXBUFFER;
-
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
 		dev_err(&adapter->pdev->dev, "Cannot configure queues, command %d pending\n",
@@ -289,9 +290,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	if (!vqci)
 		return;
 
-	/* Limit maximum frame size when jumbo frames is not enabled */
-	if (adapter->netdev->mtu <= ETH_DATA_LEN)
-		max_frame = IAVF_RXBUFFER_1536 - NET_IP_ALIGN;
+	hr = rxq->pp->p.offset;
+	max_len = rxq->pp->p.max_len;
+	max_frame = min_not_zero(max_frame, LIBIE_MAX_RX_FRM_LEN(hr));
 
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
 	vqci->num_queue_pairs = pairs;
@@ -309,9 +310,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi->rxq.ring_len = adapter->rx_rings[i].count;
 		vqpi->rxq.dma_ring_addr = adapter->rx_rings[i].dma;
 		vqpi->rxq.max_pkt_size = max_frame;
-		vqpi->rxq.databuffer_size =
-			ALIGN(adapter->rx_rings[i].rx_buf_len,
-			      BIT_ULL(IAVF_RXQ_CTX_DBUFF_SHIFT));
+		vqpi->rxq.databuffer_size = max_len;
 		vqpi++;
 	}
 
-- 
2.41.0

