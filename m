Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F1641C3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLDJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLDJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:47:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4D183BB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:47:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so14242887lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EgtMAreZX6v1a607duaaNtdR2Ho0lCLyBFIAD2u3Bg=;
        b=UWp5jxo5SgZmhR0ShSmbaFj2r/WTYvATnZCcb7Y1/Z8uIpW/2lS9xmd8kKm1Amh3r0
         SxbkFRMragD1BtlHGxx9EE1jOkLTJpdPyZVkEeCmuf/lna+QNz7teiHwXzcLr2C8TN1X
         He16v951Ffc6greL0gE0+xyxeOf27PkSE+u2iExhp+PVEBMsi0l+U5DukPYjVxhxRSlI
         ZsZTLazwK2iceFkYAGlt8LQNcwijhJa1ZmuGvNdFwwtwgGnhoYwvlIYFBdQcRUt8uKrs
         snrLHZvchdcWFOVEB82bx3MNaGN4fAIjSYzESwO0D45AW81gxMudu1AO/Qujy498EyKT
         radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EgtMAreZX6v1a607duaaNtdR2Ho0lCLyBFIAD2u3Bg=;
        b=OdNCl8J7eyENFB0MbiayG2zOYqbHD7MXhY+WrBCd/1w4u6rwMI5phh5rLYvhmuAOcg
         wbWc9A5v9JNQleGCpnSN4OEqXCVMJuFLF+imlkPxMd9CFHWMkcyswmU22BW9Ls15YcAS
         JF9nUj3IftHM54FIDbfMlJg6CSmqPPWrwsdZtiFNhD+4LSMuqZAqDFLFkdlFCZWCE7Vn
         T00Xuc2aB5Kb42sIcXv8THH5kfZcvto5kyL78EuEJt/w3LNmLPyUM8fB/Ee2zdid4jBV
         sQI7UWgwqq6SqeGPmCYe9dfDDPwRJQqgoEr5iRkFylS2ZpXSW3zQFBscH9gQXlWNBgk8
         ge+w==
X-Gm-Message-State: ANoB5pm3gop2aD4K/o/66900WGfrNF7fw3nAYGNDb4S5OWkm/XxmqtEl
        cRd0TcKTANtXk/kl8J3pku7IQw==
X-Google-Smtp-Source: AA0mqf4W++yII+JEJwHg1ZSnJBcLnVCaLxtGiBo9TVPZxhyKrxyFYE9NY5p/RQ+ELRJQi3lL/QqSWg==
X-Received: by 2002:a05:6512:1515:b0:4b5:5785:625c with SMTP id bq21-20020a056512151500b004b55785625cmr2429989lfb.361.1670147247643;
        Sun, 04 Dec 2022 01:47:27 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] dt-bindings: mmc: sdhci: document sdhci-caps and sdhci-caps-mask
Date:   Sun,  4 Dec 2022 10:47:13 +0100
Message-Id: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Linux SDHCI driver core reads 'sdhci-caps' and 'sdhci-caps-mask'
properties and few devices already use it (e.g. Qualcomm SM8450), so add
them to a shared SDHCI bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  4 +--
 .../devicetree/bindings/mmc/sdhci-common.yaml | 32 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  2 +-
 MAINTAINERS                                   |  1 +
 4 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-common.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 382d5face49a..c4c73ee1422c 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
 
 properties:
   compatible:
@@ -49,8 +49,6 @@ properties:
       - const: clk_ahb
       - const: clk_xin
 
-  sdhci-caps-mask: true
-
   dma-coherent:
     type: boolean
 
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-common.yaml b/Documentation/devicetree/bindings/mmc/sdhci-common.yaml
new file mode 100644
index 000000000000..1664615187c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-common.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SDHCI Controller Common Properties
+
+maintainers:
+  - Adrian Hunter <adrian.hunter@intel.com>
+
+description:
+  Common properties present on Secure Digital Host Controller Interface (SDHCI)
+  devices.
+
+properties:
+  sdhci-caps:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Additionally present SDHCI capabilities - values for SDHCI_CAPABILITIES
+      and SDHCI_CAPABILITIES_1 registers.
+
+  sdhci-caps-mask:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Masked SDHCI capabilities to remove from SDHCI_CAPABILITIES and
+      SDHCI_CAPABILITIES_1 registers.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fade797af150..2736c9a79f65 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -169,7 +169,7 @@ required:
   - interrupts
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
 
   - if:
       properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 3583c5f6889d..be71999cea73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18732,6 +18732,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/mmc/sdhci-common.yaml
 F:	drivers/mmc/host/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-- 
2.34.1

