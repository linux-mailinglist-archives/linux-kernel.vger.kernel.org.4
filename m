Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8703674297C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjF2PY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjF2PYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8891B0;
        Thu, 29 Jun 2023 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052240; x=1719588240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9H4rj4yLG7tjR1yeWEPFWXfPb3eSoriC/kHz9ihgBIw=;
  b=aR81Opx+iDvYCQpsqq+QPdRPB2ClFgUnlotgRe9EZCPPkPsYPJtCrkcq
   P7gtP7B8tJaGbnhNbOEJp42FXZYzeEz4TpFT5Eytfewe7tEmoo+Op5yCv
   hLg7t8sTSOcA/9YmasoY63dnGyPE5Owf16rOjHd1MAbHSluaf3am3Ufoj
   Udzd+/oV38A8OYAIHCK4SbobEAJjt6YQDlU1bcqWzyjRcbElTSZ1X9Lqt
   yVNBqmu/+N7ttymrPE+FCuNguvVbdA+5LVo88S/jgGnwLiCsFp55u2HTg
   dsGUQLzA2kMltfONgcGXnJdFNPnbpEdbNjVSMZ2Zfen6shHZ1T40tezc9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346920586"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346920586"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830573778"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830573778"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 08:23:53 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 1/4] net: skbuff: don't include <net/page_pool.h> to <linux/skbuff.h>
Date:   Thu, 29 Jun 2023 17:23:02 +0200
Message-ID: <20230629152305.905962-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629152305.905962-1-aleksander.lobakin@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, touching <net/page_pool.h> triggers a rebuild of more than
a half of the kernel. That's because it's included in <linux/skbuff.h>.
And each new include to page_pool.h adds more [useless] data for the
toolchain to process per each source file from that pile.

In commit 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB
recycling"), Matteo included it to be able to call a couple functions
defined there. Then, in commit 57f05bc2ab24 ("page_pool: keep pp info
as long as page pool owns the page") one of the calls was removed, so
only one left. It's the call to page_pool_return_skb_page() in
napi_frag_unref(). The function is external and doesn't have any
dependencies. Having include of very niche page_pool.h only for that
looks like an overkill.
As Alex noticed, the only thing that holds this function in page_pool.c
is %PP_SIGNATURE. By moving the check for magic a couple functions up,
the whole page_pool_return_skb_page() can be moved to skbuff.c.
The arguments for moving the check are the following:

1) It checks for a corner case that shouldn't ever happen when the code
   is sane. And execution speed doesn't matter on exception path, thus
   doing more calls before bailing out doesn't make any weather.
2) There are 2 users of the internal __page_pool_put_page(), where this
   check is moved: page_pool_put_defragged_page() and
   page_pool_put_page_bulk(). Both are exported and can be called from
   the drivers, but previously only the skb recycling path of the former
   was protected with the magic check. So this also makes the code a bit
   more reliable.

After the check is moved, teleport page_pool_return_skb_page() to
skbuff.c, just next to the main consumer, skb_pp_recycle(). It's used
also in napi_frag_unref() -> {__,}skb_frag_unref(), so no `static`
unfortunately. Maybe next time.
Now, after a few include fixes in the drivers, touching page_pool.h
only triggers rebuilding of the drivers using it and a couple core
networking files.

Suggested-by: Jakub Kicinski <kuba@kernel.org> # make skbuff.h less heavy
Suggested-by: Alexander Duyck <alexanderduyck@fb.com> # move to skbuff.c
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c    |  1 +
 drivers/net/ethernet/freescale/fec_main.c     |  1 +
 .../marvell/octeontx2/nic/otx2_common.c       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 include/linux/skbuff.h                        |  3 +-
 include/net/page_pool.h                       |  2 -
 net/core/page_pool.c                          | 52 +++++--------------
 net/core/skbuff.c                             | 28 ++++++++++
 11 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 84751bb303a6..6222aaa5157f 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 
 #define TSNEP_RX_OFFSET (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8fbe47703d47..99b3b4f79603 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -38,6 +38,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <net/ip.h>
+#include <net/page_pool.h>
 #include <net/selftests.h>
 #include <net/tso.h>
 #include <linux/tcp.h>
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a5d03583bf79..d17a0ebc9036 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <net/page_pool.h>
 #include <net/tso.h>
 #include <linux/bitfield.h>
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index fe8ea4e531b7..7eca434a0550 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -16,6 +16,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bitfield.h>
+#include <net/page_pool.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5ce28ff7685f..0f152f14165b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f0e6095809fa..1bd91bc09eb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -35,6 +35,7 @@
 #include "en/xdp.h"
 #include "en/params.h"
 #include <linux/bitfield.h>
+#include <net/page_pool.h>
 
 int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..95c16f11d156 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -15,6 +15,7 @@
 #include <linux/average.h>
 #include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
+#include <net/page_pool.h>
 #include "util.h"
 #include "testmode.h"
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 91ed66952580..f76d172ed262 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -32,7 +32,6 @@
 #include <linux/if_packet.h>
 #include <linux/llist.h>
 #include <net/flow.h>
-#include <net/page_pool.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
 #endif
@@ -3423,6 +3422,8 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
+bool page_pool_return_skb_page(struct page *page, bool napi_safe);
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 2b7db9992fc0..829dc1f8ba6b 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -307,8 +307,6 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-bool page_pool_return_skb_page(struct page *page, bool napi_safe);
-
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 struct xdp_mem_info;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 985ccaffc06a..dff0b4fa2316 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -582,6 +582,19 @@ static __always_inline struct page *
 __page_pool_put_page(struct page_pool *pool, struct page *page,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
+	/* Avoid recycling non-PP pages, give them back to the page allocator.
+	 * page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
+	 * in order to preserve any existing bits, such as bit 0 for the
+	 * head page of compound page and bit 1 for pfmemalloc page, so
+	 * mask those bits for freeing side when doing below checking,
+	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
+	 * to avoid recycling the pfmemalloc page.
+	 */
+	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE)) {
+		put_page(page);
+		return NULL;
+	}
+
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
 	 * regular page allocator APIs.
@@ -913,42 +926,3 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-
-bool page_pool_return_skb_page(struct page *page, bool napi_safe)
-{
-	struct napi_struct *napi;
-	struct page_pool *pp;
-	bool allow_direct;
-
-	page = compound_head(page);
-
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
-		return false;
-
-	pp = page->pp;
-
-	/* Allow direct recycle if we have reasons to believe that we are
-	 * in the same context as the consumer would run, so there's
-	 * no possible race.
-	 */
-	napi = READ_ONCE(pp->p.napi);
-	allow_direct = napi_safe && napi &&
-		READ_ONCE(napi->list_owner) == smp_processor_id();
-
-	/* Driver set this to memory recycling info. Reset it on recycle.
-	 * This will *not* work for NIC using a split-page memory model.
-	 * The page will be returned to the pool here regardless of the
-	 * 'flipped' fragment being in use or not.
-	 */
-	page_pool_put_full_page(pp, page, allow_direct);
-
-	return true;
-}
-EXPORT_SYMBOL(page_pool_return_skb_page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7edabf17988a..4b7d00d5b5d7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -879,6 +879,34 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+bool page_pool_return_skb_page(struct page *page, bool napi_safe)
+{
+	struct napi_struct *napi;
+	struct page_pool *pp;
+	bool allow_direct;
+
+	page = compound_head(page);
+	pp = page->pp;
+
+	/* Allow direct recycle if we have reasons to believe that we are
+	 * in the same context as the consumer would run, so there's
+	 * no possible race.
+	 */
+	napi = READ_ONCE(pp->p.napi);
+	allow_direct = napi_safe && napi &&
+		READ_ONCE(napi->list_owner) == smp_processor_id();
+
+	/* Driver set this to memory recycling info. Reset it on recycle.
+	 * This will *not* work for NIC using a split-page memory model.
+	 * The page will be returned to the pool here regardless of the
+	 * 'flipped' fragment being in use or not.
+	 */
+	page_pool_put_full_page(pp, page, allow_direct);
+
+	return true;
+}
+EXPORT_SYMBOL(page_pool_return_skb_page);
+
 static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
-- 
2.41.0

