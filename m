Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70865B44A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiIJGdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiIJGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:32:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCCA9C23
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:32:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6493342wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QiWSd72/Gov/txDRXqyZOezqNFbbbhOFh/0naTA0HJ0=;
        b=SpOvu81pXZuIvpN2Pu1UBKqilGk0GKLo5EB/rhi1x3ImLgBOOl2uoXnY30OVEmc1Dr
         Z4C1K1H4EW7oIribQyOy5/F40btpCJlaCi6WR50kt7wh/MmW+NnsP1mWwjm/mhdxptMp
         TlGkKBhi+HQbsZT4Vw0qkYfBZq/K1b1d4dPnxsRcSa2wL6+zwb58B8MCPkN8oQeWcq99
         hX+G6h8ha/CDWzOoR+mMoamh4RvccWHN0bTp+OaYbLD0DN8hN6R75k2K65iCbDd4hmpN
         mvp/22w8g8KEQjysvkkh0HGuuNSWxMw7Mjm4rQzZ0yoO7XvxREne2uM/iPUs7NdiQ2Kt
         NsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QiWSd72/Gov/txDRXqyZOezqNFbbbhOFh/0naTA0HJ0=;
        b=ZPVS2t1txpTAXAAo13vqHqkDh8nAd8Bxi46QjA7zSmNl9f8w3ZxmNAOU39Mk0g/bLY
         kbo1/vBfiSCzuuazlZVk6WCseE6LYqiQxpbzqv7eaHFT7z2dvS9ZqnDEKwF9ilfnwNr0
         ozGdFvJxYjCLiR3lOL2pF9ks3WoggEAnUxl3AsAGBaWd5FNldHpaeiiZO5s8IHwuAlAe
         xKWdv9Jy8kFrLFG2aAikDsy8k/JESFRkdf5bURbY0c/cTvvt+x23QlLumdpbCFzzzKvq
         +7Gdi2hNmps6Em1eGj2ebjaRa6jzi3mpABGV57NLH/2pO7Bdea7w3ggl25O8CyhXlB/k
         S0Jg==
X-Gm-Message-State: ACgBeo2q1zaB6L/mDa9YMQY8HGJZhAb/yXo8lpgtdnoEWP6wIFpZlTKL
        KRsK/TVfR+b7HEkMTBXxgOGt
X-Google-Smtp-Source: AA6agR5AKoMPVA1kSBoPA5L6Q/QgGVFryc9Q7MLLSN2xzwq39z1mWVhmxkWQ9KbLeyTu9/aoBgukyw==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr7309474wmc.78.1662791548515;
        Fri, 09 Sep 2022 23:32:28 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:32:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 11/12] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Sat, 10 Sep 2022 12:00:44 +0530
Message-Id: <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings support for SM8450 SoC. Only the clocks are
different on this platform, rest is same as SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index bb8e982e69be..977c976ea799 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,sdx55-pcie-ep
+    enum:
+      - qcom,sdx55-pcie-ep
+      - qcom,sm8450-pcie-ep
 
   reg:
     items:
@@ -32,10 +34,12 @@ properties:
       - const: mmio
 
   clocks:
-    maxItems: 7
+    minItems: 7
+    maxItems: 8
 
   clock-names:
-    maxItems: 7
+    minItems: 7
+    maxItems: 8
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -124,6 +128,35 @@ allOf:
             - const: sleep
             - const: ref
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-pcie-ep
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+            - description: PCIe Reference clock
+            - description: PCIe DDRSS SF TBU clock
+            - description: PCIe AGGRE NOC AXI clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+            - const: ref
+            - const: ddrss_sf_tbu
+            - const: aggre_noc_axi
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

