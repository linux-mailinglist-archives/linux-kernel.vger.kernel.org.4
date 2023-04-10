Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C776DC904
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDJQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:02:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C31E63;
        Mon, 10 Apr 2023 09:02:06 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7606d6a2aa5so2412239f.1;
        Mon, 10 Apr 2023 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142525; x=1683734525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml18rVYykM8RSPcNS38Utyfp7oGrBURSiK5dX/uCCMg=;
        b=Xb7DyguBz/havimHm+lI28ZuxYeIjMZcSFeL8Y5Tzq9jtTT2kGY5wHzMgomybXdwgw
         SGm8NxbqdmCz2JHdqkS66oSrPtgGsonTFCLNtx7eYUi3HQ1EktK1JhIITc9MEy04/t1N
         zSYsa1V1lX7fqgOrwYpMKlb3gs5yjvudfbDVmaTQ+IWBiHJnC1zrVIs20hUSWMaxaSJH
         N5v3TofZESwUNbDahV9Qndj+xuqpnHwI/7VUX8X8IytBtNSavPN5IPrOVEjUsJCs7hnd
         WyVUxVRqyxbqdegI8n/u5ceifFhcvFBiuLZk8QkpXt8ikLMVXDkqbqTBi/vXZI+O0KaS
         DWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142525; x=1683734525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml18rVYykM8RSPcNS38Utyfp7oGrBURSiK5dX/uCCMg=;
        b=3WZVN1YQvrmpMDsWScnYoKdynwryM+sWm+51Hl6g3KyMcdeHlImKecJ5jLzoYfMf8k
         x07s2comb00NZNEO0Db9XZk7Li6HI6J3wlGDmzEXnUbh6P60JwuVyVVy8V6s6U/58yPA
         c7ZsCmaU8YTMqgMFC3S80kRWnfgD2QEwkVl5ObvU9xxV6OctZqezjuYKc8KXFguAUb4l
         r8KsEjkRz4Nk5UiIi0OcITvOS3qY2tO15nNx+BNu9U/KMz5f1h752wqex/4Drz5mJlXJ
         Wrtfpt+2U98USPAW8iuN+ZdZkoR5vN7t0IhQjVBusaIexbd+2zlpy0vExU9UbptEo16U
         rHIQ==
X-Gm-Message-State: AAQBX9ePaRH1S2j6KgvdMWeRbgz0doeNLkiSm/mOiOwHM+0YKR4F1XFo
        IHe9DnzxQwYdcp5v5X3RiWw=
X-Google-Smtp-Source: AKy350Z//jb9iMw3Y2hMFp4YCE1amp7CtwmW4ptJyAQl/zovn0w+U9N1IIl/vHh9DLqiYe+YyAevaw==
X-Received: by 2002:a05:6602:89d:b0:760:9027:3501 with SMTP id f29-20020a056602089d00b0076090273501mr182225ioz.0.1681142525680;
        Mon, 10 Apr 2023 09:02:05 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d9a87000000b00746041ecbf9sm3184435iom.39.2023.04.10.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:02:05 -0700 (PDT)
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
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: input: touchscreen: add bindings for focaltech,fts5452
Date:   Mon, 10 Apr 2023 11:01:56 -0500
Message-Id: <20230410160200.57261-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the Focaltech FTS touchscreen drivers.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../input/touchscreen/focaltech,fts5452.yaml  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
new file mode 100644
index 000000000000..f42868293439
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
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - touchscreen-size-x
+  - touchscreen-size-y
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
+        interrupt-parent = <&tlmm>;
+        interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+        avdd-supply = <&vreg_l28a_3p0>;
+        vddio-supply = <&vreg_l14a_1p88>;
+
+        pinctrl-names = "default", "suspend";
+        pinctrl-0 = <&ts_int_active &ts_reset_active>;
+        pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2160>;
+      };
+    };
-- 
2.40.0

