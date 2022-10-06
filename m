Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7E5F640A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiJFJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJFJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:58:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584682765
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:58:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y23-20020a1c4b17000000b003bd336914f9so594460wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=DKUe3vaae/qSDqavB5b2UyWmPZChwcUVYf9R6hn/2Jk=;
        b=kvh8o1q8Z3XffpWmBIs19YsYizHkIsAKO2dWamLk5yyb4p6QhyPGPN08b4X8Kbozj9
         C23/+XKWB3hU6zYX1aeu6o8iMCcNyH/EILwjw0rguMbrdE2CGXB4zANyvO9bhlssfevM
         AU0i7HOPmM1Yy2BSOpnp07/e52A8LhN+OZfhbxmutohVRhBExZrUOXAQEySzjWKm/6Ie
         09ASQE6/ah3Q7+aywgk7QDLPj3wJHDCg3xLTag9ffgvRAezAFwzrz7qWiWyFWgUhzWnv
         LHdJkDrtBN73Z6YTxEL5mnRCewrv1CLHjUvuCHpoNsGA10ahvub2M6HL1Rohq0HdIstl
         2rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DKUe3vaae/qSDqavB5b2UyWmPZChwcUVYf9R6hn/2Jk=;
        b=SggbWMuphtlt4Ni4vLHfnNv05SdxoUIMX44fGFk0goswYaCBJl0UZz/eJ2BpyCMLTd
         TJZyxDD68mpLRvbjh2m4wLn6uOGHE/qG/DcfG5AoLZZRgiZX8eSWm9tknmDd7vgk9lqa
         yyqEZ7h14IeWPa6X1Y4eDbMGK3Qs/Zcm6Wl8b8KEjbPflejbahYxg95QCb5fg2y2TrQc
         QeIQQ4NBzDaru+KmHrmi1ojQwgzVtN4rIpn+lmPsfM0hihwyXZDfO0zvhf0+cq172YPK
         2eOdVxeK3fMoWli4QlnuJrdrBGfMACMEgEzAAWu91jsaZtfLjeu8pvtCu3A9YMIolmSG
         jGRw==
X-Gm-Message-State: ACrzQf1wTaF2Kgzfrmki4QWKD2Y1z9sDxSg5l3nPnjYk/rhfwApoWgSG
        FQfz7GQSfogh8OTKRbICvkwXZA==
X-Google-Smtp-Source: AMsMyM6L8ghlxMdO1iMdKN45dC57YFQOq98tTziOD6Xmlg9dSwwRONBE2pPyKhlY4hoi3jeNNEOLXg==
X-Received: by 2002:a05:600c:4f82:b0:3b4:a6fc:89d2 with SMTP id n2-20020a05600c4f8200b003b4a6fc89d2mr2508352wmq.53.1665050285343;
        Thu, 06 Oct 2022 02:58:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm17935603wre.58.2022.10.06.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:58:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Oct 2022 09:58:02 +0000
Subject: [PATCH 5/6] dt-bindings: regulators: convert non-smd RPM Regulators
 bindings to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v1-5-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the non-SMD Regulators  bindings to dt-schema and remove the
old text based bindings now we have migrated all the content.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 246 ---------------------
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++
 2 files changed, 127 insertions(+), 246 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
deleted file mode 100644
index b622359e73c2..000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ /dev/null
@@ -1,246 +0,0 @@
-Qualcomm Resource Power Manager (RPM)
-
-This driver is used to interface with the Resource Power Manager (RPM) found in
-various Qualcomm platforms. The RPM allows each component in the system to vote
-for state of the system resources, such as clocks, regulators and bus
-frequencies.
-
-Please refer to soc/qcom/qcom,ipc-rpm.yaml
-
-= SUBNODES
-
-The RPM exposes resources to its subnodes. The below bindings specify the set
-of valid subnodes that can operate on these resources.
-
-== Regulators
-
-Regulator nodes are identified by their compatible:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-pm8058-regulators"
-		    "qcom,rpm-pm8901-regulators"
-		    "qcom,rpm-pm8921-regulators"
-		    "qcom,rpm-pm8018-regulators"
-		    "qcom,rpm-smb208-regulators"
-
-- vdd_l0_l1_lvs-supply:
-- vdd_l2_l11_l12-supply:
-- vdd_l3_l4_l5-supply:
-- vdd_l6_l7-supply:
-- vdd_l8-supply:
-- vdd_l9-supply:
-- vdd_l10-supply:
-- vdd_l13_l16-supply:
-- vdd_l14_l15-supply:
-- vdd_l17_l18-supply:
-- vdd_l19_l20-supply:
-- vdd_l21-supply:
-- vdd_l22-supply:
-- vdd_l23_l24_l25-supply:
-- vdd_ncp-supply:
-- vdd_s0-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-	Usage: optional (pm8058 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- lvs0_in-supply:
-- lvs1_in-supply:
-- lvs2_in-supply:
-- lvs3_in-supply:
-- mvs_in-supply:
-- vdd_l0-supply:
-- vdd_l1-supply:
-- vdd_l2-supply:
-- vdd_l3-supply:
-- vdd_l4-supply:
-- vdd_l5-supply:
-- vdd_l6-supply:
-- vdd_s0-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-	Usage: optional (pm8901 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vdd_l1_l2_l12_l18-supply:
-- vdd_l3_l15_l17-supply:
-- vdd_l4_l14-supply:
-- vdd_l5_l8_l16-supply:
-- vdd_l6_l7-supply:
-- vdd_l9_l11-supply:
-- vdd_l10_l22-supply:
-- vdd_l21_l23_l29-supply:
-- vdd_l24-supply:
-- vdd_l25-supply:
-- vdd_l26-supply:
-- vdd_l27-supply:
-- vdd_l28-supply:
-- vdd_ncp-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_s7-supply:
-- vdd_s8-supply:
-- vin_5vs-supply:
-- vin_lvs1_3_6-supply:
-- vin_lvs2-supply:
-- vin_lvs4_5_7-supply:
-	Usage: optional (pm8921 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vin_lvs1-supply:
-- vdd_l7-supply:
-- vdd_l8-supply:
-- vdd_l9_l10_l11_l12-supply:
-	Usage: optional (pm8018 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-The regulator node houses sub-nodes for each regulator within the device. Each
-sub-node is identified using the node's name, with valid values listed for each
-of the pmics below.
-
-pm8058:
-	l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
-	l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
-	lvs0, lvs1, ncp
-
-pm8901:
-	l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
-	mvs
-
-pm8921:
-	s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-	l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
-	l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
-	ncp
-
-pm8018:
-	s1, s2, s3, s4, s5, , l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-	l12, l14, lvs1
-
-smb208:
-	s1a, s1b, s2a, s2b
-
-The content of each sub-node is defined by the standard binding for regulators -
-see regulator.txt - with additional custom properties described below:
-
-=== Switch-mode Power Supply regulator custom properties
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <empty>
-	Definition: enable pull down of the regulator when inactive
-
-- qcom,switch-mode-frequency:
-	Usage: required
-	Value type: <u32>
-	Definition: Frequency (Hz) of the switch-mode power supply;
-		    must be one of:
-		    19200000, 9600000, 6400000, 4800000, 3840000, 3200000,
-		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
-		    1480000, 1370000, 1280000, 1200000
-
-- qcom,force-mode:
-	Usage: optional (default if no other qcom,force-mode is specified)
-	Value type: <u32>
-	Definition: indicates that the regulator should be forced to a
-		   particular mode, valid values are:
-		   QCOM_RPM_FORCE_MODE_NONE - do not force any mode
-		   QCOM_RPM_FORCE_MODE_LPM - force into low power mode
-		   QCOM_RPM_FORCE_MODE_HPM - force into high power mode
-		   QCOM_RPM_FORCE_MODE_AUTO - allow regulator to automatically
-					      select its own mode based on
-					      realtime current draw, only for:
-					      pm8921 smps and ftsmps
-
-- qcom,power-mode-hysteretic:
-	Usage: optional
-	Value type: <empty>
-	Definition: select that the power supply should operate in hysteretic
-		    mode, instead of the default pwm mode
-
-=== Low-dropout regulator custom properties
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <empty>
-	Definition: enable pull down of the regulator when inactive
-
-- qcom,force-mode:
-	Usage: optional
-	Value type: <u32>
-	Definition: indicates that the regulator should not be forced to any
-		   particular mode, valid values are:
-		   QCOM_RPM_FORCE_MODE_NONE - do not force any mode
-		   QCOM_RPM_FORCE_MODE_LPM - force into low power mode
-		   QCOM_RPM_FORCE_MODE_HPM - force into high power mode
-		   QCOM_RPM_FORCE_MODE_BYPASS - set regulator to use bypass
-						mode, i.e.  to act as a switch
-						and not regulate, only for:
-						pm8921 pldo, nldo and nldo1200
-
-=== Negative Charge Pump custom properties
-
-- qcom,switch-mode-frequency:
-	Usage: required
-	Value type: <u32>
-	Definition: Frequency (Hz) of the switch mode power supply;
-		    must be one of:
-		    19200000, 9600000, 6400000, 4800000, 3840000, 3200000,
-		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
-		    1480000, 1370000, 1280000, 1200000
-
-= EXAMPLE
-
-	#include <dt-bindings/mfd/qcom-rpm.h>
-
-	rpm@108000 {
-		compatible = "qcom,rpm-msm8960";
-		reg = <0x108000 0x1000>;
-		qcom,ipc = <&apcs 0x8 2>;
-
-		interrupts = <0 19 0>, <0 21 0>, <0 22 0>;
-		interrupt-names = "ack", "err", "wakeup";
-
-		regulators {
-			compatible = "qcom,rpm-pm8921-regulators";
-			vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
-
-			s1 {
-				regulator-min-microvolt = <1225000>;
-				regulator-max-microvolt = <1225000>;
-
-				bias-pull-down;
-
-				qcom,switch-mode-frequency = <3200000>;
-			};
-
-			pm8921_s4: s4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				qcom,switch-mode-frequency = <1600000>;
-				bias-pull-down;
-
-				qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
new file mode 100644
index 000000000000..e18bb8b87c43
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM IPC RPM REGULATOR
+
+description:
+  The Qualcomm RPM over IPC regulator is modelled as a subdevice of the RPM.
+
+  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
+  for information regarding the RPM node.
+
+  The regulator node houses sub-nodes for each regulator within the device.
+  Each sub-node is identified using the node's name, with valid values listed
+  for each of the pmics below.
+
+  For pm8058 l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
+  l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
+  lvs0, lvs1, ncp
+
+  For pm8901 l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
+  mvs
+
+  For pm8921 s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
+  l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
+  ncp
+
+  For pm8018 s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l14, lvs1
+
+  For smb208 s1a, s1b, s2a, s2b
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,rpm-pm8058-regulators
+      - qcom,rpm-pm8901-regulators
+      - qcom,rpm-pm8921-regulators
+      - qcom,rpm-pm8018-regulators
+      - qcom,rpm-smb208-regulators
+
+patternProperties:
+  ".*-supply$":
+    description: Input supply phandle(s) for this node
+
+  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
+    description: List of regulators and its properties
+    $ref: regulator.yaml#
+    properties:
+      bias-pull-down:
+        description: enable pull down of the regulator when inactive
+        type: boolean
+
+      qcom,switch-mode-frequency:
+        description: Frequency (Hz) of the switch-mode power supply
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum:
+          - 19200000
+          - 9600000
+          - 6400000
+          - 4800000
+          - 3840000
+          - 3200000
+          - 2740000
+          - 2400000
+          - 2130000
+          - 1920000
+          - 1750000
+          - 1600000
+          - 1480000
+          - 1370000
+          - 1280000
+          - 1200000
+
+      qcom,force-mode:
+        description: Indicates that the regulator should be forced to a particular mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum:
+          - 0 # QCOM_RPM_FORCE_MODE_NONE do not force any mode
+          - 1 # QCOM_RPM_FORCE_MODE_LPM force into low power mode
+          - 2 # QCOM_RPM_FORCE_MODE_HPM force into high power mode
+          - 3 # QCOM_RPM_FORCE_MODE_AUTO allow regulator to automatically select its own mode
+              # based on realtime current draw, only for pm8921 smps and ftsmps
+
+      qcom,power-mode-hysteretic:
+        description: select that the power supply should operate in hysteretic mode,
+          instead of the default pwm mode
+        type: boolean
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/mfd/qcom-rpm.h>
+    regulators {
+      compatible = "qcom,rpm-pm8921-regulators";
+      vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+
+      s1 {
+        regulator-min-microvolt = <1225000>;
+        regulator-max-microvolt = <1225000>;
+
+        bias-pull-down;
+
+        qcom,switch-mode-frequency = <3200000>;
+      };
+
+      pm8921_s4: s4 {
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+
+        qcom,switch-mode-frequency = <1600000>;
+        bias-pull-down;
+
+        qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+      };
+    };
+...

-- 
b4 0.10.1
