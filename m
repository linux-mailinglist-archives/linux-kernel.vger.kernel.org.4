Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5456D6A76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjDDRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjDDRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4868E1BC7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so133636993edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpK/rtOcThFCxDcbYqxrVp6qCPyXXE6NETLUVka6bxA=;
        b=v0wc6b2d1QxI7/jZ+uBgmbxjHwi59bay/+45jHonTU/GBhm6u3pyEVojA7GQHMOfRw
         h5lPa6H+85UMnbxZj4UZn2gRM1Bme68eut5viccIh5raZaK5duIP1tQ5GvDxtGAjqUJz
         QfQi0Lo8TOkyr540TKT/mXs2rsy9DruNvU23qAeZnVdeQSL8/4vn0VAvbBFb6/Z637Hg
         ViLMpEMhI/jbes6LlG87Sf7DrZ7i57DleIK65F6ma6OHGvF9xI6cubSdup8EB7JAPv4r
         QV1upkRhH/c0mlW9y+r+ryd66CCRW3hCdA0J5EOGcYfI6IbKXOB0Uvc2AlZKNU7QV+KU
         k7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpK/rtOcThFCxDcbYqxrVp6qCPyXXE6NETLUVka6bxA=;
        b=MxPbvhktkz6NbwO2I0LPFzwsf7yEgKqoj2o1KY5VgQyBjgm1yKrwu/IzJFlMyr+DEk
         4ESben4pUuNqHeHS69BxzJ1Dbw//5q/6p1/vOB3tdmHDA5NR/gX/WcusdD4NndYYwxiy
         f6KPesZikW+tGF31jVHFs3/3nhoc8NRgfaPMlLq4sLYCTYVcvZStqNrf5fl1JdKp7ccY
         uIjvpoi6vZxafxZoRLb2TLhDWMv6Bkpr1frsJMdavnmdh7L3IBJXkUkcJsIgF077R/Wk
         jhvj8mO29RaG/BnGy/cAdNobVf2TT38a153oDnEIe0fOiIkeh6o1l2NMlitEMJLknotS
         Wp5A==
X-Gm-Message-State: AAQBX9fnHZjSwaEaei1LpyqPTtFpQWH0V23KojTH4CY4cSe6y0DsafbS
        iLY5dLLFos4/FGjmp6DIPm+X9Q==
X-Google-Smtp-Source: AKy350awC1v10sh90uGlxtPQ9IQ2RZGfeDlr0E3Sjgs9OxsSjqNuiq/Md4IQntYmIbhK3Rm1Yg9DnA==
X-Received: by 2002:a17:906:f9c6:b0:921:5cce:6599 with SMTP id lj6-20020a170906f9c600b009215cce6599mr300364ejb.41.1680628977869;
        Tue, 04 Apr 2023 10:22:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 25/40] dt-bindings: nvmem: Drop unneeded quotes
Date:   Tue,  4 Apr 2023 18:21:33 +0100
Message-Id: <20230404172148.82422-26-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml      | 2 +-
 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml         | 2 +-
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
 Documentation/devicetree/bindings/nvmem/imx-iim.yaml            | 2 +-
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml          | 2 +-
 .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml         | 2 +-
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml     | 2 +-
 .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml          | 2 +-
 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml        | 2 +-
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml     | 2 +-
 Documentation/devicetree/bindings/nvmem/rmem.yaml               | 2 +-
 Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml     | 2 +-
 .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml     | 2 +-
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml     | 2 +-
 .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml         | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 14c170c6a86e..296001e7f498 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
index 5ec8f2bdb3a5..e0860b6b85f3 100644
--- a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Sven Peter <sven@svenpeter.dev>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 25033de3ef6b..36def7128fca 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -20,7 +20,7 @@ maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 3b4e6e94cb81..70fb2ad25103 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -14,7 +14,7 @@ description: |
   unique identifier per part.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
index 7aac1995cfaf..e9d9d8df4811 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
@@ -14,7 +14,7 @@ description: |
   i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index d0a239d7e199..9876243ff1e8 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -15,7 +15,7 @@ description: |
   i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
index fe2cd7f1afba..e89fd879c968 100644
--- a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
@@ -10,7 +10,7 @@ maintainers:
   - PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 75e0a516e59a..d16d42fb98b6 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Lala Lin <lala.lin@mediatek.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index c3c96fd0baac..a296d348adb4 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -15,7 +15,7 @@ description: |
   settings, chip identifiers) or user specific data could be stored.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index ff317fd7c15b..8938eec22b52 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
index f93bc50c40d7..6c26800f8b79 100644
--- a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2173fe82317d..e952907ad1d5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index 4702f10ecca2..dce0c7d84ce7 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -15,7 +15,7 @@ description: |
   to/from the PBUS.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
index a4a755dcfc43..38a39c9b8c1c 100644
--- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
index febee8129aa9..c5403e149080 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index dc790d2cd9f0..b8bca0599c45 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   "#address-cells": true
diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index 172597cc5c63..a69de3e92282 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -16,7 +16,7 @@ maintainers:
   - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index a7644ebbc2ca..8877c2283e9e 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Vincent Shih <vincent.sunplus@gmail.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
-- 
2.25.1

