Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DB7084FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjERPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjERPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FC01A5;
        Thu, 18 May 2023 08:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E720E65032;
        Thu, 18 May 2023 15:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA78C433D2;
        Thu, 18 May 2023 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684424048;
        bh=zFBld/tZ7AocfQGxbusrEecyvSpoa50rSwNlH5iRWjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XitzRxz5Rw0UPEAf7onUmdsyr6vVL8LorK/a66OO02ggd2WVcaL4WokSqmKOZqkhP
         zZou1910bYLnFvJYJqMxtyPGX//KwAubDr0a/RBZsT9IYwitdjKWhHMev2b9mX/S01
         9JsJkceJx50s3wF8p3q0N3jSu/CW0TCJmOKOy/ZF+iCENJfeFKEEkDsd/HIjuMcTgi
         PmhRUjNNM3y//fdiu2DK1qpQMC4DruKIm5CZW/DAUzOVv08ngc3MV+AJLzSoqfJFet
         GhU/RPQGMYyvkRZK5Y8ix0R9+j7KUuv/0Js3IpI/8nOGfo88SnYUOf1myVOGJrNLb9
         2cjJFZjKRK4gQ==
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
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 03/10] dt-bindings: serial: add documentation for Bouffalolab UART Driver
Date:   Thu, 18 May 2023 23:22:37 +0800
Message-Id: <20230518152244.2178-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518152244.2178-1-jszhang@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 000000000000..0ef858e50efb
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#
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

