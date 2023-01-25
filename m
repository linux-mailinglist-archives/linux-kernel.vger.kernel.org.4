Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9D67A78A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjAYAXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjAYAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:23:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EC4B8A5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx13so43413018ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhJRzXVyFbYsW9+EPTTFmUQre+ecqTHVuxtlkf1ZhBo=;
        b=KCLc7tjuPxwl5JW8yMLr1Wn5U5TnOHXpJR9NXS35wGwpcxF92n6GwN6d2xeH3QzBrU
         4WAG5bmWef/Pu9BseaRWJIdThGWZUghD1/mykmTHdHyUNMMUPv5yKRdM2LqG/f5iCYtm
         6HCjTLZJF3O29/qVTTMGYJymLcJEvX0M0G8iT0jKLteUVJGi06JmvEXGBsp3olwYz95A
         D7gOtlA4y4SqhHcejKrZK41ioSnnOL/8y4AjT0QJ851q9johTHIgv30clTX1wW5iBTgm
         PRHADWXI1A4mEBUAfuQ8hWdCO5tIm1Rx0SZ1Bq5vTPcQ1WsljCaAYNtJJ5AWQazQ+r5c
         q4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhJRzXVyFbYsW9+EPTTFmUQre+ecqTHVuxtlkf1ZhBo=;
        b=p5qwCW6mWEOJuXgtrNLSDHBMmUrT1k/eo3N2R0wxEVA3KADEWXOU+3rgO0Czt3hQAe
         6Bhzwcgi7YMGtlSGorc/wMMOvLDmtGPpEaHQaW3Mk6ZMfBwV8CCiou21MHTf7y7rgBZV
         HB8pRELWrlwgTcl7n8QVhjt/CRHVMAqD0fyIhxRE/gxfHqlyFYrvPfpv1zAHQLi4t9QL
         jwwy/z30uuSVGUSEPcI8M3uuuZ1KVMwxkLGjZ27jw55q9iEGkR1uf+I/uAM1RbqkRdCY
         5Bdz2UrS2ulyazJGOvgrrfqcTf+Vmxr+JZA9g89wPwP0zSpCIjZGa1CRdbROEYVzpB/B
         yKYQ==
X-Gm-Message-State: AFqh2koQimj6dQfpxqUV0C0fWK3wvzm+XNdJqOfxr78kgj7v+UHbIznO
        7PudQlLmBKqsW+owrTJ7ghp/aQ==
X-Google-Smtp-Source: AMrXdXvS1BAG+73sw122jBVVgFvXv4BoWPsK0NmBVj0lSa1oJW1cWbomQQG6e+x6UomqF0DgG/FF/Q==
X-Received: by 2002:a17:907:9252:b0:86e:d832:2f60 with SMTP id kb18-20020a170907925200b0086ed8322f60mr27013282ejb.48.1674606199621;
        Tue, 24 Jan 2023 16:23:19 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1584606ejc.2.2023.01.24.16.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jan 2023 01:23:06 +0100
Subject: [PATCH v3 1/6] dt-bindings: crypto: Let STM32 define Ux500 HASH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v3-1-32ee12cd6f06@linaro.org>
References: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
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
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Pick up Rob's review tag.
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
