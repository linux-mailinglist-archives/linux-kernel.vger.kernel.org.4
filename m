Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972616E4931
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjDQNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDQNDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:03:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F7B464
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:00:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso7465860wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681736333; x=1684328333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsLURC3owKowAjRUI95QJeyM80kZGGfPZpm5Kswf0kM=;
        b=T1A4g0oQXcvCMgcuhlRUGhwlD0M5TmoxsDKA4RD6zzQEJpvi3MMPBVscEfplK+mgI6
         KyojiN+ElfbctjFyau9MrGO7sFCQvl+cUmkB/4G9h1dJOJ4cyxTV8cFVFCVhSE8e5V1c
         DzTwYT8axlgtLo+5bZHGqQ1udDWGHPwa1T81o5gfc2E7iIQkX6vj4xb4EG8R6I/v7xtR
         hP2pMDPvUnjQG+QT5UVv4zpVCpl+EBBn6CYWHUVvyoXQtKxKzkVMJJI7ZcFvb0sS62Xq
         /Zc6kFgchtaHhF/npbuv7GPoEF8ULrU7XH9D+x3ydDm/7qNN7W56Xvrkw3rOhJUM4PK6
         xWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736333; x=1684328333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsLURC3owKowAjRUI95QJeyM80kZGGfPZpm5Kswf0kM=;
        b=LIJPDL3rs2FRQV9+49aXMLaLslZbD1kkbCvJvUP7YY1INxlm5BdgDPsASEeYL9QByM
         DUw98OTc8vay42tLyQNMCc56x13nNcHePDMVFZai2DMF5gcveu7IY6OJivYqzPgG8iLv
         R5cw7zxViTgJ5ONMtZyUFRvyBbmfCN8LJ9ftBnSH2Z19HleJfUMPbWUREUKj5OObp+eb
         7N11zkTKBtQp1on5N0WBCrlbMTfKFDBQdVefUm/2v0bxPYdamW0a8xrTFdwT4A8LbStC
         kZkhWBtzRg/w8KDXSXDFSWeB6Hc2UhOqrWPpjUfZNteWzss+7m7y5Bum++9GeJ2y5X8d
         Eqpg==
X-Gm-Message-State: AAQBX9cZOjkCK9+c5jp2LhJ2p2exT2IO5o6TatitS+jqJhlj3/CGhiCG
        HsI7x6+rhXKXTLzLuILRYzSP3w==
X-Google-Smtp-Source: AKy350bJEuoVoO4QTZYeoYWWPIdSxw+1myKTw9gC+605fCIC+2nf0RlG8vthQd5PUQimlR+IOFcaJQ==
X-Received: by 2002:a05:600c:ac9:b0:3f1:6f57:6fd1 with SMTP id c9-20020a05600c0ac900b003f16f576fd1mr4444391wmr.9.1681736333441;
        Mon, 17 Apr 2023 05:58:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15557546wmo.10.2023.04.17.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:58:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 5/5] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
Date:   Mon, 17 Apr 2023 14:58:44 +0200
Message-Id: <20230417125844.400782-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the Adreno GPU IOMMU for sa8775p-based platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 191b510b5a1a..92712d0c4100 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x20000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			dma-coherent;
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_HUB_AON_CLK>;
+			clock-names = "gcc_gpu_memnoc_gfx_clk",
+				      "gcc_gpu_snoc_dvm_gfx_clk",
+				      "gpu_cc_ahb_clk",
+				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
+				      "gpu_cc_cx_gmu_clk",
+				      "gpu_cc_hub_cx_int_clk",
+				      "gpu_cc_hub_aon_clk";
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.37.2

