Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C286D2904
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjCaT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCaT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:59:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670FAF11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so23562552wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680292774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fthu4cbJuS/uLvSEiZqvZyqG03DhDKwpcohAdcCNaA=;
        b=VU2WVN1vgP+NTNn1Uvx7/DpTd9Tv1Vtg0p0PKnY5rhSAh10/mvrkj+fGH4oumch1/A
         rH3cteopkCW/wmEh/b65lAT4JXkClniFRAJgANUuZi0ZQ6rskDIhIZ388jpUdWBjRWBR
         aSR6JiBeZ7t6MqzhszMcCDpwCnmAVsnuS5ryo8VoZHTUTzdlPf1iWChCMpJYsteYiHZ6
         449Y2AqE3juVWa3+AQkSC1DIa8gqS5wwRKqtmehtl8eBxC3ZTwlrVylEWzD4eFII5s/g
         lIKDgVnaptr+YnVRkWjFHLu3h4f9T9gZpnOnBR2IFz5tj90sX3eXsHSTVO6oXwwU/HKE
         KlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fthu4cbJuS/uLvSEiZqvZyqG03DhDKwpcohAdcCNaA=;
        b=atVe4mkIamFgpAM/DspYabuWUhCCPzyNSTuxuPz6dLQSJXoLHT/q3DJexRclhmFMSB
         SQsVTnCqLNWp4DSNoXJunip/d9sGhiCuN/rkeakAoScEXFuGkKe0mK7NudR3mHLsbQjj
         gZl5k3wDtzhfHdZwG9LKf6nNhxdtiUChyk+sYu5WbLN7vRugLxEXo+b1ybKf2qhLdg95
         NO+tV5dCSs9nhAcDMOCsMzYzNZq/LSvZdg1QhiEUYlKRncICdVs2dePLvYtmBkJ7/XGa
         4DrU/o/Kxlar+FnuI7ERtYmUa/94zh7+gn0DYtr1KHVr32/RPPnajz7/0ts1SaI3KDw6
         DcRQ==
X-Gm-Message-State: AAQBX9fm0d3EpjAoS2aOqsoAh04d3imNTAyVWBRGMb0YDQDB5ChE4VUx
        r0dLYL1mBMwgKd0EXB9X2Hr2dg==
X-Google-Smtp-Source: AKy350Z1eZ5ZixhhVDDntJzKXIeve9ucwu9HarPzgmutM/g3sBvxQjGBB7Y1K0y5n3xN/BVZayoAAg==
X-Received: by 2002:a05:6000:1044:b0:2e4:c9ac:c49c with SMTP id c4-20020a056000104400b002e4c9acc49cmr5485342wrx.26.1680292774097;
        Fri, 31 Mar 2023 12:59:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1dc:d1f:e44f:2a1d])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b002cff0e213ddsm2990286wrt.14.2023.03.31.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:59:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/5] phy: qualcomm: phy-qcom-qmp-ufs: add definitions for sa8775p
Date:   Fri, 31 Mar 2023 21:59:18 +0200
Message-Id: <20230331195920.582620-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230331195920.582620-1-brgl@bgdev.pl>
References: <20230331195920.582620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add QMP PHY config for sa8775p and add support for the new compatible.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 994ddd5d4a81..126bd47c3fa0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -823,6 +823,41 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.no_pcs_sw_reset	= true,
 };
 
+
+static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8350_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8350_ufsphy_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
+		.rx		= sm8350_ufsphy_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
+		.pcs		= sm8350_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
+	},
+	.clk_list		= sm8450_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= ufsphy_v5_regs_layout,
+};
+
 static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1542,6 +1577,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,msm8998-qmp-ufs-phy",
 		.data = &sdm845_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sa8775p-qmp-ufs-phy",
+		.data = &sa8775p_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
-- 
2.37.2

