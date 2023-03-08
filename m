Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA16B0368
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCHJw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:52:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7B9887E;
        Wed,  8 Mar 2023 01:52:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a25so63523243edb.0;
        Wed, 08 Mar 2023 01:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678269139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvxrCA9BaAG+0IE8vbijjkrf+m1rC4XBRDE72BFYjMw=;
        b=lWNkP1ooMPRZoylzLyqFWN3EMdv5XrHCnzoG0T39cM0EOVRFq9/TBoyEagUX4HvTfx
         3WQ8Himlp0WLq4cGuJboNk5OyzuevKoDSzDG1Jkbt5bZ2fR1YVTUvvJ7s33eSsIADtW4
         iYHUYU9PAgWjjV+qfDbNyAAjfKGmZTYUPJIlzSX75b/xqBa53fGneLmudo+CwWGXfyL7
         AVZDeHn1FJA4AjA9wEM6mrSrJZDpM36x1IvkMALOPopK/Guf8ieTV//Z9OMGGPAiz0iL
         C7NNFU8LC8d7Q8e/v1oEEb+KNK3MijqYlfKIW23m9bwbA8kuN6uHP8GZ/PEHdeziOocO
         H+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvxrCA9BaAG+0IE8vbijjkrf+m1rC4XBRDE72BFYjMw=;
        b=WMDQnBYfCd3wo4zJIK2ZUbMKLtCqmMb/opCeM5pLHprEuf0YGGyvmJNIuPwcYJegFm
         sv+BpThZm0iYsdA6ztjuz5Qkpi8ruQs5roMTo1jWGPEvGLcSPwrx5o5u4uLZEizaZ2eK
         mRcHp/iAXNYnFURr4icFEUbK8QXahqPnFpjnPAEZjNpXMiHPiPA7KEdRc2HuhYYVVhSx
         Y8Qax74P2+pYEZUnmXlZH3DfZ4+uPa3cLnqBlKYWzO76OOzqWORFNWUhzxujUhUZe00U
         dzgNCwHuftAPfbrv8EOmyrzylUj9/BN3kkYAoHLtNox7894LmM2FjaWRz8LcNP4fj9yK
         /aog==
X-Gm-Message-State: AO0yUKUSoWG4k3QZLZtjLm/TK77lXPH6irxWwyquq9T81C4LopgWEKck
        O+PzJMa1JRE/pLGnDLpXGyM=
X-Google-Smtp-Source: AK7set+lxZXmQmw0HYO/RzGCAdd5cxQw0l9GiyyZ5L7AoIC2YmbOKk9Xn85QHIGgOl23Kczc8K5Duw==
X-Received: by 2002:a17:907:6e15:b0:8b1:75a0:e5c6 with SMTP id sd21-20020a1709076e1500b008b175a0e5c6mr23039270ejc.18.1678269138924;
        Wed, 08 Mar 2023 01:52:18 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b008d8f1b238fdsm7369177ejq.149.2023.03.08.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:52:18 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Ldd-Mlp <ldd-mlp@list.ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: media: i2c: add lm3560 binding
Date:   Wed,  8 Mar 2023 11:52:08 +0200
Message-Id: <20230308095209.14700-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308095209.14700-1-clamor95@gmail.com>
References: <20230308095209.14700-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/media/i2c/ti,lm3560.yaml         | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml b/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
new file mode 100644
index 000000000000..b3c2ccb83a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ti,lm3560.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3560 Synchronous Boost Flash Driver
+
+maintainers:
+  - Daniel Jeong <gshark.jeong@gmail.com>
+  - Ldd-Mlp <ldd-mlp@list.ti.com>
+
+description: |
+  The LM3560 is a 2-MHz fixed frequency synchronous boost
+  converter with two 1000-mA constant current drivers for
+  high-current white LEDs. The dual highside current sources
+  allow for grounded cathode LED operation and can be tied
+  together for providing flash currents at up to 2 A through
+  a single LED. An adaptive regulation method ensures the
+  current for each LED remains in regulation and maximizes
+  efficiency.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,lm3559
+          - ti,lm3560
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  ti,peak-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 0x20, 0x40, 0x60]
+    default: 0x60
+    description: |
+      Peak current can be set to 4 values 1.6A (0x00),
+      2.3A (0x20), 3.0A (0x40) and 3.6A (0x60).
+
+  ti,max-flash-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 32
+    maximum: 1024
+    default: 1024
+    description: |
+      Maximum flash timeout in ms with step 32ms.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  "^led@[01]$":
+    type: object
+    description: |
+      Properties for a connected LEDs.
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      ti,max-flash-current:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 62500
+        maximum: 1000000
+        default: 1000000
+        description: |
+          Maximum current in flash mode in uA with step 62500uA.
+
+      ti,max-torch-current:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 31250
+        maximum: 250000
+        default: 250000
+        description: |
+          Maximum current in tourch mode in uA with step 31250uA.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash-led@53 {
+            compatible = "ti,lm3559";
+            reg = <0x53>;
+
+            enable-gpios = <&gpio 219 GPIO_ACTIVE_HIGH>;
+
+            ti,peak-current = <0>;
+            ti,max-flash-timeout = <1024>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            led@0 {
+                reg = <0>;
+
+                ti,max-flash-current = <562500>;
+                ti,max-torch-current = <156250>;
+            };
+
+            led@1 {
+                reg = <1>;
+
+                ti,max-flash-current = <562500>;
+                ti,max-torch-current = <156250>;
+            };
+        };
+    };
+...
-- 
2.37.2

