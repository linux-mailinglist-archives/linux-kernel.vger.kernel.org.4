Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A637481E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGEKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGEKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:17:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBECE4B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:17:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso9916576e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688552271; x=1691144271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/PHi0Jgg0AWMsXAjQJ5U4jp3MPBa0UlRbW8srl3Ihw=;
        b=pdCch86LI+GK00eBaliFuGFYp11K2GD81RBf8d5o9ZzCK12suCVzqtuRI2yL5S02r2
         PbtRnHFsjp/9Z3lffbkIH28juVsneAPxbJkOLe1hGGRNbZFiYfkoYeVYivWDKgSjljYt
         o3PvWYI4s59dX6GJ9hkyfC+b/s09d13xS0V7amwq2lOhzegXQ9I9lG/NO0h9xMlhQL1y
         FDxx8ymDNHNAB+ZWaMFtV2RPpx6wiqdgTZr0yYwVNoVnrPWXIBHh9hOskAaN4v4FjCDG
         n0RoITMlReoUb2+ZT6eQcjgTn+NgJbkBrp9LpLr/dXMXyOhRzQeACCGjiok00r7DW+tv
         cMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552271; x=1691144271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/PHi0Jgg0AWMsXAjQJ5U4jp3MPBa0UlRbW8srl3Ihw=;
        b=OPvB4tcPF+kXX8lTs5brUoEwBf/PBc4+CCx4sACQlN/JkOM3Ek2YXaW1411NruZDNO
         26xjclig25x4IzqAsb9zcnWDcULllEK7h27ldwUcwYt3WuW8u7ETal2Nyupdo8DkTiwi
         iCBULBbgIw5inMRNa5P0SG1hucOE1ztYHMsEkbyvbEtywMeQPyq4wYN8ndWdsk42cxZ8
         DHTZ0pY9YE/y7w606og7LNNFy0OgWRbRuarDjQxoR21SuWD9S5qR7WPRQtj0h61Sejci
         c09xH/XuNiL1q95JStNBaQg7sKQ0uUdhzIrilb86MkpWA+w5QpmHHDtkkQFw8XdW3aMH
         J2vg==
X-Gm-Message-State: ABy/qLa/qqemamX7lb6EkSvYQYkl1xXJdERyeB7dJE/VuZgQqDw+Xjf3
        727dl3OQW3htZpc6DCLh79WYCg==
X-Google-Smtp-Source: APBJJlF7C57LwITAQXZXCtktNHzoNkC3ObELjasgOsj39XLjJc4LgEDfuAoE0ecgCXsCwFR7Qpgi/Q==
X-Received: by 2002:a05:6512:3082:b0:4f8:6833:b13c with SMTP id z2-20020a056512308200b004f86833b13cmr12689324lfd.14.1688552271235;
        Wed, 05 Jul 2023 03:17:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004fb75943ab3sm4774418lfk.258.2023.07.05.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:17:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Jul 2023 12:17:46 +0200
Subject: [PATCH v2 1/2] dt-bindings: mtd: Add SEAMA partition bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-seama-partitions-v2-1-9d349f0d5ab7@linaro.org>
References: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
In-Reply-To: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This types of NAND partitions appear in OpenWrt and
U-Boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix up the binding to be childless
---
 .../bindings/mtd/partitions/partitions.yaml        |  1 +
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 2edc65e0e361..9bd0a8d800da 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -21,6 +21,7 @@ oneOf:
   - $ref: linksys,ns-partitions.yaml
   - $ref: qcom,smem-part.yaml
   - $ref: redboot-fis.yaml
+  - $ref: seama.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
new file mode 100644
index 000000000000..5ed7764bba69
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Seattle Image Partitions
+
+description: The SEAttle iMAge (SEAMA) partition is a type of partition
+  used for NAND flash devices. This type of flash image is found in some
+  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
+  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
+  (MIPS), Broadcom BCM53xx, and RAMIPS platforms. This partition type
+  does not have children defined in the device tree, they need to be
+  detected by software.
+
+allOf:
+  - $ref: partition.yaml#
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+select: false
+
+properties:
+  compatible:
+    const: seama
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            compatible = "seama";
+            reg = <0x0 0x800000>;
+            label = "firmware";
+        };
+    };

-- 
2.34.1

