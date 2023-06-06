Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E57242DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjFFMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjFFMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:44:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960CE7C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:44:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7573880e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055458; x=1688647458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=qNeCawTHroCgl5fcdtDUaxX0eIF9Ix5dn++5hN82QtOf2y1D6NARDHgCS4YAMwVEyt
         cXMjmQJJdO0FpxZoVSrFuYnupsUNWa00Phx6h/n71YXz28DLQoX8XnZNdBh9q6zer+uI
         RmtEHM/KwaGjQXeNDqiwQze61NsMdcsZOi2IyB97j9GDivnFFDYbKHda7QUBgWIi9nvo
         KZYKnUNfNrjxm2HOq6NIGDLQEjKe/HIYkyU1Ld1sl1cn7flPbRIoQiqrdB4+mKD4dZZq
         KY4rStX/hCNUV9KEXxYXh8IdFbWMRplsoFRSO5kszeLVO2KKWY7/m4krspqXllErzpTF
         8ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055458; x=1688647458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=FBJ2ZoN1D2RRVW3CqB6ZKxOMbKIIAt39+bdnt54Br8GwvaajjWYuyTsXTHVD/VzVqn
         Uy+L6ZeT9DnYL6dKUHCFi/Vj2Kv34LKtmjJSnlILz+bWM0AGcifeKpAyi/pPVurFw4ZO
         ycqsLi71BkUQ0caXLLO5xD7WDuBcBIAlFe+MBHoByyXnbm8bP1oanOqNXcABIAYwp27L
         lZFJuSjBRL/WppEXnhTlLp5OhR5QE/hRH3XWKKYzXUnfTrc0PK/ZUyZ8A8zlJupbYRes
         xQbgdTm7wCdZZVSYzf312ztvFj2ixo9defiYLJecFKHhU+84fWho922usKf4zL+Qf7my
         xn5Q==
X-Gm-Message-State: AC+VfDxTzKWLIgRwuJL/YClailYQqXQfTahcSdp5Dn+Kqf4HYAGorKxz
        MAKQe8uTtDHc04H7QxBXLDvsJQ==
X-Google-Smtp-Source: ACHHUZ72I/+mf+dvF/26dRGOmhr3s9AFAVcw4zjBgnlCUcVuS7LeBNmKYkK9ZWeWqnaLe66LYSA6Cg==
X-Received: by 2002:a19:f806:0:b0:4ee:dafa:cb00 with SMTP id a6-20020a19f806000000b004eedafacb00mr962101lff.60.1686055458477;
        Tue, 06 Jun 2023 05:44:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 06 Jun 2023 14:43:58 +0200
Subject: [PATCH v6 07/12] drm/msm: mdss: Add SM6350 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-7-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1447;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0D7OZJvsI1VqBAldTbVtRFbwuC+jJW8mAUrMe9Ykcbs=;
 b=//U5sESzjAZLdCHYZ7ycan2Fus4ZSVv4WamSuLI1t4OMIDaUAydO06CalgWdDLxiEiIJLw4g7
 vol9S9AHLtNAi9CDM5pCBm7aNTBzNvC2KfEyDdpgGh2KQkJ3GUhh/aq
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

Add support for MDSS on SM6350.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e8c93731aaa1..4e3a5f0c303c 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -538,6 +538,14 @@ static const struct msm_mdss_data sdm845_data = {
 	.highest_bank_bit = 2,
 };
 
+static const struct msm_mdss_data sm6350_data = {
+	.ubwc_version = UBWC_2_0,
+	.ubwc_dec_version = UBWC_2_0,
+	.ubwc_swizzle = 6,
+	.ubwc_static = 0x1e,
+	.highest_bank_bit = 1,
+};
+
 static const struct msm_mdss_data sm8150_data = {
 	.ubwc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
@@ -571,6 +579,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-mdss", .data = &sc8180x_data },
 	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
 	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
+	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
 	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
 	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },

-- 
2.40.1

