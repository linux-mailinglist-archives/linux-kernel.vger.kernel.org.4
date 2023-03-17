Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC396BEF44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCQRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCQRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:10:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76366A5D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:10:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so23011331ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679073023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbiO5/X3P9CxjsxwAoFfrfx6CtrKMZRN7CMSZJ9KayM=;
        b=WjWna3CsJ/ma24fuaikjiZhs9+BstGlhXHBQXWp/Nbqwzm2OeAqGfg/A7tQUET5E2u
         NgfGKqOMDoiwGYMZTlmiqT1xtQyLWWM0tOTIigFQPVk9IDiocJHAUck3+OvCJC2CUWYj
         8jHjmAydWufJtElxKE4y8ZBBG/ARLmB6Av+ukYDfbzkTR9UTXtnFrsQd3G1qQ8Sk/60i
         8hzrO49oZffS5xoFrOHhnimfPhJAquL+UnRiHGmjSKpVoBPuAiwdKsgG5H4XafaeGo0G
         1TehSVpsNxSXhH+1VOgttJvkkPaeuqbeaLLfuZ9aTwsf71WbETGxdB+HW0onVQa6Gej2
         P7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbiO5/X3P9CxjsxwAoFfrfx6CtrKMZRN7CMSZJ9KayM=;
        b=lFGXzlP5zVTyzJPriFri5cxVepX7kC3pNp7IjEYmkI1tt5uzuZRhta2Mkg9oR5bu/E
         leAGn2WSJMuCgiJc9OLNH8JLkA3nAt8L1vcMiDIgqVoi1n1Pmcs+1JFQrGwGabw/sgPW
         h8Tl+rCTcuZOacrMAzWVDjEZ0YAeUZk7493Pg4IQ1yWO7MyAJ2xrX8wAmmGJo6dldIk9
         tEFIwdqb9O/z1VhZwG/MqlRxbqUMAuCyDd/wRaXkhPPvK74nJgxe57tS/o8uvAI7WqYy
         sPjiy/hEKUbVLU4vLbUn8kitNzXEHWKS1q/ukIYGEB2v3y16IxmbhJSLfT5ogZxmO5o9
         3MbA==
X-Gm-Message-State: AO0yUKVj/KGDsBXCu+VmdM1wJSf8SaXzof+GvUj5thvfJChYmC45x+aU
        +4CQ+5eTHsFz6wi1qMGLWlpLj//HQiSW9NoifrY=
X-Google-Smtp-Source: AK7set9gP8Oua/MgC7u4bl/PdJ8GJj9h1Z32jCyyMKVY+tUp09SF3tAQnBmwqDmJFb2VB2QJbc4MSg==
X-Received: by 2002:a17:906:cd11:b0:930:123:8cc8 with SMTP id oz17-20020a170906cd1100b0093001238cc8mr77478ejb.21.1679073023656;
        Fri, 17 Mar 2023 10:10:23 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:10af:6120:339:9abb:39d1:cb35])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm1181067ejc.197.2023.03.17.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:10:23 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: optee: add interrupt controller properties
Date:   Fri, 17 Mar 2023 18:10:02 +0100
Message-Id: <20230317171003.974801-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index d4dc0749f9fd..ff7e1292c803 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -40,6 +40,16 @@ properties:
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
@@ -64,3 +74,31 @@ examples:
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

