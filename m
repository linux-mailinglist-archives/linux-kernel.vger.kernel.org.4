Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62D6BAF54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjCOLd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCOLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:33:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98758664D0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:32:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so74033903edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJIPBS8b/IYdR4MkxApb1rcmpblReO8/5hZw+mD6UJE=;
        b=X9LPWl7Pb9C642Yw4iaoa1AZ5rYTdPMk6OA9tgeICQR7HthDyZgJxaUjxTyu/tKLmW
         DzNloFI2QUJ46vblYORd8i4VOpYMBefgjd19+YWrOIBbBFIjj0I9xqntS/2uSAEaqd+z
         53NP4K1F7y6hERBCcILUTncdCsSB/saafrlYSTIWMhNSF+yi52SUQ5b31KAHWQwLABQ+
         4a+ES+yNiqJ/1QPc+6KNIZp3Df1HNdDIgZEu7fd3lXxVmaVAaekAYolwp9igQgVP/Kl0
         ITeHhMQv6gIajMMRRbsVMNkMRbFLz01ROk/QrPT5MMRml6bsbm5HgtFzCMksnBQeOni4
         Pk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJIPBS8b/IYdR4MkxApb1rcmpblReO8/5hZw+mD6UJE=;
        b=IuTsHVuPOMfdvyYU1OVTP5OQfHI8ovxH9a+hzAicFZc4lFsARJO7MOgLQflasZDwPV
         v/TlqUE6372C+zNKfBCykXMInfnDV2v9ndj5hn0WijObntQBa+U23Rx//Z+JmtbXANBh
         Eo4EQHS30642Rgg0O4Kr5mKhLR2C/zU5+DFEo2GMx9PiL0eIUAUbhxxJSg2Xu0SI7xqZ
         Q2C+q/1yVV8suuJ0uAWA8155MWYcGhGoYJbnjPnSdLdpVykbg1r8A6YOVvh2iU2QuVX0
         N/A/czzpEB9/VknqYfsgvKAYO38fiUMVgiX9NIgm3kgCximErekdncvRaK5Qk7K09IcB
         OGnw==
X-Gm-Message-State: AO0yUKWCEHlI3riq3mTQg8Dpg9VndFjgoAPp36bRWDO7cwGILZjFMu5c
        EpMmBn+jHPZdiIuuLtAxn7QpTMo7jmJFEM0xCzo=
X-Google-Smtp-Source: AK7set84sKeemJG3TVXCoAn4ULR4rtw94ThipVDY2A+00vI2G6z4JpG26lUn9i2MCSEXCu0UVWwtEw==
X-Received: by 2002:aa7:dc17:0:b0:4fd:2363:16f2 with SMTP id b23-20020aa7dc17000000b004fd236316f2mr2051972edu.37.1678879926592;
        Wed, 15 Mar 2023 04:32:06 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1008:2d39:4d4b:ab19:bc3b:a0cd])
        by smtp.gmail.com with ESMTPSA id 1-20020a508e41000000b004fb95f51f54sm2264151edx.12.2023.03.15.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:32:06 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: arm: optee: add interrupt controller properties
Date:   Wed, 15 Mar 2023 12:31:59 +0100
Message-Id: <20230315113201.1343781-1-etienne.carriere@linaro.org>
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

