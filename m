Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC44A70A214
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjESVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjESVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:49:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680010F0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d44b198baso28752b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532964; x=1687124964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMTHG8l+qigWdbQ7cyJvnKtXRMQ+ez6nvcozSSImI4Q=;
        b=JU/j+wF4xxh9lERHCCg4N1+f1/6hGzxFeeLl8VrSXpkaBfs3tlS31JJDuG7tVps+vd
         sqoum0t/fXwbg6NU9BVtI79XnsxAvlqaHjsxdIgxc8FEAAD2AsMyofJ9API4zl9HMiIH
         veMwKKBoBMP9h+jqK6ugDw/gCpK2xqMTN9qW3phfxvCuxI0DCtVieES/gAJjzXKIIqo6
         xDDPrKcTqL7+C1mhUbwUFwUIKLLswhwfiHcqOua/yRs0x2OAlTLQ7Hn3y/X2G/uHfRXZ
         ggMn4XpfRH3Uurr4i8xu5P1KL/K2dgnW0mZ0VwQ+mQbcadxXQqkX13nGmuAjX4COsAKI
         vD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532964; x=1687124964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMTHG8l+qigWdbQ7cyJvnKtXRMQ+ez6nvcozSSImI4Q=;
        b=QPKsPsl7ZiDZUc+t177MgXYVlI6cgvvKyG//HlegIIyabp98/CzS3bc1J1wMDfGwbz
         cu+dzGI6Hu1Lj4W8wc3u5nW+KsiLvjp0ofY1rzkCT+5G4NSwV2Qc+zGR8eQKq4y0GE2j
         pBzn9T4Y+gUyCxVtl/x7aqgGbHyJ5TGhcUIpZcqgQ7AYusDbdHHFPA8V1zT2MlsueSES
         lQii4MThqFOtUXjyDGNrHeDbbWnmrh5cHqDtp2weAwFF6lmCVlczstEtk0kIFtRO4C9E
         UActP+tiZoe6lQANFftTIPfQ0t0ChojuWhQ1Y3uOWcFsJEnhy+rbr1dAoaMO5EbRNxOu
         WV7Q==
X-Gm-Message-State: AC+VfDyXSrJXFqF6kMJo+nipCDoach5yTULJE38rzRYzOzK7HCyh3t32
        eibDtf5l70jpjlRFJ6FCCJRYlw==
X-Google-Smtp-Source: ACHHUZ4V4pUaCkvF4R5gycfw6Lr8Yibmb3dDXK7V58CS8fiWiW9cqBrMGSUOwC03z8L4vzyE8qNY7A==
X-Received: by 2002:a05:6a00:a17:b0:64b:e8:24ff with SMTP id p23-20020a056a000a1700b0064b00e824ffmr4155555pfh.17.1684532963814;
        Fri, 19 May 2023 14:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:49:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v7 09/11] arm64: dts: qcom: sm8250: Add Crypto Engine support
Date:   Sat, 20 May 2023 03:18:11 +0530
Message-Id: <20230519214813.2593271-10-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8250.dtsi'.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7bea916900e2..79fad917d142 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2232,6 +2232,38 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x592 0x0000>,
+				 <&apps_smmu 0x598 0x0000>,
+				 <&apps_smmu 0x599 0x0000>,
+				 <&apps_smmu 0x59f 0x0000>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x592 0x0000>,
+				 <&apps_smmu 0x598 0x0000>,
+				 <&apps_smmu 0x599 0x0000>,
+				 <&apps_smmu 0x59f 0x0000>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.38.1

