Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783855E97F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiIZCiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiIZCiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:38:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C211809
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 19:38:01 -0700 (PDT)
X-UUID: b61bbf69277e4545b0248197cb190557-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lNjS0daBockfvC8/I+tkIjGjCHW4b3iin6Yx3Vdho4k=;
        b=LlnTQdxsD/9oDIeb7uboHvuYrMCNGik2EKkY1aMeKTC7/Qp2BRGZcrWXGYNF1L7jFlMYw5PggHxN/1snECroFyURNLlWt9O4h9q08eHODMq9MjbAzrMgnsNPEKiILd525qDPnlOH0Dm1/yoALxDx9IA7X1rnklKyASGj+lPdTjY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0ac22042-0d93-4acb-bdd5-771a7855c217,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:70cc05a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b61bbf69277e4545b0248197cb190557-20220926
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 307749542; Mon, 26 Sep 2022 10:37:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 10:37:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Sep 2022 10:37:50 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH next] phy: mediatek: fix build warning of FIELD_PREP()
Date:   Mon, 26 Sep 2022 10:37:50 +0800
Message-ID: <20220926023750.21183-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change the inline function mtk_phy_update_field() into a macro to
avoid check warning of FIELD_PREP() with compiler parameter
-Wtautological-constant-out-of-range-compare

the warning is caused by mask check:
"BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \"

Fixes: 29c07477556e ("phy: mediatek: add a new helper to update bitfield")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-io.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
index 9e9c6f221c92..d20ad5e5be81 100644
--- a/drivers/phy/mediatek/phy-mtk-io.h
+++ b/drivers/phy/mediatek/phy-mtk-io.h
@@ -37,9 +37,10 @@ static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
 }
 
 /* field @mask shall be constant and continuous */
-static inline void mtk_phy_update_field(void __iomem *reg, u32 mask, u32 val)
-{
-	mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val));
-}
+#define mtk_phy_update_field(reg, mask, val) \
+({ \
+	typeof(mask) mask_ = (mask);	\
+	mtk_phy_update_bits(reg, mask_, FIELD_PREP(mask_, val)); \
+})
 
 #endif
-- 
2.18.0

