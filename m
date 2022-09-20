Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A95BE4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiITLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiITLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1806F546
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w2so2537604pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9eQI2Cevi4CZxbZ5a/a4ZLydPDsHng3JOmFm5TOPYxU=;
        b=seHHPlJwXGEx6BmM9uq4xkwJnMtDLj3xONpxayVKGc3DoSgHi5g4LnC1alUGtNYEj7
         1rtso+wP9LEKfpwvCG8uuBvUKKafDHKsyA8JU5O5+7/dhIupWLGOOiwtkoWwiLEK0cEo
         4bgXbH8YLcZApWUohphuQy1Qh2E74IKCiuwMgUZVw2v8b18ouhk6YD4FW2in7rW6R+Em
         gXQtTyJhFVrAGSLlvl90DPrxQcaHOGgUGAsqyZCq2p8aEiU6HoIj884PwiM/0aLrgiDc
         JJvx+ODNRYEuYJk3WtCCV1PkG9MOBsF4Rg74wLMEt9U/fbe2Ntxv6AFA+ViipPiGJh7c
         /klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9eQI2Cevi4CZxbZ5a/a4ZLydPDsHng3JOmFm5TOPYxU=;
        b=u6FQ4wJsXklOgdroZkfHub3DosYgM0gVhCoeq3Qpx3zMoy0G/v3l/gpC3ol7jqkAGb
         nwOuerrxf4uToR+A1bwiJpHYAgUZFDsf41hrA/ae2eE+oXLwsokSnlgb4+sCqRrLcQvX
         KouORVNcyOwjPTyPNf9AlRz61F8/eBFgmHIVt+0dTVZIL3CwU4TAgieDT6aQZSazI23x
         TNcwwjLLZNth8ao6DF33E8HXwrxM5XcouFwgQfeMkKqnez53uA2An34Ytnl/1/VtrxEJ
         8I2Aczb68Czuqiy9Gg/KoFZiIEOtK1c/eGrIWOm2KF/9UEPro5cGhDKE9fRMXd3ebSDC
         jLjQ==
X-Gm-Message-State: ACrzQf3ijOho8IOHlmfcVLjp41WjAZuiLqtWt1Cm1Fy+mqZkfrSuPHou
        zWT4wx9f4ICf6I4JPDE7mp6ahQ==
X-Google-Smtp-Source: AMsMyM47G5K8wJp8zrxu/rF4BBKK7H5DKRfQh+xRdKkGsbBHKtmmZPNvkdCjnpfZ85bnEwJ83rY8XQ==
X-Received: by 2002:a63:e105:0:b0:438:b084:78ad with SMTP id z5-20020a63e105000000b00438b08478admr19750840pgh.391.1663674067023;
        Tue, 20 Sep 2022 04:41:07 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:06 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 1/9] dt-bindings: qcom-qce: Convert bindings to yaml
Date:   Tue, 20 Sep 2022 17:10:43 +0530
Message-Id: <20220920114051.1116441-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm QCE crypto devicetree binding to YAML.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.txt   | 25 -------
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
deleted file mode 100644
index fdd53b184ba8..000000000000
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm crypto engine driver
-
-Required properties:
-
-- compatible  : should be "qcom,crypto-v5.1"
-- reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- clock-names : "iface" clocks register interface
-                "bus" clocks data transfer interface
-                "core" clocks rest of the crypto block
-- dmas        : DMA specifiers for tx and rx dma channels. For more see
-                Documentation/devicetree/bindings/dma/dma.txt
-- dma-names   : DMA request names should be "rx" and "tx"
-
-Example:
-	crypto@fd45a000 {
-		compatible = "qcom,crypto-v5.1";
-		reg = <0xfd45a000 0x6000>;
-		clocks = <&gcc GCC_CE2_AHB_CLK>,
-			 <&gcc GCC_CE2_AXI_CLK>,
-			 <&gcc GCC_CE2_CLK>;
-		clock-names = "iface", "bus", "core";
-		dmas = <&cryptobam 2>, <&cryptobam 3>;
-		dma-names = "rx", "tx";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
new file mode 100644
index 000000000000..8df47e8513b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/qcom-qce.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm crypto engine driver
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  This document defines the binding for the QCE crypto
+  controller found on Qualcomm parts.
+
+properties:
+  compatible:
+    const: qcom,crypto-v5.1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: iface clocks register interface.
+      - description: bus clocks data transfer interface.
+      - description: core clocks rest of the crypto block.
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: core
+
+  dmas:
+    items:
+      - description: DMA specifiers for rx dma channel.
+      - description: DMA specifiers for tx dma channel.
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-apq8084.h>
+    crypto-engine@fd45a000 {
+        compatible = "qcom,crypto-v5.1";
+        reg = <0xfd45a000 0x6000>;
+        clocks = <&gcc GCC_CE2_AHB_CLK>,
+                 <&gcc GCC_CE2_AXI_CLK>,
+                 <&gcc GCC_CE2_CLK>;
+        clock-names = "iface", "bus", "core";
+        dmas = <&cryptobam 2>, <&cryptobam 3>;
+        dma-names = "rx", "tx";
+    };
-- 
2.37.1

