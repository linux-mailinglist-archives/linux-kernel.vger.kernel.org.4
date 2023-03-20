Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D846C1580
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCTOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjCTOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:49:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19032595F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:47:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so47681488edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679323640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il9YWorlQE7qriqKsC4ZO4n1FQhxWC5upPu4Ay50MJY=;
        b=FBcCe0Xs0m4wCKZL7wJQPbxIonSqZsX0kg3cURIN3/IszssXDbcQRURBwuYQCwhXra
         wgFt+NPOwYG4vJfPKs86Ju9T/efHjo29D3lLGApKgLJ1zpH4Fy1zlZiBLDuWDCvpkTGU
         Ea/nA+kpZPyZOk4+XlZDVG/bxVFZY/aK/bPcNGefdx1qVMAxq8vmjj9nNjnv9MyoUF2h
         f322ouEa1vEVtuumatLFlxHEVoyPifT9g1g9L2WvT/Mr7wgwna9JYW2PTeZZXHAtA/4A
         IUAK6Occ1xz5GFmiCcBWzehOcHgr2qpte2UAay2/51BLIuLpFWleLow3Z4tkYuX30lFJ
         1FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il9YWorlQE7qriqKsC4ZO4n1FQhxWC5upPu4Ay50MJY=;
        b=kDwJ0zdPRdk5v5qXdvoBWNu7NXFQxQ698M+Ln1R1Xg4X5G1XpEjIFHGDqjh4xSM6qO
         FXjQjJGLn8wIGxVejF7fD0Rk5RS1QRKbwbOLNGf+2kn8/WZDsi30fYt0jbn3Y8tzw3A9
         Q1MN9lIlCD3daYX7bTkqwQ2UBrXXC/3AP9iX0Mq5xNtdz1vmdZak5xu89gnnrWUN+Ewn
         YJqifG56ZwhJo0pBdw1GExMxLst7JGCzSRBKg6VnppjoONS338f6QrHOkS6xXr7z4ghm
         ZPEqQnAoOgr/CMQ8INRf27XUJzkefJsmszLJRSINcBiduSbx6BswyTvpLE4rRVqunX3d
         AnBg==
X-Gm-Message-State: AO0yUKUsPhsIi0C5wzrm1U56viv7DLC9iUeZhAoH9FXiWdM4opSA1iBi
        Ide3zmw2ROZGaKmwl0lcHNA2wA==
X-Google-Smtp-Source: AK7set/OVWu4fwaMjI+KXgkPc6AvBpPPQLglH9fGEnmWHgw5U+gGtq86OjeKuhQ9kIsRt8FWJx9Ogg==
X-Received: by 2002:a17:906:39ce:b0:932:c1e2:9983 with SMTP id i14-20020a17090639ce00b00932c1e29983mr10328923eje.15.1679323640207;
        Mon, 20 Mar 2023 07:47:20 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x2-20020a50ba82000000b004fb30fc1dabsm4913172ede.96.2023.03.20.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:47:19 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [RESEND PATCH v9 1/2] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Mon, 20 Mar 2023 16:46:57 +0200
Message-Id: <20230320144658.1794991-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add the SM8550 platform to the binding.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

This patch is a resend of the following:
https://lore.kernel.org/all/20230208180020.2761766-10-abel.vesa@linaro.org/

No changes since then.

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..be7b4b805291 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,pcie-sm8350
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
+          - qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -58,6 +59,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
+  iommu-map:
+    maxItems: 2
+
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
   clocks:
@@ -205,6 +212,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -639,6 +647,37 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8550
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 8
+        clock-names:
+          minItems: 7
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: noc_aggr # Aggre NoC PCIe AXI clock
+            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+        resets:
+          minItems: 1
+          maxItems: 2
+        reset-names:
+          minItems: 1
+          items:
+            - const: pci # PCIe core reset
+            - const: link_down # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -724,6 +763,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:
-- 
2.34.1

