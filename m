Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0F74525C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGBUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGBUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:34:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1578E4E;
        Sun,  2 Jul 2023 13:34:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3113da5260dso4139269f8f.2;
        Sun, 02 Jul 2023 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330093; x=1690922093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaAnY2MYt0RLcMUJbL7J5suwKGVCMC1VbS7DigqvURE=;
        b=eiFrJewPOXpmbgCxu0MGAOK/yP08hkAJXGkhsXJChai9swwd2mULgbWQRFWK/1bXYX
         ypHFJ0ew9zdAB+2VagoBcwIN452aFLfic7sAXvNTM2RYNA4kR4sF2G96lBa+gKOJBfZr
         ceoto7mNjX+FxDrY8LQEWuLiwnOpq2ztMykf7+varARw+4vAVq5TJ5AjlqCnF0oMyNZ4
         IF559ehbVw4JeFWn4vbp0HLoEtqByPDrKtFbnmfu3JWrOOVMAaag40SOhlkYkbhR9myw
         TT6DoBQNjncgUKb19I83RIjrO7CILEL8IrrannO3E2XnMR5OydeoYHiPK47ccLzgzwFO
         RpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330093; x=1690922093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaAnY2MYt0RLcMUJbL7J5suwKGVCMC1VbS7DigqvURE=;
        b=i0w+Mve5VTKXO1nuTn7jB3gwsJjDgvuuJJDXacTWNPXYyh5OeHiG3pU001PoN7jQ54
         VsAsSUKOvdlV/mrmQlz5Dsjh7kTAxC7gZX73ciGxBJWG4b/dIQrAeVlZ9ZEzfFq3++IF
         SogdtM5bqXmfgr6wtFVbL8zu278A6Lnoy2gtsPL1KCeldqSKNrVdXfPhAv5rA+nkr5K2
         +fmMz8BOrhfLw4mJGbpWS4AmHs7lac4r4oiRsgSeFECIJzPZKXAf0YHQRjcP5AcCeMIz
         UAlZACitxQb3JfVoOf5LkvJR6iA4xGCZg1lYpzd540X9+CHlQiRTzvCorJEFPYlMnhhy
         cHiA==
X-Gm-Message-State: ABy/qLaIF5XlfnFGHFqQrT6nWQbWvliAwKFrmu34R8OHSO12aygCsK5z
        qzPm+9DZTtTaVxrnxXIWWbE=
X-Google-Smtp-Source: APBJJlExfIi1htPAWuwGuJA3assg5RdUAYRwBkW1/5OraOyqze7LAGXwW8RLaFwvDI1798iteTb+3A==
X-Received: by 2002:adf:e6ce:0:b0:313:ef96:84c8 with SMTP id y14-20020adfe6ce000000b00313ef9684c8mr6311811wrm.67.1688330093125;
        Sun, 02 Jul 2023 13:34:53 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b4ae:ae48:2e1b:1dcd])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm24000478wrv.74.2023.07.02.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:34:52 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 4/6] dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentation for L2 cache controller
Date:   Sun,  2 Jul 2023 21:34:27 +0100
Message-Id: <20230702203429.237615-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT binding documentation for L2 cache controller found on RZ/Five SoC.

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. The AX45MP core has an L2 cache controller, this patch
describes the L2 cache block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v9 -> v10
* No Change

v8 -> v9
* No Change

v7 -> v8
* Updated commit header message

v6 -> v7
* No Change

v5 -> v6
* Included RB tag from Rob

v4 -> v5
* Dropped L2 cache configuration properties
* Dropped PMA configuration properties
* Ordered the required list to match the properties list

RFC v3 -> v4
* Dropped l2 cache configuration parameters
* s/larger/large
* Added minItems/maxItems for andestech,pma-regions
---
 .../cache/andestech,ax45mp-cache.yaml         | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
new file mode 100644
index 000000000000..9ab5f0c435d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2023 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andestech AX45MP L2 Cache Controller
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  A level-2 cache (L2C) is used to improve the system performance by providing
+  a large amount of cache line entries and reasonable access delays. The L2C
+  is shared between cores, and a non-inclusive non-exclusive policy is used.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - andestech,ax45mp-cache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: andestech,ax45mp-cache
+      - const: cache
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  cache-line-size:
+    const: 64
+
+  cache-level:
+    const: 2
+
+  cache-sets:
+    const: 1024
+
+  cache-size:
+    enum: [131072, 262144, 524288, 1048576, 2097152]
+
+  cache-unified: true
+
+  next-level-cache: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - cache-line-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cache-controller@2010000 {
+        compatible = "andestech,ax45mp-cache", "cache";
+        reg = <0x13400000 0x100000>;
+        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
+        cache-line-size = <64>;
+        cache-level = <2>;
+        cache-sets = <1024>;
+        cache-size = <262144>;
+        cache-unified;
+    };
-- 
2.34.1

