Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2064C83E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiLNLmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiLNLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:41:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3037C20BF9;
        Wed, 14 Dec 2022 03:41:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i7so4365269wrv.8;
        Wed, 14 Dec 2022 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn0MD+1RARDIyxKGqeu2aoKtYrYvz2nkxqNXSob+WEs=;
        b=RsBqv8KfU89PIWVQLJR2lZNNkJKJd9WN9dLEkiSgUorcxwP9t2BLxAFUfep4bYXQL4
         MR0FwQPa5Z9FCjzDmhjNUJ9YPmLepSXfpaDroaJPNHumr+CGTUh6ObgMv5a7ooNbLGKP
         DDUOKq8jcZZAY1WKK9DrlHcJ1QY5TxOKsiq9ziVLamsnqNW9t5qRX9/bHCi3Te6Qwavc
         Lz1z210QnOpO2Tk19d4tu0KQAocxacWTdJtYmWHNdQ8Gi1Khd30GYiV3UaY5h4VNR1uj
         zQv+y2GNY1nDqKF5/6yhC0VhoUjnjWvPRblA7+rL2iEidl1/YUCUT1gEZChSO+1jCip4
         296Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn0MD+1RARDIyxKGqeu2aoKtYrYvz2nkxqNXSob+WEs=;
        b=B0HoBfrgMIjvfG/Xh46xxst3gqjcfdnlt/TetVNZ6Vzs/qOcMt8lLtZDi/Owh+Fc/7
         jHthWdaqrpgZH10GXv9j9HWZWIzyfV+mQfB1fGasszRYSQV86HRFX9c0hGJJerZMzECt
         tcyFlVBxpzd7yA6yDlfEA6AT6mcqg/2n6sm0E4cMaka7+4KOMMqWc7IxZRfwQuDyXF5k
         HbfYc1wPcvTBPsMZpzfvVHLfjCwQqf5mL0nUow19jInx/Wm2Pg5K1qWl9HaRw4nC5UgA
         D1n5PTeOaRy7LTyyfmVSjbfk7bKpnuOw9YpeePgTeu3JOl16vlfqUuxoqtRuIHzXCURp
         /gjQ==
X-Gm-Message-State: ANoB5pl/AzdxB9YxNIcQK+ef46jjRYs1LQlZH1pRMZeQoMhsLKgMqNG8
        gAgCymMtxQtmvHeAegH4nPM=
X-Google-Smtp-Source: AA0mqf5MPV404tH7abuAsdk+a/wLlTUQk8PI8K1FVWpeXk1PazEfGOELFWNhIXxitbl/pIG31Z9QjA==
X-Received: by 2002:a05:6000:137a:b0:242:4209:ea73 with SMTP id q26-20020a056000137a00b002424209ea73mr15426652wrz.28.1671018109528;
        Wed, 14 Dec 2022 03:41:49 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0024258722a7fsm2697405wrg.37.2022.12.14.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:41:49 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Wed, 14 Dec 2022 12:41:42 +0100
Message-Id: <20221214114142.204041-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214114142.204041-1-cbranchereau@gmail.com>
References: <20221214114142.204041-1-cbranchereau@gmail.com>
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

From: Paul Cercueil <paul@crapouillou.net>

Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
interface.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../bindings/display/panel/auo,a030jtn01.yaml | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
new file mode 100644
index 000000000000..6c099eb63434
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
@@ -0,0 +1,61 @@
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
2.35.1

