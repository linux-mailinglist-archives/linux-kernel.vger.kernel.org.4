Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8C602FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJRPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJRPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:42:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93081B56C5;
        Tue, 18 Oct 2022 08:42:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy4so33196050ejc.5;
        Tue, 18 Oct 2022 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6V4GGutCgqH9SAAugBYUbePwRzXguzjtNw602xA/gE=;
        b=mHm+3pWbcBXYNzpH81/lPhpNc0B5kdPfe11TzAwKplI3MeDt+vueDt94EyEvU1Sp/9
         FG7s+qK49MByuxF/6qySYFNkRnj6YmVQQEE8HHmga3zOcvsVUPoRbh5/mWw2A8h+CosA
         443JPbvEAxAPNq/5WHvZnMihOiVz1OULEPw6NGmo6iRZMTZVReFpSbtdIE/2luLroH3l
         7acYUGPBANPm+bneNLEmYehFT74EjsE/BD5l0SplQu2yBTl0Otb6yxygQGBfyJww9O47
         siGdsYoNyCv6f7moBSe45FPQAvagtdUYy1gQ6hueJSaHwvMavITll5AvKH7uzXQC3EX0
         U8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6V4GGutCgqH9SAAugBYUbePwRzXguzjtNw602xA/gE=;
        b=H6TnyLY9o/C18/ZQ65lv2nhRx5nE4cV6g1inkLJQEyBTy2qk80YTMSJnofunpsYPf4
         1vmiVo6iJqa0+01n9ekBcTcoEbDlDgC/8iqk84ObItAcdKt6PwN0sb0J23PVltysLDDh
         EsKHyV/FV6DE6KuzWAMIwZztQRXUQwK/kniegZ2Wk85/yuNOELwRPCtikCCZ+4aIiQxX
         HNKfLaI9XxKZskbQk0uIno+7Wqm7JE5HSa3y6pAiFUv+b1vOh8Xsoi7mfMPNDyEIzkVh
         MnhRTxAvIvjST8SBF6cp5SoI51JwxMStuWFcSfV/TeSmA9c7XWKCURISG0CmqF60TjfH
         VhOg==
X-Gm-Message-State: ACrzQf0uDkWoRYjxBF5ns5qm6C1a9NQUQwwiuacp6Zq8iQapdQkmi4zd
        nXc1Obau9I52HsBvS4tPyCU=
X-Google-Smtp-Source: AMsMyM4aQBhuScJ+Q7RqBmH9Vm86c4qsX+AsD4/jD1J/4RjZSwYFXEPfljnNUP0uP4wvnYZSMzZ1OQ==
X-Received: by 2002:a17:906:9c82:b0:781:5752:4f2b with SMTP id fj2-20020a1709069c8200b0078157524f2bmr2842003ejc.561.1666107730031;
        Tue, 18 Oct 2022 08:42:10 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id c18-20020a170906925200b0078dd2f9357fsm7751636ejx.89.2022.10.18.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:42:09 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 2/2] dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding
Date:   Tue, 18 Oct 2022 17:42:02 +0200
Message-Id: <20221018154202.4634-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018154202.4634-1-zajec5@gmail.com>
References: <20221018154202.4634-1-zajec5@gmail.com>
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

Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
stores its configuration in an environment data block.

Such blocks are usually stored on flash as a separated partition at
hardcoded address. Broadcom however decided to:
1. Store env data block inside U-Boot partition
2. Avoid sticking to hardcoded offsets
3. Use custom header with "uEnv" magic and env data length

Example (length 0x4000):
$ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
(0x40000 offset is unit specific and can change)

Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
support label/name only partition") DT can describe partitions matching
them by a name (without specifying actual address). With that feature
and this binding change it's possible to:
1. Specify DT node for Broadcom's U-Boot env data subpartition
2. Add nodes for specific environment data variables
3. Reference them as NVMEM cells

This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
find environment data early (before it accesses DTB) and it does that by
looking for an "uEnv" magic. Dirty way.

This binding can however be used by operating systems. It allows
describing cleanly U-Boot, its env data and variables. It tells
operating system about Broadcom-specific env data so it can parse it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Work on better commit body & add example
V3: Avoid duplicated "mac" label
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index e96bca99f2d9..cbc5c69fd405 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -38,6 +38,8 @@ properties:
         const: u-boot,env-redundant-bool
       - description: Two redundant blocks with active having higher counter
         const: u-boot,env-redundant-count
+      - description: Broadcom's variant with custom header
+        const: brcm,env
 
   reg:
     maxItems: 1
@@ -73,3 +75,22 @@ examples:
             };
         };
     };
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x100000>;
+            compatible = "brcm,u-boot";
+            label = "u-boot";
+
+            partition-u-boot-env {
+                compatible = "brcm,env";
+
+                ethaddr {
+                };
+            };
+        };
+    };
-- 
2.34.1

