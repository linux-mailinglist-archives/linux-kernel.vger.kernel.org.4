Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32E6BC8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCPION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCPINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:13:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9EAB482E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so776461pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa5+j+q0lCIAbc8JmC9mNr+0xopel6ew7V5dLkcdAME=;
        b=MDlVi+hX4yIa61hBzu4Po7iIK1TKUYMwQKEVnr45vuMN2m+uN8NHLb+uSlC1Prxz4B
         wO2zbA2l7hIg+iFAD2EjN/F76XqTgmM5LHGiDbILv4T1NubwS23jCozb1jFnoGasR+8F
         X/Go61rmLfrbB+u9/JwKqUoMxGAYgIjXUamvL8XVZhKJmJlMC61naSy3m8hF7UkP/TDL
         rLtiRrx3WTX355J/9dhJAebbRfLl+JwfdbFMadc/Ap15qLwN/V07cBl1Xke8txUjKUlg
         WH1FjTTsouXQYsjxkrq9Fw55M09GRo/MiQCEhSdwhHKCIhytzfHl+VE3Z3hXPNNIF29J
         mcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa5+j+q0lCIAbc8JmC9mNr+0xopel6ew7V5dLkcdAME=;
        b=MVnUNm/uE5Usbg9rYGY97OtAnO2SI44DfET5R2Yb1NulOnWNYIR7oxL873lfHSWL15
         1ZYoKSpHMFvxrLQzwAIhA3ZaLEBeYrbOBUdy4cDJrZi5GM06PoK/+KfjpFQz5I9XE0Zc
         G8tMaa6PyWcDxvsF0SQkVUcejf53JVqHmYZulkg4URYSM7NxmhgTQ46U8MJPzfW6FblR
         lNjbRCLSVYhYr70hyJYYYm4mv8HI2/ZJnBYcOPk5p6GWGjORUQLCH+roZpqZZHnAbLuk
         ghuYW2/emcNVzOvOP9dBA8b+TmWmTW6bkmw0nQLav4MSMp3mvabFodjhHrnwuQ2XRz0i
         dnKg==
X-Gm-Message-State: AO0yUKXzrT072aQGtlnsRD7/zKYChdo/7oSDb+zXnZojKrhKHNqrrNwh
        g3CdMrMCFbBZjqXq7f3J6LNd
X-Google-Smtp-Source: AK7set8BeO+fRDR0c5emkkdmsSXdfiYHELh8ectMRFABlsxc4jd7Vrco9adoXo9i3JO9cYerDAs5Jw==
X-Received: by 2002:a05:6a20:1582:b0:cb:c266:3f6b with SMTP id h2-20020a056a20158200b000cbc2663f6bmr3271138pzj.12.1678954359174;
        Thu, 16 Mar 2023 01:12:39 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 15/19] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
Date:   Thu, 16 Mar 2023 13:41:13 +0530
Message-Id: <20230316081117.14288-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

"mhi" register region contains the MHI registers that could be used by
the PCIe controller drivers to get debug information like PCIe link
transition counts on newer SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..ecbb0f9efa21 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -44,11 +44,11 @@ properties:
 
   reg:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -185,13 +185,15 @@ allOf:
       properties:
         reg:
           minItems: 4
-          maxItems: 4
+          maxItems: 5
         reg-names:
+          minItems: 4
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
@@ -209,14 +211,16 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.25.1

