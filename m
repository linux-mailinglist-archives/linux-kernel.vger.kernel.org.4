Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC80737BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFUGmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFUGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:42:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876310D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:42:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-987accb4349so664401466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687329766; x=1689921766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoN7Ok0SKP6e+nvIGPL/uYRmtK4NznFFx8jgBVW/pBE=;
        b=AbD59zvH1tTgwvomAGUGfyLAWF3DAthn6QVcEsI+AByRTknJ9nIVZyjFobgZOsCVW7
         cVLERghOduu+RFbvXBlN7r9wHr1/i9+4hJ7M1SczfyrHO23otQxTmGX9D5Z98iVan28P
         EdIG2XOGZ7RxmbVwwGdYIAl4cQiJuqeNLYnltZkn3dgIOmz7vR+RxdUkoog0i4/RSxmZ
         AjywleZgvHZOj0+oUzDc0f2ssSug4MIzqPTXUzS06ZGjJlJg2G5F/D6AROqSZvxiwKnc
         m9rEaSDFV8+Z5ymev4EIeMIw8GP8QoRjqZ0nlRtx8I2Z9y7AlbDh2TleJclYlRawcNa7
         Kb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329766; x=1689921766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoN7Ok0SKP6e+nvIGPL/uYRmtK4NznFFx8jgBVW/pBE=;
        b=cuQVEwrPKNkbTXKCtnH2+tjuFVbVlkh6LRtJGODp6N0D+mwVCA6zYiqlyP8ClANJzw
         C5Azl1txluds3dSdq6C5uo+Gso3yWqKoVjUOIexBZe2B2A0CJDqVQe/W0QmmhtC7dTMd
         WtOaODZkY8Wn7UtPd8EbrQg32MUcZvGlawg9I+tYnXMXlq3LkRqbFal4gD4JVP5Ia+Bw
         KG153Z24PF4pCaYMCaHoQDX38gvizw9lDiNGM5PDelP9TG3I7/EOS3EDkzc6oTyjrCDN
         HI2q+HyC8NuSTnIUr8FfI24zOzOMl44x1arLhHL1rWkTO6BH9jZAoDMC4HC26wMpC64k
         Cjqw==
X-Gm-Message-State: AC+VfDwHrLC4PCy8RO+VBsStxqwd5xtLwIR9+HU54LI9e/y7zFUumyvf
        0QIoT3cgS6tWj2J8v8cFMCI+EA==
X-Google-Smtp-Source: ACHHUZ7/YRtI6xTdzg7eKWCRpduuZtiAGjXikYaa0aAlnnfaWsyaDbSoYbh0y2HyCIQ8aMTBS9rOtw==
X-Received: by 2002:a17:907:3e0a:b0:8b1:7de3:cfaa with SMTP id hp10-20020a1709073e0a00b008b17de3cfaamr14522289ejc.3.1687329766084;
        Tue, 20 Jun 2023 23:42:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709063ad100b009821ce1ea33sm2549254ejd.7.2023.06.20.23.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:42:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: crypto: intel,ixp4xx: drop unneeded quotes
Date:   Wed, 21 Jun 2023 08:42:42 +0200
Message-Id: <20230621064242.9038-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---

Changes in v2:
1. Drop more quotes (also amlogic)
2. Add Linus' tag
---
 .../devicetree/bindings/crypto/amlogic,gxl-crypto.yaml      | 4 ++--
 .../devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
index ecf98a9e72b2..948e11ebe4ee 100644
--- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -19,8 +19,8 @@ properties:
 
   interrupts:
     items:
-      - description: "Interrupt for flow 0"
-      - description: "Interrupt for flow 1"
+      - description: Interrupt for flow 0
+      - description: Interrupt for flow 1
 
   clocks:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml b/Documentation/devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml
index e0fe63957888..a4006237aa89 100644
--- a/Documentation/devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml
@@ -2,8 +2,8 @@
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/crypto/intel,ixp4xx-crypto.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/crypto/intel,ixp4xx-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel IXP4xx cryptographic engine
 
@@ -21,7 +21,7 @@ properties:
     const: intel,ixp4xx-crypto
 
   intel,npe-handle:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to the NPE this crypto engine
-- 
2.34.1

