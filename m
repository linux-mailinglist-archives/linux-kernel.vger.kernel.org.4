Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48CD712D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbjEZTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbjEZTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:23:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7745E4C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5208be24dcbso757431a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685129000; x=1687721000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btA26CfzhWy+kp3uofjDjq8wT7mv+U+LR27ouy/0RX4=;
        b=YvOcPDllz+idyR1ffVcHFcFhrJqHuqZGFvD8KNb2sMQRfZq+tA667Yv1SuzQzVnW8R
         obE/cJI+3dcRSEhNj8Z8aGeM4dxVlPzjyKvukEr0/GvBDJEe4WssqOrYjPSiWoMmAYc5
         yHW7BH8hoP2UO7HT6i6Q7NNQDi9ZNmSAZ/3xoXqe9LLLapFd3deWM05x9F/tjOQc1iRF
         mhUdR3HYCfmc13SDwOW5DN0+rJaYcgJa50vXyVyGsMByhrWpVU1yqUyATIfJ8DfIbJpV
         vbMEpKKAguQb7d5kz1VFYPLPVSORiNKDM0HATSseCeItr0iQ4YigF4rqu5RZ+ii31Uyd
         aT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129000; x=1687721000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btA26CfzhWy+kp3uofjDjq8wT7mv+U+LR27ouy/0RX4=;
        b=GlZZDteUv5WKjsbZgKcRXCmO5Es0/IXDYmu+zh7/+SttnChDaKkduNtjxxpmIPwgiF
         44dPdV0JOGdePeXzeS8TMpXtVwPO4R4tyLLTQ1tHLxKA0FzmVw7bADxb19yMnbnt0sjI
         AlfOJ9XbsBy716qoy3altxguO+VyB2qU2ocf5QfmiTghbupq1K7R6SvE+Njp2+0mP8r3
         Ueq9QEgWRt/PFJkwiVfX0ALPVXI1NQnfpmlOaicByQdKVMcGkrzy7nzC3pUmLm/DCpBT
         klGCdXBgKQtsXco5jp0P5TTNgJOcQA63fmC06WtOxhlQ6VujaftHJcazNvNyrBMwEAUL
         Vhiw==
X-Gm-Message-State: AC+VfDwtWoxnZVpNAHIztfNxnHXfDU4OVTOMui7mCpdk9Bq/ntg/8HKS
        I4mg5fKzGMdHh/OMnJLsqQrS7Q==
X-Google-Smtp-Source: ACHHUZ7dqztEuFf/KVWC3ihzMKkzAMMAqg+0d94cF8m7jOxyYey9Y2I1YaDXbNVtVd9JwZ+GCE1dVg==
X-Received: by 2002:a17:902:e750:b0:1af:9b8a:9c7b with SMTP id p16-20020a170902e75000b001af9b8a9c7bmr3557556plf.47.1685129000220;
        Fri, 26 May 2023 12:23:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:23:19 -0700 (PDT)
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
Subject: [PATCH v8 08/11] arm64: dts: qcom: sm8150: Add Crypto Engine support
Date:   Sat, 27 May 2023 00:52:07 +0530
Message-Id: <20230526192210.3146896-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8150.dtsi'.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7f7bbfefa5b..197c016aaeba 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2094,6 +2094,36 @@ ufs_mem_phy_lanes: phy@1d87400 {
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
+			iommus = <&apps_smmu 0x502 0x0641>,
+				 <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x508 0x0011>,
+				 <&apps_smmu 0x512 0x0000>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x502 0x0641>,
+				 <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x508 0x0011>,
+				 <&apps_smmu 0x512 0x0000>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.38.1

