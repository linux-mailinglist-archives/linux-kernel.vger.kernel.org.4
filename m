Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6176B6425
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCLJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCLJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:33:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160451EBDD;
        Sun, 12 Mar 2023 01:33:09 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b5so3892898iow.0;
        Sun, 12 Mar 2023 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTyur/y1Zf29WY4wvz+mTKnfsVL2wpjYMZL0OKfdL0w=;
        b=ShCVN+kJ9c4PDWZ4tT3jIzBc+VLDVk525D46LB7OMyWTmRBTDNvR2hAOk3zzz7TEaC
         4hwjb5SjaXkubM+LC/BVmEjT3Ov1X3bMnHDaGcIgt2UCnlo+dYFQENvA1BVEuq0Xxi3n
         2UUjMeChogMm2ZBEXxyHqZh1O4B0HotJoku2DC295Tp3vbLNVyld+4dg/eGch517tJ8J
         YUZU1kXmlmP6hXRyHRGol6J41fwdLj75XmBL254bxXMV56afiqUq7OpdjOKSsATbsRwu
         sR5PycdsTfkDWNxya4JIQ0jbh897QeSHPVqevYRwqg08DrooYwhxMEHsfg0KyYAnLW39
         EICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTyur/y1Zf29WY4wvz+mTKnfsVL2wpjYMZL0OKfdL0w=;
        b=2XGpFY/GHC48tMV77PXUE5gElP9o9TGCF35AVC3zZii8UnIxXMOLnBR1zMVNEmXAYb
         Llzuu4OcCevgF4rmJn+MntFGtMroO7IBnqniTy0oemplDAUER+5QyImuVsAbLQDYgjr0
         mFaqf3fDPinrj7JZg1IWinccrM26M9Gzc9ITH5MTHL79XS2g2pv8J+0lhXwClaMKGSqi
         2i+naVxrnz+aOT8MDnJB38wNxNgpLMXS1qznUaQeOOqR0fDJ+41hG9g6txXJDC4pd48C
         K3qjNd3PhiIkAKXONKi3fkNamHVyA0UyBpGbMaXadWfN97CX82gVjHt790Ptlt3R9R8f
         X4Tg==
X-Gm-Message-State: AO0yUKUdcZijIoCFuR3mReyHOwAAVvi9jE+RqRAKIIbaWgVz/LOjx7S2
        B2BoKnjoTjn08VMO1XBX9Ow=
X-Google-Smtp-Source: AK7set8etpHAUJ2iLzj9ZfQzJOpdcOxtbgHBophffrb16+rbZngmJ0rqRJXoNKm0EPk+cxBeCR6ODA==
X-Received: by 2002:a5d:9606:0:b0:74e:8718:a174 with SMTP id w6-20020a5d9606000000b0074e8718a174mr6911103iol.1.1678613588388;
        Sun, 12 Mar 2023 01:33:08 -0800 (PST)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a6bfc07000000b00716eb44b97esm1585031ioh.27.2023.03.12.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:33:08 -0800 (PST)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH 1/5] dt-bindings: input: touchscreen: add bindings for focaltech,fts
Date:   Sun, 12 Mar 2023 04:32:45 -0500
Message-Id: <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the Focaltech FTS touchscreen drivers.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../input/touchscreen/focaltech,fts.yaml      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
new file mode 100644
index 000000000000..07fe595cc9ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/focaltech,fts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech FTS I2C Touchscreen Controller
+
+maintainers:
+  - Joel Selvaraj <joelselvaraj.oss@gmail.com>
+  - Caleb Connolly <caleb@connolly.tech>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - focaltech,fts5452
+      - focaltech,fts8719
+  reg:
+    const: 0x38
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: a phandle for the regulator supplying analog power (2.6V to 3.3V).
+
+  vddio-supply:
+    description: a phandle for the regulator supplying IO power (1.8V).
+
+  focaltech,max-touch-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: max number of fingers supported
+    minimum: 2
+    maximum: 10
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - focaltech,max-touch-number
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    &i2c5 {
+      status="okay";
+
+      touchscreen: focaltech@38 {
+        compatible = "focaltech,fts8719";
+        reg = <0x38>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+
+        avdd-supply = <&vreg_l28a_3p0>;
+        vddio-supply = <&vreg_l14a_1p8>;
+
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&ts_int_default &ts_reset_default>;
+        pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
+
+        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2246>;
+        focaltech,max-touch-number = <10>;
+      };
+    };
-- 
2.39.2

