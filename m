Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371569F7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjBVPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjBVPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:33:29 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903339CE9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id fd25so3882499pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMSvnDU64o95J5N9i3H4OYKYP+QezDC8GOgpgloFHv8=;
        b=GDFmvn86qxfTR0yFZJ0kAN5wpkL6OmovwhzyDVJMaoo5VoeD6W7HNMZ+L7inWzGW20
         NZTEKa3hwArvPxMK/A5YxCkzFbOyG57LnQTHFZHVqfTOWmiHXTrfnvnFh6z2RCl59B/d
         a8Ri7whljlL9tjARXm/cua1hCL+UT5QkeD3W8bMwFWRdmRvd9ZNBOFMmY7JdEwswJBip
         nZqNsjmhVnj3dzV0Sdgi+gXkRk6RB+wd03h6x0umiA8nZtvNC4cXGP8Tac0foKnG2gyA
         s10Na+zpRapA62TDhdRdK2FBCT1RX3gtgkSsIjNqaEneSnQmVeQmFOepT8TRCMqkC9y2
         pSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMSvnDU64o95J5N9i3H4OYKYP+QezDC8GOgpgloFHv8=;
        b=bOD+eUiOrDYIiW/jCo2mU3AbPmRkUcolR98/YWFUzttIlt7sJ6i/sCLggw9Nl62mLl
         UcYUkrM11fHkHnR1b6kiLMY3KL+eI3yGYa7nDUskIws8XJHIqiXcaRIhuMIlW951C7rD
         6mNymZDFKUF9conu5356QsH6Uk24m/P6qU1lxYB3JiuIzOov5H7o1s3fdW8qL/td9iSN
         haMw3peMYNh3G9ZnDUmlhrgFs1enZvKHGYu4bld8Rodo0nTPiXedmxjPqaS06QqcS5Uh
         dyemx6MocxI+QXV/YoS+CqHh8VTgB32x7l0k6/mY+QSIr7hjv+vGykFFTeV4x0NzBVjn
         FfbA==
X-Gm-Message-State: AO0yUKXyCZslusY0eVcmSs65H0OnsQWEvSL5ZH/cb1AKXw5TuXwuUIZd
        sETjcAjNoLytJtQUIab4fuzG
X-Google-Smtp-Source: AK7set9ni8WDJPDhM17uAJwQMGjhZd/em4yQh7aJpXXmajfE+IZd1d8hcwT6xeKzy8U9BhvFvF3Dhg==
X-Received: by 2002:a62:1cc8:0:b0:5a9:c682:f489 with SMTP id c191-20020a621cc8000000b005a9c682f489mr8338789pfc.3.1677080000042;
        Wed, 22 Feb 2023 07:33:20 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/11] dt-bindings: PCI: qcom: Add SDX55 SoC
Date:   Wed, 22 Feb 2023 21:02:43 +0530
Message-Id: <20230222153251.254492-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
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

Add support for the PCIe controller on the Qcom SDX55 SoC to the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index f48d0792aa57..3bba1ef3cff5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - qcom,pcie-sc8180x
       - qcom,pcie-sc8280xp
       - qcom,pcie-sdm845
+      - qcom,pcie-sdx55
       - qcom,pcie-sm8150
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
@@ -199,6 +200,7 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
+              - qcom,pcie-sdx55
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
@@ -646,6 +648,32 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sdx55
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: sleep # PCIe Sleep clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
-- 
2.25.1

