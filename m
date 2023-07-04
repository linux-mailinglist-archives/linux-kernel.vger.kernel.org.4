Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF43F747144
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjGDMZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGDMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:25:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481A1BD4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:23:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so89203271fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688473405; x=1691065405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPValZyTZ8WT4pXLvEOIhNkjZRCsSVMvy0kqcxXBZWY=;
        b=GbdNYU+53uc+CKJ45SjHdFYvihr23ISMMItqnnGph2QrBQp/yUMObVlUB5z18Fww6W
         V3fldaqEl6L+CEcp8/o4l5MeC26PsbGQXiTDGgZp3Ptioa6a9IES2HzueIOT7VyOTN61
         bjquV6U0C5dzQJvTdxRdYqxI34m0L0zIo5Tiei5DBfaiYD23RrrjWjomMgQS9bdPis6V
         cdi8Xj60xM914Rj+lfjdlREdLmdWQ5IpQcBKnJzq9xBHTLacA6ImPgMFeD/Z/Bz5DM0N
         mXLOunrwwhKfvcGwfdSVKQH4J07PeT/P/5SZDXhbQJk0o2Glnwd5l11l0jV0a4F8Ey0Y
         lLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473405; x=1691065405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPValZyTZ8WT4pXLvEOIhNkjZRCsSVMvy0kqcxXBZWY=;
        b=RKZnxfzW66jAEPyOTDpSYQqvPGGlgKlaj8I6t/jsFGh6yD7p8UPdZW7ogThs/O84Ib
         kTBdPMAB829lTZD+u5J9g8dhLiw5WNmtYKniS0O8aMMeybWq5dkh3roHiSr7v9Te1vw8
         soee8oCJ0snuSv53Fk34Dlh2XX6sjur2JrnnXxtVowD7b/Hrjvht8r3/IDNnkEYz+/ad
         4a7hRYPY9I0xhAydGfGZQ00Nq2H5Ur949AOEwr/K+1uhs57U1aCCw50/wg/d5jGLOA8v
         Sso42eikMhorZaZpHoCptfw90sMKue6+SKAqLSwsBjEiIoFuV6vl3EKP9+HUyTfQac2n
         zgnA==
X-Gm-Message-State: ABy/qLYmaCt6HmpHgm4jAl3LeVCK85HgDqo+9gRR8j0MJmhEeI0os+1u
        C22L1VKQM+OTAfak6lcIsDPmaA==
X-Google-Smtp-Source: APBJJlGhow9mucQnVPsfHwcdatGIOezpi0wujhzokvFVMFGT/fK19zshJEpL7q0k7GTqRVHtWMA6Kw==
X-Received: by 2002:a2e:7011:0:b0:2b6:e958:d03 with SMTP id l17-20020a2e7011000000b002b6e9580d03mr4190511ljc.30.1688473404846;
        Tue, 04 Jul 2023 05:23:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e9790000000b002b6d465583csm2851817lji.126.2023.07.04.05.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:23:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 04 Jul 2023 14:23:18 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-topic-8250_pcie_dmac-v1-2-799603a980b0@linaro.org>
References: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
In-Reply-To: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688473400; l=1012;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VBShug28IBIFJfOo9caAInSc6q5XHytMqyraNym9TJs=;
 b=3Q7TSlPOV0jaUPz/ndqxXhZeVAyVR+DygeEGccfP5sWFJmt2hzoRB/YMfoX+lmk8Wcf//cyYm
 xvYJbE9aEYbC3Kc97Jj+kSOPYiwCaXBnFbflUPm9IZbP5VT0a1NVThO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMMUs on SM8250 are cache-coherent. Mark them as such.

Fixes: a89441fcd09d ("arm64: dts: qcom: sm8250: add apps_smmu node")
Fixes: 04a3605b184e ("arm64: dts: qcom: add sm8250 GPU nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 1af0eed9eef5..ccc38c205de3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2729,6 +2729,7 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "ahb", "bus", "iface";
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
+			dma-coherent;
 		};
 
 		slpi: remoteproc@5c00000 {
@@ -5399,6 +5400,7 @@ apps_smmu: iommu@15000000 {
 					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 		};
 
 		adsp: remoteproc@17300000 {

-- 
2.41.0

