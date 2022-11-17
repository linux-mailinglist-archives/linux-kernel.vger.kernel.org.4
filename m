Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE65062E28C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiKQRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiKQRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:05:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD171F0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:05:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a14so4911718wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XexGR7jVcVpGwbDs2U4NbQNM37ZAhVCuEdK37iGnHn8=;
        b=AsBslfPD2VG4/mjmW4cc3MmfACiH73+ioqv4xySCpemsLEQdpmQrcwrxyBccKNwLyq
         5KNkH3U4oMct5UbUAXe0O5WxbAGZh2N3dcHwKqanf4rm0RRdX9oD4zZiBwUpkv3ZPIE9
         sPb19EcsJeHgdiHrtMVofJhfJpgtyJZ/SBYlJAqS550wtV5QMNQrdGYxvhwzID9AlG76
         9/PiofNCfs5BUblyF5Fd76SMvYckA0kkFw71YbDqFqUI2xmE6fJaR/HMUNf3P6cv/eQm
         qpLs1FFHKYW1cLDNWq7EE7f0OyKKLzhoXPsvoZOy6fSXIo+TAxsBTAj2H80UaML8xyt5
         sqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XexGR7jVcVpGwbDs2U4NbQNM37ZAhVCuEdK37iGnHn8=;
        b=X42D8rsPPCe9psbH0wIQ8/2uI2RGze2OXw2Dkga59WO/Jswlgzqg+Jhxe58Pss1uhq
         XifHY8wzmZX0GUcCEuHKRqUnpBwT1SvXCkgtiZPKSY5IW77nMqjs4tTFED3a5Gq+6tIm
         NP6EI9Rh1UU0JXYTifrjdl2+Nd1fYKPXsftxgQxbR8vQp1xdWFqcTFZUwrXdVyHRnmQ7
         buekeCJQnYj3toIMksXnrF2m/DHIOxsOzI2ufPMqPNRysdpHKE8mIYSilc7Psf5DH2fS
         KxC9IMdkyvx6ljDuSoTl80t96WmPVAVnLtmxh/jg+WGUK5JBSLd4iDhPG1V4P5tCwcuQ
         WTMg==
X-Gm-Message-State: ANoB5pke2Tv31kEBmgPVuDiuOqal+BO3BpOOubibRahsOWg5T8KraB3J
        s1wrQP9/tDsg/ewhnbVVOC7rEw==
X-Google-Smtp-Source: AA0mqf6XUKeEMQuhycFOv9aBAo69aqa4SCZLaqP/UhQ12HKousiSCd+NvC/gJV/eTfWxOttglGJr5Q==
X-Received: by 2002:a5d:4e43:0:b0:241:bc7b:7db9 with SMTP id r3-20020a5d4e43000000b00241bc7b7db9mr894848wrt.646.1668704701232;
        Thu, 17 Nov 2022 09:05:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b00236488f62d6sm1396225wru.79.2022.11.17.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:05:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 17 Nov 2022 18:04:58 +0100
Subject: [PATCH v5 1/2] dt-bindings: regulators: convert non-smd RPM Regulators
 bindings to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the non-SMD Regulators bindings to dt-schema, the old text based
bindings will be deleted later since the RPM bindings are not yet converted.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
new file mode 100644
index 000000000000..6c7b37a4008f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,rpm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPM regulator
+
+description:
+  The Qualcomm RPM regulator is modelled as a subdevice of the RPM.
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
+    unevaluatedProperties: false
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
