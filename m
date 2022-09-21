Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786065BF5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIUE41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIUE4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:56:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CB7C304
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso4564331pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jkKXgc3d0MWwxQPM3fO9sVRhHaZ+os5SScxBlsQUWO8=;
        b=kvV5ydzQjjyZcfzh1vwCL1lWrmBBHbZVrNztHmLX34QC1HXdSuFmGz2+SFm4UbFFya
         rgwK2IPJ11gOVt7ggR508C51LPvC0QphmuJFzqBb9KOEW4JkUU/1fnQjShYGV1IVXWjP
         nZlCDw6EtmNER7hwBn/mgT1Fjv/onwwrJKMJ8xP9/pLH2/cbGXj1mVaRBhRZrFGPrt7m
         Xm7I6TxidaRGLld0FBrjEzWpXGTEbwJJXxJgqkyX+HhUqa8NQpxUgOiefY4i7pI6TFJ6
         CverrBTcKBOWzgbsZj6bluj0KQF67pC/LbH7Wbo2Ih6UDpbNNIXev1Ah15K+g10vsSjb
         Sgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jkKXgc3d0MWwxQPM3fO9sVRhHaZ+os5SScxBlsQUWO8=;
        b=4hQGIvwDL2k2oq+0A6MT5wa2izjpLDLudl9NnMHvxcc3ZvwUVR7RmYoOy9mSTHCUJv
         DoCLXFSp+ggyaoZFFDjkIDf4xvXaqBUwexAY510cxMtJ4THOOjWq+h99sbRLHs7XknWC
         McvpgXfwennmz7j3Ztt/tBmhuv3BAxQ6PYFG95bTVfoJZU/3/zZTaxg5ACpGdqsGCsyl
         c2pQoRs8qE+McZR/fDDzf+EPI2742wjFFthyvajYQjzpcXpMvnh86zV3bKvUL6HyNGDQ
         nYN+GDLHFx1RyPo8z4KE8OxcvHfyaMjSNP3A1q+hExl2EEaIfCCaeKzkrLSZ28QTt+zJ
         ovsQ==
X-Gm-Message-State: ACrzQf1iXTDMb7ZLSjYkbdTGTLOBwxq7IrCKeaJZDv4aw8yAzLZq3sLc
        CBEtibBRaKZO3w0s4TRpfy2sPA==
X-Google-Smtp-Source: AMsMyM5dYGSY2mS4ZtMippp1MLtH6fIDc1VOFMTTTSlhZ8F6m8PfSogrOZOwuryDJ/gXuzP1L/RbpA==
X-Received: by 2002:a17:90a:e7d1:b0:200:94fd:967a with SMTP id kb17-20020a17090ae7d100b0020094fd967amr7328346pjb.57.1663736179023;
        Tue, 20 Sep 2022 21:56:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b00176e2fa216csm871829plf.52.2022.09.20.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:56:18 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de
Subject: [PATCH v7 1/4] ARM: dts: qcom: Use new compatibles for crypto nodes
Date:   Wed, 21 Sep 2022 10:25:59 +0530
Message-Id: <20220921045602.1462007-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
References: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
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

Since we are using soc specific qce crypto IP compatibles
in the bindings now, use the same in the device tree files
which include the crypto nodes.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b23591110bd2..9c40714562d5 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -314,7 +314,7 @@ cryptobam: dma-controller@8e04000 {
 		};
 
 		crypto: crypto@8e3a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq4019-qce";
 			reg = <0x08e3a000 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				 <&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a7c7ca980a71..0ae3c601b279 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -198,7 +198,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq6018-qce";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				<&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a47acf9bdf24..0683ef931413 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -286,7 +286,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq8074-qce";
 			reg = <0x0073a000 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				 <&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c0a2baffa49d..0dd6e1fea99c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -755,7 +755,7 @@ cryptobam: dma-controller@644000 {
 		};
 
 		crypto: crypto@67a000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,msm8996-qce";
 			reg = <0x0067a000 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..4aa5a82bd265 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2566,7 +2566,7 @@ cryptobam: dma-controller@1dc4000 {
 		};
 
 		crypto: crypto@1dfa000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,sdm845-qce";
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AXI_CLK>,
-- 
2.37.1

