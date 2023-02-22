Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DD69FA11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjBVRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjBVRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:23:23 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C930D9;
        Wed, 22 Feb 2023 09:23:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g8so7279671lfj.2;
        Wed, 22 Feb 2023 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9PdNIUkyOijxkm8lOstlC8GwZtZ2lt8a9Evhp9jHyY=;
        b=XkTDmNQdujDorBXEGlYn8MmYJHDngP+r5qV8JFl16HU3Cd6o5Q+eT84Zatbghp/blU
         Jyf4jKMfzY3cOKgoH2V1oE7QHiDP2VUFMqnocY3mDzrmfnzrr99vMEeoGsGMfgcogfZX
         xAyU52u2dvL95BB4DEG5Hb3J4yn5/VakYa1GdlQiTqyFS91rs34V4h6FahlgeJvIuJBA
         FUgMvxvbhwSvWNXc3zKrgt491iMi4qM6eyubHCK5FmpLY2ntwt82j6GBtpVyShH/t9iy
         puKBoUcO4l4DR35P0EljAFLaSsqU45Qz3gIr3BSeIlIk4oFf/JYwLPtu7/j0F/DoeCie
         TwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9PdNIUkyOijxkm8lOstlC8GwZtZ2lt8a9Evhp9jHyY=;
        b=tMRU4eXwDfF04Ld5TL+SeBSteLPmYRwVffCLI+xD23PZB1o8+KqifxtQVVqwpqe0rv
         /3Y7h56YPE6m5rs9FVMltjwHqR/Appeic5bcRJjGNq54Z7FcTSJMmor1C3b76/TNB/oh
         C+RtGnTo6+DTMrI6gRPJcdX3svwZrWOix3xF/gcRNoKyJWtD7ddoIU9A7oeUNZsnj4/z
         DTo+rnXBhj7p8NR47avrtEI6BlLEDGQYfJNk1ObD4pJ3cBsEsr6jI0rpN2XDrIAjGaGF
         N1uw917hkzhog2O00wLsMeMKrt8ydXz/v9fkFlOm8rngqkB+Z8UcQKeAl9C0BDu+OqJ4
         +IuA==
X-Gm-Message-State: AO0yUKUwiUWy2wEICC7fUhsNlY8gSLCFUI7ZRF7szhVkZjgVG7ZaLEnh
        bsgYnVp36RiDesRRmA01jcw=
X-Google-Smtp-Source: AK7set9BKbpC8Ukkt7GbTONVOGAOFba/xfy892ryKdsUW97CvVgj7f+L6Nf38pA4EnI9bJOkxd/bfQ==
X-Received: by 2002:a05:6512:218e:b0:4dd:9c16:ff7 with SMTP id b14-20020a056512218e00b004dd9c160ff7mr1161984lft.36.1677086600636;
        Wed, 22 Feb 2023 09:23:20 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e93c2000000b0029477417d80sm721513ljh.85.2023.02.22.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:23:20 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/4] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Wed, 22 Feb 2023 18:22:44 +0100
Message-Id: <20230222172245.6313-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222172245.6313-1-zajec5@gmail.com>
References: <20230222172245.6313-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot's "ethaddr" environment variable is very often used to store
*base* MAC address. It's used as a base for calculating addresses for
multiple interfaces. It's done by adding proper values. Actual offsets
are picked by manufacturers and vary across devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index cbc5c69fd405..36d97fb87865 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -50,7 +50,11 @@ properties:
 
   ethaddr:
     type: object
-    description: Ethernet interface's MAC address
+    description: Ethernet interfaces base MAC address.
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
 additionalProperties: false
 
@@ -72,6 +76,7 @@ examples:
             reg = <0x40000 0x10000>;
 
             mac: ethaddr {
+                #nvmem-cell-cells = <1>;
             };
         };
     };
-- 
2.34.1

