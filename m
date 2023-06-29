Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8172174297D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjF2PYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjF2PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A12703;
        Thu, 29 Jun 2023 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052241; x=1719588241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/XcIomoM5FwKJ4/woDWeTY9YJxcho3WgtMqtWHrNMM=;
  b=RnycxpmWI6AMDWRkIz9CAizAp/OMhCqxDCYNevqvFG3dl2jztXrvTq5q
   FuPm/RwI7mIZXQN+0COgw5qeLtHf59/C266sEHA8Dl+whvhCnPUnDBm4R
   xeZypJApv48jvtYehlq1qtJtdLt4tPIteqVXNjJIpj0fK4dsIADSL6QZE
   Wq4rdOh6Phi/h0auxmBZ4pSTxGZ9Hf5Er6I2teI2/wVL7suobyaamFSR1
   CLvEbPulrMitt/8ZI24LPxDsnGBE13CNxAZAgYdFGdDpy9kzZHDNkExFU
   A3vWg1vSSCB5Zddul7IVfvQf1ZrfGCwdyL9HWtZ/TPD+sbw+s+QuOFPCg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346920613"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346920613"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830573798"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830573798"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 08:23:57 -0700
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
Subject: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op externals when possible
Date:   Thu, 29 Jun 2023 17:23:03 +0200
Message-ID: <20230629152305.905962-3-aleksander.lobakin@intel.com>
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

Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
even when on DMA-coherent platforms (like x86) with no active IOMMU or
swiotlb, just for the call ladder.
Indeed, it's

page_pool_put_page()
  page_pool_put_defragged_page()                  <- external
    __page_pool_put_page()
      page_pool_dma_sync_for_device()             <- non-inline
        dma_sync_single_range_for_device()
          dma_sync_single_for_device()            <- external
            dma_direct_sync_single_for_device()
              dev_is_dma_coherent()               <- exit

For the inline functions, no guarantees the compiler won't uninline them
(they're clearly not one-liners and sometimes compilers uninline even
2 + 2). The first external call is necessary, but the rest 2+ are done
for nothing each time, plus a bunch of checks here and there.
Since Page Pool mappings are long-term and for one "device + addr" pair
dma_need_sync() will always return the same value (basically, whether it
belongs to an swiotlb pool), addresses can be tested once right after
they're obtained and the result can be reused until the page is unmapped.
Define new PP flag, which will mean "do DMA syncs for device, but only
when needed" and turn it on by default when the driver asks to sync
pages. When a page is mapped, check whether it needs syncs and if so,
replace that "sync when needed" back to "always do syncs" globally for
the whole pool (better safe than sorry). As long as a pool has no pages
requiring DMA syncs, this cuts off a good piece of calls and checks.
On my x86_64, this gives from 2% to 5% performance benefit with no
negative impact for cases when IOMMU is on and the shortcut can't be
used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h |  3 +++
 net/core/page_pool.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 829dc1f8ba6b..ff3772fab707 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -23,6 +23,9 @@
 					* Please note DMA-sync-for-CPU is still
 					* device driver responsibility
 					*/
+#define PP_FLAG_DMA_MAYBE_SYNC	BIT(2) /* Internal, should not be used in
+					* drivers
+					*/
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
 				 PP_FLAG_DMA_SYNC_DEV)
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dff0b4fa2316..498e058140b3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -197,6 +197,10 @@ static int page_pool_init(struct page_pool *pool,
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
 		 */
+
+		/* Try to avoid calling no-op syncs */
+		pool->p.flags |= PP_FLAG_DMA_MAYBE_SYNC;
+		pool->p.flags &= ~PP_FLAG_DMA_SYNC_DEV;
 	}
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
+	if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
+	    dma_need_sync(pool->p.dev, dma)) {
+		pool->p.flags |= PP_FLAG_DMA_SYNC_DEV;
+		pool->p.flags &= ~PP_FLAG_DMA_MAYBE_SYNC;
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
-- 
2.41.0

