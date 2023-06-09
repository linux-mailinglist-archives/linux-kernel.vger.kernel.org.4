Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65A729C55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFIOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjFIOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931993C0F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:07:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977d02931d1so274214566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319674; x=1688911674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vuuH12IFYzE8hSEom6ACjhga+vJ8Y/H3cnZUjmxwo0=;
        b=JtP8ZGwKiKVR9ztC07TLerrR2Uxqkt5Ox3XUhN0+sESN99DQUWXct7i1n4UUWpjCjW
         /PbkfRUGBAQ+bmuqF5p3hOmnG9mO43gbKoSKbh77vKQ2l+cvecsCYETjHxG1AUhlnjHB
         oplUWEUtsY3z+rLu58KPl0HQdEY47WZic5K0JTkmPHBMcL6dl2d5KwF0narTk9/Ux4kb
         /vQS1Qmjy6G6BXHiPk3U4pk2pepOfGfRvi0sOK6luWZz4pvabw5jC2qtln4SzI21HgqC
         dOOY6z+757Ds0KILE1JmuyoOJH9K0o94pjOUz+0TKqCv/u27YU3/Qjc29pIoiS3c29qZ
         kdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319674; x=1688911674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vuuH12IFYzE8hSEom6ACjhga+vJ8Y/H3cnZUjmxwo0=;
        b=XapsGnTEIgFgBo41DSTWh9FI0Sc5zMnANxg1MT1BypYog8mrggSPVN0f9c6NjtIHE2
         wKU7LUV6h4DrzNZfmL72ghX6l/RBygjphrlAguceyN6WRwOoXKY9T5i75PCrqyVeQLc2
         XtGl+xCrafkjWBf2D6UfbU37nfHnrmSeX4K6TyKxQS/zZ9T5eP7Ar7I+99Kbu1vf93bh
         Z1dZFs4Uh+umUuARXJltyzjSlqRXefKvlA0l1I4wWwMJltYbXX9sojc2xy+Lutd9VOfR
         dr7wZ6Ku0m0imRPTZrbcUHxXHmjwYjhiBB6GIpj7a5my7nCmpPzXNIEE3pytrn21rhqh
         0cZg==
X-Gm-Message-State: AC+VfDzTOots+r+1RMIWjp0jS4U4MA2WuRhbuVGfVgzJ61VFiomy+hri
        tpoa5gaQX0yr079lO0XfUfR5pA==
X-Google-Smtp-Source: ACHHUZ5MsU3kZrlq0EHll8zAjRlT4wiVMedsx6Lb2KqQmJZoJPwkDb+hz8M5k8j3xnrrBkI/nyEgtA==
X-Received: by 2002:a17:906:ee82:b0:96a:ca96:3e49 with SMTP id wt2-20020a170906ee8200b0096aca963e49mr2011879ejb.13.1686319674156;
        Fri, 09 Jun 2023 07:07:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b00974c32c9a75sm1317644eji.216.2023.06.09.07.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: drop unneeded quotes and use absolute /schemas path
Date:   Fri,  9 Jun 2023 16:07:51 +0200
Message-Id: <20230609140751.65129-1-krzysztof.kozlowski@linaro.org>
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
checking for this can be enabled in yamllint.  Also absolute path
starting with /schemas is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml      | 4 ++--
 .../devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 9e733b10c392..509df06b9c9d 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -98,9 +98,9 @@ required:
 
 patternProperties:
   "^usb-phy@[a-f0-9]+$":
-    allOf: [ $ref: "../phy/ingenic,phy-usb.yaml#" ]
+    $ref: /schemas/phy/ingenic,phy-usb.yaml#
   "^mac-phy-ctrl@[a-f0-9]+$":
-    allOf: [ $ref: "../net/ingenic,mac.yaml#" ]
+    $ref: /schemas/net/ingenic,mac.yaml#
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
index 99686085f751..26d94cedc871 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
@@ -48,7 +48,7 @@ properties:
 patternProperties:
   "^dma-router@[a-f0-9]+$":
     type: object
-    $ref: "../dma/renesas,rzn1-dmamux.yaml#"
+    $ref: /schemas/dma/renesas,rzn1-dmamux.yaml#
 
 required:
   - compatible
-- 
2.34.1

