Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6062BE48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiKPMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiKPMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:36:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A11CFCB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:36:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m22so43667598eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZI+ceW6VQ5zA1QC8NrptsEak6ZySgvdKWJKwF7NqZg=;
        b=nDNZSRSNb5qBOMRh6dn0wX0VL1+0G9f7KaAM2H65q2ZN3Cj+TEEbDocYgatvapSV3e
         BhuomuPvki95L2EA8SdARV4TGSJBGs+IPpmVDBP6WJUV2WvvESGRMKhl1DER9K4kkGrv
         K8N7lLvLQtTNvixAy9tVogjtlY0+nI/kQmJLGnwqs//VYPh9s6bT/IhMhr4Ou9QoR152
         8lQ40XKbar2Or2yBbajyQAA255luzDDrmN2s7WRu0gIwk+4EVyLpxz9bnlMAy1RtRD+h
         BnB11jdg8Ykxi3tO9AAE0Ovo/b5eLPK2lmm27hNYMWa+S6UbHwDF1mYm2Cbs8+fRQOcQ
         RogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZI+ceW6VQ5zA1QC8NrptsEak6ZySgvdKWJKwF7NqZg=;
        b=ZwgacsmVjRc0h2fhA/lk4vW/c6Hn/mSM6G57sOybADkgXDYHuwy4mIdp+NXxMj6Yrm
         5K5HLk7hVIPTmZ0IGwKnPSsNDk8noDjCw4x/iqte2J3404yUKNDx5Otx29nVownabFIM
         cKr/4Ib4YWPF77Zg+S+bQ0+2d/npqKTRB1pTwqHntp/Lmwmd5fNrf+OcoXhn4/T/05yp
         0qkmlfjrY+IMwBa9sqIH2tIoLpn1HJNpBt9JsxZAuZg6vV0g5sgB8AflDC2CxvD/KQ0V
         YeDTYBw0Kp4lDm5m4dSwM8qzEYMQwcP0tOYr+zoWl9uRXQGxc0XJBHOZqOVzWW6U0y7p
         fOaQ==
X-Gm-Message-State: ANoB5pmxjKEB6+d1zJY8vPreLEXSloB3ee2kdwqWmAw3KJcJn/ARMiC/
        k6Cc7hW8W0mvm/WSF58aIujj4A==
X-Google-Smtp-Source: AA0mqf7IZRxqxjtOUNLZcB8daGMUMt3UYb5W430IX4XZKYD7e47JaUXyuq69chdXPOqIvtdV9UUSvg==
X-Received: by 2002:a17:906:53d8:b0:7ad:cc9f:4ae0 with SMTP id p24-20020a17090653d800b007adcc9f4ae0mr16635994ejo.504.1668602185202;
        Wed, 16 Nov 2022 04:36:25 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm6773346ejb.86.2022.11.16.04.36.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Nov 2022 04:36:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8350-sagami: Add GPIO line names for TLMM
Date:   Wed, 16 Nov 2022 13:36:11 +0100
Message-Id: <20221116123612.34302-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221116123612.34302-1-konrad.dybcio@linaro.org>
References: <20221116123612.34302-1-konrad.dybcio@linaro.org>
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

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Sagami-common / PDX215 DTSIs to better document the
hardware.

Diff between 215 and common:
< 			  "NC",
< 			  "NC",
> 			  "WLC_I2C_SDA",
> 			  "WLC_I2C_SCL",
< 			  "NC",
> 			  "WLC_INT_N",
> 			  "CAM_MCLK4",
< 			  "NC",
< 			  "NC",
> 			  "TOF_RST_N",
< 			  "NC",
< 			  "NC",
< 			  "NC",
> 			  "QLINK1_REQ",
> 			  "QLINK1_EN",
> 			  "QLINK1_WMSS_RESET_N",

It's pretty logical as 1 III has WLC (WireLess Charging), and an
additional 3D iToF sensor. As for QLINK, no idea.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v2.

 .../qcom/sm8350-sony-xperia-sagami-pdx215.dts | 206 ++++++++++++++++++
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 203 +++++++++++++++++
 2 files changed, 409 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
index d21bbeb603a6..c74c973a69d2 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
@@ -11,3 +11,209 @@ / {
 	model = "Sony Xperia 1 III";
 	compatible = "sony,pdx215-generic", "qcom,sm8350";
 };
+
+&tlmm {
+	gpio-line-names = "APPS_I2C_0_SDA", /* GPIO_0 */
+			  "APPS_I2C_0_SCL",
+			  "UWIDEC_PWR_EN",
+			  "HAP_RST_N",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL",
+			  "PM8008_1_RESET_N",
+			  "WLC_INT_N",
+			  "OIS_TELE_I2C_SDA",
+			  "OIS_TELE_I2C_SCL",
+			  "PM8350_OPTION", /* GPIO_10 */
+			  "NC",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "NC",
+			  "CAM1_RESET_N",
+			  "LEO_CAM0_RESET_N",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "TS_I2C_SDA", /* GPIO_20 */
+			  "TS_I2C_SCL",
+			  "TS_RESET_N",
+			  "TS_INT_N",
+			  "DISP_RESET_N",
+			  "SW_SERVICE",
+			  "DISP_ERR_FG",
+			  "TX_GTR_THRES_IN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_30 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SPK_AMP_INT_N",
+			  "SPK_AMP_RESET_N",
+			  "FP_INT_N",
+			  "FP_RESET_N",
+			  "NC", /* GPIO_40 */
+			  "NC",
+			  "DEBUG_GPIO0",
+			  "FORCE_USB_BOOT",
+			  "FP_SPI_MISO",
+			  "FP_SPI_MOSI",
+			  "FP_SPI_CLK",
+			  "FP_SPI_CS_N",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC", /* GPIO_50 */
+			  "HAP_INT_N",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "SBU_SW_OE",
+			  "SBU_SW_SEL",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_CLK",
+			  "NFC_ESE_SPI_CS",
+			  "NFC_I2C_SDA", /* GPIO_60 */
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "HST_WLAN_EN",
+			  "HST_BT_EN",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX", /* GPIO_70 */
+			  "HST_BT_UART_RX",
+			  "HAP_I2C_SDA",
+			  "HAP_I2C_SCL",
+			  "RF_LCD_ID_EN",
+			  "RF_ID_EXTENSION",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HALL_INT_N", /* GPIO_80 */
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_SOF_TELE",
+			  "NFC_DWL_REQ",
+			  "NFC_IRQ",
+			  "WCD_RST_N",
+			  "ALS_PROX_INT_N",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "TRAY_DET",
+			  "UDON_SWITCH_SEL",
+			  "PCIE0_RESET_N",
+			  "PCIE0_CLK_REQ_N",
+			  "PCIE0_WAKE_N",
+			  "CAM_SOF",
+			  "RF_ID_EXTENSION_2",
+			  "RGBC_IR_INT",
+			  "CAM_MCLK0", /* GPIO_100 */
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "CAM_MCLK4",
+			  "NC",
+			  "CAM2_RESET_N",
+			  "CCI_I2C0_SDA",
+			  "CCI_I2C0_SCL",
+			  "CCI_I2C1_SDA",
+			  "CCI_I2C1_SCL", /* GPIO_110 */
+			  "CCI_I2C2_SDA",
+			  "CCI_I2C2_SCL",
+			  "CCI_I2C3_SDA",
+			  "CCI_I2C3_SCL",
+			  "NC",
+			  "PM8008_1_IRQ",
+			  "CAM3_RESET_N",
+			  "IMU1_INT",
+			  "EXT_VD0_XVS",
+			  "NC", /* GPIO_120 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HAP_I2S_CLK",
+			  "HAP_I2S_DOUT",
+			  "HAP_TRG1",
+			  "HAP_I2S_SYNC",
+			  "HST_BT_WLAN_SLIMBUS_CLK",
+			  "HST_BT_WLAN_SLIMBUS_DAT0", /* GPIO_130 */
+			  "NC",
+			  "UIM2_DETECT_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "TRAY_DET", /* GPIO_140 */
+			  "SM_RFFE0_CLK",
+			  "SM_RFFE0_DATA",
+			  "SM_RFFE1_CLK",
+			  "SM_RFFE1_DATA",
+			  "SM_MSS_GRFC4",
+			  "SM_MSS_GRFC5",
+			  "SM_MSS_GRFC6",
+			  "SM_MSS_GRFC7",
+			  "SM_RFFE4_CLK",
+			  "SM_RFFE4_DATA", /* GPIO_150 */
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "HST_SW_CTRL",
+			  "DISP_VDDR_EN",
+			  "NC",
+			  "NC",
+			  "PA_INDICATOR_OR",
+			  "TOF_RST_N",
+			  "QLINK0_REQ",
+			  "QLINK0_EN", /* GPIO_160 */
+			  "QLINK0_WMSS_RESET_N",
+			  "QLINK1_REQ",
+			  "QLINK1_EN",
+			  "QLINK1_WMSS_RESET_N",
+			  "PM8008_2_IRQ",
+			  "TELEC_PWR_EN",
+			  "PM8008_2_RESET_N",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1", /* GPIO_170 */
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+			  "SM_DMIC1_CLK",
+			  "SM_DMIC1_DATA",
+			  "SM_DMIC2_CLK",
+			  "SM_DMIC2_DATA",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN", /* GPIO_180 */
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "WCD_SWR_TX_DATA2",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "IMU_SPI_MISO",
+			  "IMU_SPI_MOSI",
+			  "IMU_SPI_CLK",
+			  "IMU_SPI_CS_N", /* GPIO_190 */
+			  "MAG_I2C_SDA",
+			  "MAG_I2C_SCL",
+			  "SENSOR_I2C_SDA",
+			  "SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_UART_TX",
+			  "HST_BLE_UART_RX", /* GPIO_200 */
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index dab5145358e7..a428ce31ab4e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -571,6 +571,209 @@ &spi14 {
 
 &tlmm {
 	gpio-reserved-ranges = <44 4>;
+	gpio-line-names = "APPS_I2C_0_SDA", /* GPIO_0 */
+			  "APPS_I2C_0_SCL",
+			  "UWIDEC_PWR_EN",
+			  "HAP_RST_N",
+			  "NC",
+			  "NC",
+			  "PM8008_1_RESET_N",
+			  "NC",
+			  "OIS_TELE_I2C_SDA",
+			  "OIS_TELE_I2C_SCL",
+			  "PM8350_OPTION", /* GPIO_10 */
+			  "NC",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "NC",
+			  "CAM1_RESET_N",
+			  "LEO_CAM0_RESET_N",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "TS_I2C_SDA", /* GPIO_20 */
+			  "TS_I2C_SCL",
+			  "TS_RESET_N",
+			  "TS_INT_N",
+			  "DISP_RESET_N",
+			  "SW_SERVICE",
+			  "DISP_ERR_FG",
+			  "TX_GTR_THRES_IN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_30 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SPK_AMP_INT_N",
+			  "SPK_AMP_RESET_N",
+			  "FP_INT_N",
+			  "FP_RESET_N",
+			  "NC", /* GPIO_40 */
+			  "NC",
+			  "DEBUG_GPIO0",
+			  "FORCE_USB_BOOT",
+			  "FP_SPI_MISO",
+			  "FP_SPI_MOSI",
+			  "FP_SPI_CLK",
+			  "FP_SPI_CS_N",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC", /* GPIO_50 */
+			  "HAP_INT_N",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "SBU_SW_OE",
+			  "SBU_SW_SEL",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_CLK",
+			  "NFC_ESE_SPI_CS",
+			  "NFC_I2C_SDA", /* GPIO_60 */
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "HST_WLAN_EN",
+			  "HST_BT_EN",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX", /* GPIO_70 */
+			  "HST_BT_UART_RX",
+			  "HAP_I2C_SDA",
+			  "HAP_I2C_SCL",
+			  "RF_LCD_ID_EN",
+			  "RF_ID_EXTENSION",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HALL_INT_N", /* GPIO_80 */
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_SOF_TELE",
+			  "NFC_DWL_REQ",
+			  "NFC_IRQ",
+			  "WCD_RST_N",
+			  "ALS_PROX_INT_N",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "TRAY_DET",
+			  "UDON_SWITCH_SEL",
+			  "PCIE0_RESET_N",
+			  "PCIE0_CLK_REQ_N",
+			  "PCIE0_WAKE_N",
+			  "CAM_SOF",
+			  "RF_ID_EXTENSION_2",
+			  "RGBC_IR_INT",
+			  "CAM_MCLK0", /* GPIO_100 */
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "NC",
+			  "NC",
+			  "CAM2_RESET_N",
+			  "CCI_I2C0_SDA",
+			  "CCI_I2C0_SCL",
+			  "CCI_I2C1_SDA",
+			  "CCI_I2C1_SCL", /* GPIO_110 */
+			  "CCI_I2C2_SDA",
+			  "CCI_I2C2_SCL",
+			  "CCI_I2C3_SDA",
+			  "CCI_I2C3_SCL",
+			  "NC",
+			  "PM8008_1_IRQ",
+			  "CAM3_RESET_N",
+			  "IMU1_INT",
+			  "EXT_VD0_XVS",
+			  "NC", /* GPIO_120 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HAP_I2S_CLK",
+			  "HAP_I2S_DOUT",
+			  "HAP_TRG1",
+			  "HAP_I2S_SYNC",
+			  "HST_BT_WLAN_SLIMBUS_CLK",
+			  "HST_BT_WLAN_SLIMBUS_DAT0", /* GPIO_130 */
+			  "NC",
+			  "UIM2_DETECT_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "TRAY_DET", /* GPIO_140 */
+			  "SM_RFFE0_CLK",
+			  "SM_RFFE0_DATA",
+			  "SM_RFFE1_CLK",
+			  "SM_RFFE1_DATA",
+			  "SM_MSS_GRFC4",
+			  "SM_MSS_GRFC5",
+			  "SM_MSS_GRFC6",
+			  "SM_MSS_GRFC7",
+			  "SM_RFFE4_CLK",
+			  "SM_RFFE4_DATA", /* GPIO_150 */
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "HST_SW_CTRL",
+			  "DISP_VDDR_EN",
+			  "NC",
+			  "NC",
+			  "PA_INDICATOR_OR",
+			  "NC",
+			  "QLINK0_REQ",
+			  "QLINK0_EN", /* GPIO_160 */
+			  "QLINK0_WMSS_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "PM8008_2_IRQ",
+			  "TELEC_PWR_EN",
+			  "PM8008_2_RESET_N",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1", /* GPIO_170 */
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+			  "SM_DMIC1_CLK",
+			  "SM_DMIC1_DATA",
+			  "SM_DMIC2_CLK",
+			  "SM_DMIC2_DATA",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN", /* GPIO_180 */
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "WCD_SWR_TX_DATA2",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "IMU_SPI_MISO",
+			  "IMU_SPI_MOSI",
+			  "IMU_SPI_CLK",
+			  "IMU_SPI_CS_N", /* GPIO_190 */
+			  "MAG_I2C_SDA",
+			  "MAG_I2C_SCL",
+			  "SENSOR_I2C_SDA",
+			  "SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_UART_TX",
+			  "HST_BLE_UART_RX", /* GPIO_200 */
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
 
 	ts_int_default: ts-int-default-state {
 		pins = "gpio23";
-- 
2.38.1

