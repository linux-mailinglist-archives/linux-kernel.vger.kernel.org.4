Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30B6252C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiKKEoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiKKEnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:49 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D06AEDD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:19 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so4408313fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88dbZKnLEUx7Ht3ijEWLgxbktVAqIkhhdLqR4LLY0Pg=;
        b=bv6ABeD0FMYwosnkSOwSDcCdQ0TnBV/dnIsn2N7jCXZAmg2jAQy6p247q6+2vaHGZw
         vOGbJQZ+584D2/VmgsF1o+w17/Xybk9XUDhXqKyH71c9F8kK5bjjbG4wguGyWTFO774j
         2s1RnnOwx7aGHKfuKC8002TnsCQao6J/S8GVHcd8d3MiSN1NcJ+6qKhpYaf3B4tU/Yfk
         bW80dr0z2Dume1ve0WXk1Kj+8DuahSjIcX7S/1wfLz/fl9UNRBZ2X1u/N3JvCEuMoCgm
         UweVvUYWIR5EKPyJId6E2EisaZhpDSOKXjRBN9tNaWQMNmxzhAXP4vTkHu73hEA5bzxk
         RAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88dbZKnLEUx7Ht3ijEWLgxbktVAqIkhhdLqR4LLY0Pg=;
        b=I/1X8mXWusPtKm/BQFrXwZXkhFBFkFMi1EPAtf7nZ+W8nS+8MhyQIalC6BD6Y9F94J
         AITFpEIShAFmBt8e79P5GSwtgd5/72g0DShliNgs542qwitH5VaGBP0Bhh43E1jIlPCl
         CRfkDEQDBDwNVhDhpNstkpDWxDs1SpjcZCHdAOJhiK5MWQsxai8lDOq5WAjttC25ESIv
         0Z02nBRJO05RvZG+7vVDqzRCI1DsTuGQqWj2gSTNCbksJHIP7vBrdBripPNvynOBWvcx
         /8m8hPStNoW2wKRxdDElP14oRAsRQ0y4/cd9teIqEWatKDFA4wLQroLQdESywgDDtgfC
         0k7g==
X-Gm-Message-State: ANoB5pnIPU1dZ+x1hYB8PbHYszc4u7jOLO+m2emM0TSYXZepn3FNV9q+
        y3i5h4Xx36Owja0OVIMzQiL7FQ==
X-Google-Smtp-Source: AA0mqf6CqtSOVM274vgjmTQ112E0vxr/SpLMG1AlHX7CjYrn05YgouV1wHjkvregNZxrS8J6nwtsGA==
X-Received: by 2002:a05:6870:b01f:b0:13b:2f1f:8327 with SMTP id y31-20020a056870b01f00b0013b2f1f8327mr30099oae.15.1668141797235;
        Thu, 10 Nov 2022 20:43:17 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:43:17 -0800 (PST)
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
Subject: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Date:   Fri, 11 Nov 2022 10:12:04 +0530
Message-Id: <20221111044207.1478350-7-apatel@ventanamicro.com>
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

We add DT bindings document for RISC-V advanced platform level interrupt
controller (APLIC) defined by the RISC-V advanced interrupt architecture
(AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../interrupt-controller/riscv,aplic.yaml     | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
new file mode 100644
index 000000000000..0aa48571f3bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Advancded Platform Level Interrupt Controller (APLIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
+  level interrupt controller (APLIC) for handling wired interrupts in a
+  RISC-V platform. The RISC-V AIA specification can be found at
+  https://github.com/riscv/riscv-aia.
+
+  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
+  interrupt sources connect to the root domain which can further delegate
+  interrupts to child domains. We have one device tree node for each APLIC
+  domain.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - vendor,chip-aplic
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
+      The presence of this property implies that given APLIC domain directly
+      injects external interrupts to a set of RISC-V HARTS (or CPUs). Each
+      node pointed to should be a riscv,cpu-intc node, which has a riscv node
+      (i.e. RISC-V HART) as parent.
+
+  msi-parent:
+    description:
+      The presence of this property implies that given APLIC domain forwards
+      wired interrupts as MSIs to a AIA incoming message signaled interrupt
+      controller (IMSIC). This property should be considered only when the
+      interrupts-extended property is absent.
+
+  riscv,num-sources:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 1023
+    description:
+      Specifies how many wired interrupts are supported by this APLIC domain.
+
+  riscv,children:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    minItems: 1
+    maxItems: 1024
+    description:
+      This property represents a list of child APLIC domains for the given
+      APLIC domain. Each child APLIC domain is assigned child index in
+      increasing order with the first child APLIC domain assigned child
+      index 0. The APLIC domain child index is used by firmware to delegate
+      interrupts from the given APLIC domain to a particular child APLIC
+      domain.
+
+  riscv,delegate:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    minItems: 1
+    maxItems: 1024
+    description:
+      This property represents a interrupt delegation list where each entry
+      is a triple consisting of child APLIC domain phandle, first interrupt
+      number, and last interrupt number. The firmware will configure interrupt
+      delegation registers based on interrupt delegation list.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - riscv,num-sources
+
+examples:
+  - |
+    // Example 1 (APIC domain directly injecting interrupt to HARTs):
+
+    aplic0: interrupt-controller@c000000 {
+      compatible = "vendor,chip-aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0xc000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+      riscv,children = <&aplic1>;
+      riscv,delegate = <&aplic1 1 63>;
+    };
+
+    aplic1: interrupt-controller@d000000 {
+      compatible = "vendor,chip-aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>,
+                            <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0xd000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+
+  - |
+    // Example 2 (APIC domain forwarding interrupts as MSIs):
+
+    interrupt-controller@d000000 {
+      compatible = "vendor,chip-aplic", "riscv,aplic";
+      msi-parent = <&imsics>;
+      reg = <0xd000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+...
-- 
2.34.1

