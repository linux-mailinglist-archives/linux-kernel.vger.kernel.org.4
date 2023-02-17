Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39A69AA23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBQLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBQLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:16:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8B311D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k13so939813ljn.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e01nddNNggomilaOmguOcFx036Ua8m431JWLUtouH8=;
        b=CFjALJfnxDN/Vkk/EMv9EpN+uCLAJekJSpOmCzBM9HXaRJ1JDo7s2RCA5W9MOFiU4O
         LSz8x1NWXU/in4bBl5bfF+OzpMaO0it5JqnthD7bg3demWpykgfsjuLvr9zKwHciV5wm
         ntBwFtaAAlAt3gNjbBxObFbRG1Mw+QvPpogE+FebZvekkA1XJuhO4OwosATUot/pcB39
         CdXW73vyWq+1LejmEunqRaXoQdvoAvZS653gC2SD1x+g4TwVsANDagPpvF42OqrznDVj
         6TUy8oUbhmODSfsNDQLct/ogTWOGCZMbxm8pCozighMcbny1GUQ1RQQ9uf+t7CHnHjXG
         jNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e01nddNNggomilaOmguOcFx036Ua8m431JWLUtouH8=;
        b=NlA79c+cB4EpviuuP9rOrbmE82ZugkftsPNRp+pSMa/H2/s6iUrDDZVGy/eFTSHCrb
         Yaw5nb7HSo2brYtogn9BlU7ZlJOnfmJwh44za3tMX5wQt2CTXcYeNEOVLKwk1nsBGs8G
         Oa+eu/28kVBZiG2gCwTv9a5aMC7MDceTfuNc7hgDxo65fJ//Ks2qhs30JtLyZuIIMFfO
         KEcyCFGiSGW2/u2/TdB/zxWT5Okj4jll+n1TA4+3+iyS2eesbB0PSm/SagCPYHUZbNgj
         vnWF7WXhyk/x0sPTWsaqwunzqYyy7ntivAzCe15zRZeew878m1Fk04SexpvC5yT79eO+
         ob7w==
X-Gm-Message-State: AO0yUKUy4d1Li8zzL1IRrsoWrXLbbQ9I9zUcb0hvsFtn7SpR+yIY/TVr
        PCUCEu9qnnmB45jJ3BDA+J6xtw==
X-Google-Smtp-Source: AK7set8UZtt/gDomOxIqtofjuy2wALx/F9R2DtKLK8ThMjlMdmnvCx7zhJ+vQFPf9RFthPrvueUFsA==
X-Received: by 2002:a2e:574b:0:b0:294:712a:5190 with SMTP id r11-20020a2e574b000000b00294712a5190mr739293ljd.28.1676632584963;
        Fri, 17 Feb 2023 03:16:24 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
Date:   Fri, 17 Feb 2023 12:16:11 +0100
Message-Id: <20230217111613.306978-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d94171f9b73d..3da77141a164 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2287,7 +2287,8 @@ gpucc: clock-controller@2c90000 {
 		};
 
 		adreno_smmu: iommu@2ca0000 {
-			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x02ca0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.39.1

