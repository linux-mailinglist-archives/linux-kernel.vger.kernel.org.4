Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44A6E31C6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDOOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDOOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926D49DA;
        Sat, 15 Apr 2023 07:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6582961760;
        Sat, 15 Apr 2023 14:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE4EBC4339C;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681568336;
        bh=g3ATOu+IH9mcXX+NmXDHTqH3ckqOF36wKo5UkW4+MXE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=YJ5cdgGTAS63vr+EJOduWhsGIv+DRwgnQzn3Hl6Os5J5gq+1O2dvkAMIpqo/g1az2
         nkXIJlW4/9SBU5I1bHA6ySM3Fh4HrX2PtY4kyIu5+TkceJm3A7d2igt5fqUHbKBq1w
         XMtA9D0sptzH0QyUmPcnNnEqaFxDD9NgHxjl4pDDosqtUXvkAr4D/tF7QK6bRy59lK
         D8rSDCZQeaYh4+8X2a9XhzjObRO0TdEhAdawnBy0US33XTJGijGZZr8dxY/yWa6UJf
         dSnmNNZKDLdI7wjANYIysUoefgNfaUKanNdTkuxaz+VU0xFgrtTh9WeRokGQbdVc4R
         Df3W2aTcNSIlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A39EBC77B76;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sat, 15 Apr 2023 22:18:45 +0800
Subject: [PATCH RFC 2/3] mmc: dw_mmc-histb: add support for hi3798mv200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v1-2-db5b91d939d4@outlook.com>
References: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681568331; l=5241;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=5yOa8E9ies3gES65jo2XGwK0E3e6BIAYTTq7qEPsamM=;
 b=DFlKznDN8g5ZRu9sOrKtVzO0h5PfUP+aspJMHi+NmOuJQtAQg7qt/7YExkXSpUK6SjQrx1Wfm
 czvVDJEq/uHCxURVYoD3vACK2z7+2rUJJrBWA2bKh0kGqA10Vcsr53g
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add support for Hi3798MV200 specific extension.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/host/dw_mmc-histb.c | 105 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-histb.c b/drivers/mmc/host/dw_mmc-histb.c
index 106e586bcff4b..9c6fd78009668 100644
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
@@ -133,6 +141,75 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
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
@@ -160,6 +237,14 @@ static int dw_mci_histb_init(struct dw_mci *host)
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
@@ -172,9 +257,19 @@ static int dw_mci_histb_init(struct dw_mci *host)
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
@@ -187,8 +282,16 @@ static const struct dw_mci_drv_data hi3798cv200_data = {
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
 
@@ -208,6 +311,8 @@ static int dw_mci_histb_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->drive_clk);
 	clk_disable_unprepare(priv->sample_clk);
+	if (priv->ctrl_type == DW_MCI_TYPE_HI3798MV200)
+		clk_disable_unprepare(priv->sap_dll_mode_clk);
 
 	dw_mci_pltfm_remove(pdev);
 

-- 
2.39.2

