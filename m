Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9264B31E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiLMKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiLMKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:19:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14E1C91F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:19:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p8so4093737lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOTFzqy0SHhl805Xgu2KuiLNTiAHbB6xxYJIBzREPXE=;
        b=iANdQ2bZf8C7csyk8rH6ek0Hk9E/sNjSPX3qQPIKKnU9neZmUWYlHWfL0mVBTOmJDt
         m8Sc0UWGW/mVonwlkicy9NJ81ezbIITu6SOdN5kwz2HCO2LghNUxasBJFXztq4wwGdI/
         2ilfThButawwArjhYAYO0xOUoT0Q57Tg8c7oifIx7b0ZlUzK7aBHo2wCCgz87NNwfFy6
         mrD1GeK1wiI2ASwpXJnJoShK97pk8DupxfWusjS+CycUFgpS9Kuotjl2dUAIK/VjxRvQ
         uGRrKcxg8A/TC+ZGlqxfbC2XNQnfG3J11p5Pu3gmHA2rySrZqAXFfCXjL6+XmYJHrpRA
         X7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOTFzqy0SHhl805Xgu2KuiLNTiAHbB6xxYJIBzREPXE=;
        b=ityP4WNQqdnGxbTka9BHb1IPWiL8boLwQFKqKWiBtGGq9LbRKja/0u7pzuPOKlJbB+
         d43cDZtcKHVt8PPZoq2CUzYgK4L8RHIG7+OuuNv4J2ZqSeV2edffcgCgGjz13HSjIY8L
         Djg/S/l5G2lS0/96Aozy1zPQ4ns7CU7+2NyqStwVqYZggT/RcVgVjEeNq4YjnSeUfZDV
         ug9If8WBIJjl6SAN4np/t9GW2vgUWK18Af7kvMpsrXb6HEqaua5B1fSEBRRftEeqMEGT
         LEhURO0+DeVHP1WSd3XW7km3b8TdGD2qgQ25eCNTGuUD4x586XqOzOuR33gKNr1XsCNe
         zq2g==
X-Gm-Message-State: ANoB5pmaI5eiqHH8gUOaEPlU8AD4/eQPE2/WapYWIrSoFd5ZTjSao4WV
        +UCTMy6iEgkLvQ0GVirn+/dKPQ==
X-Google-Smtp-Source: AA0mqf5GPFS+RKDgnJ4MrDULTtCICP7U2QEbslv+c3TB5mQYZa+kfPWGjWmxhcVj+A7z8b+JJGbLDQ==
X-Received: by 2002:ac2:5e63:0:b0:4b5:8054:1ded with SMTP id a3-20020ac25e63000000b004b580541dedmr4528335lfr.9.1670926772871;
        Tue, 13 Dec 2022 02:19:32 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o11-20020ac25e2b000000b004b5732080d1sm302460lfg.150.2022.12.13.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:19:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: rename AOSS QMP nodes
Date:   Tue, 13 Dec 2022 11:19:20 +0100
Message-Id: <20221213101921.47924-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
References: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
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

The Always On Subsystem (AOSS) QMP is not a power domain controller
since commit 135780456218 ("arm64: dts: qcom: sc7180: Use QMP property
to control load state") and few others.  In fact, it was never a power
domain controller but rather control of power state of remote
processors.  This power state control is now handled differently, thus
the AOSS QMP nodes do not have power-domain-cells:

  sc7280-idp.dtb: power-controller@c300000: '#power-domain-cells' is a required property
  From schema: Documentation/devicetree/bindings/power/power-domain.yaml

AOSS QMP is an interface to the actuall AOSS subsystem responsible for
some of power management functions, thus let's call the nodes as
"power-management".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Call the nodes "power-management"
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 906fb9343bcc..1370b7adccd8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3248,7 +3248,7 @@ aoss_reset: reset-controller@c2a0000 {
 			#reset-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sc7180-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7c24c2129800..4768ae74d61f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4257,7 +4257,7 @@ aoss_reset: reset-controller@c2a0000 {
 			#reset-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sc7280-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 3cb4ca6c53eb..05086169d873 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1921,7 +1921,7 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5f1f7cb52c90..a749e6b9d5ac 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4965,7 +4965,7 @@ aoss_reset: reset-controller@c2a0000 {
 			#reset-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 0f01ff4feb55..8dda257178c9 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1273,7 +1273,7 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sm6350-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x1000>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d1b64280ab0b..089f730beb76 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3589,7 +3589,7 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sm8150-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fbbbae29e0c2..a4e171a59409 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3741,7 +3741,7 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sm8250-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 49db223a0777..1fd0df2e343f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1717,7 +1717,7 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sm8350-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index e0d30dadbf8b..e9a835e34ad2 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2453,7 +2453,7 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		aoss_qmp: power-controller@c300000 {
+		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sm8450-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
-- 
2.34.1

