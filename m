Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7356BAE35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjCOKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjCOKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:52:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283D136E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:52:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r27so23708233lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678877536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdl0RlZFPypGKRGyzZFN/ydDgJu/V+/+Pk1xTXyKWrI=;
        b=bqtJQZOe55DYn/2V+wznVWxy6nZ9Wp3VqQW89I9EWdQ5Sc1pQKJ+55BLPd6qARroYR
         ok3YTg8gNeR+PQR343hvM3X7i2OTddQDCGH1C1Uantxt/ZN8WRKz/7TdZ4NQorRIbr/U
         1gMHvIbro+4yOWVSanJaSamYVBgmS7Vzc7idGVgFS6zHs6/iG40DBA8ysfJxoi+kOkzf
         FluAufnB5w9MFoCpm5dfLoJFLiN0B4Ern587udYVh3n7Ils0oqut/9pIFuidwZQr++L/
         N/cQfkTsx77WL2xVP83j57rbt959e5uPJ969Ohkdm7hvX9CjChjJs2NnzxZp4Ztx7ZRW
         E+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdl0RlZFPypGKRGyzZFN/ydDgJu/V+/+Pk1xTXyKWrI=;
        b=QpsOHm68NX0AxpZzuoWcIgnn3a3E/ttEKcqZQ8cBpHaxKXmc44+BojxOxnw8UZpRnx
         Wg1rt6sO8vi7l0eVOWa/vp7KbDcfu6JwLYjxtZwjK2ugG/c+cWdHbtGJV4gR4OoDdWGX
         qdhSUwJB6WKAgSaPFNWqy70bunNvoWkVFAQrzur6EAiOiqABSie3CY0yPmHwct49v9Ey
         rzIdSwLNO6W6YfeRA0PQrcu2Mufo9BqKTSgcA3mkcLIlYoc77dgkGSPVW9mC8ToI13LX
         LN5LkcMqrd+oILwH+k8a6oG/3aCicHxbhiJoBx/HHKihndOsEj9NF9EyU3DY3mYJNnr2
         obkw==
X-Gm-Message-State: AO0yUKUOutEYV1AHEwZSUEVHk+6AqCwBtmArfndylqrmY7LVvghiwmXn
        jyceyYjnn7nzvvylAu5U2UlFeQ==
X-Google-Smtp-Source: AK7set+IBx9i/5w+IF1PkXqQMsvGoGIQHXi/vOHvJHD2FU+IheSn2dkE6FAGqhbQ5zS0W7yJdyE2sw==
X-Received: by 2002:ac2:494b:0:b0:4b5:b06d:4300 with SMTP id o11-20020ac2494b000000b004b5b06d4300mr1435118lfi.29.1678877536315;
        Wed, 15 Mar 2023 03:52:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q3-20020ac25fc3000000b004d856fe5121sm767791lfg.194.2023.03.15.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:52:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 11:52:09 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sm6115: Add GPUCC and Adreno SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kamorta_adrsmmu-v1-2-d1c0dea90bd9@linaro.org>
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678877530; l=2214;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4Yr3jyIzx6Uo9VaD9+bKTUbQOMghksaMqVasI0YJqlQ=;
 b=/y5MREEnqichNpxqBG3CJz98rlDwF4UBmNYM4I8LMIk7z/75bl5dTtaQnNOR+3cO5oLdVtpcbvki
 1dlAXAJ2AM5G7jWobn1L5qakyP2sN3ftFFqJP9QHLZJD5Jqj7kxA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPUCC and Adreno SMMU nodes in preparation for adding the GPU
itself.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c56738633431..c1844abc4d9f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sm6115.h>
 #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
+#include <dt-bindings/clock/qcom,sm6115-gpucc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -1135,6 +1136,43 @@ usb_1_dwc3: usb@4e00000 {
 			};
 		};
 
+		gpucc: clock-controller@5990000 {
+			compatible = "qcom,sm6115-gpucc";
+			reg = <0x0 0x05990000 0x0 0x9000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,sm6115-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "mem",
+				      "hlos",
+				      "iface";
+			power-domains = <&gpucc GPU_CX_GDSC>;
+
+			#global-interrupts = <1>;
+			#iommu-cells = <2>;
+		};
+
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,sm6115-mdss";
 			reg = <0x0 0x05e00000 0x0 0x1000>;

-- 
2.39.2

