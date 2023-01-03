Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A584365BF17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjACLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjACL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:45 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3CF03F;
        Tue,  3 Jan 2023 03:29:32 -0800 (PST)
X-UUID: c0aa10b8ccbf46719f0f612fe6d7d22f-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vf6IcfalnyFtEwcYPBgscSxhCUGC67GQz9ghXYhk16o=;
        b=iXBnmaZmVaA3MtKd34q/1M3YfSMRqyZ9ld57d4n4U0X8VJ8RshKnl+58Kx9wItjjHsOnFW7aV+FEcl6QzjBJWyOaAWb/XpIKTDPkzIT9qkaXUqq3+RNkAUmAytQvsNnZhNTKBwjb1OgdRN77ksm56h5pTBHow0Wg8X3UG/mMNXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:2957d9b0-b490-45a5-90a6-c71fe306039b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.16,REQID:2957d9b0-b490-45a5-90a6-c71fe306039b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:09771b1,CLOUDID:359e1b8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230103192928A19EHKMY,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: c0aa10b8ccbf46719f0f612fe6d7d22f-20230103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 153076878; Tue, 03 Jan 2023 19:29:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 19:29:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 19:29:26 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 03/14] soc: mediatek: mtk-svs: clean up platform probing
Date:   Tue, 3 Jan 2023 19:29:14 +0800
Message-ID: <20230103112925.16554-4-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230103112925.16554-1-roger.lu@mediatek.com>
References: <20230103112925.16554-1-roger.lu@mediatek.com>
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

From: Matthias Brugger <matthias.bgg@gmail.com>

We only ever call the SoC specific probe function from
svs_platform_probe. No need to carry that function in a global
datastructure around.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 465b60a5cedc..5abf94aafbac 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -319,7 +319,6 @@ static const u32 svs_regs_v2[] = {
  * @banks: svs banks that svs platform supports
  * @rst: svs platform reset control
  * @efuse_parsing: svs platform efuse parsing function pointer
- * @probe: svs platform probe function pointer
  * @efuse_max: total number of svs efuse
  * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
@@ -336,7 +335,6 @@ struct svs_platform {
 	struct svs_bank *banks;
 	struct reset_control *rst;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
-	int (*probe)(struct svs_platform *svsp);
 	size_t efuse_max;
 	size_t tefuse_max;
 	const u32 *regs;
@@ -2347,11 +2345,10 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 	svsp->name = svsp_data->name;
 	svsp->banks = svsp_data->banks;
 	svsp->efuse_parsing = svsp_data->efuse_parsing;
-	svsp->probe = svsp_data->probe;
 	svsp->regs = svsp_data->regs;
 	svsp->bank_max = svsp_data->bank_max;
 
-	ret = svsp->probe(svsp);
+	ret = svsp_data->probe(svsp);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.18.0

