Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0176CF2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjC2TRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjC2TRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:17:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B36A6D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q14so17267384ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680117459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkAai3XhfiUPRhW3jICgZ5p+Oa8ltVSaTnDmaflq7J0=;
        b=h2ZHVxfVjRCAHLr2IjDjiLbFb1+cBIYfc9aUZq26bTziEOKuyjCvaNzR21aZpshJhl
         0z+e7glfFGvqF5p1LyX266gHOECuCV5VIl8TpbA4Oe8pAU5FbdZKGj6YslqmUY6Vg72s
         gKagz4V0V3xNGEt73Zy5sk27tYRs8YmoqdEd54ibxlMgObc3z6UExRkmb2jFdYoE9128
         E2Y+oCYj7e5VUy+PzyI4bp46j+blfd8pFoQllSitaF4g5rFfndNK6koBJtEsmudItEHf
         a2n+1CHR+0H0+PKkD4mHX9B3DOK9+MuwcJI5XLl0ylGSY4Ca5TmOm8M0sy7eqw+6exWd
         6fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkAai3XhfiUPRhW3jICgZ5p+Oa8ltVSaTnDmaflq7J0=;
        b=AVn9BQPs1+/GfvKdUHSA7af0Hk3XZTnWk9DH/H43I2N8SLGxWn4tQREki3CaykMCnY
         LtZ3fWG3KLV6l9Ol1JUWEtu0OMt4BuEe6iXGjTyIc1Y6svBEHTiQueTTCFNjLbXUvQkw
         I0Y+kLyl4EHc39Fqdr1Mj7zQDiBIJjS582Im/5pC2MKdgiiLu4guJZQDCnR+f/jkUC5B
         inM7edOnBbEDILNbB9pPHfERXRKe5FlTDx4hd/HuA4i7/Sb1qyvRKjmW5tkTEMUud4gy
         nG0bJ0xKkqWrYwIf1Fx5UAuGJCeH8avsXzyFj204d+TqN0MEUlKTqGzMIfrZPC4SJFzD
         2LBA==
X-Gm-Message-State: AAQBX9f5ldAKZ66cIui0khpPijJv+v8NOwh0kT/XlsmAzvAd8n8USwyo
        gRoFfrOgsw4H9gJzU2yQjmmVgQ==
X-Google-Smtp-Source: AKy350Y6N2QBFcszpreUAjNB5vbbYZ/x8V1DIVwJGSTWXjpolHT7cCqcTY4tZvENYdTB90Nj9ksMAQ==
X-Received: by 2002:a2e:6e16:0:b0:2a6:1682:3a1e with SMTP id j22-20020a2e6e16000000b002a616823a1emr107837ljc.31.1680117458981;
        Wed, 29 Mar 2023 12:17:38 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e3804000000b0029ad1fc89b3sm5189658lja.60.2023.03.29.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:17:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:17:29 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: msm8996: Pass VDDMX to gpu in
 power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-topic-adreno_opp-v1-2-24d34ac6f007@linaro.org>
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
In-Reply-To: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680117452; l=1874;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=B4c/XI1szXxzRjFxiQx3VjZCHnPxGxqsOILu9llcN2Y=;
 b=Zs9LksiWRztnXYtI4O3NfXHgKmEahbtvCpXjg3ZG98cB1u4HUyqw+s4VmKtPstHhnnUov1foxpUk
 RR4OCGrFDyd3G9norJZwh8qiAX82Ny9DXokCHV9hL/kqR5rGpXms
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since power-domains is used for perf_level pm_genpd scaling, it's only
fitting that we pass a power domain that's actually supposed to be
scaled (and not only turned on/off) to the GPU. While we don't quite
support CPR3 yet, the next best thing we can do is pass VDDMX, so that
we're at least guaranteed a reasonable vote on the memory side of
things. Do so and leave a note mentioning CPR3 PD should be used here
instead when support is added.

Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
Fixes: 3f65d51e9e22 ("arm64: dts: qcom: msm8996: Make GPU node control GPU_GX GDSC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4661a556772e..4dd37f72e018 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1228,7 +1228,8 @@ gpu: gpu@b00000 {
 			interconnects = <&bimc MASTER_GRAPHICS_3D &bimc SLAVE_EBI_CH0>;
 			interconnect-names = "gfx-mem";
 
-			power-domains = <&mmcc GPU_GX_GDSC>;
+			/* TODO: also scale VDDGFX with CPR3 */
+			power-domains = <&rpmpd MSM8996_VDDMX>;
 			iommus = <&adreno_smmu 0>;
 
 			nvmem-cells = <&speedbin_efuse>;
@@ -2254,7 +2255,13 @@ adreno_smmu: iommu@b40000 {
 				 <&mmcc GPU_AHB_CLK>;
 			clock-names = "bus", "iface";
 
-			power-domains = <&mmcc GPU_GDSC>;
+			/*
+			 * We need both GPU_GDSC and GPU_GX_GDSC to be on, but the
+			 * power-domains entry under gpu is occupied by the scaled
+			 * voltage domain. Since GPU_GDSC is a parent of GX_GDSC,
+			 * we can simply pass GX here to turn them both on!
+			 */
+			power-domains = <&mmcc GPU_GX_GDSC>;
 		};
 
 		venus: video-codec@c00000 {

-- 
2.40.0

