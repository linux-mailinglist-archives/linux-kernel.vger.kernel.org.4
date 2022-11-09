Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23321622DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKIO1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKIO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5413F85
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:26:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c25so26012445ljr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVFLp+q4rqPPv5pDBxdXoy+mEvkQOdHCoCkRlHx+cFM=;
        b=hQXvkdkeQ8u8kPUKFMCQApvuYe9GpGtkWjHCtda1yfJxJ7ZnyIzkzL4evgRQSijRFH
         AH7L+eKgUWqVxBq50aYzZVEcpENiexoYxYdLbt3eUPwiamVSuFrN7fzBuuXUv68t+UR2
         ESObtMbfkS+lMmDhhWgNHOQopKN1jr8cAULe+MaA57sW/Dgma7ZmyE1VRq3fXt24/6zR
         kkHYjWONQRsNxLhxam8MmEo8ICtm9pTkPtevmoYgpw5ox9NXn6UB5z7Ep2GeiZ9AoTHz
         PbK7Lwlf6g5M9JWDfg1Jk6Q9J9oNjycGU9RHEr00GOCrShYN6eOHQ76vbvCE88AjOtIr
         oT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVFLp+q4rqPPv5pDBxdXoy+mEvkQOdHCoCkRlHx+cFM=;
        b=VElfomwmPLsuT/hq4qR7SYMMbvMpm6MULuiqRKCY0ua7+JFvUNo+pt6cRdbQpwAiQ9
         9I2LjZx6PKmuR3uCudqGEQQJV8e5kuoBai8IJ2rCksrVJhBFb9qo+E2qlkuwVsfLlANU
         uZqNIE8/yGinWwP95JHv/HevCE177qe9AP5/+99OGtjwyGB/1cds6Rl/nObAwras2OcG
         3tb7T2mLYAGHT7o3hvd4EczjMJ4HZsBIGR3ilj3IDmrOMQzKCMEXPYEtWloljJCy/rTM
         LrqxzaErojO2YhAhZMgq5b+Ds5eYwMNoKtYgNP697/dNHtLHuV/6xvALFj3A3RjPOLwx
         +Mig==
X-Gm-Message-State: ACrzQf2U4sj2tSx48Bjzt+SDZuuMz18FnJC8E5CVMa3qJGKrUVHoqjP6
        WsP2Amx9HXPWlxfGIGw0aCTVBw==
X-Google-Smtp-Source: AMsMyM7VzJjcEpij0nLstHpgmHAkqBG+QBBl4Xi7oqAYLhjfbcN/2JDgxGtdRfEykLPSIcFtzdzewA==
X-Received: by 2002:a2e:5054:0:b0:277:389e:8877 with SMTP id v20-20020a2e5054000000b00277389e8877mr21556714ljd.165.1668003999539;
        Wed, 09 Nov 2022 06:26:39 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004a2ae643b99sm2241008lfr.170.2022.11.09.06.26.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:26:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm6375-pdx225: Enable SD card slot
Date:   Wed,  9 Nov 2022 15:26:23 +0100
Message-Id: <20221109142623.53052-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109142623.53052-1-konrad.dybcio@linaro.org>
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
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

Set SDHCI VMMC/VQMMC to <=2v96 and allow load setting by the SDHCI
driver, as required by this use case.

Configure the SD Card Detect pin, enable the SDHCI2 controller and
assign it the aforementioned regulators.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 33083f18755b..c4181476f3b8 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -153,7 +153,8 @@ pm6125_l4: l4 {
 
 		pm6125_l5: l5 {
 			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <3050000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l6: l6 {
@@ -235,7 +236,8 @@ pm6125_l21: l21 {
 
 		pm6125_l22: l22 {
 			regulator-min-microvolt = <2704000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l23: l23 {
@@ -302,6 +304,34 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+
+	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+};
+
+
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
 
-- 
2.38.1

