Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87CB60365F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRXEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJRXEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:04:06 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E1BE2CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:04:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z18so10294303qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SKk0pUCgLwhfjypSgrxLtxlJmX8JgawfBhUMDt+ICk=;
        b=rx7VVK5ft2n8lkM2P4qqZRQd1rQS+I7yjKxd7JiSZSiV0LG88/MztFwwdaluywnpeS
         8re6JNhf4LBDetzpO5hy7aDBnIoa3yG/2ChqAyr2MTXOfySxWA/0ywm1ru+ou42zQXss
         QWbhmmD5jct0slMbOVIRQf1yudylF6zbJwPzWc9m2d1iX0NLAWj2BVQppVQcVAmopkfl
         1Mvuh6QcLv6kAlV1GgvGKmv+PeMeIhcxdGExslomIUpxT8jthlzJoinLwQA/5STsR9tw
         bwrV8DzhE6ngC09Qv3JMMlBhQSBqxJW8rBv31Ol5inBThCFMiT0XlE8OKvOZ1XFDzoq2
         zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SKk0pUCgLwhfjypSgrxLtxlJmX8JgawfBhUMDt+ICk=;
        b=H2+kFfwprKPazTnFS1uQvFfU4oAG9luN6GKNvB6G/KIQDS2anEidbLQVJ6CDw18RtR
         pRksiRQ8YOztoL7460WeUQbSqrmdo9EV393xPDiQXhlPfRjmB+8ZeyiijZgR/5i6J2T2
         EIyn7lMxA2x/8f+IBnBXiGAPL4VISHyxohIc3MfLZ47hfa5M3F6n26ITcogM15er6yjk
         6rdykSSY/H+yHpf3v1NoMPXsQjjOiEhK2rGdFPmsuAgmbOFZ+qwgVIPoerLHr7FC2POP
         jcFDE19oSzuNtLYUHHJdiUbk62Sr/Rn+dL3Flo7DfenP95stpFS1iGQ2ldiuyDnmRGIB
         BZeA==
X-Gm-Message-State: ACrzQf1QCTABAk/HBFxhKmD++TZUeAsHgm1Wwdz2sWCEAPCVYRAUSW/z
        quY8zPN9ioaPgsdItxaR7MqmMg==
X-Google-Smtp-Source: AMsMyM698ltExeKoStVUihmZuHnd3N0x3PJZiOL7qQ+N+7HYSg3kLCbhvGf4ExcA4ZeAn2Y5BHdffg==
X-Received: by 2002:a05:6214:29eb:b0:4af:b287:8ff6 with SMTP id jv11-20020a05621429eb00b004afb2878ff6mr4365906qvb.65.1666134240416;
        Tue, 18 Oct 2022 16:04:00 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id 134-20020a370a8c000000b006cbcdc6efedsm3279010qkk.41.2022.10.18.16.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:03:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
Date:   Tue, 18 Oct 2022 19:03:51 -0400
Message-Id: <20221018230352.1238479-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
References: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
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

Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
and that drivers can bind with only one compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..aa08c0e065c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -678,7 +678,7 @@ ipcc: mailbox@408000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -904,7 +904,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x09800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1209,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

