Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5A653D72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiLVJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLVJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:24:32 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37056E0BE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:24:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so1815037lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68vQHDAyfLGGKwktfUmbOivt9MYU5nkUryP23gTK9rc=;
        b=Kip7m14Xx/tarhFOdy0J023i0JBfWs63+4+z8MBWphGmFJuVzcG2VvN8GOJda5dMTq
         7PlAP4gg67X7bhNNylVt/nUYE2COvdoNgidOoxIMVVZCljcEVk2F0f7qTMSNZGSl+1WI
         XeUtodjxd9xDRpqogO5b6pvoTGQbw8UZD1osYWJ7bjCPl6gg5YdaDOIJ2WfNH0UoMXCb
         agWbFKevRVcIQ4SlXRFXWjacmIgLqmjluQ1i4lVWLVe5bvu3vwAT53AlvQ1aLIkcaubX
         qZ7Mlmni4RDfYhwGUBPZ33lOVMQEvSkCXs3gauwe7QtJTI27jH1kPe6f3gSoWaEDWDXL
         C0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68vQHDAyfLGGKwktfUmbOivt9MYU5nkUryP23gTK9rc=;
        b=pA5hsgc9a7HxBgjFErGHyOeXQ3tmTzYNors7Lw7xRfDpfHPlDnIqPSPkaKGuKY60bL
         luoDbk8jPjgvru1pR1b+kCdAmA8i8M3gccBh9KYOKZpJ7kytfUxsmbgsNY94rBBKIgm6
         GIccLv3e52Qx14EJsGoZ1KsucINgqtm7nymcJ4n2ozVSva9h0rBRsSL8s+CVfI9UOE9F
         oZ6I12t9YBqA8sTPCJihzb2RzfVkjbdrkNrcqp43XeryaVcwaMJqolMiv6GNGYR1zUHy
         Xpx6KA0FHeiGlQSXVP19X1B+D/mDLV/DOT3CmGwIySh03mNMJcfndGW3rDzkc7jp0Wf6
         oarg==
X-Gm-Message-State: AFqh2kpIJOMu+hDa9MAFx2AQkkpnvRzNY8cCbUaATs1Ql0sr9tFbATPi
        gMVP6C7apVrNCX0xkKF8JKH7zg==
X-Google-Smtp-Source: AMrXdXvRLGXpw/IldWjcH6Psvsy5FKL2mJyz33k7rd2bZ1PP4sfQulfRObsX2FkVtKHWyRygK0FruQ==
X-Received: by 2002:ac2:4bcc:0:b0:4b6:fae9:c9b7 with SMTP id o12-20020ac24bcc000000b004b6fae9c9b7mr1425029lfq.7.1671701069434;
        Thu, 22 Dec 2022 01:24:29 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i40-20020a0565123e2800b004b0b131453csm10724lfv.49.2022.12.22.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:24:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Date:   Thu, 22 Dec 2022 10:23:55 +0100
Message-Id: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
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

Disallow clocks for variants other than:
1. SMMUs with platform-specific compatibles which list explicit clocks
   and clock-names,
2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
   variable clocks on different implementations.

This requires such variants with platform-specific compatible, to
explicitly list the clocks or omit them, making the binding more
constraint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 895ec8418465..0d88395e43ad 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -367,6 +367,34 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  # Disallow clocks for all other platforms with specific compatibles
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cavium,smmu-v2
+              - marvell,ap806-smmu-500
+              - nvidia,smmu-500
+              - qcom,qcm2290-smmu-500
+              - qcom,qdu1000-smmu-500
+              - qcom,sc7180-smmu-500
+              - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
+              - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
+              - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
+              - qcom,sm6350-smmu-500
+              - qcom,sm6375-smmu-500
+              - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+    then:
+      properties:
+        clock-names: false
+        clocks: false
+
   - if:
       properties:
         compatible:
-- 
2.34.1

