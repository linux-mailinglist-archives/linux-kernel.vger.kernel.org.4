Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23F6229E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKILNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKILMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:12:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B292872F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y14so45720800ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pye56l5tV+PFr5V02s5kVYgOc0gcJFpQaxO9onF9KkY=;
        b=BxELVLupmY2A2S+cBmejE519foAq8SasAUypsrvZnDtEDtHHOI20RcR9m4UA9rLmZP
         enRbCsh5HN7NkUzkEx/1cT1RCCs1KrykJTcrq1qERBjRBCi/38STK20E9uCp2+ppOl6h
         8xUbqguygxnsw+TCvxYtOpFIWKl8BCna/SZBfyyc0X4b1uLzu9tOeBCmUqAya49AAsfK
         G4BfX6aSX+NLnwTku++NMeO3CWM+jjSuOchkhMGNr+84BPAE447vdBlDrXQ8UStWHTKr
         o0e5RxgX1hyOitMhsmO6JsXI3Emnbp1XsZE0q5n/LPIVwqf+VZ/9/9jX7+Q0MGrmb11u
         uAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pye56l5tV+PFr5V02s5kVYgOc0gcJFpQaxO9onF9KkY=;
        b=g1aRaskT8bgf9S50atnGKUxB8Eyrc52IOKCx+5l+uAyWTUq1PwdzL5Hp04af0g+tg6
         bw0d9u8ere9FiC5Hxn5lrlI4DdTUtlhG9ne38qpcA9I1Ih74n3hYUA/x8BdPf+I6o0w3
         YHP0uymrgt3qOi/+sEyT7sOe82cmWYMWggumOf0/71Hy7jz+uVMXK+Jaq16DFhSwt7zM
         rajbRjQ1Xx1gI93J165jgc5ni8vnUbuycKLaZgXEhDQj1sO8fMCo6itnFtmupMQSkERi
         RsROWeqmbxk/C7md/sCoM3uLRmlXa87V0LSIwsXyjKof86e9O1nXSdsc4LMOUf6TwUsl
         jxrg==
X-Gm-Message-State: ACrzQf3+wOPNA3zv/uH2A4WAc5ErwIJmbxhOQDQNWi7+euVxwBy7/6li
        oIZavxXOxBszkXDBqHkJd8HE5A==
X-Google-Smtp-Source: AMsMyM7N13aLIJJVWBNZ3QN5EuRoAQYQCSQf6HYQ8DgRnlL4IqvtX3Yv6DmDcAMCYFJrzKbHN4OqPg==
X-Received: by 2002:a17:906:35c9:b0:78d:77b1:a433 with SMTP id p9-20020a17090635c900b0078d77b1a433mr1105891ejb.486.1667992368803;
        Wed, 09 Nov 2022 03:12:48 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] arm64: dts: qcom: sm6375: Add GPI DMA nodes
Date:   Wed,  9 Nov 2022 12:12:29 +0100
Message-Id: <20221109111236.46003-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for GPI DMA hosts on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 9b1a497e5ca7..62a64dd731a0 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -567,6 +567,46 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x04a00000 0 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0x16 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
+		gpi_dma1: dma-controller@4c00000 {
+			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x04c00000 0 0x60000>;
+			interrupts = <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 504 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 505 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0xd6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6375-dwc3", "qcom,dwc3";
 			reg = <0 0x04ef8800 0 0x400>;
-- 
2.38.1

