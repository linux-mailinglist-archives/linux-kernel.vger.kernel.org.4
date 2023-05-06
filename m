Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC06F9035
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEFHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEFHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:34:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF311B6C
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:34:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso1727662f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358440; x=1685950440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzc7fEYymsV81rQJGMHPbBkx6cBbwGrwRZfcN8X9Dqo=;
        b=BBERDjmCiHS4ibFtbHwl2xgsmEiM83TXAd6B55JV6ns3WJbxJvUGj4UXwTaCTjQRhN
         U4v7d5bB9+yYg9pPUUs6Qm57V5aBtqpp01ofFVF1JPUZyTkUtBLEh/F+xyt5m+WOnsoj
         kPHNYgacd67i/f2oE98VKK+FOvzJvsETXlkAuUeCJbYiwXfeW9CqP2n90OqK8RWWEIfk
         iyV1ZE0ljXeiJc1aXgL23CiNOFzAGwemMUT69yuKlhaLj3XPWyB0tAFytIthG5ep4jAW
         s6g4akEhYbsfzASdesHUa7yiKvROer3fCdVX0tq3FrF7h3QmB4K5q79lQZzwnd+ufMPN
         dqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358440; x=1685950440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzc7fEYymsV81rQJGMHPbBkx6cBbwGrwRZfcN8X9Dqo=;
        b=CEZhPnvMsoMeRsZEw6PCnnEDLsKSeUnfPltHlk18kcs3OJDN6dxfJGurTwDhSid3W9
         SIfXVLYy7pGIoKVSHImakdDQvxvmEMQNj44NaOxwOvxgJyGeSAxDVMOJqI4t6irbRmcw
         DEyZ7MHidLSRK0M+HXZymwoBxV3z2wN8T9tVlFCYE69vsHXo4eh1/sguDKZy1HzsiWem
         k4AkyzJ885n/PA3N3KCK3OuZqFLe7HWrEHF8fVL1CIrk7KjCPOeEMPMXj7HHjoKpL3Jy
         WI4K5RYWozjJa80JLE8OnpKEeAVKDkj5gxlOr0BwG2/UT3c4Ykmffl2n2iEg+6eTce1E
         d4cQ==
X-Gm-Message-State: AC+VfDwVgiYqWnFUR6eh61TsNrjlRiXyMDEFS8uxrbXRcYpeiziFmy51
        4pJiJY+ZNTpZHf6dOfTmD/bA2T8ecYC86F3Nkkg=
X-Google-Smtp-Source: ACHHUZ7HW+XvdPuxaNma9oy8YluJNS9JWOJYQVPF5Aa69QDk5VMh0R0ZLxtPOFQZlbjk8JzEzY9J6w==
X-Received: by 2002:a05:6000:12d0:b0:304:b1da:77d with SMTP id l16-20020a05600012d000b00304b1da077dmr2763936wrx.52.1683358440354;
        Sat, 06 May 2023 00:34:00 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5009000000b003063430ad9bsm4506523wrt.88.2023.05.06.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:33:59 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller properties
Date:   Sat,  6 May 2023 09:32:34 +0200
Message-Id: <20230506073235.2770292-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an optional interrupt controller property to optee firmware node
in the DT bindings. Optee driver may embeds an irqchip exposing
OP-TEE interrupt events notified by the TEE world. Optee registers up
to 1 interrupt controller and identifies each line with a line
number from 0 to UINT16_MAX.

The identifiers and meaning of the interrupt line number are specific
to the platform and shall be found in the OP-TEE platform documentation.

In the example shown in optee DT binding documentation, the platform SCMI
device controlled by Linux scmi driver uses optee interrupt irq 5 as
signal to trigger processing of an asynchronous incoming SCMI message
in the scope of a CPU DVFS control. A platform can have several SCMI
channels driven this way. Optee irqs also permit small embedded devices
to share e.g. a gpio expander, a group of wakeup sources, etc... between
OP-TEE world (for sensitive services) and Linux world (for non-sensitive
services). The physical controller is driven from the TEE which exposes
some controls to Linux kernel.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Removed empty line between Cc: tags and S-o-b tags.

No changes since v3

Changes since v2:
- Added a sentence on optee irq line number values and meaning, in
  DT binding doc and commit message.
- Updated example in DT binding doc from comment, fixed misplaced
  interrupt-parent property and removed gic and sram shm nodes.

Changes since v1:
- Added a description to #interrupt-cells property.
- Changed of example. Linux wakeup event was subject to discussion and
  i don't know much about input events in Linux. So move to SCMI.
  In the example, an SCMI server in OP-TEE world raises optee irq 5
  so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
  SCMI message in the scmi device for liekly later processing in threaded
  context. The example includes all parties: optee, scmi, sram, gic.
- Obviously rephrased the commit message.
---
 .../arm/firmware/linaro,optee-tz.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index 5d033570b57b..9d9a797a6b2f 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -41,6 +41,16 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
 
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description: |
+      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
+      irq is assigned a single line number identifier used as first argument.
+      Line number identifiers and their meaning shall be found in the OP-TEE
+      firmware platform documentation.
+
 required:
   - compatible
   - method
@@ -65,3 +75,31 @@ examples:
             method = "hvc";
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    firmware  {
+        optee: optee {
+            compatible = "linaro,optee-tz";
+            method = "smc";
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+        };
+
+        scmi {
+            compatible = "linaro,scmi-optee";
+            linaro,optee-channel-id = <0>;
+            shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
+            interrupts-extended = <&optee 5>;
+            interrupt-names = "a2p";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_cpu_dvfs: protocol@13 {
+                reg = <0x13>;
+                #clock-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

