Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB965C1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjACOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbjACOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:14:52 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E0B11C3D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:14:46 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c9so15748221pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxy1AII8mzQRWc0P6lSKBTCvnK5R7b9MxsVjt7NSjH8=;
        b=OK6PGwt4wzY9D/3RnfGc+XZ7yBXLZLVPotryDSjOPiqJQElCG+rsGRiqohGB/EImGp
         QU+6p2U6O2Q9AHUNwHHsuw5SzXR4+WkyA85++UES3c8HP3vATjgwYtWzxLf1O/K4Cz9s
         VzHl0fLv6NKbjGMtWSwNEiphs4VcXEeNK0niO0jGLXLVrsb/zEywDJn8RCCzZVXDjhte
         rZpRFwsxnEtf6ezq8mEHq7qZhfwjkGJHAUC9bSrkgDG5vBM7FJvU7dZ7o0M4vXN/Qhpr
         E7ebKQahi3Jq4dlJp2NcVswmII79ZtTU8Q2AKCwpHAlMESKdWx2TqAt5hpcCMHmRegqe
         s4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qxy1AII8mzQRWc0P6lSKBTCvnK5R7b9MxsVjt7NSjH8=;
        b=p5GJHGPeE3pm0xIutfnXBdqrcagpjyFLyMdm/aJJpkEjVLrMwN5JOFi0xrkXEY0xsM
         UF17wLhWnq1cuJOCHhIC9nXR4nwGo/gSVTwD4pasIvN62zqNnnYt73Ipef7rnyYB7sq8
         AveEa/qbgBTqP+Zt3OHPnB7DMK/yDEmcu9hJQGbBaezEclOuDTlAa/27OVov6j0h+dX4
         6XTFTUYwRfD965hiaGV384YHPVLoJ3hgeLV8GkTDD+cgMovamLvA8QrNjKNmASNi940Y
         FZOpqFMYQGz6OUuy5aafM62SAPRnxSK8V8ayQ2zGw2slgIygnpoPXF2cS9u17+F6wX0D
         76tQ==
X-Gm-Message-State: AFqh2kp2zNamTm7SOG5qkDSuHB3aDHtVCFhwE9hmzg/JLEo6lDY9L6n5
        zOYLsmt4roRGq89xLr82optp6A==
X-Google-Smtp-Source: AMrXdXvsk2ds4lPc3kxJKGZucLF/Wkv1k1fz59SMG/UzSr+MrpjPQ9fKZ0kUGFT06+58QOFmMFg5Dw==
X-Received: by 2002:a62:8382:0:b0:581:21c2:804c with SMTP id h124-20020a628382000000b0058121c2804cmr29057091pfe.17.1672755285453;
        Tue, 03 Jan 2023 06:14:45 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a628301000000b0056be4dbd4besm5936035pfe.111.2023.01.03.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:14:44 -0800 (PST)
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
Subject: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
Date:   Tue,  3 Jan 2023 19:44:06 +0530
Message-Id: <20230103141409.772298-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141409.772298-1-apatel@ventanamicro.com>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings document for RISC-V advanced platform level
interrupt controller (APLIC) defined by the RISC-V advanced
interrupt architecture (AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
new file mode 100644
index 000000000000..b7f20aad72c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines an advanced
+  platform level interrupt controller (APLIC) for handling wired interrupts
+  in a RISC-V platform. The RISC-V AIA specification can be found at
+  https://github.com/riscv/riscv-aia.
+
+  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
+  interrupt sources connect to the root domain which can further delegate
+  interrupts to child domains. There is one device tree node for each APLIC
+  domain.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - riscv,qemu-aplic
+      - const: riscv,aplic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Given APLIC domain directly injects external interrupts to a set of
+      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
+      node, which has a riscv node (i.e. RISC-V HART) as parent.
+
+  msi-parent:
+    description:
+      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
+      message signaled interrupt controller (IMSIC). This property should be
+      considered only when the interrupts-extended property is absent.
+
+  riscv,num-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1023
+    description:
+      Specifies how many wired interrupts are supported by this APLIC domain.
+
+  riscv,children:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      maxItems: 1
+    description:
+      A list of child APLIC domains for the given APLIC domain. Each child
+      APLIC domain is assigned child index in increasing order with the
+      first child APLIC domain assigned child index 0. The APLIC domain
+      child index is used by firmware to delegate interrupts from the
+      given APLIC domain to a particular child APLIC domain.
+
+  riscv,delegate:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      items:
+        - description: child APLIC domain phandle
+        - description: first interrupt number (inclusive)
+        - description: last interrupt number (inclusive)
+    description:
+      A interrupt delegation list where each entry is a triple consisting
+      of child APLIC domain phandle, first interrupt number, and last
+      interrupt number. The firmware will configure interrupt delegation
+      registers based on interrupt delegation list.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - riscv,num-sources
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (APLIC domains directly injecting interrupt to HARTs):
+
+    aplic0: interrupt-controller@c000000 {
+      compatible = "riscv,qemu-aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0xc000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+      riscv,children = <&aplic1>, <&aplic2>;
+      riscv,delegate = <&aplic1 1 63>;
+    };
+
+    aplic1: interrupt-controller@d000000 {
+      compatible = "riscv,qemu-aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>;
+      reg = <0xd000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+
+    aplic2: interrupt-controller@e000000 {
+      compatible = "riscv,qemu-aplic", "riscv,aplic";
+      interrupts-extended = <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0xe000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+
+  - |
+    // Example 2 (APLIC domains forwarding interrupts as MSIs):
+
+    aplic3: interrupt-controller@c000000 {
+      compatible = "riscv,qemu-aplic", "riscv,aplic";
+      msi-parent = <&imsic_mlevel>;
+      reg = <0xc000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+      riscv,children = <&aplic4>;
+      riscv,delegate = <&aplic4 1 63>;
+    };
+
+    aplic4: interrupt-controller@d000000 {
+      compatible = "riscv,qemu-aplic", "riscv,aplic";
+      msi-parent = <&imsic_slevel>;
+      reg = <0xd000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+...
-- 
2.34.1

