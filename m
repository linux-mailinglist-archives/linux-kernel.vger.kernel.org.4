Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC940714B11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjE2NyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjE2Nx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:53:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496C7100
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso3776699e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368367; x=1687960367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmQPbfO+F1oBJQkI9K6akAThU3d6RkZKcfSUr9dQgtc=;
        b=prhQ9z135A/XL4btw/gHLarhsQTq1qSmqcG9EJ/CgoAkvg5xhCypAQNSmY6M7r9FVK
         DgxDVZ3bZ74uiCWStRYQkHwb2hONVAeYtRqz0SlVxGEj1nCkXPuyajvRxhSQWt7SvyKg
         5GuXouEjufiAondg96OBTe8iEx7lnu0mz0zF2fnYnUDW1U/vkuCMCSHEdnuvbg31jw9T
         yC7BDN5uKBJGnNT0nZZfG71ell3GbPey3XmF6oZE8rgS0ttmsht2TSjsK9djvW4XRo5B
         s5hK2/ewptLEFFIPCRX/M3d7z2OITer4ow43PzVZ4rUwNHLf932bLJ8gDf6YRdksDLZY
         9RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368367; x=1687960367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmQPbfO+F1oBJQkI9K6akAThU3d6RkZKcfSUr9dQgtc=;
        b=gUxJ2kjqEjeJAKkNpx4eJKgWNc1HDoJnI0rJxQLLS0IDNR0/YYu+sdOAYMDNMTjKYi
         nOpJANbtOO7KpubWAE7PSiKjB4RpoyOmaf4bR1EMja8rkv0lLMelQLGaqQNhXj7/xOPt
         nPNXWNCjRlDW2kPKeO42r/Ib2f46iRDysObBUVzW2CVtSmsYb6Atfnv5E+1MOxpnBti7
         MyON8lhnBF0R/Don8OqG1Ac3PaASG5bzVB4th0TSJI3kxJqMxNYOUY6TW0IV/YzugRoW
         ZMkJjWte6QobFaoNEoi8Oqp9MRPpezlGcxyAwjLHSH1lYb4vR3mszql364+Nd+ul0+7I
         E2pQ==
X-Gm-Message-State: AC+VfDyWaqZO6J0eCP9a6kSIsBmq9nndiYAzY99Hd1VKjx9FJ0kC7zP+
        ajsGwqbsZ0leiqVESa4Gf+gsFg==
X-Google-Smtp-Source: ACHHUZ5qIz1TDmuUb+T9cZ+rwxl66xf6w5ydg7F17FenUfg9o03xTAGn2LV1Jtj+8I3M6Yr2YiZhYg==
X-Received: by 2002:a05:6512:64:b0:4f0:c18:5114 with SMTP id i4-20020a056512006400b004f00c185114mr3608499lfo.26.1685368367275;
        Mon, 29 May 2023 06:52:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25310000000b004f2532cfbc1sm4700lfh.81.2023.05.29.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:52:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:52:34 +0200
Subject: [PATCH v8 15/18] drm/msm/a6xx: Use "else if" in GPU speedbin rev
 matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v8-15-69c68206609e@linaro.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685368343; l=1434;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=H2Z7peqqE8oAE8U3nTlARepFCY8M4ZLiVH3inaSxkyA=;
 b=cJIeKzGQe+QN5PWfsZoxB2X1FWjbe0uOO7QgbvODui4tH5P1SROuXZRm59GAYZ5IXYQ/FggUp
 lfKc6RPYy8kCvM8sJpZC8p+ZpSbu87BNBxXpAZDsP1d72JhvWbstku7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU can only be one at a time. Turn a series of ifs into if +
elseifs to save some CPU cycles.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1a29e7dd9975..5faa85543428 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2170,16 +2170,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
 		val = a618_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
 		val = a619_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
 		val = adreno_7c3_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
 		val = a640_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
 		val = a650_get_speed_bin(fuse);
 
 	if (val == UINT_MAX) {

-- 
2.40.1

