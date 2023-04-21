Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AB6EAE37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjDUPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjDUPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:43:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756F8C14D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f4214b430aso1202004f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682091809; x=1684683809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhninvCfwM3cEyNcZ4WVCLboSbKUZEfNvggheMtKI8=;
        b=qq5fZeLPGJBiR9WhxWVr/J2CJptqhk9VO5SyqMuOtE/wlt0cn3bA5tQnKH7Fzvp8+t
         mUSsTPeg36zmG9mmFLDh6jBXWURqB90UmXSIkSxoF4c7IDP1MH8KxDGY1+VRnsi3gLYU
         zMKDZgKWr5HuGtUMzABagGDObqud77iPIHM98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091809; x=1684683809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGhninvCfwM3cEyNcZ4WVCLboSbKUZEfNvggheMtKI8=;
        b=PyAgFv4xtpzQ+oMhXAVgDtHfQetMvMRsGSQSleWQ3fqVfAEObj9acyWEpVYmFXWLLE
         TqnG0RAWalUgqM53z4e918AfXS+4+icZK4yNyVFDHc08nVOcuUJFk/lcUFqpv/i8TQ2l
         DlhdDZN8rHydPha3Oiz7M/KfHLBr0N0aL/x/BVYSbafCHjrXBKvhOW+fpk8m0ySRQCtj
         8cinyx4gkyOfEw01nZd1xqkNAZe5MpuvhuSrqbwmO08heam5Z4xqLFC3RXGkKOCdwURC
         SHNFuaUz3MGMe8Aad6sqKOJLjE1XSof09vFcqFDbMMEdPoL0yk4bZEgJnmrO6F6g6CZw
         MSrw==
X-Gm-Message-State: AAQBX9f0Dx1ZNot42W6DWq5+qsr6M0Mvzao/BlZCdq6/DEvBUDCDsmLM
        dIQhR0yEFoDsSZ80qOIdvTMf/K3Sm0yk2SMsldxwTg==
X-Google-Smtp-Source: AKy350bNOn0XaJOZbHF/mKa+8yWb9j1RXhwzD+mFTe+LakHPYoh+l9jh6N7W7PRZUGF+DcSi/r7iFw==
X-Received: by 2002:a5d:4147:0:b0:301:8080:a8fa with SMTP id c7-20020a5d4147000000b003018080a8famr4768749wrq.27.1682091809492;
        Fri, 21 Apr 2023 08:43:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.127.129])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm4651609wrw.79.2023.04.21.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:43:28 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/7] dt-bindings: display: panel: Add synaptics r63353 panel controller
Date:   Fri, 21 Apr 2023 17:43:02 +0200
Message-Id: <20230421154308.527128-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add documentation for "synaptics,r63353" panel.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../display/panel/synaptics,r63353.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
new file mode 100644
index 000000000000..13e6ed39e124
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/synaptics,r63353.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics R63353 based MIPI-DSI panels
+
+maintainers:
+  - Michael Trimarchi <michael@amarulasolutions.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sharp,ls068b3sx02
+      - const: synaptics,r63353
+
+  avdd-supply: true
+  dvdd-supply: true
+  port: true
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+required:
+  - compatible
+  - avdd-supply
+  - dvdd-supply
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "sharp,ls068b3sx02", "synaptics,r63353";
+            reg = <0>;
+            avdd-supply = <&avdd_display>;
+            dvdd-supply = <&dvdd_display>;
+            reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mipi_dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.32.0

