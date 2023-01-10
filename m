Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE0664C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjAJTT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbjAJTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:19:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655C532A2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:19:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bq39so20073299lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts8pg88W1SqtrgDHeZ4rSJsGAKw1h4BEAKukVwN8v3k=;
        b=SYtpocZKmQuNT/cicSsVXpir68fDa2z7z+EAUU6wwuQugpXbj7qS/eV7elXgrOdXzG
         y2VDDM9KRO4d3cg9VSYhTGYCBTmkB0SIUuTkQ85SjoBCBP08s9xPRvg4+KEHhPMlPAWi
         09WVmjPlfr4Q7yQ+yQYW1C0IoLAdSVC7XaxnLf17RM4UBOtBVS5ZR+ne5KYMWMVrEo1o
         oM8pQ4aZQS5lSKzCixfby8C6vO2POe8cGqKOExqjnJfV8IxeOD7t0R7WC+Hw6PKtyHhi
         LPT4U0q3q+F5Hd7xt8yfC/Ox7MIQvd4PX3BWBqId7XMaOl1aTjQPuBiDo1+kZQ1MgALY
         WjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts8pg88W1SqtrgDHeZ4rSJsGAKw1h4BEAKukVwN8v3k=;
        b=jLPWCkrA5nF0DL5H5zFp6nOGLTWXChvNYBvLWy2HgPciQlkw+I8OVr6yenKtrFTooV
         FEhNC9Akkbn4I6j3e+invVvk5NO+MS9Uf673caQz78faofX6HEoIZ0ITX2mpp3i8bmV3
         PhUBl+h+4Gntu3RhQB70BjiHiPEzZenNoL19Hg2nmJ/PwxWFBqolbCSyQxu1au/tJTTE
         UOH2ENBOAqNzxAQs+lJKxk7uY/whpTee5PvXGdv/BgXLXlC2co64FTHAcfQl9FGUzv/z
         Fw9sPGnQCzV/zFU+XlysK/V0/+9ym2uwTDKMISeV+lYjlyqlFRACmlI3XcY6Jxb3LLig
         awNg==
X-Gm-Message-State: AFqh2kpyaSo7bX1X32eZ3mc2EGaX65mV/Kh7CcVCOIPEL6CuD/xm/Upm
        SzF6fOMSqilnd2Qg/1pVAZfEiA==
X-Google-Smtp-Source: AMrXdXsu5gKMcq/XNjBnXZSELLg6daB3YeKbqTWkcPPos88PhXSEz+HeSC+wiccc3koNOZ1lhkQngw==
X-Received: by 2002:a05:6512:e9f:b0:4cb:3b24:8390 with SMTP id bi31-20020a0565120e9f00b004cb3b248390mr10706584lfb.59.1673378374793;
        Tue, 10 Jan 2023 11:19:34 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id x28-20020a056512131c00b004b549ad99adsm2297725lfu.304.2023.01.10.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:19:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 20:19:12 +0100
Subject: [PATCH v2 1/6] dt-bindings: crypto: Let STM32 define Ux500 HASH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v2-1-bc443bc44ca4@linaro.org>
References: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
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
ChangeLog v1->v2:
- Use an else construction instead of if/if not.
---
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
index 4ccb335e8063..b767ec72a999 100644
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
 
@@ -41,11 +47,26 @@ properties:
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
+    else:
+      required:
+        - interrupts
 
 additionalProperties: false
 

-- 
2.39.0
