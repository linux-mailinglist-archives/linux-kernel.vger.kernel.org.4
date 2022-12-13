Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9A64BCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiLMTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiLMTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:10:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83B25C7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so6558649lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaTjX9kmXgk2NSbnDVcg70Dryb8H2MzA5DwqvOQCmlU=;
        b=S4Mu0HNJknq8RSnPK3OQ/I62oGoS3brj3sZFSwXZFdqGW0v+0UUYArj3ZHUnZv5FRH
         KPlxvHqxxQCLTY+nmaSB5lFHuNAtY5utvDvVs5WVE8F3YCGdPD0NBTi68oiUiBiNyO85
         Zi50RmnwAVYBMZPtaTYU0564qEKYxpMvpRq+DOdW+DxFO9cebjneByIw1PAuwQzgqNgL
         MEY4Gch/G4JIKjcNDhRSlk+BpuC/EfILwWIBVkcQRdLrqnCEE+a3lpGq9YAUYEm96Plz
         ffuE/FwzdXRmztwWX2nqcKmLxDE5GbGfsLYFaecZHmWNMHxhP3I1jc74yujL1vwTWNcj
         5ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaTjX9kmXgk2NSbnDVcg70Dryb8H2MzA5DwqvOQCmlU=;
        b=aiJNfMotne5juJDpIOlkNpm5NaVvLO0uPdxcBAxI4s4SfftJUOjKz1tjSUjUVKNa7j
         IQ+hOvkHUFCUJqtMLNzpHHmxIj1Dd9GUxCNAqcgSGd7aF49UeOxwzNMhQWAbLZeyim2e
         kxJNfyQDOLm/VksxWpHQ2SGdoClDZQo4CpFeYCgZ8KC1vyqo24jqfnaYZM7iVaXfGq8y
         GL2x0sE+WXYN8Cal2s1oAJGlnHWD+aGmK2Bme5cpzb4l4Wy7K1hT6XtrpTjGg75HjMYm
         C50Xgl7OEfP/5uULx4SD7AiWidX+2KYtnI8HsRqTk8SMfgHHL0Am615hQowHj83ZpZcO
         Y5YQ==
X-Gm-Message-State: ANoB5pmJipFIm70/zB5BJWt2lPW9hGVhwO17633MN2Xna3k3ZPJ1grD1
        fpPgTkM8WoFiTtJpSYeYTlDo5w==
X-Google-Smtp-Source: AA0mqf46AxqNOAV/NR6NF6Ybwx72TY/maEsa2RINIFqKr7rxN4mKYaYrj0FZyw9HjNElp2LVi1X3hQ==
X-Received: by 2002:a05:6512:b91:b0:4b6:ed8b:4f16 with SMTP id b17-20020a0565120b9100b004b6ed8b4f16mr3400571lfv.52.1670958649892;
        Tue, 13 Dec 2022 11:10:49 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651c119c00b0026dfbdfc1ddsm372023ljo.11.2022.12.13.11.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:10:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: qcom: sm8450-nagara: Configure SLG51000 PMIC
Date:   Tue, 13 Dec 2022 20:10:36 +0100
Message-Id: <20221213191036.611241-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213191036.611241-1-konrad.dybcio@linaro.org>
References: <20221213191036.611241-1-konrad.dybcio@linaro.org>
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

Nagara devices use the Dialog SLG51000 PMIC for powering some camera
sensors. Add the required nodes to support it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 62 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 1a0c26d84b4f..e7017e6b5435 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -513,7 +513,58 @@ &i2c5 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* Dialog SLG51000 CMIC @ 75 */
+	pmic@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+		dlg,cs-gpios = <&pm8350b_gpios 1 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_pwr_a_cs>;
+
+		regulators {
+			slg51000_a_ldo1: ldo1 {
+				regulator-name = "slg51000_a_ldo1";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_a_ldo2: ldo2 {
+				regulator-name = "slg51000_a_ldo2";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_a_ldo3: ldo3 {
+				regulator-name = "slg51000_a_ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_a_ldo4: ldo4 {
+				regulator-name = "slg51000_a_ldo4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_a_ldo5: ldo5 {
+				regulator-name = "slg51000_a_ldo5";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_a_ldo6: ldo6 {
+				regulator-name = "slg51000_a_ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_a_ldo7: ldo7 {
+				regulator-name = "slg51000_a_ldo7";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
 };
 
 &i2c9 {
@@ -612,6 +663,15 @@ vol_down_n: vol-down-n-state {
 };
 
 &pm8350b_gpios {
+	cam_pwr_a_cs: cam-pwr-a-cs-state {
+		pins = "gpio1";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <1>;
+		drive-push-pull;
+		output-high;
+	};
+
 	snapshot_n: snapshot-n-state {
 		pins = "gpio5";
 		function = "normal";
-- 
2.39.0

