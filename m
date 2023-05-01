Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354C6F3644
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjEASvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEASvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:51:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFDC6;
        Mon,  1 May 2023 11:51:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso3543732a12.3;
        Mon, 01 May 2023 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967072; x=1685559072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYiX1kIaDSc0tISjTp3CF+Qs2kF5135CE7l+f2phEaA=;
        b=aZlEm1MUUd0y46ppigHOw/ChK7rnbaoRpn+nynKdJWDXN75+qRS2iogzUdK6WEsH1s
         A9MY66RcO3hZxrfBwFiCz0Tf/AhrvCUHT6aAVYw+KYFd+3pCjAYX8evPI07fUX0IiGPg
         Dgkr25/qIfZumVG5oopGBVfLiPn9G8OyqWYbtgt2WC7BDoRLDmci2SZlrCkWfRVLf0R4
         yfi6pO1RQWxgEbBXz/bRreSwRTXMrqP1a425/Mi+wH4LWonfa62NwU+onPosdVBWbwV8
         wafMJB7gxfcscYxywKGlRLn4tsg4v3Y663EEqGcdzITIlXj4fSPjCQ/1+wlbmJYB0CpA
         PgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967072; x=1685559072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYiX1kIaDSc0tISjTp3CF+Qs2kF5135CE7l+f2phEaA=;
        b=TKl3loFs/k8H9Ek5sfYysCduLIj8Me7ylPQGkdeO7/09peITf1U/6ogpUdSN9edSHv
         dDf8o8w/Ebjz7is7yMdV2E/r4JqvExlVmai7MgthgVnVxzd+qhC4CXx/1j+el7vppi/+
         aRd6GxDaKUwUeAvl3GFpbMjuDB3qEmSFQoxr+H5ADFCXyWTCvOByXelKoQmAcGnnVP52
         7dbzsSlI4bVsvvOmI+KdYVxClExpUZ/atvmDPTSEzMDKpBG0tmoFKcO3lLcNC5VF+7Zz
         5LlJmdewHNtUrGMmMIoNGumxqQMmPfXOP0lteA1DHaEHlOPOoJXkkPD0TdGdhYgg1Xdg
         ySdg==
X-Gm-Message-State: AC+VfDzVfWX7NCwbt+yFYDCIObXP2/ImcQ43gpXxAOWpRPEacRgfTj4K
        QegglfiDq5bo9L7yx8jSwBY=
X-Google-Smtp-Source: ACHHUZ7JKuFFRMBI7s0DooN1jTc7B1Nlu4lwgQB5ev6TA6Q7ajR1hJkv1WtGCogARxhFZKxjtCWoAg==
X-Received: by 2002:a50:ef0e:0:b0:4fe:97a2:4b86 with SMTP id m14-20020a50ef0e000000b004fe97a24b86mr6841785eds.8.1682967072203;
        Mon, 01 May 2023 11:51:12 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906594a00b008cecb8f374asm15028335ejr.0.2023.05.01.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:51:11 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
Date:   Mon,  1 May 2023 20:51:01 +0200
Message-Id: <20230501185103.25939-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501185103.25939-1-aweber.kernel@gmail.com>
References: <20230501185103.25939-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the S6D7AA0 LCD panel controller, including the
S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
of tablets, and the S6D7AA0-LSL080AL03 and S6D7AA0-LTL101AT01 panels
used in the Samsung Galaxy Tab A 8.0 and 9.7 2015.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changed in v2:
 - Updated commit message
 - Applied suggestions from Krzysztof Kozlowski
Changed in v3:
 - Correctly applied suggestions
Changed in v4:
 - Added LSL080AL03, LTL101AT01 compatibles
 - Added description to reset-gpios
 - Added vmipi-supply, renamed enable-supply to power-supply
---
 .../display/panel/samsung,s6d7aa0.yaml        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
new file mode 100644
index 000000000000..918f62a78ecd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      # 1280x800 LSL080AL02 panel
+      - samsung,s6d7aa0-lsl080al02
+      # 1024x768 LSL080AL03 panel
+      - samsung,s6d7aa0-lsl080al03
+      # 1024x768 LTL101AT01 panel
+      - samsung,s6d7aa0-ltl101at01
+
+  reg: true
+
+  backlight:
+    description: |
+      Backlight to use for the panel. If this property is set on panels
+      that have DSI-based backlight control (LSL080AL03 and LTL101AT01),
+      it overrides the DSI-based backlight.
+
+  reset-gpios:
+    description: Reset GPIO pin, usually GPIO_ACTIVE_LOW.
+
+  power-supply:
+    description: |
+      Main power supply for the panel; the exact voltage differs between
+      panels, and is usually somewhere around 3.3-5v.
+
+  vmipi-supply:
+    description: VMIPI supply, usually 1.8v.
+
+required:
+  - compatible
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
+            compatible = "samsung,s6d7aa0-lsl080al02";
+            reg = <0>;
+            power-supply = <&display_3v3_supply>;
+            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.40.1

