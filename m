Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5E5FA1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJJQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJJQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:30:52 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A957BFC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:30:50 -0700 (PDT)
Date:   Mon, 10 Oct 2022 16:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665419448; x=1665678648;
        bh=cjMkhQ7NUxCP/REarhtYFMEFiZDBTs3pv/wGJ6xTeM0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=XKvIJT3fs45Sig4evbPVNrjheipJCfYv0nUD4JqmtDrcQ25MlhTXbKR+PB6hOupul
         Tn6+C6z1IjG2zodxWXV4dxLq7f6/QdPjZUIyWBvnV38lwP2YnbGTgsSPIHvXNai4K9
         mZp0KkgPQOe1PsGNbPAy5U9oUqDN1h6F98uVxh6I=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>
Subject: [PATCH v6 1/2] dt-bindings: input: document Qualcomm PMI8998 haptics driver
Message-ID: <20221010162945.1325770-2-caleb@connolly.tech>
In-Reply-To: <20221010162945.1325770-1-caleb@connolly.tech>
References: <20221010162945.1325770-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for qcom PMIC PMI8998 haptics driver.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../bindings/input/qcom,pmi8998-haptics.yaml  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pmi8998-ha=
ptics.yaml

diff --git a/Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.y=
aml b/Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.yaml
new file mode 100644
index 000000000000..9f51c527595c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,pmi8998-haptics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998/PM660 Haptics
+
+maintainers:
+  - Caleb Connolly <caleb@connolly.tech>
+
+description: |
+  Qualcomm SPMI haptics is a peripheral on some QTI PMICs. It supports lin=
ear resonant
+  actuators and eccentric rotating mass type haptics commonly found in mob=
ile devices.
+  It supports multiple sources of wave data such as an internal buffer, di=
rect play
+  (from kernel or userspace) as well as an audio output mode.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,pmi8998-haptics
+          - qcom,pm660-charger
+          - qcom,pmi8996-haptics
+          - qcom,pmi8941-haptics
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: short
+      - const: play
+
+  qcom,wave-play-rate-us:
+    description: |
+      Wave sample duration in microseconds, 1/f where f
+      is the resonant frequency of the actuator.
+    minimum: 0
+    maximum: 20475
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - qcom,wave-play-rate-us
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interrupt-controller/irq.h>
+
+      spmi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pmi8998_haptics: haptics@c000 {
+          compatible =3D "qcom,pmi8998-haptics";
+          reg =3D <0xc000>;
+
+          interrupts =3D <0x3 0xc0 0x0 IRQ_TYPE_EDGE_BOTH>,
+                      <0x3 0xc0 0x1 IRQ_TYPE_EDGE_BOTH>;
+          interrupt-names =3D "short", "play";
+
+          qcom,wave-play-rate-us =3D <4255>;
+        };
+      };
--
2.38.0


