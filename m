Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35124729C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjFIOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbjFIOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:07:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8435BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:07:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so2752533a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319626; x=1688911626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OToptLfKkpAj+EMrcxNGnflmwbvM6WNt+MwCx6/njFk=;
        b=o/aNa3DxA3cMiE+xzApZI9BwyjcEuMYHmp8UTzc2gUPsdCh2SbdVkEvR46tZcX24OM
         4oXv6GWZVCkJxsTbvmSbkbV8/El8rjidT1vNJkk8r2elfgeWTg9hYRQ/Eszq/lbmBMD0
         8kjZl940Noy5PBv6lGeLW9Ws9QS3nBxpTeqM5chjRqRd/Lu4B5PasQNfzVeExBqZ3d3L
         h/RCTjbUQeQer335wdG2ziHx18ZhTQWtrhjwFRP9JLo07XLPUMXk6FEiaRxoIpkBh419
         2LAvCS96sI069WaM7Zfp+P2VX4vOc6b141G1b4VBHHu+4E2I86SXoaBBLR8RW8V30dx/
         xarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319626; x=1688911626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OToptLfKkpAj+EMrcxNGnflmwbvM6WNt+MwCx6/njFk=;
        b=hEFeqQkyIYKqWygArI1NIOKaNyQpYKKvCI5J9TLo/sYMbuOwhhx6kfoSt8xot1sibe
         Nam7Ca7l0MBiHIPAy4f1EtLctcn3KOZQBb8GoftTeIPaRogN5fTiiqCJJT2EYhJ/6uCJ
         nzna/crlSP7OX1olC50Lm0Vz0ida9qCF8DVmW/YDEZvDkekp8EhD8B2RdFjb6yzmwuY5
         YG2THFvRYtfg1pQILLWtIYT9khtkXFl2PDsfvmn72/chRXqjgV4jmuCulE8F5aAOXVRi
         kjIQ0hAFU2BQykVR2XwFFWKc9VLNGSKJfOIA3fSJD8vgZuFTI+dp4IoBJxm1nQx59b8b
         gA2w==
X-Gm-Message-State: AC+VfDxFOZ1+mIiQUv/A0UaX7krFZw+aQH8k/GcdbYoyQ01QzA1CPZvj
        PSvfx9QcU2UyjToZNyeloSqqoexMn3sujBXZx8c=
X-Google-Smtp-Source: ACHHUZ4cKa4ceRDfYpuqBNzldnl+6HGlfQBymnqN4Qe8hvlJWFONnyWZIwMKNaSai++5+c4RkU3c3w==
X-Received: by 2002:aa7:cd66:0:b0:514:938a:67cd with SMTP id ca6-20020aa7cd66000000b00514938a67cdmr1166102edb.38.1686319626157;
        Fri, 09 Jun 2023 07:07:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c74d000000b0051823c1a10bsm61961eds.54.2023.06.09.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: rockchip: grf: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:02 +0200
Message-Id: <20230609140702.64589-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/soc/rockchip/grf.yaml        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index bf2370c66ed9..e4fa6a07b4fa 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -121,7 +121,7 @@ allOf:
         usbphy:
           type: object
 
-          $ref: "/schemas/phy/rockchip-usb-phy.yaml#"
+          $ref: /schemas/phy/rockchip-usb-phy.yaml#
 
           unevaluatedProperties: false
 
@@ -136,14 +136,14 @@ allOf:
         gpio:
           type: object
 
-          $ref: "/schemas/gpio/rockchip,rk3328-grf-gpio.yaml#"
+          $ref: /schemas/gpio/rockchip,rk3328-grf-gpio.yaml#
 
           unevaluatedProperties: false
 
         power-controller:
           type: object
 
-          $ref: "/schemas/power/rockchip,power-controller.yaml#"
+          $ref: /schemas/power/rockchip,power-controller.yaml#
 
           unevaluatedProperties: false
 
@@ -158,7 +158,7 @@ allOf:
         mipi-dphy-rx0:
           type: object
 
-          $ref: "/schemas/phy/rockchip-mipi-dphy-rx0.yaml#"
+          $ref: /schemas/phy/rockchip-mipi-dphy-rx0.yaml#
 
           unevaluatedProperties: false
 
@@ -186,7 +186,7 @@ allOf:
         reboot-mode:
           type: object
 
-          $ref: "/schemas/power/reset/syscon-reboot-mode.yaml#"
+          $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
 
           unevaluatedProperties: false
 
@@ -241,7 +241,7 @@ allOf:
         io-domains:
           type: object
 
-          $ref: "/schemas/power/rockchip-io-domain.yaml#"
+          $ref: /schemas/power/rockchip-io-domain.yaml#
 
           unevaluatedProperties: false
 
-- 
2.34.1

