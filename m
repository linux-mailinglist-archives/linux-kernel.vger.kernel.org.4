Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB8663B23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjAJIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjAJIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:33:03 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2B45659;
        Tue, 10 Jan 2023 00:33:02 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so7732772pga.1;
        Tue, 10 Jan 2023 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5J/eidAZ28irC4eDoeGgMFsD2kCLuCXO26buxFQLHA0=;
        b=pMIB6ht+FhDsw5HZVqVlWGadzfORmIrx79MYwrbnQvuljPQ0TfDWwoxf5MzCw8Ja7T
         EaJyU9MyazxKUCPevX7kfg6OcSE0hNmTry/wvBKcIytDLlWqwC8CpkN+J5thJFB24LS1
         CQQoSSOI2TuAypXfxpA9LFk+zqaJCnAqBzbww2jw+v50jqbhXMVwrzdsjd/AvuQlpZEv
         6ovoYQe0hGH4oWQ4nQm/Xq6g4VxVZFpnSjeHPfqbn1NoOs6AJlf0AVFKob7H7+fvm+4P
         P/JiIVe4rvEgBLR/pXfTfMiLm2/DGVLigoS1TjVBZUZNFi+8WYuZ6nbEX1uhzl3HjJzo
         qroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J/eidAZ28irC4eDoeGgMFsD2kCLuCXO26buxFQLHA0=;
        b=B9ISXr3fPiC/bq71ogd6AYT+eS0z+JqlnJQp9V+vqeXhp6IwQpIiQ8DkEZVJeBSFC/
         PIKPqWEVFSJZGhvZ9/B++2lUtD1MmM2ewV+ABc2O+mQ9Ku0goo38hSG4hRMA7rmVkJ4W
         /FU5U5dA2r+ZPFDJO8X8vVY3cEaPRFF6ZDHyzrNqOkIlmrfGe4qWS9c306vFJgRZu7yk
         rblI8CNzDP2uVrzyp/4se913jeRfD5CwHkevYoU1m9hY+Z82HLP35YiPk0HEErmu7sHJ
         KLgU32g8wYeetn1CnvSH5cp1N9XXrdbqHtGz6mO+6WT0ox4X7UGGXVdUZO/034iuDK/S
         MPrg==
X-Gm-Message-State: AFqh2krE5meFEQWilH82JIhg6qPi3aglYFqhE1PP+YjT3D1/NzXd+dJ5
        LP0lNnePjLoJ70uarPadf7E=
X-Google-Smtp-Source: AMrXdXtCvKv+3P1+DjthaDgdsiFlMIPTBnPJ8aY4JBJs0+O28xqQXCHU6oDZt7stWSCdeG1FvS5XOA==
X-Received: by 2002:a05:6a00:288f:b0:581:fddb:749c with SMTP id ch15-20020a056a00288f00b00581fddb749cmr40534358pfb.5.1673339582298;
        Tue, 10 Jan 2023 00:33:02 -0800 (PST)
Received: from localhost.localdomain ([180.217.149.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a626503000000b005871b73e27dsm5064950pfb.33.2023.01.10.00.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:33:01 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Jim Liu <jim.t90615@gmail.com>
Subject: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Date:   Tue, 10 Jan 2023 16:32:38 +0800
Message-Id: <20230110083238.19230-4-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110083238.19230-1-jim.t90615@gmail.com>
References: <20230110083238.19230-1-jim.t90615@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for the Nuvoton NPCM7xx and NPCM8xx sgpio driver

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v4:
   - modify in/out property
   - modify bus-frequency property
Changes for v3:
   - modify description
   - modify in/out property name
Changes for v2:
   - modify description
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..3c01ce61f8d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton SGPIO controller
+
+maintainers:
+  - Jim LIU <JJLIU0@nuvoton.com>
+
+description:
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
+  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)
+  and parallel to serial IC (HC165), and use APB3 clock to control it.
+  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
+  NPCM7xx/NPCM8xx have two sgpio module each module can support up
+  to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
+  GPIO pins have sequential, First half is gpo and second half is gpi.
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity option (level-high, level-low, edge-high, edge-low)
+  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
+    nuvoton,input-ngpios GPIO lines is only for gpi.
+    nuvoton,output-ngpios GPIO lines is only for gpo.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sgpio
+      - nuvoton,npcm845-sgpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,input-ngpios:
+    description: The numbers of GPIO's exposed.
+      GPIO lines is only for gpi.
+    minimum: 0
+    maximum: 64
+
+  nuvoton,output-ngpios:
+    description: The numbers of GPIO's exposed.
+      GPIO lines is only for gpo.
+    minimum: 0
+    maximum: 64
+
+  bus-frequency:
+    description: Directly connected to APB bus and 
+      its shift clock is from APB bus clock divided by a programmable value.
+    default: 8000000
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nuvoton,input-ngpios
+  - nuvoton,output-ngpios
+  - clocks
+  - bus-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpio8: gpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        bus-frequency = <8000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        nuvoton,input-ngpios = <64>;
+        nuvoton,output-ngpios = <64>;
+        status = "disabled";
+    };
-- 
2.17.1

