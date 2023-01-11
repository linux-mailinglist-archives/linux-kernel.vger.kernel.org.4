Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21C665573
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjAKHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjAKHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:45:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D4101DC;
        Tue, 10 Jan 2023 23:45:38 -0800 (PST)
X-UUID: ecb1f7ce918311ed945fc101203acc17-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b7yNvUj+1iWfdSzh60OgaeHK/98sY0UhtMzQV5RG5IE=;
        b=VHbWunAZ/lHLCYHSkp0yG6DBHSCDAzgM/k5moPOX+2dNVmArRNiSwET9OqwAQF0cmRkq85LZ2aRtIAx7RhjHisM6j3dVfr52p9I1ip/kSN6eyfrosq/KLo5SxHN+vPnwZa0whCrasxTmb5Gf7pHx33fL4jG+kmNyk0mRFnQxyF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:b752f472-6719-4877-b344-5ca1713b9bae,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:543e81c,CLOUDID:28ac5354-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: ecb1f7ce918311ed945fc101203acc17-20230111
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 530755976; Wed, 11 Jan 2023 15:45:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 Jan 2023 15:45:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 15:45:30 +0800
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
Subject: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
Date:   Wed, 11 Jan 2023 15:45:19 +0800
Message-ID: <20230111074528.29354-6-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230111074528.29354-1-roger.lu@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MediaTek HW design, svs and thermal both use the same clk source.
It means that svs clk reference count from CCF includes thermal control
counts. That makes svs driver confuse whether it disabled svs's main clk
or not from CCF's perspective and lead to turn off their shared clk
unexpectedly. Therefore, we add svs clk control APIs to make sure svs's
main clk is controlled well by svs driver itself.

Here is a NG example. Rely on CCF's reference count and cause problem.

thermal probe (clk ref = 1)
-> svs probe (clk ref = 2)
   -> svs suspend (clk ref = 1)
      -> thermal suspend (clk ref = 0)
      -> thermal resume (clk ref = 1)
   -> svs resume (encounter error, clk ref = 1)
   -> svs suspend (clk ref = 0)
      -> thermal suspend (Fail here, thermal HW control w/o clk)

Fixes: a825d72f74a3 ("soc: mediatek: fix missing clk_disable_unprepare() on err in svs_resume()")
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 57 ++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 9575aa645643..830263bad81e 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -326,6 +326,7 @@ static const u32 svs_regs_v2[] = {
  * @bank_max: total number of svs banks
  * @efuse: svs efuse data received from NVMEM framework
  * @tefuse: thermal efuse data received from NVMEM framework
+ * @clk_cnt: clock count shows the clk enable/disable times by svs driver
  */
 struct svs_platform {
 	char *name;
@@ -343,6 +344,7 @@ struct svs_platform {
 	u32 bank_max;
 	u32 *efuse;
 	u32 *tefuse;
+	s32 clk_cnt;
 };
 
 struct svs_platform_data {
@@ -502,6 +504,32 @@ static void svs_switch_bank(struct svs_platform *svsp)
 	svs_writel_relaxed(svsp, svsb->core_sel, CORESEL);
 }
 
+static bool svs_is_clk_enabled(struct svs_platform *svsp)
+{
+	return svsp->clk_cnt > 0 ? true : false;
+}
+
+static int svs_clk_enable(struct svs_platform *svsp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(svsp->main_clk);
+	if (ret) {
+		dev_err(svsp->dev, "cannot enable main_clk: %d\n", ret);
+		return ret;
+	}
+
+	svsp->clk_cnt++;
+
+	return 0;
+}
+
+static void svs_clk_disable(struct svs_platform *svsp)
+{
+	clk_disable_unprepare(svsp->main_clk);
+	svsp->clk_cnt--;
+}
+
 static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
 				     u32 svsb_volt_base)
 {
@@ -1569,6 +1597,12 @@ static int svs_suspend(struct device *dev)
 	int ret;
 	u32 idx;
 
+	if (!svs_is_clk_enabled(svsp)) {
+		dev_err(svsp->dev, "svs clk is disabled already (%d)\n",
+			svsp->clk_cnt);
+		return 0;
+	}
+
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
 
@@ -1590,7 +1624,7 @@ static int svs_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(svsp->main_clk);
+	svs_clk_disable(svsp);
 
 	return 0;
 }
@@ -1600,16 +1634,14 @@ static int svs_resume(struct device *dev)
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(svsp->main_clk);
-	if (ret) {
-		dev_err(svsp->dev, "cannot enable main_clk, disable svs\n");
+	ret = svs_clk_enable(svsp);
+	if (ret)
 		return ret;
-	}
 
 	ret = reset_control_deassert(svsp->rst);
 	if (ret) {
 		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
-		goto out_of_resume;
+		goto svs_resume_clk_disable;
 	}
 
 	ret = svs_init02(svsp);
@@ -1624,8 +1656,9 @@ static int svs_resume(struct device *dev)
 	dev_err(svsp->dev, "assert reset: %d\n",
 		reset_control_assert(svsp->rst));
 
-out_of_resume:
-	clk_disable_unprepare(svsp->main_clk);
+svs_resume_clk_disable:
+	svs_clk_disable(svsp);
+
 	return ret;
 }
 
@@ -2411,11 +2444,9 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_resource;
 	}
 
-	ret = clk_prepare_enable(svsp->main_clk);
-	if (ret) {
-		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
+	ret = svs_clk_enable(svsp);
+	if (ret)
 		goto svs_probe_free_resource;
-	}
 
 	svsp->base = of_iomap(svsp->dev->of_node, 0);
 	if (IS_ERR_OR_NULL(svsp->base)) {
@@ -2456,7 +2487,7 @@ static int svs_probe(struct platform_device *pdev)
 	iounmap(svsp->base);
 
 svs_probe_clk_disable:
-	clk_disable_unprepare(svsp->main_clk);
+	svs_clk_disable(svsp);
 
 svs_probe_free_resource:
 	if (!IS_ERR_OR_NULL(svsp->efuse))
-- 
2.18.0

