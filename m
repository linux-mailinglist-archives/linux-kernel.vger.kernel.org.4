Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2D67E5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjA0M5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjA0M50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:57:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B317D299;
        Fri, 27 Jan 2023 04:57:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p26so2233320ejx.13;
        Fri, 27 Jan 2023 04:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu06/R6jtaPsdOb+3M2mEKtYsdSHx6tfbfAcrndOQiY=;
        b=RDP38X1zJPgqzvN1XCkEq4SVPmTQJgz+TtoZ7p0KPbx1HzpefwgV2vrv9+u3ztby+C
         qEuJMPPnNz01zSJ+T+PdJoEC6KDvVw4vaT0vM1cAwh4t5HDF7UiAmhA5k0+R0bCU9NKn
         CIr0AQlSY9uqDjDhm3imWKkQQeDamC2guKI8dJTdCR0mASfR1Et9eG8Mhj4r3GJcFUtS
         SDhDg7+5ElZpS0RIMNnMuu4LlCtXGXsrT0GXlR7tlOOkpZ5/AkzbbReCT9bDTGlPWXba
         8xgLTnW16ajKyA4K7/LcpvJcvIqTPg+0v2/R8gaMmkqll+bDZQMn6SOPUY8tv+m5Wvtf
         Q3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu06/R6jtaPsdOb+3M2mEKtYsdSHx6tfbfAcrndOQiY=;
        b=zMBJYIxTCYJ/drcfRGBtXI49E1swbBnfqoU7LUApdHOUaEFitHMr3Ro9BUGS/tHoXl
         RycYyGEv3R1k40nMa4XG8HKe9I/XH0Nls0a49AqXntpEV6fAQaSDQmdp9kDrgIFU2dFM
         gLwC1MS0N6cdquBO9o7DspKixSMGjHqLtHAPOPBqAlBbcmeqThyCP/TBAujunUnhPjib
         HDXDc8Df4QmL1vxSVPQiQW8pGg+b4JuRtSiwXcADZ0WDHTgtYWCK8uJJ7mcGOTNNsu+b
         Kyl2c3t08yRNolsxxJegRZwArJN9lg8c4LtPeXnt2Dqrkx5HUYM9DpLKbqCBNUgdwoF1
         rpjQ==
X-Gm-Message-State: AO0yUKU0DbCETvjKjOdCynCN4rxmixMSIPWLW29mBjcBByTnJqUckHnj
        eiOSZhetRFlif+l6bncdwmZsNvSCkw8=
X-Google-Smtp-Source: AK7set9CIj+dNhjJCL5JmCTdK3ABAk72t2Rmw7D90StGXtMj9uFqz2mT5mgzRXOP+GBUpSLG4g5q1A==
X-Received: by 2002:a17:907:7f25:b0:87a:4802:cb4f with SMTP id qf37-20020a1709077f2500b0087a4802cb4fmr3981598ejc.76.1674824242666;
        Fri, 27 Jan 2023 04:57:22 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402358500b00482e0c55e2bsm2248136edc.93.2023.01.27.04.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:57:22 -0800 (PST)
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
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 3/6] dt-bindings: nvmem: convert U-Boot env vars to NVMEM layout
Date:   Fri, 27 Jan 2023 13:57:06 +0100
Message-Id: <20230127125709.32191-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127125709.32191-1-zajec5@gmail.com>
References: <20230127125709.32191-1-zajec5@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 35385df2302c..1373154c0b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21214,7 +21214,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
-- 
2.34.1

