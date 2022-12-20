Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD9652019
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiLTMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiLTMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:01:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39804D2F2;
        Tue, 20 Dec 2022 04:01:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v7so8562814wmn.0;
        Tue, 20 Dec 2022 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GccDBeJZjaH9XCmg3AAu3a9rt4MbZnC2S1dc4W7SU5o=;
        b=Fk5ZJdVFnJ7r2G0RFverr6ublZxy8NcXwcgNGsXo1b9n8bpZhcR4c2itnoxmq9ci/M
         mS82N1AUGIzKdToiR6D9eeSalfgBYVUBxPYUq4M3r3/E/AokqIDyVPfsloY0rcY1Z4+s
         4Ot9cwW8Kt/Sz+HqnJ5bCTUFguLFAJEn9lDUrooMZDpYLM0E55ZILwp1RFhl7yMM6+JP
         dDB2GgNQL5o2IOrcfy9KeKpki+RdqB8owi/khENc3kKGOgBsagGBPxhP4/JGAh3L3WYX
         KJyqbBua9QdrNSKRluP17z/BLHd78TDcZYTZxpA02bTr7g8HkFOyWe4cDkC8XFcdklJT
         cM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GccDBeJZjaH9XCmg3AAu3a9rt4MbZnC2S1dc4W7SU5o=;
        b=QbmE8oKBcIkNKzTT1z7d7evWFz/85e6yueO+7Sdu3JHwrMvd6D99qNhwDUYFEG8vvI
         qeHCydNcMokKQrbhdm+h3Dqz9ERXhC/QY+U8Z+Nz+hRuDbGR8KtYqgNbIzn6M/qx9OGI
         3MOXF9uJYSo89PpuwrStuYy/wEj5MUqv4P3N/MtOo16Pe2vylpsaHeb/j09U9vt4s8Up
         9Htg/NdHm10IOfaOI1+z5F1HdIj0tN8/FGJJX3QbBIA4FPgFJ2Y04M1Tqoe9ehEsctFe
         GymvVL1nnqBMDMKVdjcihL7XzC9GxBgSkJ45hSV/bgka7ADoJfZ6GbQ1YU09lcLhj3Rt
         sqpw==
X-Gm-Message-State: ANoB5pk8/9oqzg725z1zJrEtXtoOIt1rYvz4JqU41+wUQTGZ40Ez381P
        c8jsqGDHnqsgEu5O0CKXlxPqWE1KWb0=
X-Google-Smtp-Source: AA0mqf6qCxOt/snVy2o1Qpdg+T6cqG4NvfpldAZS0aFU2zO0U/4UPj7DnHR8IayPG4+Mh+7wc1Q87A==
X-Received: by 2002:a05:600c:22ca:b0:3d1:ee97:980 with SMTP id 10-20020a05600c22ca00b003d1ee970980mr46536595wmg.7.1671537676543;
        Tue, 20 Dec 2022 04:01:16 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b003d04e4ed873sm22843188wma.22.2022.12.20.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:01:16 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Tue, 20 Dec 2022 13:01:08 +0100
Message-Id: <20221220120108.481554-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220120108.481554-1-cbranchereau@gmail.com>
References: <20221220120108.481554-1-cbranchereau@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/auo,a030jtn01.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
new file mode 100644
index 000000000000..0d1e6b45b0f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
@@ -0,0 +1,54 @@
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

