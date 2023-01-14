Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3954566A9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjANHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjANHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:10:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A104EF3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:24 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so23077228pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1my+Ly+FdtcosfHyIpZcPo3UptFe/yXHtTG6Hbw8BdE=;
        b=e109sXnNdjXcjgCLrSEEcyu+tuWSVd4PN5QkiZZEDRhdcuQ7Ho0EIcsEu4yIvn4gnx
         XvEHJ7M5mUVV+2fX8E9x+V70GIf3uUMBB+gGwbSiRUuZ8OQj+k1HA9Y+MIbpnhgTonQi
         2q0buXs+WtL3CBVjdb2xQki38biLtUnTTcYSocA5sB4Tf6Zb1ZYZGZ4K/OyT5pHIPHah
         BamhPrxiant5wJtWu5MW4Api5g2ZX2YqhUfcEF+P7RA8LiLtQ7v1eYDgL+w2V3z9lacb
         7FMk7Leml2PMjp5L2nb9VXezvJo6pduQxYGJyZ4MRZjTeIrumWUKryOw2o7CCeCqxq/n
         O8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1my+Ly+FdtcosfHyIpZcPo3UptFe/yXHtTG6Hbw8BdE=;
        b=D8iihFxGmDuN6Biz/YaCrmjPARG8xyKjVzwfiWpu72WWWlrPY1rDJAhOG9g6P0NLLC
         C7ZLFWGbu4w2s9kGkQ+NYURZZTEX+TYmAnvwvTt05iiZW+Txztv7ziOwaiZLYNcDhX8l
         JDbO12kYcO4bmiRGCELxNwOHVffIC+uSK7WiyW3TAojJhYEAe1kehAtS9whofQSPi6ap
         XfGEcX66pfl9vajzau8hv9JuZEDM3bilJQKWaSXpFag+0EqxD+6kdmQiH6DVhEqVG4fe
         T+RHyIaPCh5J5kiRymhbCgrEXG4WT+axAtzTW6dwowzDq6Oq+7LZLIWxJAXItU5HQNNX
         hCkw==
X-Gm-Message-State: AFqh2kq3kCdc7c6iziV7y56YV3m1w9Liht7QMSAQ3QFAf20nddLLibii
        2HsfQXhLm1STkOGnmFi3B1sy
X-Google-Smtp-Source: AMrXdXs6EAjcPF4M6Wqty9znidm8MXEEZ9RAmNBdzqta3QiAE6LgLsqh0GjuM62Wz4s7H3LFJr0PsQ==
X-Received: by 2002:a17:902:e3d2:b0:192:fd1e:a96c with SMTP id r18-20020a170902e3d200b00192fd1ea96cmr11716712ple.26.1673680224198;
        Fri, 13 Jan 2023 23:10:24 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:10:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 02/12] phy: qcom-qmp-ufs: Rename MSM8996 PHY definitions
Date:   Sat, 14 Jan 2023 12:39:59 +0530
Message-Id: <20230114071009.88102-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
References: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only MSM8996 is using "_ufs_" naming convention for PHY definitions instead
of "_ufsphy_" as like other SoCs. So to maintain the uniformity, let's
rename all of the definitions to use "_ufsphy_".

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 30d098735040..5645637e7773 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -99,7 +99,7 @@ static const unsigned int ufsphy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] = {
+static const struct qmp_phy_init_tbl msm8996_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
@@ -148,12 +148,12 @@ static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_tx[] = {
+static const struct qmp_phy_init_tbl msm8996_ufsphy_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
 	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x02),
 };
 
-static const struct qmp_phy_init_tbl msm8996_ufs_rx[] = {
+static const struct qmp_phy_init_tbl msm8996_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x00),
@@ -634,15 +634,15 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
 	.rx2		= 0xa00,
 };
 
-static const struct qmp_phy_cfg msm8996_ufs_cfg = {
+static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.lanes			= 1,
 
-	.serdes_tbl		= msm8996_ufs_serdes,
-	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes),
-	.tx_tbl			= msm8996_ufs_tx,
-	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufs_tx),
-	.rx_tbl			= msm8996_ufs_rx,
-	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufs_rx),
+	.serdes_tbl		= msm8996_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_serdes),
+	.tx_tbl			= msm8996_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_tx),
+	.rx_tbl			= msm8996_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufsphy_rx),
 
 	.clk_list		= msm8996_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
@@ -1220,7 +1220,7 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 static const struct of_device_id qmp_ufs_of_match_table[] = {
 	{
 		.compatible = "qcom,msm8996-qmp-ufs-phy",
-		.data = &msm8996_ufs_cfg,
+		.data = &msm8996_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,msm8998-qmp-ufs-phy",
 		.data = &sdm845_ufsphy_cfg,
-- 
2.25.1

