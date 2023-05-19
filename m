Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3E709D25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjESREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:04:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E299132;
        Fri, 19 May 2023 10:04:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso220550566b.0;
        Fri, 19 May 2023 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684515843; x=1687107843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMbfgZNtYeRwD9smgGxKkhNix43UFfi2sTWJFSMwRx0=;
        b=P4xVhmOOzmp4vBNC/eDpPzNpBkI7hhNpQEDfnWtU7yM3gMpNfpZHU8JcOOzqUyrig1
         lb1stbTLqOeeVbFDPQwMfKCKJMSLcUsSWHSGznckf3/eXD2brfFmt2cuFucD0w3kdPHO
         nF7XQ8MS7ZjZTzpVtG4sNBuzAAlOuHRjeLZDBmn1GBEvtA56Rm2eq6FVP24jn2kFKb4j
         S4oAuJb24IkACLDtLOw+DGL4afM1QkRctlTt9rlOfcUPxFru6KZouAT+nTNqrHvWspQs
         sE2FOuoo9AoKorvldkWNE4qIDKopllcrgQQ9a4jd6Wdvoi8ccLV3Ay9edGJhxLCXshCE
         BcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515843; x=1687107843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMbfgZNtYeRwD9smgGxKkhNix43UFfi2sTWJFSMwRx0=;
        b=H5j3Vx11b18jGvgMhPzFseoTn+7a20hPAu2c0W/S+5wo5KuQwmk1NgHH2vYrSxyb0u
         HYNOsS8iU4xRPA0A40DqTgkT7c1Q/RqqWjIPXaM5+Z0xOaIEVbPwS4xhlFD01PCE4e/4
         KVrtKU8jH8xM939YPhzne1qdw+wfVMNC7bGO+uzTt5wFfD+rlIN6dmfvdkxZpWftdt8z
         Yl/twsVF9fGxUrADoHjQaDrPQuOizdZoCZ7E3QpyGeFcPZ3X+lPmL1LsKye30FfixUKU
         oaQ1o3Q2amOfNY05qv5Chp6mXuDcDxtDyURa/fgMt8lrw3lj7cGy+sWx6y3NoHBjpK4A
         98Yw==
X-Gm-Message-State: AC+VfDz3p3GcI/W2QSSH74X0GqNbLt9uYeBqT+uHpboKLuHcPZPPsQTB
        rHl62LWnJF74A0FDboLJuFI=
X-Google-Smtp-Source: ACHHUZ4kGmVmCGrd+bXfst09wD0FQoK/I6kxSeXm7KDAEPwXQJc939EXnwfTfV8PBLtqAtuhCcQh8A==
X-Received: by 2002:a17:907:961c:b0:967:4bc7:38c0 with SMTP id gb28-20020a170907961c00b009674bc738c0mr2641931ejc.9.1684515843333;
        Fri, 19 May 2023 10:04:03 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id mf13-20020a170906cb8d00b00965ffb8407asm2489988ejb.87.2023.05.19.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:02 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
Date:   Fri, 19 May 2023 19:03:52 +0200
Message-Id: <20230519170354.29610-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519170354.29610-1-aweber.kernel@gmail.com>
References: <20230519170354.29610-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 - Added reg to required properties
 - Reordered required properties
Changed in v3:
 - Fixed patch that didn't apply
Changed in v4:
 - Added LSL080AL03, LTL101AT01 compatibles
 - Added description to reset-gpios
 - Added vmipi-supply, renamed enable-supply to power-supply
Changed in v5:
 - Changed compatibles to avoid concatenating multiple model numbers
 - Removed '|' from multiline descriptions
 - Fixed license
---
 .../display/panel/samsung,s6d7aa0.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
new file mode 100644
index 000000000000..45a236d2cc70
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+    items:
+      - enum:
+          # 1280x800 LSL080AL02 panel
+          - samsung,lsl080al02
+          # 1024x768 LSL080AL03 panel
+          - samsung,lsl080al03
+          # 1024x768 LTL101AT01 panel
+          - samsung,ltl101at01
+      - const: samsung,s6d7aa0
+
+  reg: true
+
+  backlight:
+    description:
+      Backlight to use for the panel. If this property is set on panels
+      that have DSI-based backlight control (LSL080AL03 and LTL101AT01),
+      it overrides the DSI-based backlight.
+
+  reset-gpios:
+    description: Reset GPIO pin, usually GPIO_ACTIVE_LOW.
+
+  power-supply:
+    description:
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
+            compatible = "samsung,lsl080al02", "samsung,s6d7aa0";
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

