Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84B607AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJUP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJUP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:28:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08827A33C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:28:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2269121wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cneSXN4S2VuOhuzg++x76NmZMHgpdrcPpBRea9wvggw=;
        b=qJ0g2R4eIcGpdp8qo7Ubk4FAe0pROq+cHpaomx3Ww0ang3LQZnBUEDKyxb14meEcRv
         poK8JgZ8S9/R2MyadbeA/R7huAcwS1U7W/3fwrW0JwLn3NPeErfALYGeEkCTLRItk/CT
         +S168Ia+qaCT3p+rjIY+OI8sLWQsX3bBJ0qE4bgfFhH6rIR7/BIOvpXfz0oFOkXAVlmr
         X2sDpikKr1wRq0zbFqNSniJSwKa1P4nw+RcPY7JLbcndYy1ENZuAIE+rNQHOeCAbJ8Ed
         odalQOaQHyE83/j34pFhHGy6NXnQ3VKMvon+tZVChaoHu+Wu4Cl1Om3uHxlzu7jiDnA9
         tzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cneSXN4S2VuOhuzg++x76NmZMHgpdrcPpBRea9wvggw=;
        b=CNlaLMIBRt/cRZyjysVz+Rtn7DO3DuULEYqbalEcCqUU1zQULkRFfn9JWE2h/K1wQg
         +ga519lfErdqsjkUmZDv/qyu11IAoT6Dc3h8n0/vhuCzeGEvsS9OUoDYIZ9utF67xX0B
         tFgLgCHtBMT1WklJ5Sjl5HP9M/DXOUm8g9cWwBgK1IJeYkAGsnguiKF6jCku+323wN/q
         7LwuqhtbvyoftQNvZ7HFDZDOZe6nU4tRUq0XOPNAuLT+UTANQkLeMSd3wPmY+COt+wDb
         u+3hqmieyIMuwRx/okr5I7XTrwGHSKO8GUkVJFxf2SOFXZ560hNf7uC2pIoISH4oggGD
         RBfQ==
X-Gm-Message-State: ACrzQf3YI9ky9K6CjIdwPhTKOC4JU12nc5iUp9RdRICNwESq0EsNnJlg
        K1P4fMsym8y7EU0O+nVqtzYB5Q==
X-Google-Smtp-Source: AMsMyM7vhCXg7vf9+6A5SukzAkIpu2CdBWNWHX5YpRYbBXFgvco143fChfxmll0ycRgI7DgnJ/l4cg==
X-Received: by 2002:a05:600c:1906:b0:3c6:f154:d4b5 with SMTP id j6-20020a05600c190600b003c6f154d4b5mr13492136wmq.94.1666366078487;
        Fri, 21 Oct 2022 08:27:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10706169wms.0.2022.10.21.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:27:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 21 Oct 2022 17:27:55 +0200
Subject: [PATCH v3 3/5] dt-bindings: regulators: convert non-smd RPM Regulators
 bindings to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v3-3-e5e045644971@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the non-SMD Regulators bindings to dt-schema, the old text based
bindings will be deleted later since the RPM bindings are not yet converted.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
new file mode 100644
index 000000000000..e8243a30323b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPC RPM regulator
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
