Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A98658BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiL2Kcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiL2Kcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:32:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1145CEE3C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so26943266lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5CzpVg95POFzeTwzqnlV+4RYF9UaX7PA+joTg3brhk=;
        b=o/Kp6wDqmmyOQeik9o1Ct9pTdOkmbqYwMJRctWiKoT69CTeREP1bGaLahI89fua4GL
         CxF8Bw/aRDDElMGD2yBA8PP32zylu+FHCfDt5B6LgS7mTneVU3EGonCNsOveHZ8ilan6
         hpTaTrVBdpypOq57R2ovvbuCQh+mDregK4MKmVRn4rIWCcmT6Q99d2M/ZmnUdnNxaSib
         17wPx9C1a/BTdKEfC99OEYYN/ExGHYIAxegGv0Xm7EMgZyTL4ZoEh4HPjUBsGE3oXvY2
         5JozILjG6YjC6rvdl4BQI+bnrZOxG/o/GQTUrcTEpeBe7Tn2pXKu+3zXtltjJ5dS/9n4
         vaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5CzpVg95POFzeTwzqnlV+4RYF9UaX7PA+joTg3brhk=;
        b=AsuBj/oAynyX6NnXVgwfnjY3HGcmzTr4agBUsQAfNamuStiuFFvej70Wgje6RKCQSM
         JtZjMxCmJ6bdY/JDTNPDK5BeEWdMx/FDnz6Zzz2GTe9qWYQdH04ipkOMmzcZoKkD9akR
         e0lsSko/Ipw0whrTu9psG40e2RZN+J/A09QgZz2BKeQ0Lfco+NkQflGogP1XuDd/0rwR
         m7IbYyOY2CuRpFHey7ZytY4oTjMYFh+m7NWdsfviPc695mCLFlsGlx67di0GO/5T899/
         LGBVGeFNtrsskgf1GqQbKwSbcJSmJNeBoaCQjJu5NOcU2c3R5Ogy/gKRpHETZRDpK3to
         aPgg==
X-Gm-Message-State: AFqh2ko8UHMZLM7PVeZ8RXMFlitXZCgeWHZD4qDWz4SAk8zSAOCS2h72
        ZMvvzgwvYOk7DIl4C87uUKtMtw==
X-Google-Smtp-Source: AMrXdXsT3QKQBp99Umq5n7BvdZ9gxZpz+t+mSJf4TJAT/1oTXgPsndAzzCkT1Zituu6YRYY7mQeTvQ==
X-Received: by 2002:ac2:5ec9:0:b0:4b5:b6e8:bb53 with SMTP id d9-20020ac25ec9000000b004b5b6e8bb53mr7390757lfq.24.1672309944440;
        Thu, 29 Dec 2022 02:32:24 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b004a478c2f4desm2993526lfg.163.2022.12.29.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:32:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8450-nagara: Configure SLG51000 PMIC
Date:   Thu, 29 Dec 2022 11:32:12 +0100
Message-Id: <20221229103212.984324-7-konrad.dybcio@linaro.org>
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

Nagara devices use the Dialog SLG51000 PMIC for powering some camera
sensors. Add the required nodes to support it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 62 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 15709d73b264..8869495c397e 100644
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

