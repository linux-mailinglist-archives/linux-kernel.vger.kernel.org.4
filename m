Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFADF734263
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFQRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFQRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5519B5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so2337609a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022115; x=1689614115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFlTog3oqwb41eoYl1kdqakfvXtFCraQtd5UVb/cu4E=;
        b=zeFtzruM2axOg+F/lkHzveED2K7zG2KVylFOgDS+1T61QcLXKQbfeqXYvIeke/hi+u
         ugi07CSivPmjkOcxyWEYDTWpo9A0QJt8tRwntWGRQN2aRX9QGsg8S4r6VuzJdQNYdt7U
         xXb+p5jzmb1oaETjIh0IzMCukb3fHzi2O+z9CAm3DTLxR4fh5qWQRJw+xAmHxSM8Ejbe
         C8kXi77BFR4/F5VLr2mKXE+4MZd796XpPE7MER7uUL4s+/X9yrpxg5d0Yy64Mhay1FPJ
         0qPoixLkgBhb9di4Y4bTTX2th9/9d+EG/Wz2YyyjPNu9lFAb2+T4R5HFaN99ZIJOsWLu
         vdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022115; x=1689614115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFlTog3oqwb41eoYl1kdqakfvXtFCraQtd5UVb/cu4E=;
        b=AD/vYF/haaxBihPSrXibih3WHz3hGDW6ogruhoeHu8wdfoplCKdaH88RObw2pV93Nr
         YKDlVNKd6W2kkiuyVqA0i6lHnsK+ojuWNOjQS//tHPelEcA66c0ovlQ5QiHOO5SHVhHy
         CblVaFqUQ2lBh3foQNkpULypehmQe1p5/xGatzgr0FQtloL+jjWOmVKTNiXQNsLU9HNV
         Kb4ZJWyoYFsH+HK4f+FGQLgUHcNUL+0ckLOdSdcsLDwxv5kGerh5x41iAwGeBtH23Tp1
         DS9yc9IxvXTd/c2pGSPRSBw8OsXIWi0ny5zIx3909dt3DFfv+uVE9QW1SY/HxjqgWoZ9
         BwRw==
X-Gm-Message-State: AC+VfDxaz6lATu51lMt2rawHeRYbdhcsuP+c5Y8ufGuuBVHwlqWgBxPo
        ytr/pY1I0K22gDzhcIeKqWmR0A==
X-Google-Smtp-Source: ACHHUZ4tbfzcAccYIZTT1GBR5RzCcoqfk3TCNwSEVzBTWuSbxibvwvhrziSWwSb0kB4yh6phT654ow==
X-Received: by 2002:a05:6402:517a:b0:50b:f929:c6d3 with SMTP id d26-20020a056402517a00b0050bf929c6d3mr3940776ede.1.1687022115507;
        Sat, 17 Jun 2023 10:15:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7c2ca000000b005184165f1fasm7146769edp.5.2023.06.17.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH] arm64: dts: qcom: sdm850-c630: add missing panel supply
Date:   Sat, 17 Jun 2023 19:15:12 +0200
Message-Id: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel bindings (boe,nv133fhm-n61) require supply which here actually can
be turned on/off via GPIO control:

  sdm850-lenovo-yoga-c630.dtb: panel: 'power-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index cfbc4fc1eba9..3d871567cf81 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -87,6 +87,25 @@ sn65dsi86_refclk: sn65dsi86-refclk {
 		clock-frequency = <19200000>;
 	};
 
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	vlcm_3v3: regulator-vlcm-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vlcm_3v3";
+
+		vin-supply = <&vph_pwr>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&sn65dsi86 1000000>;
@@ -419,6 +438,7 @@ aux-bus {
 			panel: panel {
 				compatible = "boe,nv133fhm-n61";
 				backlight = <&backlight>;
+				power-supply = <&vlcm_3v3>;
 
 				port {
 					panel_in_edp: endpoint {
-- 
2.34.1

