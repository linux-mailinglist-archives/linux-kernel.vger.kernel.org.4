Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78464B0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLMILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiLMILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:11:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD831901B;
        Tue, 13 Dec 2022 00:10:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso5785979wmp.3;
        Tue, 13 Dec 2022 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDknBfWThlh7welb6FJ9uvH/zXOQlTwHmX+vFXdoENA=;
        b=KfH6yKYKfeCnzkWuXUKr3VKDFbDQ/8X4099zjnwMewFhOOCDxbXH0rHshNaifHWe8A
         0SWaeCr/xrmTwLPu6exuTBWKHd/Dt9W09i0PmRBUXXhWoTO8+qD0fwKnofQtw/eHcbMk
         jW+rQdxNZGDg8qkculzu7TsS8K4irc3QHiPeKQDDZaUswss95suA3aBlaAsvY+JQnXG/
         klxx43vu0vn6vKEjKFP4nDL7O0r2zEBQ1ieWp902xhuKxoX7QPXObzqQCab0CKAt4/8g
         KEHA9jBmYQSfxr9JPGHpEqYUGuGssTnEDTCprQh9hregkihYWVL0TYpb+uJ+AhamOr+x
         bHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDknBfWThlh7welb6FJ9uvH/zXOQlTwHmX+vFXdoENA=;
        b=yQo/399uzOU4eqKw5zoBb2QQaEtV2DFOL+lzOJQ9hYRBAHXX6QxFA7X+4Ont/6MmhO
         N6Dqoib6S0zjGEj4PGAeFsfaQrKnaqN6RJ3gE59aI3gmMIw5tnRv1OyNjpjZ61nsAE1f
         ESS9GAHXlqChyTWyhmrpc33i2F5k0WyrOjhDqvAmwp7AQE3QETXiryl4L4fM3nYn/QDv
         QCqbFTnyPuoH3seQhO4pP6ZHu2h5ybp62fRe6rPyncand6gNoY3TRGi25S8QyK3dOv2t
         j6XBVetr5xaIqTUct/6IeRxDf2twQH60QSNRVClzqeS2o1ZDUj65LYkzP7kSxBEEmoVY
         Q4uw==
X-Gm-Message-State: ANoB5plwzpzO52ZNND65q8AwHEozHZH79vhaz4YvF+19JIEINr2vjjbs
        /pUNdNZDTk8n9qQT+J6erF4EqgYiIng=
X-Google-Smtp-Source: AA0mqf7/mrQOPc2qxM2idtmGvB70VsFboYToPO3P2J37bUuVGtKAgT9SKu3Y5TDEybJUFJZdMIz3Aw==
X-Received: by 2002:a05:600c:54e2:b0:3d2:2392:33e6 with SMTP id jb2-20020a05600c54e200b003d2239233e6mr6251042wmb.40.1670919056758;
        Tue, 13 Dec 2022 00:10:56 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c205900b003a6125562e1sm11585047wmg.46.2022.12.13.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 00:10:56 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Tue, 13 Dec 2022 09:10:34 +0100
Message-Id: <20221213081034.14226-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213081034.14226-1-cbranchereau@gmail.com>
References: <20221213081034.14226-1-cbranchereau@gmail.com>
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

Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
interface.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/display/panel/auo,a030jtn01.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
new file mode 100644
index 000000000000..fb2aef0061e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/auo,a030jtn01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AUO A030JTN01 3.0" (320x480 pixels) 24-bit TFT LCD panel
+
+description: |
+  The panel must obey the rules for a SPI slave device as specified in
+  spi/spi-controller.yaml
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: auo,a030jtn01
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
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
+    panel@0 {
+      compatible = "auo,a030jtn01";
+      reg = <0>;
+
+      spi-max-frequency = <10000000>;
+
+      reset-gpios = <&gpe 4 GPIO_ACTIVE_LOW>;
+      power-supply = <&lcd_power>;
+
+      backlight = <&backlight>;
+
+      port {
+        panel_input: endpoint {
+          remote-endpoint = <&panel_output>;
+        };
+      };
+    };
-- 
2.35.1

