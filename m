Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141BB600C58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJQKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJQKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:23:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EA27FD5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so17698217wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4vnnNnC74AadFGPIaQilMOOArwGooyURI20oo6pvdI=;
        b=E7UkAb984yGO2S+TPiMJI8VNnm2hyTRukt0iCsSbfG4/frAjKuMNKkaTWVYhqG22Eo
         pYd6DhLCyEVYISG8IRmNxxaOk0Zc7Fxdus5A4DZ1UuDas40yDtOLQ9wsTVGgn/BW4bIT
         aPUQuU6sO8iw1POLSvGTFPe4/8ETooxDRhhBnT4qxK03duAsazPQT5pTKkUcx4EyLdkR
         3oY1B8OHUEIBiBYFgcxcAXAg4GvtQhN9htlrFDR9lSTYw/1qdexnMrCnAxqIRTpeM0mm
         LIh8sGTt8HUxDJnNWkO6u0GDIWTjNu148ul5nKLuKk/1jMhHKJZZlajwD1rbZ8h2NaFf
         mzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4vnnNnC74AadFGPIaQilMOOArwGooyURI20oo6pvdI=;
        b=254g3mXuGeRX/gOHfqZ10rnvFRK6vDP+VBYdXFmeYhZF6cf4l1Z4k4l63ng/OeI0bK
         C6FoyNWbRisdW6zMejXxGZQS+BgDAU8Hif8fFJl+iELiw+d+2W+MwazDFXUodNrZzbao
         4sZB3f/BzBIwFNLDwESjU0h2d86Bk6w3EdG8OHgowPEXTXEpwbWuCZj6FQemDg04lI0B
         Oy9Tj3tGYejUOdmtbE7t2uQeZpTqfwXvcx8aA/1omV78ifXlCC7eHHdMjOeMBmdE+PaR
         7Z66Ie7bViShD5Fpj4IxO8RYKf/pVuszWKcVjqU1jNuQXrFJ+L8ydMMbQc+H+pjeqGwB
         lGGg==
X-Gm-Message-State: ACrzQf2rUG5QHt0bwCOA35CQQJX5NQHSivjEubLQyWsxsQlz9VEuyVR2
        I9ADaxAUziPBFpnv4wKgQfEbcQ==
X-Google-Smtp-Source: AMsMyM6HU5BuPA3M/bfb/GFmfDnbrmPt9e6BVpjgCq6VWHhs5X5IEOx2PBHwIP5KLLaFMco4dcVrhA==
X-Received: by 2002:a05:6000:1d82:b0:22c:ae77:c8dc with SMTP id bk2-20020a0560001d8200b0022cae77c8dcmr6046310wrb.413.1666002193889;
        Mon, 17 Oct 2022 03:23:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm15590707wmq.48.2022.10.17.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:23:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 12:23:08 +0200
Subject: [PATCH v2 4/5] dt-bindings: regulators: convert non-smd RPM Regulators
 bindings to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v2-4-639fe67a04be@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
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

Convert the non-SMD Regulators bindings to dt-schema, the old text based
bindings will be deleted later since the RPM bindings are not yet converted.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

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
