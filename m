Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF4663EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjAJKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjAJKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141013FA9;
        Tue, 10 Jan 2023 02:54:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v6so16892841edd.6;
        Tue, 10 Jan 2023 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLzMMc8ebvQzEKmQRYFOwkLETqyrkUTk5WSaxVlJTiI=;
        b=IsCWQtuQDU5qsCQI6/tTjUWEUyImFFhL4B88algPA7RIysJjlhBgZeDzBc8/3lxixG
         2FDafXmGbGiPQ3OrB8GT3/BcYy6bFRMqVCum8+O7UnoyfTjeenl2qQmY6IyvHrLMZbtw
         JNN7WJ02vfrAog/W9sGzUeOaa9i3NGxVgZVQv/AnovdnEOkJPrdlbhBvaGJOH+u2rpRU
         b7cp50CEW2thZQstFlNoy0qQdQEBNetkrZTJb3/5aMTK79wMmBoswM1IuCXYanY94OpM
         4/5/TKPWlEgSjc6mEJk/sWXbsF/MC9z9vT9X+IX+wT3f5Ahiab/K1QKG+NuLbWo9XACP
         2jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLzMMc8ebvQzEKmQRYFOwkLETqyrkUTk5WSaxVlJTiI=;
        b=tmBIXqHkEbigENWUcPsO8SEJ6mYXMIWpWGY9xFcItGZ4tvOq5sWWFVwWqsVOMYXcoD
         HyVfAoItCOfVezT7jKPdTwGGEHJXl3rMcsJKDwZ6XfTbUc0wA1oeF/r3tKU26eVuYcQw
         Z6tdDDZObSL1Pe7YS8a7N+GE2ipiu+1B+5R1r2vzA7zUjpDVoavAt9jKoAmOsedY4BDR
         lw8qPs0q9gcjVMQxUm/a+ftsp4pxWdPxpbqMJA7u7fP5Gr7GVYIlixZ1ogpoV8AZcY4Y
         C1vdDgK6B/kExfzMmP9FmKdSTfzRVn/dsGQwZWRKf5pPRq0WcwDYiWYPaZ6VOQFaJpYb
         dkyw==
X-Gm-Message-State: AFqh2kqzFztV0tXW0zuIuYyjEOir8J1aWTxT8YkXKvNzBw8PPk8hgIwN
        tA/LD1PyyKuM0cMx3MZSEN4=
X-Google-Smtp-Source: AMrXdXu38Gs7Qnlsw9kDlHcdMDp/WAeOqy1ZliIhH6aoLn9i+awk7EjgqndYA5XoH55hAoDmQyfXEw==
X-Received: by 2002:a05:6402:1caa:b0:475:b14a:f83a with SMTP id cz10-20020a0564021caa00b00475b14af83amr53164998edb.15.1673348077948;
        Tue, 10 Jan 2023 02:54:37 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:37 -0800 (PST)
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
Subject: [PATCH 3/6] dt-bindings: nvmem: convert U-Boot env vars to NVMEM layout
Date:   Tue, 10 Jan 2023 11:54:22 +0100
Message-Id: <20230110105425.13188-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
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

