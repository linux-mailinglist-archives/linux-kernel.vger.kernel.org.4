Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE646052BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJSWDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJSWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:02:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25811C070C;
        Wed, 19 Oct 2022 15:02:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a10so31238383wrm.12;
        Wed, 19 Oct 2022 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4ByX62YZWChJEBHwNEyVc7wloAEex/KgboUXCgns/4=;
        b=fcGJm0SlCv/zmDdoORjXR/SjVNJg+QqIt2rjQRI36J3QIcsVn3zmcFPVQG9vIwJKOo
         5n9H/NmLOIjP+NQT7B1A7jsETZUHQGKWM97GWjEkdQCScel6QpS734kDfFz6eIIr0oQT
         nwni3s7WtSzlNrAXDLCG6CPg3Jllu6c3weRZgfD7ueWR3nmEm7/1YAelvBSZn7NEF60J
         EWc7BbcjgwW0CEQUs8GhDULskcBCdqYrDfGCeisqDagQuWY6JWrC7YLM+fKR7sIyw+/t
         t/aDj2Oe9ZHTbPNvrujLWP69Ty7/xDrbIV2vu5wmvNzCeyuZGneTr77Z2TFFyEbfjIRa
         sk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4ByX62YZWChJEBHwNEyVc7wloAEex/KgboUXCgns/4=;
        b=K4lIxXy05I31OtvDfk/vZbTTX+e+K1qqlnYtUFsm2iAIZ8VZ3HMwoxwj+fHgoUskKb
         Oab2jUfMKaDpMEHz2pAzVs9ioG4Ndek1IDi5aQXAIdd31Qz5OJ8NARyYRVsR7ovGsECp
         pM511WgQUyRYeoPbY723POEjxeHqZjd8TvmKXbWtWwoStOFCcZH8e5fUsUUHSS89wngi
         wI/DlFy/3zmaxoyYPqZhxTBRvr+n6cUAnw0e2kaTIfag0XdDMM1LqiuuwzdaqiqTHDFe
         JzPX9HK4/xbatZ4CrGJCPZY7qpHWtja4KMYLQ3rP4dgOwFaa/K0vjMkwQ/mANl8MVxfA
         iXzw==
X-Gm-Message-State: ACrzQf14trV/qPD/3jJ12dumaycCSByc1NkG66MbB6kn4CNYFDqU9Wki
        r9dRvs2We+uClZfTZC9ke8A=
X-Google-Smtp-Source: AMsMyM7H0xfupJjA0rDClRUKorcCcZKuv9n3UFUL1z0/NcheMBZL2O7vxPnISPlH8V2JaSUxZwfemQ==
X-Received: by 2002:a5d:530b:0:b0:22e:3e8c:45aa with SMTP id e11-20020a5d530b000000b0022e3e8c45aamr6834926wrv.321.1666216974149;
        Wed, 19 Oct 2022 15:02:54 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8c7:b527:b960:aa04])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm14807824wrv.70.2022.10.19.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:02:53 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v3 1/2] dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
Date:   Wed, 19 Oct 2022 23:02:41 +0100
Message-Id: <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../cache/andestech,ax45mp-cache.yaml         | 125 ++++++++++++++++++
 .../cache/andestech,ax45mp-cache.h            |  38 ++++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h

diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
new file mode 100644
index 000000000000..4c86a15bda5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
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
+  a larger amount of cache line entries and reasonable access delays. The L2C
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
+  andestech,pma-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 16
+    description: Optional array of memory regions to be set as non-cacheable
+                 bufferable regions which will be setup in the PMA.
+
+  andestech,inst-prefetch:
+    description: Instruction prefetch depth
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+
+  andestech,data-prefetch:
+    description: Data prefetch depth
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+
+  andestech,tag-ram-ctl:
+    description: Tag RAM output cycle. First tuple indicates output cycle and the
+      second tuple indicates setup cycle.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    items:
+      - minimum: 0
+        maximum: 2
+      - minimum: 0
+        maximum: 2
+
+  andestech,data-ram-ctl:
+    description: Data RAM output cycle. First tuple indicates output cycle and the
+      second tuple indicates setup cycle.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    items:
+      - minimum: 0
+        maximum: 2
+      - minimum: 0
+        maximum: 2
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cache-line-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+  - interrupts
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/cache/andestech,ax45mp-cache.h>
+
+    cache-controller@2010000 {
+        reg = <0x13400000 0x100000>;
+        compatible = "andestech,ax45mp-cache", "cache";
+        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
+        cache-line-size = <64>;
+        cache-level = <2>;
+        cache-sets = <1024>;
+        cache-size = <262144>;
+        cache-unified;
+        andestech,pma-regions = <0x58000000 0x08000000
+                                 (AX45MP_PMACFG_ETYP_NAPOT | AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
+        andestech,inst-prefetch = <0x3>;
+        andestech,data-prefetch = <0x3>;
+        andestech,tag-ram-ctl = /bits/ 8 <0x1 0x0>;
+        andestech,data-ram-ctl = /bits/ 8 <0x1 0x0>;
+    };
diff --git a/include/dt-bindings/cache/andestech,ax45mp-cache.h b/include/dt-bindings/cache/andestech,ax45mp-cache.h
new file mode 100644
index 000000000000..aa1cad24075d
--- /dev/null
+++ b/include/dt-bindings/cache/andestech,ax45mp-cache.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Andes AX45MP PMA configuration
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
+#define __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
+
+/* OFF: PMA entry is disabled */
+#define AX45MP_PMACFG_ETYP_DISABLED			0
+/* Naturally aligned power of 2 region */
+#define AX45MP_PMACFG_ETYP_NAPOT			3
+
+/* Device, Non-bufferable */
+#define AX45MP_PMACFG_MTYP_DEV_NON_BUF			(0 << 2)
+/* Device, bufferable */
+#define AX45MP_PMACFG_MTYP_DEV_BUF			(1 << 2)
+/* Memory, Non-cacheable, Non-bufferable */
+#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF	(2 << 2)
+/* Memory, Non-cacheable, Bufferable */
+#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF		(3 << 2)
+/* Memory, Write-back, No-allocate */
+#define AX45MP_PMACFG_MTYP_MEM_WB_NA			(8 << 2)
+/* Memory, Write-back, Read-allocate */
+#define AX45MP_PMACFG_MTYP_MEM_WB_RA			(9 << 2)
+/* Memory, Write-back, Write-allocate */
+#define AX45MP_PMACFG_MTYP_MEM_WB_WA			(10 << 2)
+/* Memory, Write-back, Read and Write-allocate */
+#define AX45MP_PMACFG_MTYP_MEM_WB_R_WA			(11 << 2)
+
+/* AMO instructions are supported */
+#define AX45MP_PMACFG_NAMO_AMO_SUPPORT			(0 << 6)
+/* AMO instructions are not supported */
+#define AX45MP_PMACFG_NAMO_AMO_NO_SUPPORT		(1 << 6)
+
+#endif /* __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H */
-- 
2.25.1

