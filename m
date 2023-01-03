Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14C65CA61
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjACXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbjACXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:35:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EBD165A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:35:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so37598347lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INGl8EC4lutAaxK7oytOrepZPv62csf4zgf/Dha7g08=;
        b=tUh9Qclbxwes1y19TozU8R6/M6yFHt0Tf/7Uk9vnG8eT3MKTfnZ5FPazeKrWpGZ/Zs
         FDHCXMqufboxBhsvccZNg7j44bIL/+rNLP0e+70HxzbS67f4vUXHkOdA5Xu5FdYxlegb
         o9SYgd7W1epIDogWkpbLTzQihLn16sHKSZAXrU9AjO4LQV47d63ABNKdaa+4pNhBMVhG
         Rd9wRbiao8kN0AZQX6BTdOQxwrfmAhr00DTDe3ra1H410N6socCrzWGi30Sz09qMVa42
         pJp1lr6X8SfBhq+IueeYNKSdxR/3/E5Z60dCUmMUcUZet97rlLEZYSY+kiS1oHAkmJky
         zDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INGl8EC4lutAaxK7oytOrepZPv62csf4zgf/Dha7g08=;
        b=2yV5Fa29Y2grpoP6pxZd5HwJx/2x8TuK6U21yPbp5zLjeZdjQg+59hD/RdMwEBWECh
         CCbs88JqWBP6Fu1sPguCmkJOLrpsncNhwO/YasJhRtnQzLlvoB7uMikR/OxRQEhhw8ya
         Thw+OxkCb3E3GfVw2KOXzCkYdZ6/tK2ZI4tfP6EM24/PUWmfnrmW5V4JJSC2arRGL7sv
         16pqyASfqmyPpQN+TDHOmXitpMjxP599q6NhCOwPjWikE1cAkajtjcwgoVjjD02EEGcb
         6PbUOIkx5YM2xEBOnVpxkSm0zlBXX/2ObjdcMTIxuowtasMONUHoSJ/76Iw4yE9mIXGq
         vebg==
X-Gm-Message-State: AFqh2kro0pkIiBkTsbROFWydxrF5Q3wvmdOw7jjvxImvqHETWuTJowBU
        FEPt9IuRztGAy7lYCNsWv4Cvjw==
X-Google-Smtp-Source: AMrXdXvAhYJCpYRkWDTIDmckimmTS2x6TV9+jF5DsOMDB10ivmTBIrIyYglIf0/N5/eHOWrkh4XH1g==
X-Received: by 2002:a05:6512:3ca9:b0:4b5:61c5:8927 with SMTP id h41-20020a0565123ca900b004b561c58927mr14359517lfv.42.1672788923444;
        Tue, 03 Jan 2023 15:35:23 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b004a45edc1de2sm4939801lfs.239.2023.01.03.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:35:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 04 Jan 2023 00:35:17 +0100
Subject: [PATCH 1/7] dt-bindings: usb: Correct and extend FOTG210 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v1-1-f2670cb4a492@linaro.org>
References: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>,
        Linus Walleij <linus.walleij@linaro.org>
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

It turns out that this IP block exists in at least two
incarnations: FOTG200 and FOTG210. The one in the Gemini
is FOTG200, so add the variants and rectify the binding
for Gemini.

This affects things such as the placement of certain
registers.

It remains to be seen how similar this block is to the
third USB block from Faraday, FUSB220.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/usb/faraday,fotg210.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
index 84b3b69256b1..12d4fc742f20 100644
--- a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
+++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/usb/faraday,fotg210.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Faraday Technology FOTG210 HS OTG USB 2.0 controller
+title: Faraday Technology FOTG200 series HS OTG USB 2.0 controller Bindings
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
@@ -17,10 +17,11 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - const: faraday,fotg200
       - const: faraday,fotg210
       - items:
           - const: cortina,gemini-usb
-          - const: faraday,fotg210
+          - const: faraday,fotg200
 
   reg:
     maxItems: 1
@@ -66,7 +67,7 @@ examples:
     #include <dt-bindings/clock/cortina,gemini-clock.h>
     #include <dt-bindings/reset/cortina,gemini-reset.h>
     usb0: usb@68000000 {
-        compatible = "cortina,gemini-usb", "faraday,fotg210";
+        compatible = "cortina,gemini-usb", "faraday,fotg200";
         reg = <0x68000000 0x1000>;
         interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
         resets = <&syscon GEMINI_RESET_USB0>;

-- 
2.38.1
