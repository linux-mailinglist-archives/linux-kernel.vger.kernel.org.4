Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA26D7E89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjDEOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbjDEODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A7729A;
        Wed,  5 Apr 2023 07:01:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a44so18758722ljr.10;
        Wed, 05 Apr 2023 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kEpFJSLQ8LuijRNCE1GflXz6A3tNgKwJ9XWnGsb954=;
        b=HywO5JxM90BaXLZoJ5SdW/n8CKGwqjoFou8tbU3RPTvez7ntTaBhDGKin2tO1VL5Fz
         qk65aJHkMaY5g8xssLhCLpiD7t+VS3sXi9ai1OLU5jjU8HtfVLiaSR42UPTXRTB2sATt
         9LAEevwZH0eDCCcUFKWN8ctibZjpLgaOPvqT8AwYIpq6ULgeviZ02ebGEKG0IX+k7DuB
         OqUOibuHBMQahXW0uwtyqJIhv/9EWiI/fEAr7Y5I912WLCflL2ICNjeMV7IYI0upi9S8
         fDx7Hj9Iy/udXiUaGdZzYbeAEidcfrtdnUUmfv0ju8i8XM+tjYGP/d54TMqvc9t6tKnx
         VorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kEpFJSLQ8LuijRNCE1GflXz6A3tNgKwJ9XWnGsb954=;
        b=vjvsu5drKFXsUOrYAySBNwRLASAJC/WK1XUpzLQqZV2wvH6301eBtxw4HejcmJ3AIl
         Yzg9YPqOBXzmX3vafo02nLmCY84WF6kfv/Ev/mp8gLYZhbqmx7mr9uRrynfFwTXVPhKX
         FWr4Wz77bftQPr2KSy7FsalDgCe1TXU7jxFnSC+2SYOZVkeMmdbNFT0+0MBDW32x19qj
         3WiSZYhblpViSvjoNXI0my1Dk9pX/nzKnWEvNY2giOVBawzN7GFdXJZgJLXen2qfeRUc
         ItSNEF/M6RZlI22it3TVOFmDio8HZmaOCvbaU89FXOlHfgSfXGzyFvodRVwKJQWdnGVF
         9Itg==
X-Gm-Message-State: AAQBX9e5SuIuzRRGrNkC0E5KA7Crg4RX5yCxhcStFhIAXczwtSby4wPN
        g2fSixBeZ+xFTioi94ExfeQ=
X-Google-Smtp-Source: AKy350aJvXnN1jyTntFpnUvVePZdTUkqffK34fvAXYEZlDTuP1r5VAHxnz07gxcQiSgHfGIUkeQnOw==
X-Received: by 2002:a05:651c:22f:b0:299:ac49:46da with SMTP id z15-20020a05651c022f00b00299ac4946damr1787725ljn.42.1680703292092;
        Wed, 05 Apr 2023 07:01:32 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm2412383wmq.2.2023.04.05.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:01:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Welling <mwelling@ieee.org>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: iio: dac: mcp4922: add vdd-supply property
Date:   Wed,  5 Apr 2023 16:01:11 +0200
Message-Id: <20230405140114.99011-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These chips have a vdd supply input, which should be modelled in
the bindings as well. Vref is only the voltage reference supply for
the string DAC.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../devicetree/bindings/iio/dac/microchip,mcp4922.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
index 19374401e509..a3e80e90eeca 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
@@ -21,11 +21,14 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply: true
+
   vref-supply: true
 
 required:
   - compatible
   - reg
+  - vdd-supply
   - vref-supply
 
 allOf:
@@ -42,6 +45,7 @@ examples:
         dac@0 {
             compatible = "microchip,mcp4912";
             reg = <0>;
+            vdd-supply = <&dac_reg>;
             vref-supply = <&dac_vref>;
         };
     };
-- 
2.40.0

