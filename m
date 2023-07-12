Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E981475005C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGLHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:46:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162F173A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:45:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso10366790e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689147957; x=1691739957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pebAsfz/DVvDsj5RbKcteoVoBJD27FSwU5r3Wri7LCk=;
        b=HL6YR07d/vOgm0OMRsUstV38BpDXG0hMCdU9gCh0P3Yyz4eLQA85StITyqM9W4tcM8
         nO46ikXlottN694F81ETrKz7ojBsCP2xeSSgKg4XAo5OBnH0VxyjzkMmvz1VXgiVhcaZ
         0gGbXBlmZVwlyvcUZEDM3QlYfI6IgM9n+/GqzWvJjWDEs5hVVf9bcUg99oGPdST/aI6X
         U6o4vVRfWaFZpn/qCiUAEV8HkWhxuELCJAepAzw/mxDfmTO4pfpHKylApcbnMsR9yvcJ
         OEIIevT7vjxTbT6YyL2ldHfj/kxUzqGn8rnNmYKtyJpypZ8BEjFz7RSoASE/OWnjTh+F
         9zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689147957; x=1691739957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pebAsfz/DVvDsj5RbKcteoVoBJD27FSwU5r3Wri7LCk=;
        b=dMBog4pMHPjkWDBr8oaQmFXBgubW+GKGVccHeQrEMFOEb3+KO19usb+FNqIq59oiOB
         TRo+z55hhX7JhI4CH6KWfSdHvCORzBAzYiWHXat4ZZGhZjm9oolFmaQCtTuLbMZlBYO2
         6xs4iLYAHLixpr5uf6Z59q6hitwPEjB4fSYoek3HJ72f5oM6DqD3cygVBj+o4WgGcMZS
         CPpQ7LoD8Yi/32QkGFcwvDZ8+iq4/VF/ap5VuV6JcnN6O1KfYNT6cWH6xBM3UwzWUukt
         Iss+Soq53mvUdUpwjFGSqw49DqlJwQW0hot8nsqmlMvt/9PIimoFm6ZUYVysno4CpG8m
         VY9g==
X-Gm-Message-State: ABy/qLZp46Siy9zO6Q4dONGmApyUImnA957+/fI3URz9SxI9T448zKPi
        oFLdEebEBOKnir7SpjgWFNbNFg==
X-Google-Smtp-Source: APBJJlGWq3lc5m7abWB+8YEqLMEFLf3rl5U2j6t71fkG4aRelp0lwjWFC5YDxhyyi9mcuDlTUIL5LA==
X-Received: by 2002:a05:6512:3da6:b0:4f9:5933:8eea with SMTP id k38-20020a0565123da600b004f959338eeamr18436879lfv.3.1689147956959;
        Wed, 12 Jul 2023 00:45:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b0051bed21a635sm2352706edu.74.2023.07.12.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 00:45:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
Date:   Wed, 12 Jul 2023 09:45:53 +0200
Message-Id: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the GPIO controller subnode to define GPIO names.  Already used in
at least on DTS:

  bitmain/bm1880-sophon-edge.dtb: gpio@50027000: gpio-controller@0: 'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
index b391cc1b4590..209f03bba0a7 100644
--- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
@@ -61,6 +61,10 @@ patternProperties:
       '#gpio-cells':
         const: 2
 
+      gpio-line-names:
+        minItems: 1
+        maxItems: 32
+
       ngpios:
         default: 32
         minimum: 1
-- 
2.34.1

