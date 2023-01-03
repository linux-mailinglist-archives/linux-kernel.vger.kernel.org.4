Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422365BF0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjACLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbjACL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D153F587;
        Tue,  3 Jan 2023 03:29:37 -0800 (PST)
X-UUID: 13939d70bf5843009e2f0f6053e6b953-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mzND0DnWw9AD417JDZhq7g/cwkn0pKOarhIAsIxEwPE=;
        b=Q3JnZ/ymegteFTJkpGCg9BZKz8u0fpM6yq7Nc9XZ5telMOVB9L4pQNYRwDRArg/5hXBX3Y/5Ed9ujjoXVtYL/bwopbarjeCP6nfVUhPtAXshQ5XKZdJczwgOZjLZ5mmcvID2HAra6PZ8IeMfekREfbjN93XboosO/Y+E3IZjM+M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:2c5014ca-6725-4a8d-80e3-5502e11d5c36,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:09771b1,CLOUDID:90a48053-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 13939d70bf5843009e2f0f6053e6b953-20230103
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 98266115; Tue, 03 Jan 2023 19:29:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 19:29:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 19:29:27 +0800
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
Subject: [PATCH v3 09/14] soc: mediatek: mtk-svs: use svs clk control APIs
Date:   Tue, 3 Jan 2023 19:29:20 +0800
Message-ID: <20230103112925.16554-10-roger.lu@mediatek.com>
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

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 60 ++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 70f87715a084..d8b759897fec 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/completion.h>
 #include <linux/cpuidle.h>
 #include <linux/debugfs.h>
@@ -323,6 +324,7 @@ static const u32 svs_regs_v2[] = {
  * @bank_max: total number of svs banks
  * @efuse: svs efuse data received from NVMEM framework
  * @tefuse: thermal efuse data received from NVMEM framework
+ * @clk_cnt: clock count shows the clk enable/disable times by svs driver
  */
 struct svs_platform {
 	void __iomem *base;
@@ -337,6 +339,7 @@ struct svs_platform {
 	u32 bank_max;
 	u32 *efuse;
 	u32 *tefuse;
+	s32 clk_cnt;
 };
 
 struct svs_platform_data {
@@ -496,6 +499,32 @@ static void svs_switch_bank(struct svs_platform *svsp)
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
@@ -1543,6 +1572,12 @@ static int svs_suspend(struct device *dev)
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
 
@@ -1564,7 +1599,7 @@ static int svs_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(svsp->main_clk);
+	svs_clk_disable(svsp);
 
 	return 0;
 }
@@ -1574,28 +1609,27 @@ static int svs_resume(struct device *dev)
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
 	if (ret)
-		goto out_of_resume;
+		goto svs_resume_clk_disable;
 
 	svs_mon_mode(svsp);
 
 	return 0;
 
-out_of_resume:
-	clk_disable_unprepare(svsp->main_clk);
+svs_resume_clk_disable:
+	svs_clk_disable(svsp);
+
 	return ret;
 }
 
@@ -2340,11 +2374,9 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_tefuse;
 	}
 
-	ret = clk_prepare_enable(svsp->main_clk);
-	if (ret) {
-		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
+	ret = svs_clk_enable(svsp);
+	if (ret)
 		goto svs_probe_free_tefuse;
-	}
 
 	svsp->base = of_iomap(svsp->dev->of_node, 0);
 	if (IS_ERR_OR_NULL(svsp->base)) {
@@ -2385,7 +2417,7 @@ static int svs_probe(struct platform_device *pdev)
 	iounmap(svsp->base);
 
 svs_probe_clk_disable:
-	clk_disable_unprepare(svsp->main_clk);
+	svs_clk_disable(svsp);
 
 svs_probe_free_tefuse:
 	if (!IS_ERR_OR_NULL(svsp->tefuse))
-- 
2.18.0

