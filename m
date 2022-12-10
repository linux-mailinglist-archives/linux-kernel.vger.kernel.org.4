Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E6648F80
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLJPga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLJPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:36:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071901A21D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:36:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id x22so18045392ejs.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdfh0K5pQc5eYfucsnL5ACF2m5gK2MnXNNuw4hKO/+M=;
        b=NGhzzGwEOX5S7B4TeZbxukX50t2dcEDsu98zuTqsYTuYzyZ599lljIkI3WM6MvNA3K
         hCjr9znXK3BZReG2TJmLxG4OB+06AQIf3AJZDmWZ3CHZNLDLIE3yr1PcLPlvO8m2ygWW
         cBaF1yT+R1ia5cT2EnSG1D5F02otev5Ott5ghl+wRlIwj7H9pNMDz84sS1cJVqChuGXQ
         jKUTGphaa0bD2ockGwW9jwBRGTT9Xo0qLWYZaffNE8XvE1bf7wMsfsFLnhVz84eaCGoY
         scjyTRrkIywkJNGuVWCWsgoPHZjwOxCWWWDsUuJwk+Hjq6602f9Jr1pH2NUuNIEniuS9
         UhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gdfh0K5pQc5eYfucsnL5ACF2m5gK2MnXNNuw4hKO/+M=;
        b=F8Jzg8X22zwxHMpywxUdhH7SDenfqdGTK55QFuJIPU3szYeLjyaOqw+Ce9AbXA7Hiw
         k5vJ325ofhK7pncR70Ryff0uogAqWuNRyLxiKpaXFGjK7giwT+oNzW0hdcP791OpMH7k
         wQWhuZHjd8PDTeAxEOcOGaHMJl+GKUbenw3ZxYmZt0A9GwJXa5NJXNW8fUcP1H4yBAQY
         eQuXIG9zEP7PGkWs3aPrdROwmw4PkdYd7BOm/48dEWfh7XHFaYUJSjNWnUy/XFpAlIJz
         Z2/H9Wm76CeTxBfjkI35NcZ0S5SsWwwGawfbLvPPB3fBRG7gIZFULmfJLgCbqKVoQuua
         c44Q==
X-Gm-Message-State: ANoB5plqInR/jaRWVHk5X33/UHx/ECWU8AMvkrkBXbMtBvpeoYo0Vm0a
        VtFU5XRvN3A+n8ISjfQi2puwFcgFY33S6O8F
X-Google-Smtp-Source: AA0mqf5viKBsPqGxdaGh8HrMk7K9dL/2SPOWimdfKUCYTDO0+XEgz2WfLtFeI4l+hev5dF3Zmm72Xg==
X-Received: by 2002:a05:6512:2c85:b0:4a4:68b8:f4d9 with SMTP id dw5-20020a0565122c8500b004a468b8f4d9mr2907512lfb.31.1670681406060;
        Sat, 10 Dec 2022 06:10:06 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id bf38-20020a05651225a600b004b5901b8011sm734857lfb.105.2022.12.10.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 06:10:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8996-tone: Move status last
Date:   Sat, 10 Dec 2022 15:10:00 +0100
Message-Id: <20221210141000.14344-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210141000.14344-1-konrad.dybcio@linaro.org>
References: <20221210141000.14344-1-konrad.dybcio@linaro.org>
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

Align the style with other boards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index c9be32b81d36..40b28489d3f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -100,8 +100,8 @@ wlan_en: wlan-en-1-8v {
 };
 
 &blsp1_i2c3 {
-	status = "okay";
 	clock-frequency = <355000>;
+	status = "okay";
 
 	tof_sensor: vl53l0x@29 {
 		compatible = "st,vl53l0x";
@@ -114,15 +114,15 @@ &blsp1_uart2 {
 };
 
 &blsp2_i2c5 {
-	status = "okay";
 	clock-frequency = <355000>;
+	status = "okay";
 
 	/* FUSB301 USB-C controller */
 };
 
 &blsp2_i2c6 {
-	status = "okay";
 	clock-frequency = <355000>;
+	status = "okay";
 
 	synaptics@2c {
 		compatible = "syna,rmi4-i2c";
@@ -179,11 +179,10 @@ &camera2_rst {
 };
 
 &hsusb_phy1 {
-	status = "okay";
-
 	vdd-supply = <&pm8994_l28>;
 	vdda-pll-supply = <&pm8994_l12>;
 	vdda-phy-dpdm-supply = <&pm8994_l24>;
+	status = "okay";
 };
 
 &mmcc {
@@ -191,18 +190,17 @@ &mmcc {
 };
 
 &pcie0 {
-	status = "okay";
 	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 	vddpe-3v3-supply = <&wlan_en>;
 	vdda-supply = <&pm8994_l28>;
+	status = "okay";
 };
 
 &pcie_phy {
-	status = "okay";
-
 	vdda-phy-supply = <&pm8994_l28>;
 	vdda-pll-supply = <&pm8994_l12>;
+	status = "okay";
 };
 
 &pm8994_gpios {
@@ -474,8 +472,8 @@ rf-id-mpp-pins {
 };
 
 &pm8994_resin {
-	status = "okay";
 	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
 };
 
 &pmi8994_gpios {
@@ -619,9 +617,9 @@ pmi8994_s2: s2 {
 };
 
 &pmi8994_wled {
-	status = "okay";
 	default-brightness = <512>;
 	qcom,num-strings = <3>;
+	status = "okay";
 };
 
 &rpm_requests {
@@ -821,20 +819,18 @@ pm8994_l32: l32 {
 };
 
 &sdhc1 {
-	status = "okay";
-
 	vmmc-supply = <&pm8994_l20>;
 	vqmmc-supply = <&pm8994_s4>;
 	mmc-hs400-1_8v;
 	mmc-hs200-1_8v;
+	status = "okay";
 };
 
 &sdhc2 {
-	status = "okay";
-
 	cd-gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&pm8994_l21>;
 	vqmmc-supply = <&pm8994_l13>;
+	status = "okay";
 };
 
 &tlmm {
@@ -943,8 +939,8 @@ touch_int_sleep: touch-int-sleep-state {
  * 6 minutes to wake up (nothing interesting in kernel logs), but then it works as it should.
  */
 &usb3 {
-	status = "okay";
 	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
 };
 
 &usb3_dwc3 {
-- 
2.38.1

