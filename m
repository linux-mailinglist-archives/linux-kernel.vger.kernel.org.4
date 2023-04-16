Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E36E3890
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDPNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDPNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:16:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AA2681;
        Sun, 16 Apr 2023 06:16:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94ed301bba0so174955566b.0;
        Sun, 16 Apr 2023 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650999; x=1684242999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfDIW5rjyoFm2k6hd0M174LyRPZ8573uTfgcRgpaEoQ=;
        b=OfV9N5LHXN6YUT8ieqA//I9kn/scefHuy/SXb2SfukWCz5UQ4YuXYeOx8e+cD8hE6S
         cgkNXO9bn1tSot+Ybujk8IkZrzGvZDJQNgg2DeOK8p++7pclg6Nhaueb9Hzz/IRk9Vsm
         rfbMrFCzC9LJu0lHxyvmkeOJdyEb9v8HV7hPHv2oKxowEYztkcVz94BxV9QlkzKJgAaV
         b50Lt1K6hhRIL6q8CWMo7W4UMdLxfRNJ0zCX2GchpfrwjKzeq67fvVaOsz7krOfC1/KQ
         VXh3p+zJ7Qt1ip4QA4LjdfrYGx00K5AUM8hlJoRTv/TdS3IgXuOJKygu2BHKJTFDB6y4
         XgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650999; x=1684242999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfDIW5rjyoFm2k6hd0M174LyRPZ8573uTfgcRgpaEoQ=;
        b=RKtzlypdLgcWyr67jq2OtzgMCmaVMOj/QLFem6Qn+Bz2h+iSCxW6GFXxdQHVC+Zb1B
         s//euPoX7lSEPwFTCuEiPIubS76VZ9UHUuexV85M4hPDGi9o3ulb+vN8ggg00lRaHiFa
         +rdxnuE3H5/dBFizFxo3GIq4VCxycn4Ee2z3UIAs49eJguDDg1m7P4hNBjXvCURXmT51
         TeG7n8dEDsBq4c9oubw+SSS1Gj6hTjz26ieNa118x6HZSU7tphvSVllLT4mhrjtadSaY
         3T+Sa//QHkerRNPYQvfJkYspQTd92MgHql5bj7MVkuB8OEw388yVVmqkROGHcHDCqKzN
         UASQ==
X-Gm-Message-State: AAQBX9dbnennFYGOGLplfmJ+uBHyy/nAC1n/6Yeo28xmh6/myRCiF0D/
        z8VzZeQg2UNc1CbzpjAUy6Y=
X-Google-Smtp-Source: AKy350ZenHNVl/GG+d/h/VzSnnnqzGWK4qxf6AG9RITW6+Se/4FyHYe91VRpPyB6eRmsPraV18WRXA==
X-Received: by 2002:aa7:d88e:0:b0:504:b325:bd4d with SMTP id u14-20020aa7d88e000000b00504b325bd4dmr10619788edq.12.1681650999143;
        Sun, 16 Apr 2023 06:16:39 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640204c900b005068d7ccfb0sm2396594edw.83.2023.04.16.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:16:38 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
Date:   Sun, 16 Apr 2023 15:16:30 +0200
Message-Id: <20230416131632.31673-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416131632.31673-1-aweber.kernel@gmail.com>
References: <20230416131632.31673-1-aweber.kernel@gmail.com>
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
of tablets.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changed in v2:
 - Updated commit message
 - Applied suggestions from Krzysztof Kozlowski
Changed in v3:
 - Correctly applied suggestions
---
 .../display/panel/samsung,s6d7aa0.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
new file mode 100644
index 000000000000..079e2b3a9eaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -0,0 +1,52 @@
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
+    const: samsung,s6d7aa0-lsl080al02
+
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+  enable-supply:
+    description: Enable supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - backlight
+  - enable-supply
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
+            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+            enable-supply = <&lcd_enable_supply>;
+        };
+    };
+
+...
-- 
2.40.0

