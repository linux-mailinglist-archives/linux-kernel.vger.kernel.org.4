Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A36D7E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjDEOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbjDEODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC372AB;
        Wed,  5 Apr 2023 07:01:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so23473376wmq.2;
        Wed, 05 Apr 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJO4cU5jxcnurUOX6f4KDHqm+rWcV3FRe8BNYyMZhTs=;
        b=GZIpSKio8POp9yFYqcy4tTIeg6G75uXC1rI4ORepXnVW7XpXjwXzkb57sYVxYVXpMq
         Jbt9w4pHidyxTVQAo2V6U3cG5lU2mQCqoQ9H8yQ0oLfHLpU8o8DV3KIgREQZYyt8JNxY
         f957Sy1t8LJcEW4ZOI/y+UEu9dTVSmIuSl/kR2U5q0IdfxSFQRMYuCOxmKurAd2+IVWB
         10i/3KGSrNcA2V2UP3PNTp0kp3atWyo5mfPee9+RSBQ4ZftdBAj0cvUY+flnPifhYiqF
         RcYiLCQifela1BYE5qH0EeY+ycaxYtay+YabFiUSeVOG/fsizaRHsG7pYiwfgEgexqgJ
         SOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJO4cU5jxcnurUOX6f4KDHqm+rWcV3FRe8BNYyMZhTs=;
        b=TIgtqibIUf7y+3rtaOnrfSk+c/kVhmGeqKczAyoRCQ9k/mXlGK45K9mzLW/vgZ+iZG
         tOI+v6CtKEQNrKZwQOjNsc3QAFfwGxew7VtZx22WPZGRG+IY0vaLbofSRHmsrlWUafUU
         Ic3QvejoDYgDs30NNKXzxaN48UEICtsiLZ7BC2zVZEPVuGK449R95scQmaaWLKCp7Bhc
         wjDCRXSG1gUf9THoQpgLF2m+g/0T8kb4skSrBXT9nv6Hwgu5cGWYvc5TXF2o/1L4Upb/
         NS6M1WKSSnb/736oDLOvLOX3LBNqs2A/Vr5wBYmKC7vusj/vcs6M4H/8hAxxNtXXEriU
         lNLw==
X-Gm-Message-State: AAQBX9ckE644z6LioMC0IB5/No8ItjG1V2jazPfQKX+TLU4D5MT2wqAJ
        l1RykzokqnceaQn09gZhDeA=
X-Google-Smtp-Source: AKy350aatKyrYZdlVWUDF0Q3KqS0G65RpWo8nbCYld43xcVdeJFQb3zoRkj/yKe0PMdV508v2AI4vQ==
X-Received: by 2002:a7b:c416:0:b0:3ee:6d55:8b73 with SMTP id k22-20020a7bc416000000b003ee6d558b73mr4918297wmi.29.1680703294286;
        Wed, 05 Apr 2023 07:01:34 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm2412383wmq.2.2023.04.05.07.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:01:33 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: iio: dac: add mcp4822
Date:   Wed,  5 Apr 2023 16:01:13 +0200
Message-Id: <20230405140114.99011-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
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

The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821, and MCP4822 are
SPI digital-to-analog converters by Microchip, which have an
internal voltage reference, in contrast to the MCP49xx series
of DACs which use an external voltage reference.

Thus, these need a separate binding, as to not overcomplicate
the mcp4922 binding.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp4822.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4822.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4822.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4822.yaml
new file mode 100644
index 000000000000..c6eaf0079add
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4822.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4822.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4801, MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822 SPI DACs
+
+maintainers:
+  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4801
+      - microchip,mcp4802
+      - microchip,mcp4811
+      - microchip,mcp4812
+      - microchip,mcp4821
+      - microchip,mcp4822
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "microchip,mcp4821";
+            reg = <0>;
+            vdd-supply = <&dac_reg>;
+        };
+    };
+...
-- 
2.40.0

