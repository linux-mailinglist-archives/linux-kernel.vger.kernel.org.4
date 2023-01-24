Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FEB6795D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjAXK45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjAXK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:56:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2DEC45
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:56:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so13442842wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7zN4CDUViF3PTZLyM/3kFec4UidZAgrawq/W4v1dbE=;
        b=SVJXlXmbWCgWfJoKLOELiV3fZM7TPGBX7/4aB4cChDFmAvaO9yCbZCWDpOcBZqJxaR
         KjIFa5J7OWQxCCSQRDc4f1OIGR1hBaWUF078zeJ8y/lM05hTyPeezt5abkzBoaOKnmlu
         jTa3bmaeBNjpSZvnrIm15snup4RRtZNHZRf+yM0ZEJLZ1KaCqFHbkBDp5ZjlGQzmCH8A
         q0EIoCrh1pgKipIQ3BjEfUn5cTeCRq4Y6O/7IbwYqJtXjpKZzSO132hhx609ae1/jmmp
         vYKvjj1A9a3WC4y57svKbk834PKkeoAJShWJsTjeUzT3yCJWhS2HJpTGcAeo11cyvoMc
         sAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7zN4CDUViF3PTZLyM/3kFec4UidZAgrawq/W4v1dbE=;
        b=YIDcqv4eeqsph6yY5qxIha0YHm/LUWrXyO6AWK+KDDCRoA31lLcZnVPyyF1sHvY5CH
         hulx1nwL7S8Kalm4UhQZQIRNYi1ihP/SawIQHMtOvByU86B7RQo3W8VGImibIm4h+UFx
         YQxHVH+j5tcjqiP+LlxiCE8KOc6564xUZcfNWdTrrbm7y8mb5YD4RajQ94b97nSDUMHC
         5pYO6XQNe/as+tXjFbLrE2WnD9iW9fiBUKfHdBv92jR9gB6GutwjWYSkKkh4uxK5BkfL
         hm+Swm4r4MabsLP9s5cFrJCAx/3Ypz+hSe5PgT+aVNP1Yy6QGm/lgn4nuCUM/g+VEX0g
         xAIA==
X-Gm-Message-State: AFqh2kqa3HYNk0oWCTMcYE8hbfGI539Cj+H1jWVvauv1XZNdK6aiPAjh
        jCmo188KHdQydDokczUVwP/IhFtKYR1pRKoJ
X-Google-Smtp-Source: AMrXdXu3Gr2Q/6kcZgUwMrG1H6sh7LLL+2/5nXY5yhzNItteTHxFz+SnPxHNUrK4wfxe4jmV40aS6Q==
X-Received: by 2002:adf:e587:0:b0:2be:54a7:2b8b with SMTP id l7-20020adfe587000000b002be54a72b8bmr14573243wrm.21.1674557813173;
        Tue, 24 Jan 2023 02:56:53 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.43.103])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b00286ad197346sm1599336wrn.70.2023.01.24.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:56:52 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller properties
Date:   Tue, 24 Jan 2023 11:56:41 +0100
Message-Id: <20230124105643.1737250-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an optional interrupt controller property to optee firmware node
in the DT bindings. Optee driver may embeds an irqchip exposing
interrupts notified by the TEE world. Optee registers up to 1 interrupt
controller and identifies each line with a line number from 0 to
UINT16_MAX.

In the example, the platform SCMI device uses optee interrupt irq 5
as async signal to trigger processing of an async incoming SCMI message,
in the scope of a CPU DVFS control. A platform can have several SCMI
channels driven this way. Optee irqs also permits small embedded devices
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
Changes since v1:
- Added a description to #interrupt-cells property.
- Changed of example. Linux wakeup event was subject to discussion and
  i don't know much about input events in Linux. So move to SCMI.
  In the example, an SCMI server in OP-TEE world raises optee irq 5
  so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
  SCMI message in the scmi device for liekly later processing in threaded
  context. The example includes all parties: optee, scmi, sram, gic.
- Obviously rephrased the commit message.
- Added Cc: tags
---
 .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index d4dc0749f9fd..9c00c27f8b2c 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -40,6 +40,14 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
 
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description: |
+      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
+      irq is assigned a single line number identifier used as first argument.
+
 required:
   - compatible
   - method
@@ -64,3 +72,62 @@ examples:
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
+            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+        };
+
+        scmi {
+            compatible = "linaro,scmi-optee";
+            linaro,optee-channel-id = <0>;
+            interrupt-parent = <&gic>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_cpu_dvfs: protocol@13 {
+                reg = <0x13>;
+                linaro,optee-channel-id = <1>;
+                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
+                interrupts-extended = <&optee 5>;
+                interrupt-names = "a2p";
+                #clock-cells = <1>;
+            };
+        };
+    };
+
+    gic: interrupt-controller@a0021000 {
+        compatible = "arm,cortex-a7-gic";
+        reg = <0xa0021000 0x1000>, <0xa0022000 0x2000>;
+        interrupt-controller;
+        #interrupt-cells = <3>;
+    };
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        sram@2ffff000 {
+            compatible = "mmio-sram";
+            reg = <0x2ffff000 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0x2ffff000 0x1000>;
+
+            scmi_shm_tx: scmi-sram@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0 0x80>;
+            };
+
+            scmi_shm_rx: scmi-sram@100 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x100 0x80>;
+            };
+        };
+    };
-- 
2.25.1

