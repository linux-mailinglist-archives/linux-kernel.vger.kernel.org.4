Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDE6E3BAB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDPTsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDPTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:47:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204D3C39;
        Sun, 16 Apr 2023 12:47:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id la15so224142plb.11;
        Sun, 16 Apr 2023 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681674465; x=1684266465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEI0eSnVROGbttT9l8rewKYrct6gZV9DrPEigxvXAbE=;
        b=ifKVIowjbe1YizUEM+3ST0gRExiI9O1DyUUeZRr6cCIJTD8X7F3XPXMR9B5TX25zC3
         8lgoJhipUwQSlAcNGXf0UDxuYQXUNjT1Avz7WST6RvDZm1L9XCSnXV3oGq8Xy7Pym28c
         kpFuaq8nAIRzEhNjSKl/fglm0W7iZh/9LKL8J12Nb8f20Y0KgIu61FRUjvmSipXOOd3q
         Iuitg/MTszSXpLUI3InHo0cTIONDg4GusUqg362stUuW8ih3Ub33mOla55pwLE0BPGI6
         lawHzvtD1T4+doDwmmKML2FFGcH13ysKjhIhVdXSDDAf8Momc8JaxsugQz+iDNtQNsWX
         9Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674465; x=1684266465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEI0eSnVROGbttT9l8rewKYrct6gZV9DrPEigxvXAbE=;
        b=dtG4YdBBN/vD/hpFq5V5vNuQ92BDXCyHPRxaBZ4aeRwH0fkq5CccjsuxyPgi/+Vs+q
         4cAxho/Tr/efxuenx0qr3PBHZfnAPeZMbGHdNbcG5Ew+bWwL/c6ZS7KmXAoSihJRuu1T
         5+nzegcdvODHuaWwct7+K2j1FdvebGbNQQZ45hcDY8wztWzqGZMmbDfm3hxuXJA1df2v
         ubOgY9Br+LtUDdaNrFTzrrT76gIwedXWnAv/nevDu+anyYbI1Zkg14qFPUHmvkJrS3qZ
         ezz1FpGYw4aH1Mz3YoN9MFYEVU7oELlaB+bJdGStn4+/fcjjfYuowXsG9tdgpkumgURP
         VTkg==
X-Gm-Message-State: AAQBX9dUuDXub8nJWZXBDc7XC3WOODB4NYyzHNPIXCAbIH/jqCIPAcLJ
        d2Zgipbis5l1e30pvTr0bxoe5uHKBhMIdXAUV5I=
X-Google-Smtp-Source: AKy350ZKEfzMft2d47xJWzGkkBgfFmWE+rP1k3yCCATbX7mx8o+16vpezzFP4/TdvvMOC1/mG7MNgA==
X-Received: by 2002:a17:903:22c3:b0:1a6:4032:ef2 with SMTP id y3-20020a17090322c300b001a640320ef2mr11717060plg.28.1681674465407;
        Sun, 16 Apr 2023 12:47:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001a69b28f5c5sm4490375plb.222.2023.04.16.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:47:45 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: clock: Add gate-clock
Date:   Mon, 17 Apr 2023 03:46:21 +0800
Message-Id: <20230416194624.1258860-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416194624.1258860-1-mmyangfl@gmail.com>
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for gate clock, which can gate its output.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../devicetree/bindings/clock/gate-clock.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gate-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/gate-clock.yaml b/Documentation/devicetree/bindings/clock/gate-clock.yaml
new file mode 100644
index 000000000000..bcd549dd9db1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gate-clock.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/gate-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock which can gate its output
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  Clock which can gate its output, by toggling one bit in a register. Such
+  register may also control other clocks or reset requests.
+
+  The registers map is retrieved from the parental dt-node. So the clock node
+  should be represented as a sub-node of a "clock-controller" node.
+
+  See also: Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
+
+properties:
+  compatible:
+    const: gate-clock
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 1
+    description: Parent clock.
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the control register (in bytes).
+
+  bits:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bit index which controls the output.
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - offset
+  - bits
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+      compatible = "gate-clock";
+      #clock-cells = <0>;
+      offset = <0xcc>;
+      bits = <3>;
+      clock-output-names = "my-clk";
+    };
-- 
2.39.2

