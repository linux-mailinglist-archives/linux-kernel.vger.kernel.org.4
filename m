Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466045B827F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiINH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiINHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:55:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8D4454C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:55:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ge9so2220805pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9mP9HJdXVQAxtsXYpKC+mSQmcqbaHq7yO4Fo8xLEceU=;
        b=wUYIypOhGADGriBI+bgSRel8LMXbpdGqu9/K77qWEwH64/UwapHSINwuixauatFQVk
         WMK2f7wAtaMNTmJ6LW0Z5QDYcOXpzm6SKnovPAZPUrrc+ylHK66rhmKzWDfaarZJ9rNz
         CuvtrZiYbgO3iDlkxqXAYuZGZV6d3iFjhOKokE6zrBj6Qx1S4QFOkCuBtLrQnhVjJM0S
         uU97M8xv7YoznAK8Kl+axyREUlhNamsPYT4vyAVDK1vV2TgimGoGlsXWqRG8tX4G8eYC
         YXG2hyhuDPRQbsjSG0W9FaHs4f3D07Puk0UgAJ/NEDqdRYMVToYuDCXqSjqQr8pzgwAM
         RKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9mP9HJdXVQAxtsXYpKC+mSQmcqbaHq7yO4Fo8xLEceU=;
        b=v/mizMcnUzBCN7cBvQ5MNoZA7tppYojfwqBnR4fgE6ioraNVj59QSi7rQQGjQwZgaW
         a/cG+lBhv1YeY6JNLag1GheFJ8P/nkm7HMJoPEErEmGm7S2nFy3AG1tVxlBPkWkvjRwO
         iaE08HM9B2zdquXzXuVpcOC4YgCim4gtD8zAkk4L3bjTpXQT6gJjAqVXiZwZI96x5T9O
         BdFiNSeU+kuG61Vs5RyNiN8AShJIjNBi7T8dvS+LUJPjH7ohUeHOUhnZ7ea/tayV+xe9
         6/7Qa5t+BQP0MkAbXDi07kaGwdy32uu5t65YYi+z4xepyvK5IQzBlxIR6+Za3wJpiQmd
         te7g==
X-Gm-Message-State: ACrzQf0yW0R0Gp3sqj7WVKUfg1qNqvNZv0bqj/agWL3lNqqwst1WMalN
        sbVnzCHWnX3/IO2wFrWnnUbz
X-Google-Smtp-Source: AMsMyM40w4UYyHvFh7evE7z1F+eiJYVMfWYqChW7KmQX97jRbMwd47LDyQUEe+xCqqea0RKZyIe2Mw==
X-Received: by 2002:a17:90b:306:b0:202:b9a4:b0aa with SMTP id ay6-20020a17090b030600b00202b9a4b0aamr3467801pjb.78.1663142108381;
        Wed, 14 Sep 2022 00:55:08 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b00174ea015ee2sm10119054plb.38.2022.09.14.00.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:55:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 11/12] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Wed, 14 Sep 2022 13:23:49 +0530
Message-Id: <20220914075350.7992-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
References: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

