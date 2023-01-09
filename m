Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2996620B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjAIIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjAIIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:54:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD12DF0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:45:57 -0800 (PST)
X-UUID: 10559a3b014e4c4dafccc2fcf81277e1-20230109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BAp+xDBGU54PPm/5VMviuQnl/KdEsY0dtwop6ZaDpbE=;
        b=Lh6Kv2eOAHNBuX+fabw0f7BoGh6FE2jcq2Vq+/TjNFfhU3uaXKcfsW08fR7rQxpsYJvEGFPniqHjHnqsyRCgnDJnQfPf6fKc1iiSSBDy1FxG6iYedTeNbjfXuhHGScAiZASD9auB7+9Hk0L1UdvpUPHtyB65eNizFYTuQtMCuO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:79fc4fbf-def8-4ea4-a046-e4f36bb84947,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:16751754-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 10559a3b014e4c4dafccc2fcf81277e1-20230109
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1951956810; Mon, 09 Jan 2023 16:45:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 9 Jan 2023 16:45:51 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 9 Jan 2023 16:45:50 +0800
From:   <yf.wang@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:IOMMU DMA-API LAYER" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Ning Li <Ning.Li@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>
Subject: [PATCH] iommu/iova: Fix alloc iova overflows issue
Date:   Mon, 9 Jan 2023 16:34:28 +0800
Message-ID: <20230109083429.25622-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

In __alloc_and_insert_iova_range, there is an issue that retry_pfn
overflows. The value of iovad->anchor.pfn_hi is ~0UL, then when
iovad->cached_node is iovad->anchor, curr_iova->pfn_hi + 1 will
overflow. As a result, if the retry logic is executed, low_pfn is
updated to 0, and then new_pfn < low_pfn returns false to make the
allocation successful.

This issue occurs in the following two situations:
1. The first iova size exceeds the domain size. When initializing
iova domain, iovad->cached_node is assigned as iovad->anchor. For
example, the iova domain size is 10M, start_pfn is 0x1_F000_0000,
and the iova size allocated for the first time is 11M. The
following is the log information, new->pfn_lo is smaller than
iovad->cached_node.

Example log:
[  223.798112][T1705487] sh: [name:iova&]__alloc_and_insert_iova_range
start_pfn:0x1f0000,retry_pfn:0x0,size:0xb00,limit_pfn:0x1f0a00
[  223.799590][T1705487] sh: [name:iova&]__alloc_and_insert_iova_range
success start_pfn:0x1f0000,new->pfn_lo:0x1efe00,new->pfn_hi:0x1f08ff

2. The node with the largest iova->pfn_lo value in the iova domain
is deleted, iovad->cached_node will be updated to iovad->anchor,
and then the alloc iova size exceeds the maximum iova size that can
be allocated in the domain.

Adding judgment that retry_pfn must be greater than iovad->start_pfn
can fix this issue.

Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/iova.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a44ad92fc5eb..0073206c2a95 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -209,7 +209,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
 
 	if (high_pfn < size || new_pfn < low_pfn) {
-		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
+		if (low_pfn == iovad->start_pfn &&
+		    retry_pfn >= iovad->start_pfn && retry_pfn < limit_pfn) {
 			high_pfn = limit_pfn;
 			low_pfn = retry_pfn;
 			curr = iova_find_limit(iovad, limit_pfn);
-- 
2.18.0

