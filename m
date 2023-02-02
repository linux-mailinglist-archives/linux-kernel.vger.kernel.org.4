Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59F687EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjBBNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBBNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:25:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF88F274
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:25:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3715964wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuSrh/aHOSE5N204zdrXun9rXbJUm4pY9kguGFMi0kc=;
        b=yy90TcgeT3mhGmCRfkVKt8tqKf3ktDl3EmwPoA87gp79LykqWwxmw9pZmy9Bw1PFyT
         58+JAJfYkvwN4G6WWu2LSrG3iWXV1dIrkBnSfx0nh+A2XtC3giocFEF4iAdD7blWe+Hu
         oAw//rUnS+CvVQaOKTp4EM8h3iLvhM6LISEJDX6cynQV+df+FDW4PkDaahs3xptlU3Cx
         cBSjr6Ei7tE/OHWjEWHWfmNzxbnq4F3Ks8YKoHbyJHqnzh5W9NfxSocrDKzlD++fYid0
         M6EGi6JBoQpUcP7fizWPQhtHB/P93ASefnhd/T+zhp6jGYy+Asns1+MZxNfSyAeK0VxC
         hDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuSrh/aHOSE5N204zdrXun9rXbJUm4pY9kguGFMi0kc=;
        b=lROxqXREsAHDPZHPfuga8bifblc7RH7Aj5KSju1KIO1GE3/wVN1hmMj8fLGvuBMylf
         TxLcSqsGkPHuv4u9sVnVRUWlO7ZIvWGERQmMazGnXIUFt4n3lcGvZgHcaAnpKjEvY/gy
         B2Va/rQxz1FhYIgj5aVNV1JHUOZcw2ZLDdo5pj1KQ2nhRzMeBODAd3hyJt1pMF8QXmSV
         +aRSbfR3qfh9B3HYFale7c9KUF6NOuBA+/hi/y7IKaU8pv9GYHT9DNJVSzO/PoAgOfBs
         ffCiOSJxjS6hxBaKXJaJj0uWBYUhKOGNB2IUseOo49bApvcQrlyUgrOqCTxXBJW9Zxqu
         iWaA==
X-Gm-Message-State: AO0yUKUT3wQ+5kFJTfyKMuw7k7CNK8vmU8OIoYeVfDfdsOFBVV0/6GaU
        03RZqfph45zs2ISzgR+b5yX25A==
X-Google-Smtp-Source: AK7set8QMVWQ4U5FU8+F4i5jUjMRtq/bTrtFeNmWqAHKQmb1to7WpUsR/5jVurQrMxqo8uAQ0P4NFA==
X-Received: by 2002:a05:600c:3d8d:b0:3df:9858:c035 with SMTP id bi13-20020a05600c3d8d00b003df9858c035mr1774715wmb.10.1675344322061;
        Thu, 02 Feb 2023 05:25:22 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c449600b003db06224953sm4690943wmo.41.2023.02.02.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:25:21 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/8] phy: qcom-qmp-combo: Add support for SM8550
Date:   Thu,  2 Feb 2023 15:25:09 +0200
Message-Id: <20230202132511.3983095-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202132511.3983095-1-abel.vesa@linaro.org>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8550 specific register layout and table configs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v3 version of this patch was here:
https://lore.kernel.org/all/20230126131415.1453741-7-abel.vesa@linaro.org/

Changes since v3:
 * switched dp_tx and dp_tx2 to off->dp_tx0 and off->dp_tx1, like Neil
   suggested

Changes since v2:
 * none

Changes since v1:
 * switched from qmp-usb to qmp-combo as it will support DP also
 * changed all hex offset values to lowercase, like Vinod suggested

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 409 +++++++++++++++++++++-
 1 file changed, 404 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 86032dc4e24e..36c799fff416 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -493,6 +493,145 @@ static const struct qmp_phy_init_tbl sm8250_usb3_pcs_usb_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
 };
 
+static const struct qmp_phy_init_tbl sm8550_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MSB_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MSB_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8550_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_RX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_5, 0x5f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_TX_PI_QEC_CTRL, 0x21, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_TX_PI_QEC_CTRL, 0x05, 2),
+};
+
+static const struct qmp_phy_init_tbl sm8550_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VTH_CODE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_CTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
+
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3f, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xff, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xdf, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xed, 1),
+
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_LOW, 0xbf, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xbf, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xdf, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xfd, 2),
+};
+
+static const struct qmp_phy_init_tbl sm8550_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RX_SIGDET_LVL, 0x99),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
+};
+
+static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
+};
+
 static const struct qmp_phy_init_tbl qmp_v4_dp_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SVS_MODE_CLK_SEL, 0x05),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x3b),
@@ -614,6 +753,91 @@ static const struct qmp_phy_init_tbl qmp_v5_5nm_dp_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_TX_BAND, 0x01),
 };
 
+static const struct qmp_phy_init_tbl qmp_v6_dp_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SVS_MODE_CLK_SEL, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl qmp_v6_dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_VMODE_CTRL1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_PRE_STALL_LDO_BOOST_EN, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_INTERFACE_SELECT, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_CLKBUF_ENABLE, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RESET_TSYNC_EN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_TRAN_DRVR_EMP_EN, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_PARRATE_REC_DETECT_IDLE_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_TX_INTERFACE_MODE, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_TX_BAND, 0x4),
+};
+
+static const struct qmp_phy_init_tbl qmp_v6_dp_serdes_tbl_rbr[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl qmp_v6_dp_serdes_tbl_hbr[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl qmp_v6_dp_serdes_tbl_hbr2[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x97),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x10),
+};
+
+static const struct qmp_phy_init_tbl qmp_v6_dp_serdes_tbl_hbr3[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0c),
+};
+
 static const struct qmp_phy_init_tbl sc8280xp_usb43dp_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
@@ -795,6 +1019,13 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x3f, 0xff, 0xff, 0xff }
 };
 
+static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
+	{ 0x20, 0x2d, 0x34, 0x3a },
+	{ 0x20, 0x2e, 0x35, 0xff },
+	{ 0x20, 0x2e, 0xff, 0xff },
+	{ 0x22, 0xff, 0xff, 0xff }
+};
+
 struct qmp_combo;
 
 struct qmp_combo_offsets {
@@ -808,6 +1039,8 @@ struct qmp_combo_offsets {
 	u16 usb3_pcs;
 	u16 usb3_pcs_usb;
 	u16 dp_serdes;
+	u16 dp_tx0;
+	u16 dp_tx1;
 	u16 dp_dp_phy;
 };
 
@@ -927,6 +1160,9 @@ static int qmp_v4_calibrate_dp_phy(struct qmp_combo *qmp);
 
 static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp);
 
+static void qmp_v6_dp_aux_init(struct qmp_combo *qmp);
+static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp);
+
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -985,9 +1221,27 @@ static const struct qmp_combo_offsets qmp_combo_offsets_v5 = {
 	.usb3_pcs	= 0x1400,
 	.usb3_pcs_usb	= 0x1700,
 	.dp_serdes	= 0x2000,
+	.dp_tx0		= 0x2200,
+	.dp_tx1		= 0x2600,
 	.dp_dp_phy	= 0x2200,
 };
 
+static const struct qmp_combo_offsets qmp_combo_offsets_v6 = {
+	.com		= 0x0000,
+	.txa		= 0x1200,
+	.rxa		= 0x1400,
+	.txb		= 0x1600,
+	.rxb		= 0x1800,
+	.usb3_serdes	= 0x1000,
+	.usb3_pcs_misc	= 0x1a00,
+	.usb3_pcs	= 0x1c00,
+	.usb3_pcs_usb	= 0x1f00,
+	.dp_serdes	= 0x2000,
+	.dp_tx0		= 0x2200,
+	.dp_tx1		= 0x2600,
+	.dp_dp_phy	= 0x2a00,
+};
+
 static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
@@ -1219,6 +1473,54 @@ static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
 	.has_pwrdn_delay	= true,
 };
 
+static const struct qmp_phy_cfg sm8550_usb3dpphy_cfg = {
+	.offsets		= &qmp_combo_offsets_v6,
+
+	.serdes_tbl		= sm8550_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8550_usb3_serdes_tbl),
+	.tx_tbl			= sm8550_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8550_usb3_tx_tbl),
+	.rx_tbl			= sm8550_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8550_usb3_rx_tbl),
+	.pcs_tbl		= sm8550_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8550_usb3_pcs_tbl),
+	.pcs_usb_tbl		= sm8550_usb3_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8550_usb3_pcs_usb_tbl),
+
+	.dp_serdes_tbl		= qmp_v6_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v6_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v6_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v6_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v6_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v6_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v6_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr3),
+
+	.swing_hbr_rbr		= &qmp_dp_v5_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v6_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
+
+	.dp_aux_init		= qmp_v6_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v6_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
+
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.pcs_usb_offset		= 0x300,
+};
+
 static void qmp_combo_configure_lane(void __iomem *base,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -1529,6 +1831,33 @@ static void qmp_v4_dp_aux_init(struct qmp_combo *qmp)
 	       qmp->dp_dp_phy + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
+static void qmp_v6_dp_aux_init(struct qmp_combo *qmp)
+{
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+
+	/* Turn on BIAS current for PHY/PLL */
+	writel(0x17, qmp->dp_serdes + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
+
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0xa4, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xb7, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
+	qmp->dp_aux_cfg = 0;
+
+	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
+	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
+	       PHY_AUX_REQ_ERR_MASK,
+	       qmp->dp_dp_phy + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
+}
+
 static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 {
 	/* Program default values before writing proper values */
@@ -1542,7 +1871,10 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
 }
 
-static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
+static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
+				     unsigned int com_resetm_ctrl_reg,
+				     unsigned int com_c_ready_status_reg,
+				     unsigned int dp_phy_status_reg)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div, status;
@@ -1639,7 +1971,9 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 	u32 status;
 	int ret;
 
-	ret = qmp_v45_configure_dp_phy(qmp);
+	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
+					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
 
@@ -1701,7 +2035,9 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 	u32 status;
 	int ret;
 
-	ret = qmp_v45_configure_dp_phy(qmp);
+	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
+					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
 
@@ -1750,6 +2086,65 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 	return 0;
 }
 
+static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
+	bool reverse = false;
+	u32 status;
+	int ret;
+
+	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V6_COM_RESETSM_CNTRL,
+					QSERDES_V6_COM_C_READY_STATUS,
+					QSERDES_V6_DP_PHY_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (dp_opts->lanes == 1) {
+		bias0_en = reverse ? 0x3e : 0x1a;
+		drvr0_en = reverse ? 0x13 : 0x10;
+		bias1_en = reverse ? 0x15 : 0x3e;
+		drvr1_en = reverse ? 0x10 : 0x13;
+	} else if (dp_opts->lanes == 2) {
+		bias0_en = reverse ? 0x3f : 0x15;
+		drvr0_en = 0x10;
+		bias1_en = reverse ? 0x15 : 0x3f;
+		drvr1_en = 0x10;
+	} else {
+		bias0_en = 0x3f;
+		bias1_en = 0x3f;
+		drvr0_en = 0x10;
+		drvr1_en = 0x10;
+	}
+
+	writel(drvr0_en, qmp->dp_tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qmp->dp_tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qmp->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
+
+	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	udelay(2000);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V6_DP_PHY_STATUS,
+			       status,
+			       ((status & BIT(1)) > 0),
+			       500,
+			       10000))
+		return -ETIMEDOUT;
+
+	writel(0x0a, qmp->dp_tx + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qmp->dp_tx2 + QSERDES_V4_TX_TX_POL_INV);
+
+	writel(0x27, qmp->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x27, qmp->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+
+	writel(0x20, qmp->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qmp->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
 /*
  * We need to calibrate the aux setting here as many times
  * as the caller tries
@@ -2640,8 +3035,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 	qmp->pcs_usb = base + offs->usb3_pcs_usb;
 
 	qmp->dp_serdes = base + offs->dp_serdes;
-	qmp->dp_tx = base + offs->txa;
-	qmp->dp_tx2 = base + offs->txb;
+	qmp->dp_tx = base + offs->dp_tx0;
+	qmp->dp_tx2 = base + offs->dp_tx1;
 	qmp->dp_dp_phy = base + offs->dp_dp_phy;
 
 	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
@@ -2792,6 +3187,10 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
 		.data = &sm8250_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sm8550-qmp-usb3-dp-phy",
+		.data = &sm8550_usb3dpphy_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);
-- 
2.34.1

