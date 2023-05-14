Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE90F701E81
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjENRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjENRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0A3C28;
        Sun, 14 May 2023 10:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073EF60A48;
        Sun, 14 May 2023 17:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D288C433D2;
        Sun, 14 May 2023 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084093;
        bh=nF3JL8RuDBTKyjXk/txorqM8FS90ktPyRcC6WV+BXac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tG6Br1/S61N0FCgxfIiQATh1yxfuBb8K/Yabe3bjet9eBWbOL0vJkwkycEoVMoE6y
         z+kggXrwf7qlBT2iUon62jUuaZvp8fjHD1fE+nqnTWq+Bi/y5xKgzaXWdv1LjjvJmL
         VRuIKmRZVL9jTvTInG2UtBEvFoLGVmVd9SyeqCGyCdN0G9KlskIWA8yF/QJicLcyP6
         ZG4ell1KsWxVqkzyTYvrywz8wK0TV2ie0/V76hwxIq63tdfac2Z485UrrjsO2r1+KB
         NNm+LNx2yFWim8lgmkTrbPMnXV2QRpo+jRQm3RcU9K1KeNQrYIzZZGqAfsjsjPip5x
         lY3yJRN7z/r/Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 03/10] dt-bindings: serial: add documentation for Bouffalolab UART Driver
Date:   Mon, 15 May 2023 00:56:44 +0800
Message-Id: <20230514165651.2199-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
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

Add bindings doc for Bouffalolab UART Driver

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../serial/bouffalolab,bl808-uart.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
new file mode 100644
index 000000000000..e1c2c8ac88ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bouffalolab UART Controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: bouffalolab,bl808-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    uart0: serial@30002000 {
+        compatible = "bouffalolab,bl808-uart";
+        reg = <0x30002000 0x1000>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&xtal>;
+    };
+...
-- 
2.40.0

