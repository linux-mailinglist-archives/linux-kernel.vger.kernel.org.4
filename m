Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508E65137D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiLSTww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLSTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:52:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44F5F96;
        Mon, 19 Dec 2022 11:52:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so9668276wmh.0;
        Mon, 19 Dec 2022 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUjNXOEHX/W7UdMi+yl/0srY4t86/SAHQJknziXKrxk=;
        b=Qa3yO1IUvlwrZwmTA94ThEFY8nXr2xWUB4xDqQ0RiMeiuecs29u56KqlZL2naorOtA
         u5x3N9vKsFo1lUjgpMAyOgjm8+oTyMDoOFhlSuFkyRIeOPf/Po/Z+zijbE5it0gUeqFt
         LjAz1MivurnQ1T8Ullg1KgrsTzLF2XKZYRPNiBwqx26v6NGN1BeaqXpVR2OF/HGw/eJE
         t6acX2iCr94SSxIHJOI0exfWqD9ntz/OyDtrIdGWnxN4AEVXSpcjfUuLwqYnRxDbggek
         qFiWetl4pR0h/ycywx3Msakh65eeUi0FaE/yzQPDeLDrqAIYTneun9KE36j2JUh6FkgV
         kaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUjNXOEHX/W7UdMi+yl/0srY4t86/SAHQJknziXKrxk=;
        b=XXW50ndlJoBrAPrVbXqyBKJ8ZCBHAidou/MctYHFvgWnHOky9B/WzGqCaFstt3B+eQ
         fVZIi96731bc5nHqrkK6Ko+ckHQI+lavBji6zj9g3stNU4lh4SsXuKKu8n2hTFf4JF2l
         SJIFiyLrP8rcbUGmM2pn273Z7RFoksacyLS2KyU4n5F5Aw9piLV15LzuZr0wrqGwVnQr
         /WcbvVhxT2vh+8gKMiku1skJZKP7e9EUPiE9x1XCTHnCh3ompm0glpYXjvqGfC0DFOcG
         FGIVLGR5BlvyepsDRdga10m97D57ZzfTacRQIY5Gcddx0cxhuu/w+uY4cWdb/2lpIQmZ
         aN8w==
X-Gm-Message-State: ANoB5pnA28wjWbJ9Q5dm/VQeStezCagcjy8Y0hYF9dbAqrcqKRNBRpHp
        s+/wcFKINeLKmNOV/xyOJKU1UqsIV4Q=
X-Google-Smtp-Source: AA0mqf5VEegnXDQ7niTrm/FLhoL6PT3TL2mNd04sa3vR9sCNVCf3Ace4V9IQdHttNZH11V8DlYF0lQ==
X-Received: by 2002:a05:600c:1d83:b0:3c7:a5:610c with SMTP id p3-20020a05600c1d8300b003c700a5610cmr33042429wms.16.1671479560562;
        Mon, 19 Dec 2022 11:52:40 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003b47e75b401sm24469142wmb.37.2022.12.19.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:52:40 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, linus.walleij@linaro.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: display/panel: Add the Focaltech gpt3
Date:   Mon, 19 Dec 2022 20:52:33 +0100
Message-Id: <20221219195233.375637-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219195233.375637-1-cbranchereau@gmail.com>
References: <20221219195233.375637-1-cbranchereau@gmail.com>
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

Add bindings for the Forcaltech gpt3, which is a 640x480 3.0" 4:3
IPS LCD Panel found in the YLM/Anbernic RG300X handheld.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/focaltech,gpt3.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
new file mode 100644
index 000000000000..d54e96b2a9e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/focaltech,gpt3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech GPT3 3.0" (640x480 pixels) IPS LCD panel
+
+maintainers:
+  - Christophe Branchereau <cbranchereau@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: focaltech,gpt3
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
+            compatible = "focaltech,gpt3";
+            reg = <0>;
+
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
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

