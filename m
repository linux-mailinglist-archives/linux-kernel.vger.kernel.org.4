Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779496C4982
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCVLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVLqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:46:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91485FE9F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so18973129plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg1lgnQu4+xA6eepXo++mQt8woUG/TBdycNm/YyfbaU=;
        b=bHloxSR06JBHimoDUxxzfoM96ibGI12KHvmJVET3Y1eeRqh14S//VtaWXAFdUMAeTX
         O8cTRndpBgrpUiIP12v7JU/G7g2xU6hcKR23IZOm2qSH1LLdeODlKQ68Muiwapt6c1ML
         icW0vMvyxQsORze51OHi33kN9b6FQdzuJ0NNAIiNRa1shWP02wkGUSvjXSESX/92lXmk
         NDDBVb3m0g6ItHmie0iwBtTVDszLT3uM+yGZ8ETmyNrDzkhx/IOEP3eGjSOyBLNVEByd
         EdtjWdAaMvdRcMLyJOY+7x+bASHp1JOMcPxLFJ7sNOb6JeLAWvJW4x3FETiDgs3uNf03
         B5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg1lgnQu4+xA6eepXo++mQt8woUG/TBdycNm/YyfbaU=;
        b=ZMswfZv5Lplay2ZPl+7u3ffI2wKYDPh9p0aE4ISrOd0XtMYUmkfTD2fEgDwkYy3kJf
         ZkAhPUm6oHLCvs0gIaaQ5nnL4IzGs7/5OpbuQVDM8rNcWIuuJVMF8fZykVP0BSWkRKp3
         BppHAptzVEt313dpQHxqhKj2tM7DjQRma9O3KAhOrNRfnFhfPqhdE+65NxvhDfNyngdt
         4+tBR3JGcsbBVHsnVyeP8cXILn7TSTyzzXI3TmqX+oU4zJk7r5lIEZQX7LlJkLLrEeaZ
         3eZCjJ8gnY+2cR9GOYzdXIa7iDimCm+r0+ursrlssSSCrItxKVFZs36Phcmm6sL2SGFV
         j4qQ==
X-Gm-Message-State: AO0yUKXtb8949WArVGzHU1hMMYoVDyJlmO29vfbPajE2XqT/0BY+TJwN
        VkRv8yEF9KwBZ9NcYNuZJAo69Q==
X-Google-Smtp-Source: AK7set9y8HFX8zI6n/ls27XmzWIaKNfIoTi1kVbb1sQeetdPEgJ1wzoKk4WZqmi8dxyyj3UB0Apb1A==
X-Received: by 2002:a17:902:da8e:b0:19f:3b31:4d3 with SMTP id j14-20020a170902da8e00b0019f3b3104d3mr2620957plx.41.1679485557378;
        Wed, 22 Mar 2023 04:45:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:45:57 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 05/10] arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
Date:   Wed, 22 Mar 2023 17:15:14 +0530
Message-Id: <20230322114519.3412469-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
References: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation, Qualcomm SDM845 SoC supports BAM DMA
engine v1.7.4, so use the correct compatible strings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0fdd59a9feed..e8e9aa4da914 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2628,7 +2628,7 @@ ufs_mem_phy_lanes: phy@1d87400 {
 		};
 
 		cryptobam: dma-controller@1dc4000 {
-			compatible = "qcom,bam-v1.7.0";
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0 0x01dc4000 0 0x24000>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rpmhcc RPMH_CE_CLK>;
-- 
2.38.1

