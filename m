Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17926252C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiKKEn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiKKEnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:24 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CE6DCD4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:06 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so525430oor.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNzNkRHMwd+QQ2TZ5Hz8eXXmUBpv257CxGWvXOFmL6U=;
        b=Bi3r/MrWNIa0+rZLQzTomF9fJ1id1sbTHD3fqd1ifcE8thGPKHwtuOyrs/7MwrDuRa
         slrfYc4qSJQQm4uIXwGhfiTQcgwoilUoou8o2NWn3zKgWH8fzICDtnJkod7j9DaF57MK
         g9c6nSu3W/Oo/2WZcVSNlFS6h6BdrR3F0NMPeyMZxyI+p5nYJ2QUPVTjcv4LIjcg9/wi
         MFQ+DfkKnQNkyIwUDNBL+680TDdjADL5m5jdo4dCXvlflvLuFnLlMuue8p9sIBHI2leu
         My1OYHHunfiZ2ofNMY/rpZ5WF9GTPQyuCkSO/r4op9fciHSUPoX6glZAQ1pF0LNryD6J
         hiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNzNkRHMwd+QQ2TZ5Hz8eXXmUBpv257CxGWvXOFmL6U=;
        b=AvQHA8hbCnLdhzTVQY4+N4jUXLI4UVloDgmJwHj4QjkQYqssBoaPNzmImL5vJ1LYub
         LzS2vw3/IHiQhiDyUFZg6WBWdcbq3xoxnps5Llnf2Sn5ifZdfbcYsZyXa0VAr5D5/tRT
         3GqIVTTgu8sW8N2FYsrVJCHNiGdt9URbBV5Qn9IVWi0Y0nV7n5KhW37L3XiwgF60OO3r
         DHm5yXQRmSu1CqO2dr25wS4A9zZW2hPdLZxMCiP2tQJJZ0Gvmxgyu+aGE5DgRZyp9qIu
         GzvIucmzg1A7iwDqCeLouwScObiTtT3GmOiIiiWiLTgtvaPnbal1HiTx/odjXqKcwW0h
         1mJA==
X-Gm-Message-State: ANoB5plLFvU6yZ7z2l0l93qVosgbWD6uDj1jLgIISQsRC+EOeuOkE/X2
        pDlwdGFnuyuJh2BLr5s8vD3hAg==
X-Google-Smtp-Source: AA0mqf6fb9U65EAWkgvF8Q799UihxKSTCi6SAcqn2Vwy+E86iJmfxffqR609ooHXrp0S/fLLM/WpNg==
X-Received: by 2002:a4a:a7c6:0:b0:47f:d445:b435 with SMTP id n6-20020a4aa7c6000000b0047fd445b435mr147377oom.87.1668141785853;
        Thu, 10 Nov 2022 20:43:05 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:43:05 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller bindings
Date:   Fri, 11 Nov 2022 10:12:02 +0530
Message-Id: <20221111044207.1478350-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings document for RISC-V incoming MSI controller (IMSIC)
defined by the RISC-V advanced interrupt architecture (AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../interrupt-controller/riscv,imsic.yaml     | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
new file mode 100644
index 000000000000..05106eb1955e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Incoming MSI Controller (IMSIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
+  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
+  AIA specification can be found at https://github.com/riscv/riscv-aia.
+
+  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
+  for each privilege level (machine or supervisor). The configuration of
+  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
+  space to receive MSIs from devices. Each IMSIC interrupt file supports a
+  fixed number of interrupt identities (to distinguish MSIs from devices)
+  which is same for given privilege level across CPUs (or HARTs).
+
+  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
+  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
+  group is a set of IMSIC interrupt files co-located in MMIO space and we can
+  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
+  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
+  privilege level (machine or supervisor) encodes group index, HART index,
+  and guest index (shown below).
+
+  XLEN-1           >=24                                 12    0
+  |                  |                                  |     |
+  -------------------------------------------------------------
+  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+  -------------------------------------------------------------
+
+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively describe
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - vendor,chip-imsics
+      - const: riscv,imsics
+
+  reg:
+    minItems: 1
+    maxItems: 128
+    description:
+      Base address of each IMSIC group.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 0
+
+  msi-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 32768
+    description:
+      This property represents the set of CPUs (or HARTs) for which given
+      device tree node describes the IMSIC interrupt files. Each node pointed
+      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
+      HART) as parent.
+
+  riscv,num-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Specifies how many interrupt identities are supported by IMSIC interrupt
+      file.
+
+  riscv,num-guest-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Specifies how many interrupt identities are supported by IMSIC guest
+      interrupt file. When not specified the number of interrupt identities
+      supported by IMSIC guest file is assumed to be same as specified by
+      the riscv,num-ids property.
+
+  riscv,slow-ipi:
+    type: boolean
+    description:
+      The presence of this property implies that software interrupts (i.e.
+      IPIs) using IMSIC software injected MSIs is slower compared to other
+      software interrupt mechanisms (such as SBI IPI) on the underlying
+      RISC-V platform.
+
+  riscv,guest-index-bits:
+    minimum: 0
+    maximum: 7
+    description:
+      Specifies number of guest index bits in the MSI target address. When
+      not specified it is assumed to be 0.
+
+  riscv,hart-index-bits:
+    minimum: 0
+    maximum: 15
+    description:
+      Specifies number of HART index bits in the MSI target address. When
+      not specified it is estimated based on the interrupts-extended property.
+
+  riscv,group-index-bits:
+    minimum: 0
+    maximum: 7
+    description:
+      Specifies number of group index bits in the MSI target address. When
+      not specified it is assumed to be 0.
+
+  riscv,group-index-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 24
+    maximum: 55
+    description:
+      Specifies the least significant bit of the group index bits in the
+      MSI target address. When not specified it is assumed to be 24.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - interrupts-extended
+  - riscv,num-ids
+
+examples:
+  - |
+    // Example 1 (Machine-level IMSIC files with just one group):
+
+    imsic_mlevel: interrupt-controller@24000000 {
+      compatible = "vendor,chip-imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0x28000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      riscv,num-ids = <127>;
+    };
+
+  - |
+    // Example 2 (Supervisor-level IMSIC files with two groups):
+
+    imsic_slevel: interrupt-controller@28000000 {
+      compatible = "vendor,chip-imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>,
+                            <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
+            <0x29000000 0x2000>; /* Group1 IMSICs */
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      riscv,num-ids = <127>;
+      riscv,group-index-bits = <1>;
+      riscv,group-index-shift = <24>;
+    };
+...
-- 
2.34.1

