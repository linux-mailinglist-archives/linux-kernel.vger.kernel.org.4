Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680D66552E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjAKHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjAKHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:31:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71DE9;
        Tue, 10 Jan 2023 23:31:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so19850738edi.8;
        Tue, 10 Jan 2023 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLzMMc8ebvQzEKmQRYFOwkLETqyrkUTk5WSaxVlJTiI=;
        b=AdHiFpQdoA09CZEj5w953fkCedR6xXBwi/v2pnfJIvJChAWTHwFHisWOe4bheUZDRA
         A8enp6oPE/6Muccn+lVT364GP9a1S9tZ0xS3KOH8kMNabGN3kY0+cAxueomtqqaBUkXU
         3BDy1nuUAK4PLPLkKFmc9zgxRGVv2kLmceDzKhJghJUhnBg6sqkrW+lfFwRhAwJ2mxbG
         YtbmDPIWuVjWLU1zzCHSemztcPOSd4IwR93eb9ulpwv3tBtJGceGcSSGtIrlv4VTK4ms
         JptkRFpb31kyO1B5urcjh+twOef07Rj5em4haoU1WtaorRxPBVFqLLL5hSqbosCxdCw8
         /wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLzMMc8ebvQzEKmQRYFOwkLETqyrkUTk5WSaxVlJTiI=;
        b=1r7Ed9F2DXly01+3aubMR86oQlV9LwSsJJ5I2jnRnYPIqKUP6wWk19HnUgRZYknYlq
         PZqj4oGvi2ZERkkSEXd9DvyruVh+ohJ/S9kbFS1VIliLmtVWFey5CjZ5EwG/LkYJaYkt
         DNhnKHJM6YIcPWrnjknTjEPPVhCYAA8hFbqJizcdYrxYlQTwkh4PC8ILXIuGLvMQ43jD
         Iax+j8XeKcNWTcgV76nKkyUmGwD8h8fyLYfUzsDCdYolnVOvlJgnxgnvHbUHYnvaWNcx
         ORNY/Vskuo16jPgqJlmIVrsBV0hADjw7/fruKkVDWyGdjDn1JAMlnWMiQ96uIuwcl5m4
         FR5A==
X-Gm-Message-State: AFqh2kofDKKy8rA44VQzvfmW/XAyCXwt8bA9wkOErSD3qm1opdlDasGI
        +d/S9YWUPRzwApHwjNBmj4E=
X-Google-Smtp-Source: AMrXdXvXcOBuq4tt32IRxlFPwJkena6RpsWqDJWjTvn1AZibTtum4mml/kSn4pbl6DxqtXfDduQ9hQ==
X-Received: by 2002:aa7:d752:0:b0:499:bcfc:f47b with SMTP id a18-20020aa7d752000000b00499bcfcf47bmr7436081eds.16.1673422276146;
        Tue, 10 Jan 2023 23:31:16 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id ed6-20020a056402294600b00499e5659988sm593193edb.68.2023.01.10.23.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:31:15 -0800 (PST)
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
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/6] dt-bindings: nvmem: convert U-Boot env vars to NVMEM layout
Date:   Wed, 11 Jan 2023 08:30:59 +0100
Message-Id: <20230111073102.8147-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111073102.8147-1-zajec5@gmail.com>
References: <20230111073102.8147-1-zajec5@gmail.com>
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

U-Boot environment variables can be found of various underlaying storage
entities. This binding should be defined as a layout on top on NVMEM
device not a NVMEM device itself.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 .../nvmem/{ => layouts}/u-boot,env.yaml       | 29 ++++++++++---------
 MAINTAINERS                                   |  2 +-
 3 files changed, 17 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (77%)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 8512ee538c4c..8835b1781a9f 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -20,6 +20,7 @@ description: |
 oneOf:
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
+  - $ref: u-boot,env.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
similarity index 77%
rename from Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
rename to Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index cbc5c69fd405..fb273b174fe7 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: U-Boot environment variables
+title: NVMEM layout of U-Boot environment variables
 
 description: |
   U-Boot uses environment variables to store device parameters and
@@ -14,16 +14,11 @@ description: |
   Data is stored using U-Boot specific formats (variant specific header and NUL
   separated key-value pairs).
 
-  Environment data can be stored on various storage entities, e.g.:
+  Environment data can be stored on NVMEM devices of various underlaying storage
+  entities, e.g.:
   1. Raw flash partition
   2. UBI volume
 
-  This binding allows marking storage device (as containing env data) and
-  specifying used format.
-
-  Right now only flash partition case is covered but it may be extended to e.g.
-  UBI volumes in the future.
-
   Variables can be defined as NVMEM device subnodes.
 
 maintainers:
@@ -67,11 +62,14 @@ examples:
             read-only;
         };
 
-        env: partition@40000 {
-            compatible = "u-boot,env";
+        partition@40000 {
             reg = <0x40000 0x10000>;
 
-            mac: ethaddr {
+            nvmem-layout {
+                compatible = "u-boot,env";
+
+                mac: ethaddr {
+                };
             };
         };
     };
@@ -87,9 +85,12 @@ examples:
             label = "u-boot";
 
             partition-u-boot-env {
-                compatible = "brcm,env";
 
-                ethaddr {
+                nvmem-layout {
+                    compatible = "brcm,env";
+
+                    ethaddr {
+                    };
                 };
             };
         };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a1368722c45..2e13ee875c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21136,7 +21136,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
-- 
2.34.1

