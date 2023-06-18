Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E87346B1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFROqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFROqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:46:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21098194;
        Sun, 18 Jun 2023 07:46:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so11610215e9.0;
        Sun, 18 Jun 2023 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687099598; x=1689691598;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6LqvmytTorbyvMymG3tvGT4xDhGqjrZ+pX9r4vqd/M=;
        b=Dk1RLdVSbc2xmIljf50xhCStf5sdeYGEgV48uW7TLIqiDDBUNZnT4SXxJNhs83qj+L
         0A3OBB/NHw2jzTE+8bP3IUjGqU+JpJc7Zug9vyRY6IMR5CWJ6Ry0Q6BCedLGE351dYJv
         d5ziiG73b4iLFaJu5Byn6JZk65tJ77vJi5bTu2ytyo6XSrT0OrlUamjWCjPbNGpQcjCN
         nUpi5gng7jqIM6OC2ON5J5zSkeW3/58EvQeYLftJYizHcTdWu5BcdrTRdoGD7WD/G+/J
         dgPUF74G0bj/YRQUINwRCTCmMMvQojvJSUcYdVkUW9Qe5xxv3jFJrBc9ZjGZdbfo3WvC
         6UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687099598; x=1689691598;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6LqvmytTorbyvMymG3tvGT4xDhGqjrZ+pX9r4vqd/M=;
        b=Z7ypDDBpDg8PrdN+mijFVqEW+1EFGMEjxq2Akmz19rtYjvGPoMNEQjHjCJ5iqlTU/d
         sOYbttbSfTBHyptrWE262Z+i8cFfR52AvfRlUDgFL4ztoppEEBsjdKo+s4+XqKe3YbkG
         mofvjZd/HWuZS0A6qD5OJIKLBr098vQMTO/4HXFPX3Ey5beLx2OSX2luAEh7fkR7wnRX
         AQw88IHm2Rbt1l8oMPAYKnHf3UGfe1cCP3XlJapPOw7eDyAlE0CHdJSsCgdUiDsQRaBW
         RlGIP+hnxfewcW8ZB2n/g7w/85mO94FGBOMD2dnnJuvdSwvM2IH1ZUOmz6GJxhJRHhyR
         E0QA==
X-Gm-Message-State: AC+VfDzwtiQDSrESdtlebmYoiclPdHCItb9Shkkt4l5dpjJyuoRLSTNU
        eoBp2p2FdY99xca46ZUZ8TE=
X-Google-Smtp-Source: ACHHUZ5nf2MuxI8MFyw2raIhYXOjckAO9etN89hhAfKemmcL/jLLeASPVAlU90xJQL/oKbNIp1+VaQ==
X-Received: by 2002:a7b:cd88:0:b0:3f8:fa2e:efc1 with SMTP id y8-20020a7bcd88000000b003f8fa2eefc1mr4461014wmj.15.1687099598368;
        Sun, 18 Jun 2023 07:46:38 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f8f8fc3c32sm7059834wmd.31.2023.06.18.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 07:46:37 -0700 (PDT)
Date:   Sun, 18 Jun 2023 16:46:35 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: timer: brcm,kona-timer: convert to YAML
Message-ID: <20230618144635.GA22166@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family timer bindings to DT schema.

Changes during conversion:
  - drop deprecated compatible (it's been deprecated for ~10 years)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - dropped deprecated compatible
  - change "" include in example to <> and sort it alphabetically
  - rebase on next-20230616

I wasn't sure whether to keep Rob's R-b with these changes, so I didn't to
keep on the safe side.

 .../bindings/timer/brcm,kona-timer.txt        | 25 ---------
 .../bindings/timer/brcm,kona-timer.yaml       | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt b/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
deleted file mode 100644
index 39adf54b4388..000000000000
--- a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Broadcom Kona Family timer
------------------------------------------------------
-This timer is used in the following Broadcom SoCs:
- BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-- compatible : "brcm,kona-timer"
-- DEPRECATED: compatible : "bcm,kona-timer"
-- reg : Register range for the timer
-- interrupts : interrupt for the timer
-- clocks: phandle + clock specifier pair of the external clock
-- clock-frequency: frequency that the clock operates
-
-Only one of clocks or clock-frequency should be specified.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-	timer@35006000 {
-		compatible = "brcm,kona-timer";
-		reg = <0x35006000 0x1000>;
-		interrupts = <0x0 7 0x4>;
-		clocks = <&hub_timer_clk>;
-	};
-
diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
new file mode 100644
index 000000000000..d6af8383d6fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/brcm,kona-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,kona-timer
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
+  clock-frequency: true
+
+oneOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm281xx.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@35006000 {
+        compatible = "brcm,kona-timer";
+        reg = <0x35006000 0x1000>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&aon_ccu BCM281XX_AON_CCU_HUB_TIMER>;
+    };
+...
-- 
2.25.1

