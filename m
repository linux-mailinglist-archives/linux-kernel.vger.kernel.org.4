Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0395F3919
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJCWcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJCWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:32:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1B558E6;
        Mon,  3 Oct 2022 15:32:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id iv17so7866160wmb.4;
        Mon, 03 Oct 2022 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XSXor89wvMD5IbxoY6sxhht7eSGoSZ1Ew/JcVOWsAPg=;
        b=Pvz8y4NKbKjMNfIDOpelT+9qJ3evjx9PctMQZkAVVk0/0mLz9A4jDMpyiuuwENsoxq
         wB2AFMgZkXJR4whgW5h02M/8UK9yCTo5vsqAmpNYC2rZU5TZm223cKdfBjp2lWIFXsP5
         9fB9qseBJ76wAMB8+/UqXV71Sfkyz2DBUbx2u/DsB5JLlRtjwUB0H6RZ7i5i4OicNkwq
         +ZoSpMhfa/QktYQrqJGhvTH+FwAvThsIvRH52NMHcFFNdYjynIrCT2fXvll6OPed/PLE
         EmS1n9fs9rAMK23s0GpVQBNKeBi3CgIOp2HnbSTsc2xRQkOlrgSoXefcbB3zG9s22hUx
         w4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XSXor89wvMD5IbxoY6sxhht7eSGoSZ1Ew/JcVOWsAPg=;
        b=DB4UOksf8jZy3z88KtbloH0oIqW92+uGpSe8movYSn4+jXeZZPwaNQ4tKVUf443yr0
         Ww/cK59jPKlBdPu0ujj6z2WluvsodH0n8ZfxGkH7qwsa326FSBrlr60+TgnHo7iklbiA
         QEZaGyu3jwkV1KXfckh2ruBhbI5POuL5Oq2iUv+z1DV5hmJAnVSm5h6yxUDxqXNvEXEI
         K8RMCqtfC+uGXJCW6n1EJ+MbXB5GJtwirdtHJ8xAqk/waF2j0GVwztlH/iCfOOjJC9/e
         9x5eGdjYFjZO1NkvZ3wYFMmSLWZR//6AXtbMS9Fg9EvwdLD3umIXTIDEj/Cei0hKyBuT
         BMRQ==
X-Gm-Message-State: ACrzQf3JPSu3c/r3O5oocpFV/DU64DYS7T/VQsp+dlxSSGd9POWItbUw
        4EpIrpu03JzZwaE0SmC5ybwplr2pdwwkKQ==
X-Google-Smtp-Source: AMsMyM68z2gks/2+M/TnH4uz8efG41m2sGfpfTsoKgKttrqNcEXtubTr+3hO2kD3AuW0+n7czVZJCA==
X-Received: by 2002:a05:600c:1990:b0:3b4:c326:d099 with SMTP id t16-20020a05600c199000b003b4c326d099mr7888667wmq.19.1664836364460;
        Mon, 03 Oct 2022 15:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c8:2501:c701:34b9:36fa:3827:d20])
        by smtp.gmail.com with ESMTPSA id m64-20020a1ca343000000b003a6125562e1sm12884871wme.46.2022.10.03.15.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:32:43 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
Date:   Mon,  3 Oct 2022 23:32:21 +0100
Message-Id: <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 .../soc/renesas/r9a07g043f-l2-cache.yaml      | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
new file mode 100644
index 000000000000..f96eeffa58ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/r9a07g043f-l2-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive L2 Cache Controller
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  A level-2 cache (L2C) is used to improve the system performance by providing
+  a larger amount of cache line entries and reasonable access delays. The L2C
+  is shared between cores, and a non-inclusive non-exclusive policy is used.
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
+  pma-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 16
+    description: Optional array of memory regions to be set as non-cacheable
+                 bufferable regions which will be setup in the PMA.
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
+        pma-regions = <0x00000000 0x10000000>,
+                      <0x10000000 0x04000000>,
+                      <0x20000000 0x10000000>,
+                      <0x58000000 0x08000000>;
+    };
-- 
2.25.1

