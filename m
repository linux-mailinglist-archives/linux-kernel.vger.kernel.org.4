Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDE65C1A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjACOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbjACOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:14:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6811A18
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:14:37 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d15so32709844pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PybAMKTSkhhmmB7NHRr0O8pZxotYwnZMFF8ljzRqNkQ=;
        b=brOs4dc0lOFXuYZR26ZakZlhErUcq+oNhKNQFlP/g3FgABYBFtqhqpLCDq9CgSCVuA
         d0kAXC7ZNDNIS3UhEgt9KMKbcyIlVll38BsYd9stpedATzo9KJvXwxD7Ghl5VRoTcDSx
         G4Tak/o7Kmw0aFvHIN4fig0IvDF+z6glLwvvJnJCj0+n2Crq4pPoYKuDyG54qaBEXRnD
         ZEjAPb9VMzel6rSrSzYbjIwtq5N2zgJtDovPS5Bh+AX2HWKxazk5G5/eS700JJ7ztLtH
         tuSHxUesX4GI5KYLXtQ2babfIB2A47GyKD8mS2U3LXL1qNR01oqQzdFdrsSMArooCbVP
         eAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PybAMKTSkhhmmB7NHRr0O8pZxotYwnZMFF8ljzRqNkQ=;
        b=XVjbGr2MSowDrC9cHFelgYcn7e6mEHTI+jIDqHwGGDr6ZnK/2XgHPyqA6DwN9pARTp
         u+ZU6h6NzkpXJ5Dlrq1HCnRyVJ/iOOXe1ZQUB2tm5mJXH4HOtokQ2NkCzyMzVGneklpB
         LF+33CkfynVeR7h5UNOck2hVsBDZ7Hyw1dMetU6OnqlNbic+C3sKlh4wmaZtuSeCSsJM
         92nwGYo4k5npmQKTMrzpYGz1kPorUhDcO9V9L6s3dK1fl2Jkycx+K22FaiY1aez7KUWy
         ODncfKpqS1qQ8r0thhS6+VWlMUkyOHETBO5vw7zud4V7L/Ls0qidp7gfxvWzPfr04cgl
         /kUA==
X-Gm-Message-State: AFqh2ko1+B5xxk6EwcQr3YCFH4aYy0zr+3vW1xknnBicqVPDPM3LSg1K
        WgbcMFCVn6xLi/MGzphui12OaA==
X-Google-Smtp-Source: AMrXdXvqioKRDO01/F4B0F5J2nxAB+b+EhjP6kHywpfZzVFDzAyXmLfie5fvI13TqmREa4KI0JVutw==
X-Received: by 2002:a05:6a20:6f61:b0:9d:efd3:66f7 with SMTP id gu33-20020a056a206f6100b0009defd366f7mr45087577pzb.62.1672755276672;
        Tue, 03 Jan 2023 06:14:36 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a628301000000b0056be4dbd4besm5936035pfe.111.2023.01.03.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:14:36 -0800 (PST)
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
Subject: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
Date:   Tue,  3 Jan 2023 19:44:04 +0530
Message-Id: <20230103141409.772298-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141409.772298-1-apatel@ventanamicro.com>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
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

We add DT bindings document for the RISC-V incoming MSI controller
(IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../interrupt-controller/riscv,imsics.yaml    | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
new file mode 100644
index 000000000000..b9db03b6e95f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Incoming MSI Controller (IMSIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
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
+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively describe
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
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
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - riscv,qemu-imsics
+      - const: riscv,imsics
+
+  reg:
+    minItems: 1
+    maxItems: 16384
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
+    maxItems: 16384
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
+      Number of interrupt identities supported by IMSIC interrupt file.
+
+  riscv,num-guest-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities are supported by IMSIC guest interrupt
+      file. When not specified it is assumed to be same as specified by the
+      riscv,num-ids property.
+
+  riscv,guest-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of guest index bits in the MSI target address. When not
+      specified it is assumed to be 0.
+
+  riscv,hart-index-bits:
+    minimum: 0
+    maximum: 15
+    description:
+      Number of HART index bits in the MSI target address. When not
+      specified it is estimated based on the interrupts-extended property.
+
+  riscv,group-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of group index bits in the MSI target address. When not
+      specified it is assumed to be 0.
+
+  riscv,group-index-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 55
+    default: 24
+    description:
+      The least significant bit position of the group index bits in the
+      MSI target address. When not specified it is assumed to be 24.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - interrupts-extended
+  - riscv,num-ids
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (Machine-level IMSIC files with just one group):
+
+    imsic_mlevel: interrupt-controller@24000000 {
+      compatible = "riscv,qemu-imsics", "riscv,imsics";
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
+      compatible = "riscv,qemu-imsics", "riscv,imsics";
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

