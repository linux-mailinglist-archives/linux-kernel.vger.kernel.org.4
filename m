Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971F06EAE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjDUPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjDUPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:43:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EF12C9C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so13622755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682091815; x=1684683815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rh5L0vsYaIJ9UtaeVaKtzuEvdISSccm2v33XZZjkI4=;
        b=Nf5g+P/2+GOnJtcEETuFuhmiT6sxWDb6M/P8XwlazYJzQwW+ryb8LT/aCq3QZmzpHg
         0jyLaje0Akfc1PqNEne8n2TBpyR4vRHCS8Bl5tfmjXt5I9o1krBiH9+pXPXGLo/yiOoL
         f0MfOzY040ehJ8oafyUGYk1kmQpoEkpb43mNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091815; x=1684683815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rh5L0vsYaIJ9UtaeVaKtzuEvdISSccm2v33XZZjkI4=;
        b=WI2V+nekPbf6dT2rtE0bkp08gcGzMDswDFnJ5C0Hth9hgPMHCeMDmRpYJfp1uM4XCC
         j+6sayN/PTcANrd5Yem29ClOJXSNr7I9MMAikzbDNO04eOZdfHzPzVtfTVo5UPqAx8bb
         SlfJJ94+CMGZFzxLl6v+YS6B/rchlwk+ZqE+8S9bRmGhs2kxfwsuhbKKmF0FK/EzjE8O
         ktJXoMCYLI2HLeAqj+SFroRhM3gzQF1Y4rIx6vOV1fvod/R815deAOaQlYLMef/4JX5g
         Mddt7FL2baKiw99HhBGiSamx9KT3iiLAkdtH9HdvGjiKloCGi9wyoJKOK5ii7EmCoH3Z
         2lyA==
X-Gm-Message-State: AAQBX9clu9KP0FDHOqsml8w6QOHh4o0Xb+8I14L6+v5OO3Bkp0GWngG7
        3Zm103CE/9GmO049Z4kJ4Z4as+tlGj4Gjfz6ByQqCg==
X-Google-Smtp-Source: AKy350Z4jDGfwkjgv5nKn5t4OLHWR40djybZIow/2j2qoDHhl3eeH7HhQlGAOSGiV0g/WfUXMy3PmQ==
X-Received: by 2002:a05:6000:1b85:b0:2fb:2a43:4a97 with SMTP id r5-20020a0560001b8500b002fb2a434a97mr4068854wru.39.1682091815035;
        Fri, 21 Apr 2023 08:43:35 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.127.129])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm4651609wrw.79.2023.04.21.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:43:34 -0700 (PDT)
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
Subject: [PATCH 4/7] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
Date:   Fri, 21 Apr 2023 17:43:05 +0200
Message-Id: <20230421154308.527128-5-dario.binacchi@amarulasolutions.com>
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

Add documentation for "ilitek,ili9805" panel.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../display/panel/ilitek,ili9805.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
new file mode 100644
index 000000000000..57c36cf22e4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9805.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9805 based MIPI-DSI panels
+
+maintainers:
+  - Michael Trimarchi <michael@amarulasolutions.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - giantplus,gpm1790a0
+      - const: ilitek,ili9805
+
+  avdd-supply: true
+  dvdd-supply: true
+  power-supply: true
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
+            compatible = "giantplus,gpm1790a0", "ilitek,ili9805";
+            reg = <0>;
+            power-supply = <&reg_display>;
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

