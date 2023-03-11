Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B696B5768
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCKBVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCKBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:21:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780412EE5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:45 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r27so8912237lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4K/AHNMlQRkb43E/ezHI66d0dWT0Zo0JlIrJd09pNOM=;
        b=IQo7P1uKss4T5munHk+qv4Dl57lemIPF2z8iLXh+oSuVfKJbJjdhI9FVz9hF2p3uMF
         OaRmhb2Lx9naqweWWVqyRZF7RwoV7YzbylIhE/VrBKUqKZXM8CXBSQG+Yw4PdGLoalYP
         gVEUeVop5Ow0n5vXfTDDfjs+Um5xjs/Yy3mfPiEfC7bmoSy6wov72DHAP5f49u57B2w8
         w7TD9hZrmAc2sHlRoyHY/oknnHIwojue6Q8mOYwvOVLklY7Xhy8xHfApT9HQ3+cHQbum
         AY9Y7qEtLu3rT/0QxiZk8REP2GkQq5dU5xJ2Ql2uCZoT7modojAE9c0muegLCIskHD6F
         iP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K/AHNMlQRkb43E/ezHI66d0dWT0Zo0JlIrJd09pNOM=;
        b=Z4VfzDpvjb8lhSMLTCkKDVXrsofVcWWtzxQA+CC3/zS7/vH1MEN3jKvJquhuc5DEx1
         m3pPa+bSdt5ejlDrA4VSK3lCaFCq0o1mivdgqWq/Ax8jlAcERrQHwvC3WXNv14rkl6Uh
         ogsqa8sUzYHZ7r/yHoRyGDGjJxmjigxQkTYEB2Osji1SH0INjD8IYHZUO4nfmVLgstGU
         youSZf52GQ2ZHtoHUNr+Gy64/qRoDtyTy2JMV8Fm83rX3UVvWTI5L8HPHN0uV+qtXsSe
         NB/rpmAkJXKpxJWrFKctbslIPECnG3uEHk7ee/pW3QQxxewZc3jjcki92Kozu2p4Tk/w
         TFQw==
X-Gm-Message-State: AO0yUKVB0vBpspcWK1MBlYg+ARvuudfiOVsCZ8ZiZLP0avandahzclWA
        WVklAX4qUsXRc8GbF6/JJxnP0g==
X-Google-Smtp-Source: AK7set8ssiR98SYu5r4Qh69WU8wpxdf522+pNThT4T/tcO8vkf2ZblmUXt2RHYu8dlmM0WsxZq4pug==
X-Received: by 2002:ac2:550f:0:b0:4e1:7dd:1142 with SMTP id j15-20020ac2550f000000b004e107dd1142mr8128535lfk.51.1678497703381;
        Fri, 10 Mar 2023 17:21:43 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:31 +0100
Subject: [PATCH RFC 01/15] dt-bindings: mfd: Split out Qcom RPM MSG RAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-1-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
In-Reply-To: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=5123;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bAk28SHxh1vtiGIE/TbqS3LoxWaNFf2XwvgviIcdSsg=;
 b=gnPQOrqcJGfe8SBej6XLDEhF8meIO4b3FpM+yn/FB/kqoS4uS7px0oQZLVLlf0mOrLZel1NSJx18
 H7i8C0i0D0Co4QIn0qLdmjy54WkRqSRNpWYfFpNUOvMNUW/HHQ2e
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM Message RAM is a part of the RPM low-power core's RAM that's a
MMIO-mapped region from the main ARM CPUs' POV. It contains sleep stats
divided per "RPM master" (ARM cluster, *DSP, ...), an interrupt controller
(MPM) that's vital in the low-power mode entry/exit sequence, as it
signals the readiness to enter sleep, replays the interrupts after a total
power collapse recovery and is able to receive external interrupts from
other IPs (like the PMIC, TSENS and USB) on the SoC to initiate a wakeup
sequence.

On top of that, it contains some regions that are (ab)used by SMEM (by
design!), but we're not completely sure what ranges are r/w to/from.
This would probably need to be determined on a SoC-by-SoC - or even worse
- firmware-by-firmware basis, but since this region is quite "wild west"
by design (it may be accessed and altered in one form or another by all of
the subsystems at the same time) this shouldn't really worry us..

Split out the bindings and re-model it as a simple-mfd to allow for better
representation of the partitions within and allow child devices (MPM,
master sleep stats - coming soon).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml  | 82 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sram/sram.yaml   |  2 -
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml b/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml
new file mode 100644
index 000000000000..b1fee2b2d923
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/qcom,rpm-msg-ram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPM Message RAM
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description:
+  Part of the remote Resource Power Manager (RPM) core's RAM is exposed to
+  the main ARM cores as a MMIO-mapped device and referred to as the RPM
+  Message RAM. It contains per-RPM-master sleep statistics, an interrupt
+  controller (MPM) that's capable of replaying interrupts after a total power
+  collapse of a given master and some memory for mailbox-like functionality.
+  An RPM master is any remote core on the SoC, including APSS (the main ARM
+  clusters), ADSP etc., depending on the platform capabilities.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,rpm-msg-ram
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  # The RPM message RAM should be <=0x7000-long so 1 cell is all it needs.
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  # The MPM comes at fixed offsets: 0x1b8 on MSM8996 and later, 0x1d0 before it
+  "^interrupt-controller@(1d0|1b8)":
+    type: object
+    oneOf:
+      - $ref: /schemas/interrupt-controller/qcom,mpm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    sram@45f0000 {
+        compatible = "qcom,rpm-msg-ram", "simple-mfd";
+        reg = <0x045f0000 0x7000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x045f0000 0x7000>;
+
+        wakegic: interrupt-controller@1b8 {
+            compatible = "qcom,mpm";
+            reg = <0x1b8 0x48>;
+            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_SMP2P>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            #power-domain-cells = <0>;
+            interrupt-parent = <&intc>;
+            qcom,mpm-pin-count = <96>;
+            qcom,mpm-pin-map = <5 296>,  /* Soundwire wake_irq */
+                               <12 422>, /* DWC3 ss_phy_irq */
+                               <86 183>, /* MPM wake, SPMI */
+                               <89 314>, /* TSENS0 0C */
+                               <90 315>, /* TSENS1 0C */
+                               <93 164>, /* DWC3 dm_hs_phy_irq */
+                               <94 165>; /* DWC3 dp_hs_phy_irq */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 993430be355b..2e9e57b2602f 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -34,7 +34,6 @@ properties:
         - nvidia,tegra186-sysram
         - nvidia,tegra194-sysram
         - nvidia,tegra234-sysram
-        - qcom,rpm-msg-ram
         - rockchip,rk3288-pmu-sram
 
   reg:
@@ -141,7 +140,6 @@ if:
       compatible:
         contains:
           enum:
-            - qcom,rpm-msg-ram
             - rockchip,rk3288-pmu-sram
 then:
   required:

-- 
2.39.2

