Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3396BFBC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCRROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCRROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:14:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1829C1B314;
        Sat, 18 Mar 2023 10:14:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s20so927857ljp.1;
        Sat, 18 Mar 2023 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679159657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9PdNIUkyOijxkm8lOstlC8GwZtZ2lt8a9Evhp9jHyY=;
        b=dpH5VunWjpCn63iFcoDNWtxgyMVveYmI8v67tXbKoiIa/DfhM/on2j2ky4/cKk8HPC
         lAxYE8b0J+wAUWmLrOLJ4D0o56TnkTaw2zmM5Zeo3yLTFsfEaHZf6SKrQiiODJC+wRYm
         SJm+h8DnEODr34Lqtfm94BvIv6GInLXFhl/VOqtKma2Z9361PKm7w+eFQ2v5yWxP8YaQ
         nAmSaedWvl5bF05m66BqHK6fEk2+V/gG39qJc01ZcleezpD3JWf278ZimIJ11TxUB2B1
         KK7Ya9FOf6BtUg/I7Z6psaYiNnZ3wQp/6lHL0NFtAM/abAYtpjVXL2lscepAhz5a+6dO
         5vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679159657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9PdNIUkyOijxkm8lOstlC8GwZtZ2lt8a9Evhp9jHyY=;
        b=hhWs9YFZtm2/gVV4hXLeeK/SapVnxb4HazHI0p3IPi5MNEnOl9SgrOrtklHBlOxMg/
         ZusrCYcV2KKCxNtXw/FkOrSC1TG8LCddDIyLe5tc+J4ieZ+EFB8RCedCNeZMPVpPud3M
         NrNKownFrSJhxm3k6WXx8kOSGcu0GqggBqwiASFzUdq5iXjN8UBDju2xmOANTKJIA4IP
         qNLEVLMLpX/V2OOUj4qvKFuWQNpI4PctKuiT6+DMIt+LjgfgqXb9e1EoHrcVNcayPu42
         TJlyl3k34jt59jQJ7FNnOM14tQeCQAD5R3dvpjC92YJczxjBDPleSYnf6tQEEKUob5eb
         m1Dg==
X-Gm-Message-State: AO0yUKWtXxSCDw8HCPxzi0AfNPQmyktD9EroDufNS0w42OPwqGZenmf/
        5I6HYPwhFnnh13pw/vXYNMA=
X-Google-Smtp-Source: AK7set+ubWVjoJl1oeOHI9nP6gLMYPK66IIBurwMgzxnfjH97r8QI+YZvhy4zjtezMa0TBMw3nWSTQ==
X-Received: by 2002:a05:651c:511:b0:295:93eb:e795 with SMTP id o17-20020a05651c051100b0029593ebe795mr6313453ljp.41.1679159656632;
        Sat, 18 Mar 2023 10:14:16 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e80c9000000b0029573844d03sm929221ljg.109.2023.03.18.10.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:14:16 -0700 (PDT)
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
Subject: [PATCH V2 1/3] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Sat, 18 Mar 2023 18:13:54 +0100
Message-Id: <20230318171356.29515-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318171356.29515-1-zajec5@gmail.com>
References: <20230318171356.29515-1-zajec5@gmail.com>
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

