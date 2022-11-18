Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5571C62F92D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiKRPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbiKRPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:20:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE752B26D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:20:37 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d6so8690281lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb/6Z6Nz1gnb2z7GznvPxvyQcocsubtScHtnufLzpH8=;
        b=IHUJ4ViWC3qk37qn4GHyU/n75i6gHrjzDdr27nQHRmtg8yU0ept4ffxn0ShutbkedG
         X74NoeRHZy6eQCVmdZaI9ExK+lFrtN/K1DRB6pTQkNJpdBsxFhlmNduBJJsIFf2OfBMF
         qOEhH7Yi6iO+kU7ynIF8gxPqfgblX95IgJsb8RhfhkeHvZDiCwN7Jy/GuAzZ6PDiC1Td
         do5gR14EgDv7tcxzIEMAnAp/sXFuAZAAUKIYkvvXP8Uo/juNRUD1WhsZPNmPyGh/P14p
         90GvG4by3mFnrwHesXMPMtNyuxSkX4h+y/fH+P/q/K5SA13yLtUa3iCJV2gzvxFUPHAJ
         hEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb/6Z6Nz1gnb2z7GznvPxvyQcocsubtScHtnufLzpH8=;
        b=LSoObcWZG3Mah9AiPt+R/gJgjYbA2VUUcI4wTWT8mjVFZRTj/PErFP0xV//WNGyPgb
         ibXPB9LxKjTqvo+HLkpNaxywmENwM4gInO9sT3ZUES+wqnHSC6j3UZU/PPUOBJTV4/iV
         TYZAM7GZoNBArKZgJOgbbkiJtTEPyReTEjo8lscdKSoooy+7YIYj2tOxi3oNoMUInFuL
         1CFfa++IyDR60fk41pJSWzRtEmPntd6ZURELiLu4lFmY1YQ1dqBnXKIexLChPzmxp3ho
         y2wwGAsI8jmuzSa/+TcKQkci582RE0qeqxjb3KjU5OnP3Dw3Erh1RrOnLtKliqppZzqD
         jWtg==
X-Gm-Message-State: ANoB5pm9Zn8mXXb2/NuK4Ce6MBadQSDX+dlBqvHpT3EcG7463gJfe1tY
        Z3iTh5FBSS2atUaQZ5DNJT8JRQ==
X-Google-Smtp-Source: AA0mqf4OcdskkBwdfhW7fzDIEeecphOYfbsANRyvspW90OYHyg0Y408+8wUWBURzNqtp+MYhtMy7xQ==
X-Received: by 2002:ac2:5de7:0:b0:4af:f58e:a7a0 with SMTP id z7-20020ac25de7000000b004aff58ea7a0mr2457830lfq.507.1668784835927;
        Fri, 18 Nov 2022 07:20:35 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 12-20020ac25f0c000000b004948ddb4e4dsm690597lfq.301.2022.11.18.07.20.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Nov 2022 07:20:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8350-sagami: Add GPIO line names for PMIC GPIOs
Date:   Fri, 18 Nov 2022 16:20:28 +0100
Message-Id: <20221118152028.59312-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221118152028.59312-1-konrad.dybcio@linaro.org>
References: <20221118152028.59312-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX213&214 DTSIs to better document the hardware.

Diff between 223 and 224:

pm8350b
< 	gpio-line-names = "NC", /* GPIO_1 */
> 	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
< 			  "NC",
> 			  "CAM_PWR_LD_EN",

pm8350c
< 			  "NC",
> 			  "WLC_TXPWR_EN",

Which is due to different camera power wiring on 213 and lack of an
additional SLG51000 PMIC on 214.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm8350-sony-xperia-sagami-pdx214.dts | 23 +++++++++++++++++++
 .../qcom/sm8350-sony-xperia-sagami-pdx215.dts | 21 +++++++++++++++++
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 20 ++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
index cc650508dc2d..e6824c8c2774 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
@@ -17,3 +17,26 @@ &framebuffer {
 	height = <2520>;
 	stride = <(1080 * 4)>;
 };
+
+&pm8350b_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
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
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_PWR_EN",
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
index d4afaa393c9a..c6f402c3ef35 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dts
@@ -68,6 +68,15 @@ slg51000_a_ldo7: ldo7 {
 };
 
 &pm8350b_gpios {
+	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SNAPSHOT_N",
+			  "CAM_PWR_LD_EN",
+			  "NC",
+			  "FOCUS_N";
+
 	cam_pwr_a_cs: cam-pwr-a-cs-state {
 		pins = "gpio1";
 		function = "normal";
@@ -78,6 +87,18 @@ cam_pwr_a_cs: cam-pwr-a-cs-state {
 	};
 };
 
+&pm8350c_gpios {
+	gpio-line-names = "FL_STROBE_TRIG_WIDE", /* GPIO_1 */
+			  "FL_STROBE_TRIG_TELE",
+			  "NC",
+			  "WLC_TXPWR_EN",
+			  "NC",
+			  "RGBC_IR_PWR_EN",
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
+
 &tlmm {
 	gpio-line-names = "APPS_I2C_0_SDA", /* GPIO_0 */
 			  "APPS_I2C_0_SCL",
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 8f32b2799bcb..d73e1f3fa501 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -534,6 +534,26 @@ &mpss {
 	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
 };
 
+&pm8350_gpios {
+	gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
+			  "LCD_ID",
+			  "SDR_MMW_THERM",
+			  "RF_ID",
+			  "NC",
+			  "FP_LDO_EN",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "G_ASSIST_N",
+			  "PM8350_OPTION"; /* GPIO_10 */
+};
+
+&pmk8350_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "VOL_DOWN_N",
+			  "PMK8350_OPTION";
+};
+
 &pmk8350_rtc {
 	status = "okay";
 };
-- 
2.38.1

