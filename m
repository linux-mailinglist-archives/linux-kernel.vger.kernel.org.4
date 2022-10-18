Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADD602FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJRPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJRPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:42:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C78B56C5;
        Tue, 18 Oct 2022 08:42:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sc25so33183162ejc.12;
        Tue, 18 Oct 2022 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b56rtWITDRxSLrlOSl1k6NFsHhuMjl+yg3dnUWpYOLI=;
        b=Hsg3mAtjQpvoO0pLzprhW7xgoGOGI9zwrr5XD4snsU4F2F19updt3nOKcLraXbNufg
         6bi+WVZzw1OfNhBMm7czC2GVw6NQtKcSmH4HY4zHXL0ZxhAueBJOUTBxD50dEyLL3cp3
         4vgWY9G0/R2YvmWhUjhEUohttuigcFXKnhaa014/PoXwR2Kv+oqqYEF8t1s9rvQ++zk0
         6uEdLi8wSZnJXHHhkqm68CAEhVaphljOS6vR8l4GOGttnFCyREdcHlUVPDBPpIpFHevw
         A/SMRbUmPd674Kgf7FSdbZNDrSvOTBHItZwssZwhHj0e2L4byCwUgXx0kCLc+uXBYIgt
         SU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b56rtWITDRxSLrlOSl1k6NFsHhuMjl+yg3dnUWpYOLI=;
        b=KH7wUvYkP0zopXxC/jMuo+MfpyKMXuvDCXqlvtbgTVijV5rXa/VqqpcgETIhH/A9/4
         bN+tVmwzaJdvfEwjS8UDqAM0FX80YVryHS4paMnC2HPoNHR+ka9ymhk9FymKRsWNSpQo
         VZmV+UEHiZCZ4UsceSEZ7VK39y81z1O9ym3OTHslYE/DW66JLuxaDoIx9nRAEUxxmAEA
         SSNqH8NS1EGy+MZSLDQHbUDjIed4kMc/NC3mNV7tzc4JSXl98bBav7RdNPJ1Vu1SCB8y
         f/66lnh6/kpV8MNGS9gtGuXAh3hE4HBs2nkWjP/dPvg5ErhSwy6gGigjSjJpE+o7Vstg
         kUMw==
X-Gm-Message-State: ACrzQf03ztPVgxfK5Gx6F3LPapOL+2Cm5EDhnuoauthplUUswt0rKH2P
        CaCBrFsBt+XdMVPqgiyCE54=
X-Google-Smtp-Source: AMsMyM57XmcuD6x6f8mMwGeCzHow4jOYB0F/F3dru7OTMGAvTwEL8rc+fx9SaF+nUXUGB7wEaLBR9Q==
X-Received: by 2002:a17:907:72d2:b0:78d:4c16:a68d with SMTP id du18-20020a17090772d200b0078d4c16a68dmr2949288ejc.401.1666107726858;
        Tue, 18 Oct 2022 08:42:06 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id c18-20020a170906925200b0078dd2f9357fsm7751636ejx.89.2022.10.18.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:42:06 -0700 (PDT)
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
Subject: [PATCH V3 1/2] dt-bindings: mtd: partitions: u-boot: allow dynamic subpartitions
Date:   Tue, 18 Oct 2022 17:42:01 +0200
Message-Id: <20221018154202.4634-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

U-Boot partition may contain subpartitions. For example Broadcom
includes environment data block in the middle of its U-Boot partition.

This allows describing Broadcom's U-Boot env data and will allow
referencing its NVMEM cell in the future.

Reg: 118f3fbe517f4 ("dt-bindings: mtd: partitions: support label/name only partition")
Ref: dd638202dfb65 ("dt-bindings: mtd: partitions: add additional example for qcom,smem-part")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Add this patch as pre-requirement for u-boot,env.yaml & brcm,env
---
 .../devicetree/bindings/mtd/partitions/u-boot.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
index 8a88e7d16524..3c56efe48efd 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
@@ -27,6 +27,10 @@ properties:
           Broadcom stores environment variables inside a U-Boot partition. They
           can be identified by a custom header with magic value.
 
+patternProperties:
+  "^partition-.*$":
+    $ref: partition.yaml#
+
 unevaluatedProperties: false
 
 examples:
@@ -40,6 +44,9 @@ examples:
             compatible = "brcm,u-boot";
             reg = <0x0 0x100000>;
             label = "u-boot";
+
+            partition-u-boot-env {
+            };
         };
 
         partition@100000 {
-- 
2.34.1

