Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707836457AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiLGKXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLGKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:23:11 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8571743E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:23:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x6so20352303lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRjxOIWtw2A1MKHLuoeh0LkbVWtGv5vFiIYLb5/XtSQ=;
        b=rZdRENrE6r4Q1b4O/BhpOL0KtKFreF4e7Cl3xftxoPmaN4pumEpBESDltQ2k03yUjm
         +MPIIoZWLvUEqlMQpHX1J1k8SwS9Y+x7Pp9DEDiqD9LVOZs+8xYNCBCEVrZsG1kJgwff
         8JZ31bbFN7iXxsNyE8/wZLCu2nXlB00HOvSOzwrwd4l35+jjHgGpgCwSKUx8BmUM4xre
         ANvzMTIMZ4wIEypo2R5ycWSY4TII91gWh57tYomEY/Pg2GRpcV9wSyzFRWbQM5ruCxEV
         wihCcBGhyAK6ApSg0EWV/EJDqQgtkH2fxY1r/Qm1mfPjogpQ7yPjp0Fyw1er+HNoRc6Z
         +qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRjxOIWtw2A1MKHLuoeh0LkbVWtGv5vFiIYLb5/XtSQ=;
        b=p/WdhgCwuOV7GvhOsPKN6DkoAly+2tgTHifSuvysgeBweZHBq0I4aacJ6wb0yqaLF0
         xKOIlc26vewmhVHqSY7JlU1xV68P3Matipz2AkcbIdWvForEglErn2spvuuqwVoo/QHq
         TmJFG5NKm19eklM0OqBlNJsL/+gGx4B4ttoiKdegTW3gi2oBvASoNDulcG8kPHnjOS/C
         2gZc9OT45CnC3Kbh+Yy9bWorEGfGWzUXJOR/GYPb3H7PbOCC6RVwFOd9DZgL1BtPcEUl
         klSDa8LutX9srlGA/nKz1kv6Wkvakpf6f5TKcKycNm5f9zpdBBdm9XXXC9l6jjIcIo5+
         f7Pw==
X-Gm-Message-State: ANoB5pnce41eFyU9uBNQ+4jPuCdBnMit+JkEfRxRTwisaLu8Ce2zkZKs
        tQZVG9T4YM9egjD/7xWevt2U9w==
X-Google-Smtp-Source: AA0mqf6ST+jI5h6I6J4YO2MV4dEwoINLQIMmBJ+UqP9esDj73j09qKiso3SdFz92qJp2xkJbaX/7eA==
X-Received: by 2002:a05:651c:b0e:b0:277:3ca2:dac6 with SMTP id b14-20020a05651c0b0e00b002773ca2dac6mr26866792ljr.143.1670408588505;
        Wed, 07 Dec 2022 02:23:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bu31-20020a056512169f00b00499b27a329esm1953183lfb.300.2022.12.07.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:23:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 7/9] media: dt-bindings: cec-gpio: convert to DT schema
Date:   Wed,  7 Dec 2022 11:22:51 +0100
Message-Id: <20221207102253.26663-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207102253.26663-1-krzysztof.kozlowski@linaro.org>
References: <20221207102253.26663-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert HDMI CEC GPIO bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/cec-gpio.txt    | 42 -----------
 .../bindings/media/cec/cec-gpio.yaml          | 73 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 74 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cec-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-gpio.yaml

diff --git a/Documentation/devicetree/bindings/media/cec-gpio.txt b/Documentation/devicetree/bindings/media/cec-gpio.txt
deleted file mode 100644
index 47e8d73d32a3..000000000000
--- a/Documentation/devicetree/bindings/media/cec-gpio.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* HDMI CEC GPIO driver
-
-The HDMI CEC GPIO module supports CEC implementations where the CEC line
-is hooked up to a pull-up GPIO line and - optionally - the HPD line is
-hooked up to another GPIO line.
-
-Please note: the maximum voltage for the CEC line is 3.63V, for the HPD and
-5V lines it is 5.3V. So you may need some sort of level conversion circuitry
-when connecting them to a GPIO line.
-
-Required properties:
-  - compatible: value must be "cec-gpio".
-  - cec-gpios: gpio that the CEC line is connected to. The line should be
-    tagged as open drain.
-
-If the CEC line is associated with an HDMI receiver/transmitter, then the
-following property is also required:
-
-  - hdmi-phandle - phandle to the HDMI controller, see also cec.txt.
-
-If the CEC line is not associated with an HDMI receiver/transmitter, then
-the following property is optional and can be used for debugging HPD changes:
-
-  - hpd-gpios: gpio that the HPD line is connected to.
-
-This property is optional and can be used for debugging changes on the 5V line:
-
-  - v5-gpios: gpio that the 5V line is connected to.
-
-Example for the Raspberry Pi 3 where the CEC line is connected to
-pin 26 aka BCM7 aka CE1 on the GPIO pin header, the HPD line is
-connected to pin 11 aka BCM17 and the 5V line is connected to pin
-15 aka BCM22 (some level shifter is needed for the HPD and 5V lines!):
-
-#include <dt-bindings/gpio/gpio.h>
-
-cec-gpio {
-	compatible = "cec-gpio";
-	cec-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-	hpd-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-	v5-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
new file mode 100644
index 000000000000..19169d58316a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
@@ -0,0 +1,73 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cec/cec-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDMI CEC GPIO
+
+maintainers:
+  - Hans Verkuil <hverkuil-cisco@xs4all.nl>
+
+description: |
+  The HDMI CEC GPIO module supports CEC implementations where the CEC line is
+  hooked up to a pull-up GPIO line and - optionally - the HPD line is hooked up
+  to another GPIO line.
+
+  Please note:: the maximum voltage for the CEC line is 3.63V, for the HPD and
+  5V lines it is 5.3V. So you may need some sort of level conversion
+  circuitry when connecting them to a GPIO line.
+
+properties:
+  compatible:
+    const: cec-gpio
+
+  cec-gpios:
+    maxItems: 1
+    description:
+      GPIO that the CEC line is connected to. The line should be tagged as open
+      drain.
+
+  hpd-gpios:
+    maxItems: 1
+    description:
+      GPIO that the HPD line is connected to.  Used for debugging HPD changes
+      when the CEC line is not associated with an HDMI receiver/transmitter.
+
+  v5-gpios:
+    maxItems: 1
+    description:
+      GPIO that the 5V line is connected to.  Used for debugging changes on the
+      5V line.
+
+required:
+  - compatible
+  - cec-gpios
+
+allOf:
+  - $ref: cec-common.yaml#
+  - if:
+      required:
+        - hdmi-phandle
+    then:
+      properties:
+        hpd-gpios: false
+
+  - if:
+      required:
+        - hpd-gpios
+    then:
+      properties:
+        hdmi-phandle: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    cec {
+        compatible = "cec-gpio";
+        cec-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        hpd-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+        v5-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 05acbaecef52..197351d3bb57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4848,7 +4848,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/cec-gpio.txt
+F:	Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
 F:	drivers/media/cec/platform/cec-gpio/
 
 CELL BROADBAND ENGINE ARCHITECTURE
-- 
2.34.1

