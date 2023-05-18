Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B8708814
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjERS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjERS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3458E7D;
        Thu, 18 May 2023 11:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3375861B56;
        Thu, 18 May 2023 18:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7685C4339B;
        Thu, 18 May 2023 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436224;
        bh=Nt5XnCpe1ezvh1ILRVySirsoVP1f3952Ou9DF76XFOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVM9QbkTan5hxlgEYa3QeGODzjLKHMp6w/OAt9LlH6FCGSltcldDO0BUtI3oF8UFm
         taDbaDlW+RNfTO7NitSBmHqK2wkbjgvosrUL1y3C2jB7u1ilVrMoRLixfBR2hnO2Mp
         /mUC6OVpYa0Me9zmuh9bT+2tVSe8JWiMesvZdVwv26q6K2m+xstiPeQtherWnNU8h2
         UoMncU6IRtgNfNJRqm4X+y2uhNhcNneHsN6Ya4WY+HCICFGs45E3zI2alqvhHfG7DJ
         +b/6CWh6Sa6bZGjzNx3rySyjUjIh8UabaISQkizjpxFtTNv4MOtzlNLLAYoSqg+eMC
         puwni+5V6oMyQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
Date:   Fri, 19 May 2023 02:45:36 +0800
Message-Id: <20230518184541.2627-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary CPUs in T-HEAD SMP capable platforms need some special
handling. The first one is to write the warm reset entry to entry
register. The second one is write a SoC specific control value to
a SoC specific control reg. The last one is to clone some CSRs for
secondary CPUs to ensure these CSRs' values are the same as the
main boot CPU. This DT node is mainly used by opensbi firmware.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml

diff --git a/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
new file mode 100644
index 000000000000..ba8c87583b6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/thead,cpu-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD cpu reset controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description: |
+  The secondary CPUs in T-HEAD SMP capable platforms need some special
+  handling. The first one is to write the warm reset entry to entry
+  register. The second one is write a SoC specific control value to
+  a SoC specific control reg. The last one is to clone some CSRs for
+  secondary CPUs to ensure these CSRs' values are the same as the
+  main boot CPU.
+
+properties:
+  $nodename:
+    pattern: "^cpurst"
+
+  compatible:
+    oneOf:
+      - description: CPU reset on T-HEAD TH1520 SoC
+        items:
+          - const: thead,reset-th1520
+
+  entry-reg:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: |
+      The entry reg address.
+
+  entry-cnt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The entry reg count.
+
+  control-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The control reg address.
+
+  control-val:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The value to be set into the control reg.
+
+  csr-copy:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      The CSR registers to be cloned during CPU warm reset.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    cpurst: cpurst@ffff019050 {
+      compatible = "thead,reset-th1520";
+      entry-reg = <0xff 0xff019050>;
+      entry-cnt = <4>;
+      control-reg = <0xff 0xff015004>;
+      control-val = <0x1c>;
+      csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
+    };
-- 
2.40.0

