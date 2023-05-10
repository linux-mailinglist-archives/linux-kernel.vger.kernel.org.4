Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858DA6FE25A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEJQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjEJQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:23:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397E7DB9;
        Wed, 10 May 2023 09:22:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9660af2499dso1056079666b.0;
        Wed, 10 May 2023 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735778; x=1686327778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlvpAxn2oFm+TkdV9OynILOXrU1O7YisNtXsSxDupkw=;
        b=pZ/dvckVTItDtnZRaKV0wHYX2IxgHlX/5x5Pe9dWXZZjMFqOErKcK/iNDrn6IQ3GTi
         QfanJxzThwJwHpZwnwcOj5127PLwFWSll76jdPMeGjeYxzlzArV3G2tE6KhikepFMSLd
         JKmQIZ1kcXX06B+qlUxQzL8waONWy1i7EmUpgtN4hx6KLkHdhU8GD+QMWMmxeIvKa4Vr
         dYwz6tMgcNUiARd8FWQsLZexZ1HOmtu5gQy9vNsrRAOP3W14KRjSBQHxKypTl/9aWjnA
         C4SMbY7/etkDV3S8/YzFSVYoFfVF0+2NA7BlWmCcLCweZzzTdAOy6FkyqY3a42LNoz7U
         0wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735778; x=1686327778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlvpAxn2oFm+TkdV9OynILOXrU1O7YisNtXsSxDupkw=;
        b=gr9Ct2U/k4Nar+xGyK+pxvTp0wsAQEbcFcZ6ujQOO/nIu13wMQSYn6pkfD0mseeKX6
         1m8I2fQ3X0kR1nvJJrmPouLC+FeOYT2WvBZKFutDdZjMBBQivbHoAYoiM+O/6aNw0BeR
         WGtjabr7YBdHsvxL6J/2XyfFqreDTpfm4B8OQ2lWNKzkJAyZohOsIMabayatlFRUyPf+
         NMItPCv8O0olKlCWEjPY78NIjIG5DM4aVBh2QWNW+J40d4Fs7RzJr7w+ZySYvkg8EmZe
         ESuipbMKqmhkrWRmnqgAdcEjRnXMRk5pp9Jr7ByjX8DNLSQkYrgzrmjk2zr4LxTPVueo
         Duhw==
X-Gm-Message-State: AC+VfDxuctYZelJYQtrQ5OrD3yGUW4t/1CrRs0jJk4jlyftRqM5zGDce
        o/fRtxPltgdIS60233BupXbwJ30Roq9PDZHv
X-Google-Smtp-Source: ACHHUZ4AyobTHqsPgwZxX3LWOR2UVZET6TD8DFVi4D6N3vCWquYfcU5ZyhDjqUX9SBF3GxNB/wyCVQ==
X-Received: by 2002:a17:907:724e:b0:961:8fcd:53c9 with SMTP id ds14-20020a170907724e00b009618fcd53c9mr17237360ejc.39.1683735778105;
        Wed, 10 May 2023 09:22:58 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id m28-20020a17090677dc00b00947ed087a2csm2890149ejn.154.2023.05.10.09.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:22:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        beanhuo@micron.com, nipun.gupta@amd.com, linus.walleij@linaro.org,
        mwen@igalia.com, bvanassche@acm.org, arnd@arndb.de,
        ogabbay@kernel.org, linux@zary.sk,
        jacek.lawrynowicz@linux.intel.com, geert+renesas@glider.be,
        benjamin.tissoires@redhat.com, masahiroy@kernel.org,
        yangyicong@hisilicon.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv4 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
Date:   Wed, 10 May 2023 18:22:42 +0200
Message-Id: <20230510162243.95820-4-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162243.95820-1-m.zatovic1@gmail.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO bitbanged Wiegand controller requires definitions of GPIO
lines to be used on top of the common Wiegand properties. Wiegand
utilizes two such lines - D0(low data line) and D1(high data line).

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
new file mode 100644
index 000000000000..df28929f6dae
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO bitbanged Wiegand interface devicetree bindings
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description:
+  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
+  lines.
+
+allOf:
+  - $ref: /schemas/wiegand/wiegand-controller.yaml#
+
+properties:
+  compatible:
+    const: wiegand-gpio
+
+  data-hi-gpios:
+    description: GPIO used as Wiegands data-hi line.
+    maxItems: 1
+
+  data-lo-gpios:
+    description: GPIO used as Wiegands data-lo line.
+    maxItems: 1
+
+required:
+  - compatible
+  - data-hi-gpios
+  - data-lo-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand@f00 {
+        compatible = "wiegand-gpio";
+        pulse-len-us = <50>;
+        interval-len-us = <2000>;
+        frame-gap-us = <2000>;
+        data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+        /* devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b7e546572e8..915cb36e5b2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22704,6 +22704,11 @@ F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 F:	drivers/wiegand/wiegand.c
 F:	include/linux/wiegand.h
 
+WIEGAND GPIO BITBANG DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.40.0

