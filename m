Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8F6F6791
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjEDIdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEDIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:33:23 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607A61A9;
        Thu,  4 May 2023 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683189060;
  x=1714725060;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n/SyerxwxFMTmXmN/OA8MgfA2PcxKOBAQ2mIXdeS1oI=;
  b=jyQ67FfkrhU5B5SWg6F8I10JyBqyRtomUu4UprxAFmIIc8AvwPFq8/xn
   kghiNYWFxw9zn8vLxN3rZJJep8tWUFVJnkihqEZ4HLVzQ+e3t//XSZORH
   lbCel5SwUn8qIAC5VcheOXCUowmQsVJ8zTowxLdv7LaQ/T7KNjx+y0WOK
   +sWc/7k8xfpn4W5gYEReH8y0n98HwDrdYDeh3+oUpK3+Gd4h6q+0SPkmR
   E5sRz3E03Kv9OyliYSS2s4VjCCK2YqnC1wUV4tBWVxUhebpnvFTMGtXlB
   FPzFsq0UafZjG5uR9X9VjGWIWN6vgh/Ho5Axn/SNY7mE+aBz5RRaR1+zZ
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 4 May 2023 10:30:26 +0200
Subject: [PATCH v2 1/2] regulator: Add bindings for TPS6287x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
In-Reply-To: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683189034; l=1836;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=4aeTCaWo/RTTY36JuX2Zpeu7oe4DVZX7ahi9lgZVubM=;
 b=xCkCxU+jf4s0sABAeOhqYfs/cvI+dUupZQzy50IEuG9vdG6aHVVAMRwnIltl2WRQx2lv1eCzg
 qgGiK/lmFajBkU+tM2DELMWMsHy0nOqUDAeYD5r/1kbWizBz+VV8lpP
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
regulators.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 .../devicetree/bindings/regulator/ti,tps62870.yaml | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
new file mode 100644
index 000000000000..32f259f16314
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
+
+maintainers:
+  - Mårten Lindahl <marten.lindahl@axis.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,tps62870
+      - ti,tps62871
+      - ti,tps62872
+      - ti,tps62873
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      "vout":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@41 {
+        compatible = "ti,tps62873";
+        reg = <0x41>;
+
+        regulators {
+          vout {
+            regulator-name = "+0.75V";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <1675000>;
+            regulator-initial-mode = <2>;
+          };
+        };
+      };
+    };
+
+...

-- 
2.30.2

