Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3D6C39B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCUTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCUTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:01:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD84442E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so16873905pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679425301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/HhfixYKI42Jnmvpurms4ZlKAo1XNYYYTpB5v8v+98=;
        b=SOxS+Sd7B1mfmQ7R+OzEUOpYIsHAUU/2uMgnReRNW5dCzHjWf8Vl+e7euB4wuhk3lc
         p9m1UZd4orNVtHnEVu3rURYkBrHMRORr39MepC4Jl8+skkS+orSMQZYsFFcjrGBJrerM
         lnoD5nC5ptsgSL43S0uuEY/RBq2YGOMaTMHUKtwUanVbzODBiBxfWMUp6mxg8JlJnhbm
         4+zQ/zQKim77FDKAgqvRBjgnODoJhW8PDgVPLeGgv+K7aFz3aS/gV9mVWGVNo+otYKKI
         RK8kOo/gYb3hHgrMZOXdwtqREng2esMTbMfbRMNAMS4HStKMNv54G7njWhd8dGBBD3rg
         1kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/HhfixYKI42Jnmvpurms4ZlKAo1XNYYYTpB5v8v+98=;
        b=ZXWSXiUaXcaozxhxupQKgJqMJ164DT0rgWQKjsNNPYxYOhQvZRhRLA8MeWGpPv+iNO
         fXnPDLTXB7Gkr4LKksI1Wd2GT2inyLSQjHz6OA2Tb5xO4t38LPZFUCUNU18nValRxAvM
         edjXeDsCqCTfYsZ/zKg5UxlfYJyRwgzhMSP88qH8y5xTc1nzuTW3wGwHd1u+IjT1aOic
         OeNly+AMVIYUYPq5ZTKC5zVXiUa81HMyjy922f4t3J/bJa7aCQdGFhdJYID+U1vFhJwv
         zqKccZRp6f71XAlk1bwF9rcwN3UnLlrK6+w8H/EkUvwNgpmYXWwmjZy8f1eKP0B6PyKb
         hdHw==
X-Gm-Message-State: AO0yUKXpP68zUrGKNKleZ+dVaneqGIrFyOBy3YLHfAVaFIeT67Z0DJ+z
        dQGm0oMukzfpVKry+PLkpbljUQ==
X-Google-Smtp-Source: AK7set/Cb8A/OLdYPz92Fy5KkNSmfMAR2cgRs4cxTl/5LOBEPt17geT36s64iDnFbaLY1yTXYhKoOA==
X-Received: by 2002:a17:902:f94f:b0:1a0:7151:3cbe with SMTP id kx15-20020a170902f94f00b001a071513cbemr139651plb.36.1679425301550;
        Tue, 21 Mar 2023 12:01:41 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001964c8164aasm9043453plo.129.2023.03.21.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:01:41 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org
Subject: [PATCH 3/5] arm64: dts: qcom: sm8150: Add Crypto Engine support
Date:   Wed, 22 Mar 2023 00:31:16 +0530
Message-Id: <20230321190118.3327360-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8150.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 662098e85b97..6fb3596d3c01 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2082,6 +2082,32 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.38.1

