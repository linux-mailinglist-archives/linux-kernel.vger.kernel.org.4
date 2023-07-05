Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC87488AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGEP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjGEP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:58:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7FA1FE3;
        Wed,  5 Jul 2023 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688572679; x=1720108679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HT3QVhaII1ut20E0aOjgvB7K1D/L8nMsNYbwazudTLI=;
  b=mb6MhHJk/TlTR/TnXltCictVLMzHGENWwImC5we88+lbVy7ih7FH7bcU
   KtpPyAxiUlgQt8SVIxhlQaCvEsqiebW45r+JbW2S1kJXmtdrgoZy8/XEs
   IBVQGHeGOkJlEO9arVFpBeA6J9dLe5nsKxusJlEa5Ma3Ddzl2WWi8Bjh0
   J8AdmL8hpIOvFA9833i77sph1szOBwYhPkoVoO3tsuhRSHzWqziTLKIto
   SvIleQ+wOhPBibmjjmtLOeSlplrsROMlFouflkJURmHYsmWPFr+WtsN2w
   zQu1hbsUQzWWpci6ZvlyeHQ8eHtD/IZAz1LZGSkOOTEasiIHFtnpbkFeF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366863538"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="366863538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789205615"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="789205615"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2023 08:57:45 -0700
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
Subject: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via Page Pool)
Date:   Wed,  5 Jul 2023 17:55:47 +0200
Message-ID: <20230705155551.1317583-6-aleksander.lobakin@intel.com>
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

Add a couple intuitive helpers to hide Rx buffer implementation details
in the library and not multiplicate it between drivers. The settings are
optimized for Intel hardware, but nothing really HW-specific here.
Use the new page_pool_dev_alloc() to dynamically switch between
split-page and full-page modes depending on MTU, page size, required
headroom etc. For example, on x86_64 with the default driver settings
each page is shared between 2 buffers. Turning on XDP (not in this
series) -> increasing headroom requirement pushes truesize out of 2048
boundary, leading to that each buffer starts getting a full page.
The "ceiling" limit is %PAGE_SIZE, as only order-0 pages are used to
avoid compound overhead. For the above architecture, this means maximum
linear frame size of 3712 w/o XDP.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig    |   1 +
 drivers/net/ethernet/intel/libie/rx.c |  54 +++++++++++++
 include/linux/net/intel/libie/rx.h    | 111 +++++++++++++++++++++++++-
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 86ecedeac115..e187942b5a5c 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -86,6 +86,7 @@ config E1000E_HWTS
 
 config LIBIE
 	tristate
+	select PAGE_POOL
 	help
 	  libie (Intel Ethernet library) is a common library containing
 	  routines shared by several Intel Ethernet drivers.
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index f503476d8eef..c60d7b20ed20 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -3,6 +3,60 @@
 
 #include <linux/net/intel/libie/rx.h>
 
+/* Rx buffer management */
+
+/**
+ * libie_rx_sync_len - get the actual buffer size to be synced and passed to HW
+ * @dev: &net_device to calculate the size for
+ * @hr: headroom in front of each frame
+ *
+ * Returns the buffer size to pass it to HW and use for DMA synchronization
+ * accounting: MTU the @dev has, HW required alignment, minimum and maximum
+ * allowed values, and system's page size.
+ */
+static u32 libie_rx_sync_len(const struct net_device *dev, u32 hr)
+{
+	u32 len;
+
+	len = READ_ONCE(dev->mtu) + LIBIE_RX_LL_LEN;
+	len = ALIGN(len, LIBIE_RX_BUF_LEN_ALIGN);
+	len = clamp(len, LIBIE_MIN_RX_BUF_LEN, LIBIE_RX_BUF_LEN(hr));
+
+	return len;
+}
+
+/**
+ * libie_rx_page_pool_create - create a PP with the default libie settings
+ * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ * @size: size of the PP, usually simply Rx queue len
+ *
+ * Returns &page_pool on success, casted -errno on failure.
+ */
+struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
+					    u32 size)
+{
+	struct page_pool_params pp = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order		= LIBIE_RX_PAGE_ORDER,
+		.pool_size	= size,
+		.nid		= NUMA_NO_NODE,
+		.dev		= napi->dev->dev.parent,
+		.napi		= napi,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.offset		= LIBIE_SKB_HEADROOM,
+	};
+	size_t truesize;
+
+	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
+
+	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
+	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
+	pp.init_arg = (void *)truesize;
+
+	return page_pool_create(&pp);
+}
+EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
+
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
  */
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/net/intel/libie/rx.h
index 58bd0f35d025..8c0ccdff9a37 100644
--- a/include/linux/net/intel/libie/rx.h
+++ b/include/linux/net/intel/libie/rx.h
@@ -4,7 +4,116 @@
 #ifndef __LIBIE_RX_H
 #define __LIBIE_RX_H
 
-#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+#include <net/page_pool.h>
+
+/* Rx MTU/buffer/truesize helpers. Mostly pure software-side; HW-defined values
+ * are valid for all Intel HW.
+ */
+
+/* Space reserved in front of each frame */
+#define LIBIE_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+/* Maximum headroom to calculate max MTU below */
+#define LIBIE_MAX_HEADROOM	LIBIE_SKB_HEADROOM
+/* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
+#define LIBIE_RX_LL_LEN		(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+
+/* Always use order-0 pages */
+#define LIBIE_RX_PAGE_ORDER	0
+/* Rx buffer size config is a multiple of 128 */
+#define LIBIE_RX_BUF_LEN_ALIGN	128
+/* HW-writeable space in one buffer: truesize - headroom/tailroom,
+ * HW-aligned
+ */
+#define __LIBIE_RX_BUF_LEN(hr)						\
+	ALIGN_DOWN(SKB_MAX_ORDER(hr, LIBIE_RX_PAGE_ORDER),		\
+		   LIBIE_RX_BUF_LEN_ALIGN)
+/* The smallest and largest size for a single descriptor as per HW */
+#define LIBIE_MIN_RX_BUF_LEN	1024U
+#define LIBIE_MAX_RX_BUF_LEN	9728U
+/* "True" HW-writeable space: minimum from SW and HW values */
+#define LIBIE_RX_BUF_LEN(hr)	min_t(u32, __LIBIE_RX_BUF_LEN(hr),	\
+				      LIBIE_MAX_RX_BUF_LEN)
+
+/* The maximum frame size as per HW (S/G) */
+#define __LIBIE_MAX_RX_FRM_LEN	16382U
+/* ATST, HW can chain up to 5 Rx descriptors */
+#define LIBIE_MAX_RX_FRM_LEN(hr)					\
+	min_t(u32, __LIBIE_MAX_RX_FRM_LEN, LIBIE_RX_BUF_LEN(hr) * 5)
+/* Maximum frame size minus LL overhead */
+#define LIBIE_MAX_MTU							\
+	(LIBIE_MAX_RX_FRM_LEN(LIBIE_MAX_HEADROOM) - LIBIE_RX_LL_LEN)
+
+/* Rx buffer management */
+
+/**
+ * struct libie_rx_buffer - structure representing an Rx buffer
+ * @page: page holding the buffer
+ * @offset: offset from the page start (to the headroom)
+ * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
+ *
+ * Depending on the MTU, API switches between one-page-per-frame and shared
+ * page model (to conserve memory on bigger-page platforms). In case of the
+ * former, @offset is always 0 and @truesize is always %PAGE_SIZE.
+ */
+struct libie_rx_buffer {
+	struct page	*page;
+	u32		offset;
+	u32		truesize;
+};
+
+struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
+					    u32 size);
+
+/**
+ * libie_rx_alloc - allocate a new Rx buffer
+ * @pool: page_pool to allocate from
+ * @buf: buffer structure to populate
+ *
+ * Returns &dma_addr_t to be passed to HW for Rx, %DMA_MAPPING_ERROR otherwise.
+ */
+static inline dma_addr_t libie_rx_alloc(struct page_pool *pool,
+					struct libie_rx_buffer *buf)
+{
+	/* "Wanted" truesize, see libie_rx_page_pool_create() */
+	buf->truesize = (size_t)pool->p.init_arg;
+	buf->page = page_pool_dev_alloc(pool, &buf->offset, &buf->truesize);
+	if (!buf->page)
+		return DMA_MAPPING_ERROR;
+
+	return page_pool_get_dma_addr(buf->page) + buf->offset +
+	       pool->p.offset;
+}
+
+/**
+ * libie_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @buf: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Returns true when there's data to process, false otherwise.
+ */
+static inline bool __must_check
+libie_rx_sync_for_cpu(const struct libie_rx_buffer *buf, u32 len)
+{
+	struct page *page = buf->page;
+
+	/* Very rare, but possible case. The most common reason:
+	 * the last fragment contained FCS only, which was then
+	 * stripped by the HW.
+	 */
+	if (unlikely(!len)) {
+		page_pool_recycle_direct(page->pp, page);
+		return false;
+	}
+
+	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);
+
+	return true;
+}
 
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
-- 
2.41.0

