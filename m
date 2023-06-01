Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88684719807
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjFAJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjFAJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:59:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EA129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:59:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fb45a5258so81284566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613552; x=1688205552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90Gu+poX8fKoB/oDjzLzAZDuwhhlwN9OQimMwgRQWp4=;
        b=iM8LO+FPwTHgjFORfknFCDDjXMCN2xMBI+2u+Ik/H0rhbGttDgWLwFWhgV7GidR1EJ
         rT6uT9O6KV8yJ1zVK1wy3YY1eN2aY9T+KNEqoDB9S9q+ALh5koKj0ZcZg7K3qnr8a3TS
         mMqOuQNhrbdoYz7kJFD4qlolN2dXiGlGU9TFlTWcjlSBIeKE+t2qyN/bJpQY/mKW9nJc
         OWII9OiOktwbOH/ooYR18Gu5H9ENNz6JdXBobJpeBcrKbUaZcvlrqW4zd+LP3xs3nSxY
         Q8YzxYUo4cxMOj5Rz1DEnWj27tc4Y74KZFM4ZzRujD87iDPWXQrdnu4efzE7m37QlORd
         CT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613552; x=1688205552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90Gu+poX8fKoB/oDjzLzAZDuwhhlwN9OQimMwgRQWp4=;
        b=DTw/XA/aV9rc6SWQ2EzQaSlbgpLpZqE0//y/JFaZGDKGOtoxaxIp24Ag60GH+/mtck
         inT15LvCCi2GNSndWbXXwSnUhwObDDa9XreDxFZ8wvL8CVqYy6rIxgjLT1KPfZhP5GfR
         vhwP1vu/+ooIMlYuH7gv1ye+LqAjUwg3GeUsMl5kw13sisFzymhDPYZQp8u3Bo1mrRSL
         DZObi+nqmVIh1orY9kgVY6NCws5sFUiTLsuIzzUfy4E6IE5prwsbI38BrrY+64aK7pdC
         mzF1Xhdz4LifAJBYtCBMGlhNb+d3l5N+xUbmuakc2ytiLiG0Qrv28+n/nfmgtF74dI+D
         F+oQ==
X-Gm-Message-State: AC+VfDykHe6hCoUQO36QhNrnyYr7Cb2kZh1187fweScG4wbuT/EctUbW
        dtJaZ73Xu/+4roWZayb2IgiJxg==
X-Google-Smtp-Source: ACHHUZ6Q1hQXvbyzsDG+IHmi111NeKcnhKLafRhBIRJoDPR46b5dmWgA63foRAXbsa1b46P3eS2Jzg==
X-Received: by 2002:a17:907:7213:b0:974:1e0e:9bd4 with SMTP id dr19-20020a170907721300b009741e0e9bd4mr6983394ejc.16.1685613551711;
        Thu, 01 Jun 2023 02:59:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00965bf86c00asm10475549ejf.143.2023.06.01.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:59:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] spi: dt-bindings: allwinner: simplify with unevaluatedProperties
Date:   Thu,  1 Jun 2023 11:59:06 +0200
Message-Id: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove properties already mentioned by common spi-controller.yaml and
switch to unevaluatedProperties:false to achieve same functional effect.
This makes the binding a bit smaller.  Similarly there is no need to
allow additionalProperties for children, because spi-controller.yaml
already does it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml  | 8 +-------
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml  | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index 2155478bfc4d..a6f34bdd1d3c 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -14,9 +14,6 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     const: allwinner,sun4i-a10-spi
 
@@ -46,12 +43,9 @@ properties:
       - const: rx
       - const: tx
 
-  num-cs: true
-
 patternProperties:
   "^.*@[0-9a-f]+":
     type: object
-    additionalProperties: true
     properties:
       reg:
         items:
@@ -71,7 +65,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index fa5260eca531..28b8ace63044 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -14,9 +14,6 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     oneOf:
       - const: allwinner,sun50i-r329-spi
@@ -68,12 +65,9 @@ properties:
       - const: rx
       - const: tx
 
-  num-cs: true
-
 patternProperties:
   "^.*@[0-9a-f]+":
     type: object
-    additionalProperties: true
     properties:
       reg:
         items:
@@ -93,7 +87,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

