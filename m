Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346AA6D235A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjCaPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjCaO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415472033E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:59:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r7-20020a17090b050700b002404be7920aso21619464pjz.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680274780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NzHj5YNmfV17NjzDcXNm3XqoCp5Q8xNrFkgMu/Sz2E=;
        b=MURy1nptnSIC9bVRPExXFlM9BrJR8EjvMi0qpfg/x4x3tVHEuRG+z/vtu5BCYYuPdq
         amAASCWBP/TCAdNwiWg06uqq3S6CHuW0lGHHqnf3VsQDGmzejvxgRZmC+FzC0arwNJQ4
         xC1Gqx2g1l5qAril3QBD/1ZIrg7TolxArVjthZldiNisV2MvZEENV52wCjn/2Hi1WbtJ
         kMS5iIN5r2MPfOoO/By2o9sD6nvkSjLasEDzUz40HnZCqMsVyCDWLTuJEUK3tI94tspc
         pEs0Af6rE/gGh/7uxuoSlCz/XTt1ah47hA5Xn+V0kWvpt6ciPLpbyviqFOXEN83T/UvJ
         X7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NzHj5YNmfV17NjzDcXNm3XqoCp5Q8xNrFkgMu/Sz2E=;
        b=qSkKXCNBrDJ5MtjAD8dBAmPmqIZZg9WVO5pf6qsr+xyKONI4TrxFYE9fsr9a2W4BJk
         zvIxvRq0lYK8XwI5lWg7qzHcl345bm7bu2P16sya3PGUkJgpncQsrPoGYDB/EwkMrLJ5
         aVz1GdapvSZ+Xy80KgQCHL5Nrw+n9/AFBDA/d5jegITjvbqX35Som33CkKLVKc2315yW
         96oKr4YfEISywAbdpSxgW9MhWRccdotxDdECNoHPRh2NuSmMfMVdbNjp8jjNV3WZsN21
         oMkO2AK0U6MtTAId6AAof2zoIXgxSr15Nf+BnxkGJawj9mzJte2crEayaKDfs9MdUnJF
         cSzg==
X-Gm-Message-State: AAQBX9cspBHDl2PCgyOKG1thqGPzIJPlbRucYD1+8+iOrzjI1wuUqXC5
        KrdkWkKoAu/VKadmMUBqqWrM
X-Google-Smtp-Source: AKy350YYknMh+4tEYvWzJEoKBk26+WN1OvAn4meY49WI/3zKi0s8J4g/N+wjv8qY8g2F1amWUzJ6/Q==
X-Received: by 2002:a17:90b:4b8a:b0:23f:582d:f45f with SMTP id lr10-20020a17090b4b8a00b0023f582df45fmr28438422pjb.1.1680274779637;
        Fri, 31 Mar 2023 07:59:39 -0700 (PDT)
Received: from localhost.localdomain ([59.92.101.186])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090a938300b0023b15e61f07sm1617194pjo.12.2023.03.31.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:59:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] ARM: dts: qcom: sdx55: Move reset and wake gpios to board dts
Date:   Fri, 31 Mar 2023 20:29:14 +0530
Message-Id: <20230331145915.11653-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset and wake properties in the PCIe EP node belong to the board dts
as they can be customized per board design. So let's move them from SoC
dtsi.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts | 3 +++
 arch/arm/boot/dts/qcom-sdx55.dtsi                | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index 81f33eba39e5..b73b707342af 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -255,6 +255,9 @@ &pcie_ep {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
 		     &pcie_ep_wake_default>;
+
+	reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
 };
 
 &qpic_bam {
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 286fa92da428..bc310ed01b40 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -421,8 +421,6 @@ pcie_ep: pcie-ep@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "global",
 					  "doorbell";
-			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
 			power-domains = <&gcc PCIE_GDSC>;
-- 
2.25.1

