Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4199702652
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjEOHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbjEOHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:45:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F631B3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:45:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96aa0cab88dso521101366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684136728; x=1686728728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UttESFrrEvMiKCOSwouud9SxE7+ngY8bUQ++ZBjcYWc=;
        b=yxob4yxIb4Bg201PdiV7Z3bXOEbeK3d0tu/MOIMdAWdEUFoasKRTU9/SOZajKCOYYX
         xYDF1Y2FwdYatQGEsYdo1y0oYKLEAGg3YFF5YjqYAdZSY42KhkOQAibJmOAbJH7Ix60H
         Qpzt4sAbZyJkWQONK7RkcZKcM3cFjAoBpGF+uIZTmnwWyfMLaBASahRtW4D+zb/dh+Yh
         qLZZJNttxlMs6VfjFD0ji6JjL9QpX98LaOO7SvC1toCU6l5W5j1rsfJ9Gh6iS1EaToWk
         s0oZ6I2/2Qob9ejoYzm0zqIPsdheXhIFIYAKHoWjXgUUZDnJpUuhDgXMZey8wWVLS31O
         +uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136728; x=1686728728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UttESFrrEvMiKCOSwouud9SxE7+ngY8bUQ++ZBjcYWc=;
        b=ac+d+xJOc0ubX6z6pgmocluPCrnkBL2EzvIaiKUj2uanYQp2jtRCgO4BSV4r7PJfhd
         ypNH2Mk5TWrBYhehzBW67VY6BHfeeLRbTnDmQ1dRKd3Go3n2IUmq85Ktntg3M7E7dPi6
         AYsJ0NNn0ge7EDmRz3KZRseqPjWg0KEn6WmZtXXR930+hWbAW6sihRmu9okrUBWtsRC9
         rr2CKl22ivzG8ZWd1F5mOKCSbFq+5WChF8TUwmPWoumOIKozqsUHkPnimHrSuJ9HskNk
         MJh1/8Cvp+LaFOgqc5GfTYLb8FNjic9IrSr/1NULruz9eryStlwsHbwQ6oQhHB8HENo5
         gxng==
X-Gm-Message-State: AC+VfDwBHbClDK6gGZX5i2m4WSk+pIglhfjS2y2h4D+6ygA58pFqam+K
        VRCMqTnuVkFLifPSCoJ+2/lDwg==
X-Google-Smtp-Source: ACHHUZ4YIDCunPW0x2OethflXGWsooFhVmk1Dpl8XCOnCvTtegAd8A3kDg9WRT19l8ogMoVhx4oqCg==
X-Received: by 2002:a17:907:74c:b0:966:265d:edc7 with SMTP id xc12-20020a170907074c00b00966265dedc7mr25335288ejb.69.1684136727800;
        Mon, 15 May 2023 00:45:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id gv28-20020a1709072bdc00b00965cfc209d5sm9163515ejc.8.2023.05.15.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:45:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Date:   Mon, 15 May 2023 09:45:25 +0200
Message-Id: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards use SJA1105 Ethernet Switch with SPI CPHA, while ones with
SJA1110 use SPI CPOL, so document this to fix dtbs_check warnings:

  arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet-switch@0: Unevaluated properties are not allowed ('spi-cpol' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes since v4:
1. Order compatibles.
2. Add tag.

Changes since v3:
1. Rebase.
2. Require cpha/cpol properties on respective variants (thus update
   example).

Changes since v2:
1. Add allOf:if:then, based on feedback from Vladimir.

Changes since v1:
1. Add also cpha.
---
 .../bindings/net/dsa/nxp,sja1105.yaml         | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 9a64ed658745..4d5f5cc6d031 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -12,10 +12,6 @@ description:
   cs_sck_delay of 500ns. Ensuring that this SPI timing requirement is observed
   depends on the SPI bus master driver.
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-
 maintainers:
   - Vladimir Oltean <vladimir.oltean@nxp.com>
 
@@ -36,6 +32,9 @@ properties:
   reg:
     maxItems: 1
 
+  spi-cpha: true
+  spi-cpol: true
+
   # Optional container node for the 2 internal MDIO buses of the SJA1110
   # (one for the internal 100base-T1 PHYs and the other for the single
   # 100base-TX PHY). The "reg" property does not have physical significance.
@@ -109,6 +108,30 @@ $defs:
        1860, 1880, 1900, 1920, 1940, 1960, 1980, 2000, 2020, 2040, 2060, 2080,
        2100, 2120, 2140, 2160, 2180, 2200, 2220, 2240, 2260]
 
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nxp,sja1105e
+            - nxp,sja1105p
+            - nxp,sja1105q
+            - nxp,sja1105r
+            - nxp,sja1105s
+            - nxp,sja1105t
+    then:
+      properties:
+        spi-cpol: false
+      required:
+        - spi-cpha
+    else:
+      properties:
+        spi-cpha: false
+      required:
+        - spi-cpol
+
 unevaluatedProperties: false
 
 examples:
@@ -120,6 +143,7 @@ examples:
             ethernet-switch@1 {
                     reg = <0x1>;
                     compatible = "nxp,sja1105t";
+                    spi-cpha;
 
                     ethernet-ports {
                             #address-cells = <1>;
-- 
2.34.1

