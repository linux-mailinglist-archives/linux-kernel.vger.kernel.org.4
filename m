Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D56570AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiL0XEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiL0XD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:03:59 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA24DF64
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:03:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e13so12488174ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFhxyjlvH2C97OwizzrUKlo9kQa69CcIj1hYQfOMQx8=;
        b=KTKV/mqiy1fp5moT/wefv5Uio4Bf0syNMLLz+KxjDYeGxkXWrqtazNd7itthPYt1Y/
         EorL6NBmhsS4taoQmSkpD4gxM76YP6Jr9y3N+BMuOFn0d36IN4IE9cfZ0HZtH2/3dX6o
         +/jtigOCamBrPQgVztzHUbVzJmmDwzop3+YvcHcnNyS4fn6im2tP+CmtjVWIh202Su1d
         eilm2y2KFB7A2EZXgBv/oBGJiyzO90r/oAueNAjFZlAKpBViCHQbYwTYgJW6iTOKD6eQ
         IVFF+HAaintxi+dBUbqyWa0HOa1tqODAh9XAsUViBADu6nhyCdeZym17OaZ1rfPVBpZj
         CFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFhxyjlvH2C97OwizzrUKlo9kQa69CcIj1hYQfOMQx8=;
        b=Z2VMWWULCCl7CY3PN3vLlbjB2N9MThoGAEOwG1ER2CY/CQDP7SiHo+XdgyaQ2XktMP
         gX241nK7qzb+xWebjXfapZV+hdQ3kPwEqMN4PeKlLY7Fo+BXsoseZH3MJBgxZV40nUq0
         cYARCLpDHxlxUlF7vABuUDcrp5HT+81fSSaRRG2XQWSDL9Z+jVCYCzZqp3PbtD8GCpTA
         FLGtkEeF1kcPv4h61j763OWLmA6L+4AAgNq5D6PuVPX3yvhT5U//KRxyMqJe1IA+PaEW
         8EVRAzgj+vfJwQ1kFmjUR2UBamAuvlkfYODegxnCRFNGak6Io7aXknr7djRXG/jsApn1
         vnDA==
X-Gm-Message-State: AFqh2kqHUZe2gdoCMf4+9yZE/E6Pqnv2oFH2uc2PMkkqsLX9yItla5rF
        7D8qkGdjjM14dMvCxqOTgBQnGA==
X-Google-Smtp-Source: AMrXdXvLPSUTh6RzigUlrbFiO1oNps1dw6Y2+k7nc11Zux38U0qoG44OFTl5g08v1Wi0UGsJjtpJMg==
X-Received: by 2002:a2e:9296:0:b0:27b:574b:573d with SMTP id d22-20020a2e9296000000b0027b574b573dmr5621509ljh.19.1672182228880;
        Tue, 27 Dec 2022 15:03:48 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05651c0b9900b0027fbd4ee003sm876925ljb.124.2022.12.27.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:03:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Dec 2022 00:03:33 +0100
Subject: [PATCH 1/7] dt-bindings: crypto: Let STM32 define Ux500 HASH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v1-1-b637ac4cda01@linaro.org>
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree bindings for the Ux500 HASH block
as a compatible in the STM32 HASH bindings.

The Ux500 HASH binding has been used for ages in the kernel
device tree for Ux500 but was never documented, so fill in
the gap by making it a sibling of the STM32 HASH block,
which is what it is.

The relationship to the existing STM32 HASH block is pretty
obvious when looking at the register map, and I have written
patches to reuse the STM32 HASH driver on the Ux500.

The main difference from the outside is that the Ux500 HASH
lacks the interrupt line, so some special if-clauses are
needed to accomodate this in the binding.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
index 4ccb335e8063..681812e1c941 100644
--- a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
@@ -6,12 +6,18 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STM32 HASH
 
+description: The STM32 HASH block is built on the HASH block found in
+  the STn8820 SoC introduced in 2007, and subsequently used in the U8500
+  SoC in 2010.
+
 maintainers:
   - Lionel Debieve <lionel.debieve@foss.st.com>
 
 properties:
   compatible:
     enum:
+      - st,stn8820-hash
+      - stericsson,ux500-hash
       - st,stm32f456-hash
       - st,stm32f756-hash
 
@@ -41,11 +47,33 @@ properties:
     maximum: 2
     default: 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - clocks
-  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            const: stericsson,ux500-hash
+    then:
+      properties:
+        interrupts: false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            items:
+              const: stericsson,ux500-hash
+    then:
+      required:
+        - interrupts
 
 additionalProperties: false
 

-- 
2.38.1
