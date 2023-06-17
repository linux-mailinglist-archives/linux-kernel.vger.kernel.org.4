Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43524733E47
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjFQFY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjFQFYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4142A1FD3;
        Fri, 16 Jun 2023 22:24:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a426e4f4bso1086825a12.1;
        Fri, 16 Jun 2023 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979478; x=1689571478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZJ3aYj6oFIr1S67mCK0XTYhjmw5NjBbpLCLF9cYcTg=;
        b=namhjf0fYV2UD2ZwtTX+l/bykLFBFUQYRGIb6QAZRkI84FGD5mUIV43cIOdmjWM88O
         fl6N4xiBUmBU55LJZ0h3PgkGxLVKZLFT39uq5563g6ztgQnUR6JjR8d90lslkHvrpYQN
         YhEmz/IxWKQRcvHnjLM3MmdIy4W0GAwrXX5GUrjeMYSwGbKpCdJCRzXJ6146rtt/OL2v
         6A6PftpgHfIitkyRMB+JnJkWekssI6iWGHZ/m6ldg6Jn3Ocn1X4C7Gl7Rc1D+IAcNCtS
         svcz56foHZFzSmGurmxcZT9DN/qF/hmRkBPW1Z0NMHpcIg2L+bRVASrrSSHUCTjjYUjd
         KOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979478; x=1689571478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZJ3aYj6oFIr1S67mCK0XTYhjmw5NjBbpLCLF9cYcTg=;
        b=lScQmWsK50pd3vzjRwU+cYUUbpL5gHdEYcJZk7K8Jyv7sBlgLcAJ6XakDbKq69FiYI
         /qeUvl8M3X2P86cgMi4GPqeh7yeKEkzJmuQNyK262xOSZRny37G/4B+Gdmz5+sNTOx7i
         0eE8PDRgw+vw/quGseB+ZSL84RKjkfNPaztXA5n4wM0c6FPp0aUvLlBdGn6AL73hDOga
         2IIX2o8rRFl7to86F/aYNzcwkQxxQgpqiK4iPnN1lTwK8iom92I2CmrjYhLZ2f87tJpC
         F7UL6w2Xqv8sGvonasjUjxuOrijabI4eNGPrIl2/2SnSlIUA8PsJrYkSdNM4zFLFS+8t
         AQxA==
X-Gm-Message-State: AC+VfDxr/lBxBgvEB7HLA333i1ruzv49XD2tvxzacuw/EXHyfE4oTOFm
        5g7y5Ji9LI8keihQCzXoMrM1frU9v10=
X-Google-Smtp-Source: ACHHUZ74Z14uTmfTRWbvZXqCvyW1VvFlxwzh9dkNoN5I1svmva7NUAbyYYz7v0RkkEzBng65zpeNDg==
X-Received: by 2002:a17:907:7b96:b0:97d:ee82:920a with SMTP id ne22-20020a1709077b9600b0097dee82920amr4077156ejc.74.1686979477824;
        Fri, 16 Jun 2023 22:24:37 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:37 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/9] dt-bindings: clock: add mtmips SoCs system controller
Date:   Sat, 17 Jun 2023 07:24:27 +0200
Message-Id: <20230617052435.359177-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
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

Adds device tree binding documentation for system controller node present
in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
new file mode 100644
index 000000000000..0b29dcacd686
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
@@ -0,0 +1,65 @@
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
+          - ralink,mt7620a-sysc
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

