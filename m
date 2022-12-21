Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB746537F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLUVHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiLUVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:07:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416B325C75;
        Wed, 21 Dec 2022 13:07:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so2482726wma.3;
        Wed, 21 Dec 2022 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=TV7HOi/nDk6tN6Btf7NEWSQXW12jGkXqBc1ZJZCpH7rHo1bIES6jPHXyDmr0LSxqbo
         b5uA3Oar5vljGcFFGzJfAEtkP83r+gCzHBOsSCdOBCVWDhP++QpHCL6iZoaFO81DDjOp
         +ln2VaE4F/NLkO8nhyNKGYtqHD7HyPc5ztIKFo8uEpxmAOy8vaB5ZgTRNQ33jW9Klc5d
         4C3KidpPrCRZFnnd84lnlzKTBA7BtjKQco9hL0K1ntYXZFvcmLYkpUELHmd5cmHheaWA
         ppkuj5BGp+nUHilJygcVRcX3rztLrHkZB0rn2+VypnYZDGo0RF94KAxBcymdTpfPNrGM
         m1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=jnPbEDg+g5s3PS99231xf9mPMuzW5T7vWXraRjl+jN1Z2QtPSpFIPHlb0nnKssdpcb
         4ZsPJT07LArIgMIutdRbDpTYx7OiXV4QjNV2pzLhJR6sWhwCTaBVcwiYlYOCoCm8Rl/r
         6f+joJGeYx7LFuclqjcGuY32nmmNEcivv8sf1QM2DWEz3oszVYbjv8U2YTJhuX0+7Tsy
         OulrLMdSrPCG8fpsswgRW6rvrHo4lVRByjPknT4ftTasWxlsZq8HCGthmKyzONLcsnbW
         7fWdy+wzimTO71ke1qug8RY0Me1sCMKEiuwxdsnK4oB/XAasrvfzS0OsAmlFefTrG20F
         OktQ==
X-Gm-Message-State: AFqh2kpev1+88mkLWzyOqWAjXiyjmzmpU/jPgaL6DXgPUshgt/EIBRSS
        0iVORkkHjdzcfhq7JiOkGuw=
X-Google-Smtp-Source: AMrXdXtPsFcQ9nULzy25sD18SHnQ2BII+Hj9pyW0qhYMJrpKlYHMDezmfPea/fZ/j/2g/LCcQ8OxMA==
X-Received: by 2002:a05:600c:3b82:b0:3cf:900c:de6b with SMTP id n2-20020a05600c3b8200b003cf900cde6bmr2673465wms.15.1671656818782;
        Wed, 21 Dec 2022 13:06:58 -0800 (PST)
Received: from localhost ([176.234.10.188])
        by smtp.gmail.com with UTF8SMTPSA id iv7-20020a05600c548700b003d35c09d4b9sm4134856wmb.40.2022.12.21.13.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 13:06:58 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Thu, 22 Dec 2022 00:06:45 +0300
Message-Id: <20221221210648.2735-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221221210648.2735-1-fnkl.kernel@gmail.com>
References: <20221221210648.2735-1-fnkl.kernel@gmail.com>
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

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/pwm/apple,s5l-fpwm.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
new file mode 100644
index 000000000000..142157bff0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/apple,s5l-fpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@235044000 {
+      compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+      reg = <0x35044000 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };
-- 
2.37.1 (Apple Git-137.1)

