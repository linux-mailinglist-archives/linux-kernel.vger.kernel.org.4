Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9482747F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjGEIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGEIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:21:33 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1D1FD9;
        Wed,  5 Jul 2023 01:20:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09028281|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.587746-0.000190752-0.412063;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Tm-KwVH_1688545239;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.Tm-KwVH_1688545239)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 16:20:53 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     liweilei@awinic.com, liangdong@awinic.com, like@awinic.com,
        yijiangtao@awinic.com
Subject: [PATCH V1 1/1] regulator: Add awinic,aw3750x.yaml
Date:   Wed,  5 Jul 2023 08:19:41 +0000
Message-ID: <20230705081942.2608531-2-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705081942.2608531-1-like@awinic.com>
References: <20230705081942.2608531-1-like@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ke Li <like@awinic.com>

Signed-off-by: Ke Li <like@awinic.com>
---
 .../bindings/regulator/awinic,aw3750x.yaml    | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml

diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
new file mode 100644
index 000000000000..cdb3d9dbf88f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/awinic,aw3750x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW3750X Power Management IC
+
+maintainers:
+  - Weidong Wang <wangweidong.a@awinic.com>
+  - Ke Li <like@awinic.com>
+
+description: |
+  AW3750X is designed to generate both positive and negative bias voltages for.
+  TFT-LCD panels or other general dual-supply applications. It consists a highly
+  integrated synchronous boost converter with input voltage from 2.7V to 5.5V.
+
+properties:
+  compatible:
+    const: awinic,aw3750x_led
+
+  enp:
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single LDO regulator.
+
+    properties:
+      regulator-name: true
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+  enn:
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single BOOST regulator.
+
+    properties:
+      regulator-name: true
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - enp
+  - enn
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    pio: pinctrl@10005000 {
+      aw_enn_default: aw_enn_default {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
+          slew-rate = <1>;
+          output-low;
+        };
+      };
+
+      aw_enn_output_high: aw_enn_output_high {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
+          slew-rate = <1>;
+          output-high;
+        };
+      };
+
+      aw_enn_output_low: aw_enn_output_low {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
+          slew-rate = <1>;
+          output-low;
+        };
+      };
+
+      aw_enp_default: aw_enp_default {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
+          slew-rate = <1>;
+          output-low;
+        };
+      };
+
+      aw_enp_output_high: aw_enp_output_high {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
+          slew-rate = <1>;
+          output-high;
+        };
+      };
+
+      aw_enp_output_low: aw_enp_output_low {
+        pins_cmd_dat {
+          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
+          slew-rate = <1>;
+          output-low;
+        };
+      };
+
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        aw3750x@3e {
+            compatible = "awinic,aw3750x_led";
+            aw3750x_gpio_ctrl = <0>;
+            reg = <0x3e>;
+            outp = <0x0E>;
+            outn = <0x0E>;
+            enn-gpio = <&pio 7 0>;
+            enp-gpio = <&pio 1 0>;
+            pinctrl-names = "aw_enn_default", "aw_enn_output_high",
+                            "aw_enn_output_low", "aw_enp_default",
+                            "aw_enp_output_high", "aw_enp_output_low";
+            pinctrl-0 = <&aw_enn_default>;
+            pinctrl-1 = <&aw_enn_output_high>;
+            pinctrl-2 = <&aw_enn_output_low>;
+            pinctrl-3 = <&aw_enp_default>;
+            pinctrl-4 = <&aw_enp_output_high>;
+            pinctrl-5 = <&aw_enp_output_low>;
+
+            aw_lcdb_outp_vreg: enp {
+              label = "outp";
+              regulator-name = "outp";
+              regulator-min-microvolt = <4000000>;
+              regulator-max-microvolt = <6000000>;
+            };
+            aw_lcdb_outn_vreg: enn {
+              label = "outn";
+              regulator-name = "outn";
+              regulator-min-microvolt = <4000000>;
+              regulator-max-microvolt = <6000000>;
+            };
+        };
+    };
-- 
2.41.0

