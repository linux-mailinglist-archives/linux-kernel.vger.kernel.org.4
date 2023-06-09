Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3E729C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbjFIOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjFIOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:07:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A1B35B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:07:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9786c67ec32so312152366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319649; x=1688911649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HpeQIGODYHiGNSJMSQBwMoymm4hyXLVLPd2HVnrBGo=;
        b=pHD2Wxo2pxl205iXGtKph6ZcHVn1BfhoRC+ZK1oHcGDuotM6Fk1GEwH64l7S9+aIV2
         P9zF+hwcXHvC7f9pYidQ0MhVZl0D0SOdb1A7r0gnVe9dWmwp1rIlLnReI8yFKdfMOSuK
         qziv42dwHwO0mqkdtEYjTF692Z9+pVVed1kW/cezxVtQBC1/NH2fle021m0FuV+mfGI4
         qjqwxOP42Q8lwTonc7VLFrG4WU71WigCKPFjjtpvZK/EMREkKecngF1WLe2PfNe6perH
         J2sY4krSa8WYYKkWoRNnVIp0lcLx3SZU9Irys/16kS9hHkO4Wy0ofVar0yzw9CZt0qBj
         /4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319649; x=1688911649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HpeQIGODYHiGNSJMSQBwMoymm4hyXLVLPd2HVnrBGo=;
        b=Q7JkOP5QWozsxah7RAL6DWxj7Ypvj9no51XLfXSTEUXLDVkPTRNmh6gajPE+QJIFDq
         30KnnviOlxz8fetfeSa7l70vF1Q0Vm94gqtcnm2IWD6bj03hYUOa6ZKzSQlktmdepbaP
         XzZuZihjRI+xBT4LwgK2wtv2T7LFLMJko3xE8o2YRNF+pwRztc43MAW4liBv9B9MVjQu
         2Ciaq0V7pwb1obijxkY5OxVu/AxVF0ysh7uASdPNTNzfZesYjwfFIstTG8KotCufcUfB
         d+cwe2oEc1e7VovdqESW7wNcW3VYCNZ5vpc8p2fnb0rPE+7YuCMKYZz0cCNatloBzQH0
         ZqNA==
X-Gm-Message-State: AC+VfDyVBm5mEiGW5RV9fj2cefAX3sV/NGRCjfplysz+7kqLqV8gn7Kb
        pwIKOrA3BUyG1HdwhwDOIgTvaw==
X-Google-Smtp-Source: ACHHUZ7wlJsxn5X1kZkujNDi1sdAIGPpKLmfLVyoRs08KWVtW6wXqss1eE8xxbnfA1mnP6w9EphneQ==
X-Received: by 2002:a17:907:3687:b0:974:4f34:b04a with SMTP id bi7-20020a170907368700b009744f34b04amr2046459ejc.34.1686319649094;
        Fri, 09 Jun 2023 07:07:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709061b4600b00977e4c1727esm1343394ejg.29.2023.06.09.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: leds: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:25 +0200
Message-Id: <20230609140725.64771-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/leds/leds-class-multicolor.yaml         | 2 +-
 Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 31840e33dcf5..e850a8894758 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -34,7 +34,7 @@ required:
   - color
 
 allOf:
-  - $ref: "common.yaml#"
+  - $ref: common.yaml#
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index 64b0be9cf70b..58f0d94c6d71 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -32,7 +32,7 @@ patternProperties:
     properties:
       rohm,led-compatible:
         description: LED identification string
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum:
           - bd71828-ambled
           - bd71828-grnled
-- 
2.34.1

