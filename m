Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F567675C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAUQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjAUQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:24:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E32448F;
        Sat, 21 Jan 2023 08:24:27 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so7819832wmb.2;
        Sat, 21 Jan 2023 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tfkYuI21meii7yISj973iC57fiTGptgMgJGNgDKb0o=;
        b=O4G25ETyycYemeCuoz3CsGecXTPoPCY4f330+vzGk4ZMnHFjrv3QZYz1DWOlxvpond
         nCHYkJM5ZZ0QJcRiNhjW17i4a5nzNBg2MKwD1ffGIf7L9jatiISKT0YXsGP8mAJwV4vS
         Wo6R+7dUO5a9M/DJ0T7amlnAzo2XCQr3uB4CIClGmJo9tFOBTLKwPtdk7NgFsX2IJCZZ
         C5RlWwzfaL2G1sJlE0yhC8Ny8MA17TrpIuMaYJdFUN71tX0aqFN02GfpU6N0P/QI1DRP
         ilmZCxqrY0rE1GMFwpVhg/amIJFupilwcvGo/Lc0H7VZyHhxM41Cvtd2hdlXxzGOaKxl
         lPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tfkYuI21meii7yISj973iC57fiTGptgMgJGNgDKb0o=;
        b=ICYHXeX+HjLcoUkYQsbNNdCXbkwfAF6Sez1LqA48BW1SXB5zqOSfWQwdCxOdoCIZIC
         zLvkHGqLPUafMxZc1Ws77XfC+ziiYJ/kHSCD9Y1JfMZbcBuDvIdvBSb32BuN6KyoLEz8
         n8g7RNIphqi3isRY4LzFE2rCuDUoxlOGPrYJd8LOZjz5dmP0W0xzrqACubY9eVZAy3vS
         IWfl1x/ucDB7qR46ACgKgRysAuQUlkRapNYBLxvWy6XfqOAf9eAcxxCvZLetaARA4uzC
         0nA+LaEDde9OF40l606z844uwSBq8ZaEQtmVHADty3qZT0F5Co5JsyJtnyTiQA9Vq3sa
         x/iQ==
X-Gm-Message-State: AFqh2kor36J4WIsDLAYV4HgMDHJ3NFRUhHJ0Qj0vuLr7gVVUSfOVnmog
        aHCfcwgP6OQroSQsnW+kP9Q=
X-Google-Smtp-Source: AMrXdXusRqsRQrWSXNSka45/GTFvRl22F/EZAXpvUzrkIU9pKB2r77QH+Y9WpwuRH/UB8wS+8Ts6Dg==
X-Received: by 2002:a1c:7417:0:b0:3da:fcd:7dfe with SMTP id p23-20020a1c7417000000b003da0fcd7dfemr26348539wmc.10.1674318264472;
        Sat, 21 Jan 2023 08:24:24 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm5831443wms.38.2023.01.21.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 08:24:24 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Sat, 21 Jan 2023 17:24:18 +0100
Message-Id: <20230121162419.284523-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121162419.284523-1-cbranchereau@gmail.com>
References: <20230121162419.284523-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
interface.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../bindings/display/panel/auo,a030jtn01.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
new file mode 100644
index 000000000000..86c834eb4d98
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/auo,a030jtn01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AUO A030JTN01 3.0" (320x480 pixels) 24-bit TFT LCD panel
+
+description: |
+  Delta RGB 8-bit panel found in some Retrogame handhelds
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+  - Christophe Branchereau <cbranchereau@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: auo,a030jtn01
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "auo,a030jtn01";
+            reg = <0>;
+
+            spi-max-frequency = <10000000>;
+
+            reset-gpios = <&gpe 4 GPIO_ACTIVE_LOW>;
+            power-supply = <&lcd_power>;
+
+            backlight = <&backlight>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.39.0

