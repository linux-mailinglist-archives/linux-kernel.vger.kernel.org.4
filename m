Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490F6E3634
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDPIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDPIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D586E7D;
        Sun, 16 Apr 2023 01:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE0960C17;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 235EAC4339E;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634829;
        bh=I1zVuCbwHLpIyH1CupVPrNbprfDrqjzfxLYjmXNkoeE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=N2o6YaB/Knc2DvFH6zU/01Fzz0lyZY8ZIfrzvELgLMOond7oowZWgmGgo16nhqlH6
         D/LQ4HdSji2pT9HILzT2kkA3pEWCbR9OElY8tM66EaHdG62ylOlWTIbWqBRsUiIfhq
         q5hFJfhtlBs7ZeLJvsNRponsWGfpMyf8i7mmucq73S4QQuDwVuq2fHCvDWQ0h7BiX9
         y06+6QDr4aare/JuUMjLzsnLGaXSNf7a+asXk/tdqDaDBvPi/8KDZCU/NAsgHlQ/5l
         JuUJqfQV+uVUF9K8MLoYkhtg+t//Rwnn+uOAO7vUVX5R4Up1LLbTp6EyBqJYjXOfoQ
         rAKTqBMiJ21KA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 03834C77B72;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 16:46:00 +0800
Subject: [PATCH RFC v3 2/4] mmc: dw_mmc: histb: add support for hi3798mv200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v3-2-00e2368c0709@outlook.com>
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681634825; l=5756;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=BbS/l7vrq8NmARY0G9T42pzQupVXhImCLr1VN3mh6sA=;
 b=hVdN+BcMBcu0fG/JOPubm0H5EuF5VmxWbxkXK1J3ub5lkFtjVDWPU2Ta+py9uhZHEyg/cZ0Cq
 L2lrjN+jOCcDw4QzOdw5ysZFqxWBGTwmIY5Vd1jZBTE8a7ouqDzMQV2
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add support for Hi3798MV200 specific extension.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/host/dw_mmc-histb.c | 110 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-histb.c b/drivers/mmc/host/dw_mmc-histb.c
index 106e586bcff4b..039b6df0e8c4d 100644
--- a/drivers/mmc/host/dw_mmc-histb.c
+++ b/drivers/mmc/host/dw_mmc-histb.c
@@ -16,10 +16,14 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
+#define SDMMC_TUNING_CTRL	0x118
+#define SDMMC_TUNING_FIND_EDGE	BIT(5)
+
 #define ALL_INT_CLR		0x1ffff
 
 enum dw_mci_histb_type {
 	DW_MCI_TYPE_HI3798CV200,
+	DW_MCI_TYPE_HI3798MV200,
 };
 
 static struct dw_mci_histb_compat {
@@ -29,6 +33,9 @@ static struct dw_mci_histb_compat {
 	{
 		.compatible = "hisilicon,hi3798cv200-dw-mshc",
 		.ctrl_type = DW_MCI_TYPE_HI3798CV200,
+	}, {
+		.compatible = "hisilicon,hi3798mv200-dw-mshc",
+		.ctrl_type = DW_MCI_TYPE_HI3798MV200,
 	},
 };
 
@@ -36,6 +43,7 @@ struct dw_mci_histb_priv {
 	enum dw_mci_histb_type ctrl_type;
 	struct clk *sample_clk;
 	struct clk *drive_clk;
+	struct clk *sap_dll_mode_clk;
 };
 
 static void dw_mci_histb_set_ios(struct dw_mci *host, struct mmc_ios *ios)
@@ -68,7 +76,10 @@ static void dw_mci_histb_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	if (ios->timing == MMC_TIMING_MMC_HS ||
 	    ios->timing == MMC_TIMING_LEGACY)
 		clk_set_phase(priv->drive_clk, 180);
-	else if (ios->timing == MMC_TIMING_MMC_HS200)
+	else if (ios->timing == MMC_TIMING_MMC_DDR52) {
+		clk_set_phase(priv->drive_clk, 90);
+		clk_set_phase(priv->sample_clk, 45);
+	} else if (ios->timing == MMC_TIMING_MMC_HS200)
 		clk_set_phase(priv->drive_clk, 135);
 }
 
@@ -133,6 +144,75 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 	return err;
 }
 
+static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
+					     u32 opcode)
+{
+	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
+	struct dw_mci *host = slot->host;
+	struct dw_mci_histb_priv *priv = host->priv;
+	int raise_point = -1, fall_point = -1;
+	int err, prev_err = -1;
+	int found = 0;
+	int regval;
+	int i;
+
+	clk_disable(priv->sap_dll_mode_clk);
+	for (i = 0; i < ARRAY_SIZE(degrees); i++) {
+		clk_set_phase(priv->sample_clk, degrees[i]);
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+
+		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		if (err)
+			found = 1;
+		else {
+			regval = mci_readl(host, TUNING_CTRL);
+			if (regval & SDMMC_TUNING_FIND_EDGE)
+				found = 1;
+		};
+
+		if (i > 0) {
+			if (err && !prev_err)
+				fall_point = i - 1;
+			if (!err && prev_err)
+				raise_point = i;
+		}
+
+		if (raise_point != -1 && fall_point != -1)
+			goto tuning_out;
+
+		prev_err = err;
+		err = 0;
+	}
+
+tuning_out:
+	clk_enable(priv->sap_dll_mode_clk);
+	if (found) {
+		if (raise_point == -1)
+			raise_point = 0;
+		if (fall_point == -1)
+			fall_point = ARRAY_SIZE(degrees) - 1;
+		if (fall_point < raise_point) {
+			if ((raise_point + fall_point) >
+			    (ARRAY_SIZE(degrees) - 1))
+				i = fall_point / 2;
+			else
+				i = (raise_point + ARRAY_SIZE(degrees) - 1) / 2;
+		} else {
+			i = (raise_point + fall_point) / 2;
+		}
+
+		clk_set_phase(priv->sample_clk, degrees[i]);
+		dev_dbg(host->dev, "Tuning clk_sample[%d, %d], set[%d]\n",
+			raise_point, fall_point, degrees[i]);
+	} else {
+		dev_err(host->dev, "No valid clk_sample shift! use default\n");
+		err = -EINVAL;
+	}
+
+	mci_writel(host, RINTSTS, ALL_INT_CLR);
+	return err;
+}
+
 static int dw_mci_histb_init(struct dw_mci *host)
 {
 	struct dw_mci_histb_priv *priv;
@@ -160,6 +240,14 @@ static int dw_mci_histb_init(struct dw_mci *host)
 		return PTR_ERR(priv->drive_clk);
 	}
 
+	if (priv->ctrl_type == DW_MCI_TYPE_HI3798MV200) {
+		priv->sap_dll_mode_clk = devm_clk_get(host->dev, "sap-dll-mode");
+		if (IS_ERR(priv->sap_dll_mode_clk)) {
+			dev_err(host->dev, "failed to get sap-dll-mode clock\n");
+			return PTR_ERR(priv->sap_dll_mode_clk);
+		}
+	}
+
 	ret = clk_prepare_enable(priv->sample_clk);
 	if (ret) {
 		dev_err(host->dev, "failed to enable ciu-sample clock\n");
@@ -172,9 +260,19 @@ static int dw_mci_histb_init(struct dw_mci *host)
 		goto disable_sample_clk;
 	}
 
+	if (priv->ctrl_type == DW_MCI_TYPE_HI3798MV200) {
+		ret = clk_prepare_enable(priv->sap_dll_mode_clk);
+		if (ret) {
+			dev_err(host->dev, "failed to disable tuning mode");
+			goto disable_drive_clk;
+		}
+	}
+
 	host->priv = priv;
 	return 0;
 
+disable_drive_clk:
+	clk_disable_unprepare(priv->drive_clk);
 disable_sample_clk:
 	clk_disable_unprepare(priv->sample_clk);
 	return ret;
@@ -187,8 +285,16 @@ static const struct dw_mci_drv_data hi3798cv200_data = {
 	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
 };
 
+static const struct dw_mci_drv_data hi3798mv200_data = {
+	.common_caps = MMC_CAP_CMD23,
+	.init = dw_mci_histb_init,
+	.set_ios = dw_mci_histb_set_ios,
+	.execute_tuning = dw_mci_hi3798mv200_execute_tuning_mix_mode,
+};
+
 static const struct of_device_id dw_mci_histb_match[] = {
 	{ .compatible = "hisilicon,hi3798cv200-dw-mshc", .data = &hi3798cv200_data },
+	{ .compatible = "hisilicon,hi3798mv200-dw-mshc", .data = &hi3798mv200_data },
 	{},
 };
 
@@ -208,6 +314,8 @@ static int dw_mci_histb_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->drive_clk);
 	clk_disable_unprepare(priv->sample_clk);
+	if (priv->ctrl_type == DW_MCI_TYPE_HI3798MV200)
+		clk_disable_unprepare(priv->sap_dll_mode_clk);
 
 	dw_mci_pltfm_remove(pdev);
 

-- 
2.39.2

