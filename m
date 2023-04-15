Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A316E2E65
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDOCCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDOCCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB94C39;
        Fri, 14 Apr 2023 19:02:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f80e173ecso1839337b3.0;
        Fri, 14 Apr 2023 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524153; x=1684116153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSpKeQKbhPIuHkn19PAjkNbzGcgOHPtdtSZPV+11/j8=;
        b=l3tVvOds1VFbZlhPgwxCmPWtQ3Lx3VH7I5ydqaRjSlnbqL8ZG4+YOr1uqVHwAsYANn
         rMdEC3NZQGw2gpMqb28PP/vYxtcrKLzqOh+eUX7FDPPDUhKE7KMBpVVORh4JQqAHBOI/
         6vRJ/j25xqO7ydDmiv8O5JgC4xCXHkH/B1oui7dA/sfTQb5SibNfMZRz832ExUzqT4mk
         02wcVKQvrLYn1rvt/CnE32Q4XBnC0kOIdD3/7bkf/A50+enLGkAZr6A2Q1Zsfqbvuq2W
         Zs3VFq0I/9ctT96N6zX84kKk4QkNDpWiIQxbW+1UutM7JbvtbSr0ie6ZuzPTMGCatdVO
         0i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524153; x=1684116153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSpKeQKbhPIuHkn19PAjkNbzGcgOHPtdtSZPV+11/j8=;
        b=BcTZovTztujEWCD1Tn80WpghKPSXNsxrUM4+byGYHZ+Ou0S38JH1Vt+zwHEnpNRh/+
         e94/eILeIjjGMLFFVQWT/RzY+4Cc7WYy1cblw82W4YrvLCbXfwKWlDDvYYpmhm/IdMMJ
         CPXcgeELwKTXiX4BqfHUOF7OjCuptCq9b/rlIz+A7mGzfQNjbzoHS6pbwbo9dQ14J8p1
         AVmUSwew6kO9UPejd/M0wtcG0zqrR3YINtBKR1a7WaGKLEENhtfX3GCkZIOv+ZZY5hZy
         sKZGB43ZTARiWv+3jDhs9AfcP3j1YelBqgaiLxvnWsg113Gx0lI8FO2OAPDvPwUQ1PxJ
         /JJQ==
X-Gm-Message-State: AAQBX9cbQUy3RbunXo2N41ewfIZBSFw9wWwllqYcIyqJPdQtOBPTxUcx
        t6NUdUJMWtYD6VzCJM4Ivqc=
X-Google-Smtp-Source: AKy350aldaow3E3o/EVe7ZE++/ivGz2yDQ+bEqtAE7dnwTbSQErzo4UM2iGL4hacXHriZw9NPc4ZhA==
X-Received: by 2002:a81:1752:0:b0:54f:8af0:7328 with SMTP id 79-20020a811752000000b0054f8af07328mr3808101ywx.3.1681524153473;
        Fri, 14 Apr 2023 19:02:33 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:33 -0700 (PDT)
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
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: input: touchscreen: add focaltech,fts5452 touchscreen
Date:   Fri, 14 Apr 2023 21:02:18 -0500
Message-Id: <20230415020222.216232-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Focaltech FTS touchscreen driver.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../input/touchscreen/focaltech,fts5452.yaml  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
new file mode 100644
index 000000000000..28270dc5ed67
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/focaltech,fts5452.yaml#
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
+
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
+    description: regulator supplying analog power (2.6V to 3.3V).
+
+  vddio-supply:
+    description: regulator supplying IO power (1.8V).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@38 {
+        compatible = "focaltech,fts5452";
+        reg = <0x38>;
+
+        interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+        avdd-supply = <&vreg_l28a_3p0>;
+        vddio-supply = <&vreg_l14a_1p88>;
+
+        pinctrl-0 = <&ts_int_active &ts_reset_active>;
+        pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+        pinctrl-names = "default", "suspend";
+
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2160>;
+      };
+    };
-- 
2.40.0

