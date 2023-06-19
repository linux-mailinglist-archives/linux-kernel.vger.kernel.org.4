Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C35734AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFSEKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFSEJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED391BB;
        Sun, 18 Jun 2023 21:09:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so3305208e87.1;
        Sun, 18 Jun 2023 21:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147785; x=1689739785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNzgugrOpqNBYn0nRo99f18RXcnY60WHLMUYWf7EZ7o=;
        b=NKQniwMKc7QNM8bW5IPpEP/tXEX/h+Kx5ZY5fdWbbjuV+5yw0bPQVXClQzUiaI2mEt
         nHH3zZl5a/uZMxDnXf+49BWn1HUeuVgSyeTsIWFFxRz5UTEmT52E0IuWCbVXyM61nU46
         0Ys0vfBUWOHyXyFV3D8N3iRBLopChQW4giIgp9b82xWOGqIYbvcexQsL57I8PaF4KKSa
         cQRc/6ZAwwtYBFFyrIC6wg1herHA22MJ39qxzcTKsBovdUyDehEhM4yvu8uEmeMkN0pU
         aHNWOYR/oJsspG/nq8aILrBqECNq89ZfmBU2+tIaLcuKzlEa0y8FPHxva9gZAKVHz7gC
         Z6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147785; x=1689739785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNzgugrOpqNBYn0nRo99f18RXcnY60WHLMUYWf7EZ7o=;
        b=lR+lE04TevzAkm7oil+A1lrDw9aWUKlpKHPPAa1n0xuJLtOgmyl2PsVqRHrYDJTc/V
         hE23EC2vsWnyVMb4jxLs7Wj9ObVAsxYydpInT+KY2E9N83EBqjC3t79r8fw7rlaRNQta
         kBBELUhR5aXBM/Nv17HXd/Qi21wlOVdHpL0Pn6he1rzaFCgaez8/TwhMDGkirytOzIpI
         vZMahbkVo/RPAa6fjEh3FU1GmNMmEfDORWp7JDJaJ/BcbUR2ExNYcaWnmOP2ivoBXx4W
         S+T4VBhx4/MjMv+36AD/ZCLryQcccEUeKHcZuebI8cvLRDUwBirArTa3YyJ+vnetRyud
         xLKA==
X-Gm-Message-State: AC+VfDxDJ/qJqOVRqN7dFhnQGaR5GYppnX1oSc1LlwyNLJ0TZM9xOnD0
        gwVnxWgx2/Q+1Tb7Jhas86O0bj2eq14=
X-Google-Smtp-Source: ACHHUZ5/C7GnFTjdJyz8H/UbdtMDmafyslIhPS58jQ+zHgk95atbPKy+sMeK2idg37pyA3lGGKalnw==
X-Received: by 2002:a19:da0a:0:b0:4f8:71ca:bb0f with SMTP id r10-20020a19da0a000000b004f871cabb0fmr333777lfg.55.1687147785225;
        Sun, 18 Jun 2023 21:09:45 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:44 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/9] dt-bindings: clock: add mtmips SoCs system controller
Date:   Mon, 19 Jun 2023 06:09:33 +0200
Message-Id: <20230619040941.1340372-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree binding documentation for system controller node present
in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mtmips-sysc.yaml  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
new file mode 100644
index 000000000000..ba7ffc5b16a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTMIPS SoCs System Controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  MediaTek MIPS and Ralink SoCs provides a system controller to allow
+  to access to system control registers. These registers include clock
+  and reset related ones so this node is both clock and reset provider
+  for the rest of the world.
+
+  These SoCs have an XTAL from where the cpu clock is
+  provided as well as derived clocks for the bus and the peripherals.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ralink,mt7620-sysc
+          - ralink,mt7628-sysc
+          - ralink,mt7688-sysc
+          - ralink,rt2880-sysc
+          - ralink,rt3050-sysc
+          - ralink,rt3052-sysc
+          - ralink,rt3352-sysc
+          - ralink,rt3883-sysc
+          - ralink,rt5350-sysc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    description:
+      The first cell indicates the clock number.
+    const: 1
+
+  '#reset-cells':
+    description:
+      The first cell indicates the reset bit within the register.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@0 {
+      compatible = "ralink,rt5350-sysc", "syscon";
+      reg = <0x0 0x100>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.25.1

