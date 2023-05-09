Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA6C6FC555
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjEILs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjEILsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:48:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D5468F;
        Tue,  9 May 2023 04:48:16 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFxBL1KxDzTkDk;
        Tue,  9 May 2023 19:43:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 19:48:14 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v1 2/2] net: remove __skb_frag_set_page()
Date:   Tue, 9 May 2023 19:46:34 +0800
Message-ID: <20230509114634.21079-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining users calling __skb_frag_set_page() with
page being NULL seems to be doing defensive programming,
as shinfo->nr_frags is already decremented, so remove
them.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
RFC: remove a local variable as pointed out by Simon.
---
 drivers/net/ethernet/broadcom/bnx2.c      |  1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  5 +----
 include/linux/skbuff.h                    | 12 ------------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 466e1d62bcf6..0d917a9699c5 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -2955,7 +2955,6 @@ bnx2_reuse_rx_skb_pages(struct bnx2 *bp, struct bnx2_rx_ring_info *rxr,
 		shinfo = skb_shinfo(skb);
 		shinfo->nr_frags--;
 		page = skb_frag_page(&shinfo->frags[shinfo->nr_frags]);
-		__skb_frag_set_page(&shinfo->frags[shinfo->nr_frags], NULL);
 
 		cons_rx_pg->page = page;
 		dev_kfree_skb(skb);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index efaff5018af8..f42e51bd3e42 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1102,10 +1102,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
 		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
-			unsigned int nr_frags;
-
-			nr_frags = --shinfo->nr_frags;
-			__skb_frag_set_page(&shinfo->frags[nr_frags], NULL);
+			--shinfo->nr_frags;
 			cons_rx_buf->page = page;
 
 			/* Update prod since possibly some pages have been
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 30be21c7d05f..00e8c435fa1a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3491,18 +3491,6 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 	fragto->bv_page = fragfrom->bv_page;
 }
 
-/**
- * __skb_frag_set_page - sets the page contained in a paged fragment
- * @frag: the paged fragment
- * @page: the page to set
- *
- * Sets the fragment @frag to contain @page.
- */
-static inline void __skb_frag_set_page(skb_frag_t *frag, struct page *page)
-{
-	frag->bv_page = page;
-}
-
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
 
 /**
-- 
2.33.0

