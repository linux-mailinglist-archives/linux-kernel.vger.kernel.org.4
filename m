Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BB658BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiL2Kcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiL2KcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:32:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F79FE3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f34so26938906lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIHLGg2xFvRaIIRDrENEcScT78jL8etGRuVIB/vkvhQ=;
        b=V1/oX4zaRlj7HBFDxkLNtTX8zWbk5wm3CEkbkfIUDm+KiIhvZSWCbzMnDrwmpCQQ17
         5czt8e3ez+/uiqiiLbabYmI34ugB2GSmG0yAlZc0rtUYlKAnmndMl8TO3t8CSmw2jUfp
         0X9nMBeZr1BMS14w0P90u9vBimRY/paVV0FBigy4cnkYj2Xi0J1wlPuJWqoIlXZFTnhH
         7+Q1wP6WvikVO8reBQu/wUGkvaFlq630vdl6eKjQfZlElGVQMM6ORFOcaUw/qmkFQkTW
         7T7b0b9gWQomQF03Lrg/B3SU6NeKxHHrJWs9iml+MJfjKrJVThNUKKuAqf/J2SpqjoCb
         8uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIHLGg2xFvRaIIRDrENEcScT78jL8etGRuVIB/vkvhQ=;
        b=sGgVkNNjLPkadmIEqICv+hvm5/IlcdWV/DfaxDglkKHunWDrELoizzkjXgYg5yjux8
         YcQFwlaoTQxnFQQsip47QvzUeHR/w/rdWfCZriBS/Eopq6H7BYyQ1oFQIrQ330dDuNJt
         xjcVsZS5k/Cg7l9DRbl11WHiHJtg8SZnZz17qFX80/m+ZPYZWnju2j8+hs/Jt5KPbRKm
         fMBqRGw3eZqBQ3Y3H5mSRc5xHcGSWyhd8buchNqADvCnao7P1Hknx1Ucgsm9DbyGab1j
         5YJ0gjihTyyqOdOAvs40xFWpUJ+BVwKJRVwSCfpr6ithHuhFg3Lo45impCgRJq7rALeP
         G1jQ==
X-Gm-Message-State: AFqh2kpvyGZAITGNmRn7BBRkVbTbrVJZxz0n5I4ru2ez9VFaXgi8/hs1
        HriGlzI0xWrehXy3XxRJmo9KDw==
X-Google-Smtp-Source: AMrXdXttHeHRrSKBoaS2EjIRxwtXauHV+MDc7bxFUyp4cDIHI9pVLxbmhhZ08L554AEpHEtT+d+Vdw==
X-Received: by 2002:ac2:51b6:0:b0:4b6:ed8b:4f16 with SMTP id f22-20020ac251b6000000b004b6ed8b4f16mr7414470lfk.52.1672309938958;
        Thu, 29 Dec 2022 02:32:18 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b004a478c2f4desm2993526lfg.163.2022.12.29.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:32:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] arm64: dts: qcom: sm8450-nagara: Add GPIO line names for PMIC GPIOs
Date:   Thu, 29 Dec 2022 11:32:08 +0100
Message-Id: <20221229103212.984324-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229103212.984324-1-konrad.dybcio@linaro.org>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
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

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX223&224 DTSIs to better document the hardware.

Diff between 223 and 224:
pm8350b
< 			  "CAM_PWR_LD_EN",
> 			  "NC",

pm8350c
<			  "RGBC_IR_PWR_EN",
> 			  "NC",

Which is due to different camera power wiring on 223 and lack of a
ToF sensor on 224.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 23 ++++++++++++++++
 .../qcom/sm8450-sony-xperia-nagara-pdx224.dts | 23 ++++++++++++++++
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 27 +++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index b83500316a81..561cd4f09ab7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -13,6 +13,29 @@ / {
 	compatible = "sony,pdx223", "qcom,sm8450";
 };
 
+&pm8350b_gpios {
+	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SNAPSHOT_N",
+			  "CAM_PWR_LD_EN",
+			  "NC",
+			  "FOCUS_N";
+};
+
+&pm8350c_gpios {
+	gpio-line-names = "FL_STROBE_TRIG_WIDE", /* GPIO_1 */
+			  "FL_STROBE_TRIG_TELE",
+			  "WLC_ID",
+			  "WLC_TXPWR_EN",
+			  "NC",
+			  "RGBC_IR_PWR_EN",
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
+
 &tlmm {
 	gpio-line-names = "NC", /* GPIO_0 */
 			  "NC",
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
index 13c2fc4bccfc..fc9d74d0f227 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
@@ -20,6 +20,29 @@ imx563_vdig_vreg: imx563-vdig-regulator {
 	};
 };
 
+&pm8350b_gpios {
+	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SNAPSHOT_N",
+			  "NC",
+			  "NC",
+			  "FOCUS_N";
+};
+
+&pm8350c_gpios {
+	gpio-line-names = "FL_STROBE_TRIG_WIDE", /* GPIO_1 */
+			  "FL_STROBE_TRIG_TELE",
+			  "WLC_ID",
+			  "WLC_TXPWR_EN",
+			  "NC",
+			  "NC", /* RGBCIR uses a PMIC vreg, so it's most likely NC. */
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
+
 &tlmm {
 	gpio-line-names = "TELE_SPI_MISO", /* GPIO_0 */
 			  "TELE_SPI_MOSI", /* SONY says NC, but it only makes sense this way.. */
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index e29fb7adc780..8e128efcb128 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -551,6 +551,33 @@ &pcie0_phy {
 	status = "okay";
 };
 
+&pm8350_gpios {
+	gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
+			  "LCD_ID",
+			  "SDR_MMW_THERM",
+			  "RF_ID",
+			  "NC",
+			  "VOL_DOWN_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "PM8350_OPTION"; /* GPIO_10 */
+};
+
+&pm8450_gpios {
+	gpio-line-names = "FP_LDO_EN", /* GPIO_1 */
+			  "",
+			  "",
+			  "";
+};
+
+&pmk8350_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "DISP_THERM",
+			  "PMK8350_OPTION";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
 	status = "okay";
-- 
2.39.0

