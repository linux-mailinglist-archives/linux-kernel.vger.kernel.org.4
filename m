Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26CB64B158
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiLMImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiLMImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:42:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691D15816;
        Tue, 13 Dec 2022 00:42:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx10so14859371wrb.0;
        Tue, 13 Dec 2022 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKgK29do0XjvBFIa5Qu+YNQa8TUkw4hM3C6J+0E/JwI=;
        b=YgYedch20A1eKHsRF60pPQ4MyHukR1G5HNoNrwZwqGqrRpOK5JFwy8Q/ow5LAtZxhU
         kpnPtppTrK8MKNQaHoXpWUXXd7/tO+ZKUBEc8o3FZ+SMaDeUBJcwxdfRjXBfhJbKSmW2
         ioVqQY66mg0LgukTKb5/olYPmiR4CB+Nj43+9vVXUWnXuva0PPSmLb6F7JEvyCx2WeZm
         78GoyyXMVedDKxKXFmZofiPXu9XdTAg5xA+L9J4yg0nXddMN8I/QHdHBZ4gqZC4OcxzE
         /0agH/OdWQAe7F3OK1A16pAmFyZ3ZkKSPTJ199ccYZKEcQdfOzFY6+Dfr4lqjOsldLN4
         g/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKgK29do0XjvBFIa5Qu+YNQa8TUkw4hM3C6J+0E/JwI=;
        b=nAcSOb887sAe9W0z1CMPvisCWMLcKC0THKajqQ+AzYdsJ7eXJnl/GV1nf03ffG4sWR
         aZ4gtnnXhHPXr0mLQ4tESf/WuwFW8Pg8OmgaVRzH6V9zLHoykhuU+xC7nLFDae4TUyT6
         ExKjhy36Y82Q/b5rO0FV7eODt6FyaBntzTBGfT8XDbnmMVwiT9weq3hSY4iHKf7mz4Ne
         fh3mllpRv9N014EZq3HKdtUmRrQ6z5Cgo6FZF9x3cvRbAxYjDf9YaWmGNJrEZYC7BLAh
         LyU/Wzy+IISyPZXQe6Bwi1zFu/IllCGWYUA+l1TaD16q/M55K99fMG6y6Ml8wx8Mf4BB
         jkAg==
X-Gm-Message-State: ANoB5pm5LyE08JsvgVfZk+71VRV0iJvABjRnEna/SuzXCCEt3unwgJzR
        o4eZbyQdz/tQQaaBoxBaHs8=
X-Google-Smtp-Source: AA0mqf4lLIS+hn1OCdyn4v2Vt2KHSHteehIfQrIdoMMl5BA6GlgC6wzwyNx63t/DSryNWQHaI9SFyA==
X-Received: by 2002:adf:e710:0:b0:24c:f3b8:816d with SMTP id c16-20020adfe710000000b0024cf3b8816dmr7590165wrm.60.1670920932660;
        Tue, 13 Dec 2022 00:42:12 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id ay2-20020a5d6f02000000b002366e3f1497sm11474037wrb.6.2022.12.13.00.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 00:42:12 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display/panel: Add the focaltech gpt3
Date:   Tue, 13 Dec 2022 09:42:03 +0100
Message-Id: <20221213084203.17729-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213084203.17729-1-cbranchereau@gmail.com>
References: <20221213084203.17729-1-cbranchereau@gmail.com>
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

Add bindings for the focaltech gpt3, which is a 640x480 3.0" 4:3
IPS LCD Panel found in the YLM/Anbernic RG300X handheld.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../display/panel/focaltech,gpt3.yaml         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
new file mode 100644
index 000000000000..969f117c51ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/focaltech,gpt3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech GPT3 3.0" (640x480 pixels) IPS LCD panel
+
+maintainers:
+  - Christophe Branchereau <cbranchereau>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: focaltech,gpt3
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

