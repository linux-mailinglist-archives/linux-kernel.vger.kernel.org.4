Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68E74703C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGDL4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGDL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:56:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297810D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:56:47 -0700 (PDT)
X-UUID: d74e09ba1a6111ee9cb5633481061a41-20230704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kDmDXnjKdjFDPlrVeD7IKJ7Ywmn7ZI+Wx6K1yIaJQEA=;
        b=U0+UN2ctIVNOINxIiOMPfSIuBl9lpsKl3hpCqX2xCsIMfbTzI2JtgIzMmHlH32EW0guaNVhvSxsdT5RSbJvHG1jn7l1ZJJfUu+9sWpYab0HzshDV+rndfjcVLuu5HU4PwxMG17a7dLAManHQTMvKBTZ4Fd69VqImXhPHDAtSP5Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:7f2d32be-69d2-4369-b8b1-e91250455b05,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:7f2d32be-69d2-4369-b8b1-e91250455b05,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:14558d0d-26a8-467f-b838-f99719a9c083,B
        ulkID:230704195642DL3I3ZRD,BulkQuantity:1,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: d74e09ba1a6111ee9cb5633481061a41-20230704
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 853156001; Tue, 04 Jul 2023 19:56:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jul 2023 19:56:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jul 2023 19:56:40 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] iommu/mediatek: Remove a unnecessary checking for larbid
Date:   Tue, 4 Jul 2023 19:56:34 +0800
Message-ID: <20230704115634.7727-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a coverity issue:

>>assignment: Assigning: larbid = (fwspec->ids[0] >> 5) & 0x1fU.
	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>>between: At condition larbid >= 32U, the value of larbid must be between
>>0 and 31.
>>dead_error_condition: The condition larbid >= 32U cannot be true.
	if (larbid >= MTK_LARB_NR_MAX)
>>CID 11306470 (#1 of 1): Logically dead code (DEADCODE)
>>dead_error_line: Execution cannot reach this statement:
>>return ERR_PTR(-22L);
        	return ERR_PTR(-EINVAL);

The checking "if (larbid >= MTK_LARB_NR_MAX)" is unnecessary.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
Rebase on v6.4-rc1.
---
 drivers/iommu/mtk_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index aecc7d154f28..67caa90b481b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -838,9 +838,6 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	 * All the ports in each a device should be in the same larbs.
 	 */
 	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
-	if (larbid >= MTK_LARB_NR_MAX)
-		return ERR_PTR(-EINVAL);
-
 	for (i = 1; i < fwspec->num_ids; i++) {
 		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		if (larbid != larbidx) {
-- 
2.25.1

