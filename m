Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5C6A06A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBWKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjBWKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421E75A385
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so11161553lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za3E13sEZpZGy0TRJfvtiuOwvhVoLyHtf80EvRj/pZk=;
        b=MDFq7rd08fXsre18G6E1RTIFFlyssmJ+vfcqlTduSLfBAGaBXeUbiqS2FYeUnFxlcz
         xqtsu6wHR3yzgazAaEoSAJKqkJ57YROo71Zl14aE19ixcfjFQzMGFV50Vy1/z2DQVDyr
         WdlBgzz0BxgwxqgBKgpyDZQu8NGtXGD6YrZ5+il7oThfUPtAGqfADDnSJdpp1leUlB0R
         RiOldLJvkKRaZzEWYhLcbXaVYwM7pxE7Kb8fcth7iPB91UC2KdLvMuBZKhhTamILNn+Z
         G5DnB02Pmi6FLAiHyMVQ9Q7tE1sNtXlPF+uQPWB5JSp0bequVliG6odKHsCDWfrhW+ph
         JJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za3E13sEZpZGy0TRJfvtiuOwvhVoLyHtf80EvRj/pZk=;
        b=e2KlTjQgx2oHJlnjaPxsD/sIq0J76Eeqzz1lD2UMUVvlLU+Gnn6+GYrcQ/MEuWuamx
         nqvO2EJf6rBTaR5k7eIczn5dwSxxTlHDocA42+QQu4qvNmpeQpJdMby4oyw49hXChUB2
         +XS6QPiJk2/EHrZ13iARoudQjhzMYK+NQNhBwJ+r/dlyaPXiVP6bIUHfKTtB2XgoU76m
         WHTS0kt7mGu16cBqUmUFMUwFut5dghk7hl0ClveBTaAQz+iEv02Q/eJF2qSdQaFMIk/k
         Sy58jSnS/WAtRq5f8vzeyoSlprdkoq1DUcRLumiKOKD8Yb/zfdO2y02yrp4z5LVRHvCQ
         zP8A==
X-Gm-Message-State: AO0yUKWa9Fvsr14c1UW/OCjdeCTjvWwYH5xnKWFWxth0mBAUd+d2YWit
        /NYq+sdu9t/ZWgvC10rGplLJRQ==
X-Google-Smtp-Source: AK7set+INuNTeXBO0iROBK4FB6M/NFho1ZgSth/f6jVVon+fZ6e/xF2oYOFwXv7MXdUhShIA2QVsYA==
X-Received: by 2002:ac2:53b3:0:b0:4db:1e4a:74a1 with SMTP id j19-20020ac253b3000000b004db1e4a74a1mr3691416lfh.0.1677149526474;
        Thu, 23 Feb 2023 02:52:06 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:06 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:51:58 +0100
Subject: [PATCH v3 2/7] drm/msm/a2xx: Add REG_A2XX_RBBM_PM_OVERRIDE2 to XML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-2-5f22163cd1df@linaro.org>
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=1718;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rz6HoVcDmCXeKasABEEZkTNc5/V8jfFkA4B1KcOgBnk=;
 b=SV+lLJPnQxMiG/KFu5RTsHoCbIyFDh3U+cxdnLtWr+2iKgpzxvA+vL+isiIzxDQu0WWLaAFkiOco
 5fsAxgM/ChvKgPuWKpvD2Uc6+EI07YVG76reRZTaxRAM7YZWZsqV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial merge of [1], subject to be dropped if a header
update is executed.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21484

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a2xx.xml.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx.xml.h b/drivers/gpu/drm/msm/adreno/a2xx.xml.h
index b85fdc082bc1..fbac25f66c67 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a2xx.xml.h
@@ -1313,6 +1313,18 @@ static inline uint32_t A2XX_MH_MMU_VA_RANGE_VA_BASE(uint32_t val)
 #define A2XX_RBBM_PM_OVERRIDE1_MH_TCROQ_SCLK_PM_OVERRIDE	0x80000000
 
 #define REG_A2XX_RBBM_PM_OVERRIDE2				0x0000039d
+#define A2XX_RBBM_PM_OVERRIDE2_PA_REG_SCLK_PM_OVERRIDE		0x00000001
+#define A2XX_RBBM_PM_OVERRIDE2_PA_PA_SCLK_PM_OVERRIDE		0x00000002
+#define A2XX_RBBM_PM_OVERRIDE2_PA_AG_SCLK_PM_OVERRIDE		0x00000004
+#define A2XX_RBBM_PM_OVERRIDE2_VGT_REG_SCLK_PM_OVERRIDE		0x00000008
+#define A2XX_RBBM_PM_OVERRIDE2_VGT_FIFOS_SCLK_PM_OVERRIDE	0x00000010
+#define A2XX_RBBM_PM_OVERRIDE2_VGT_VGT_SCLK_PM_OVERRIDE		0x00000020
+#define A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE	0x00000040
+#define A2XX_RBBM_PM_OVERRIDE2_PERM_SCLK_PM_OVERRIDE		0x00000080
+#define A2XX_RBBM_PM_OVERRIDE2_GC_GA_GMEM0_PM_OVERRIDE		0x00000100
+#define A2XX_RBBM_PM_OVERRIDE2_GC_GA_GMEM1_PM_OVERRIDE		0x00000200
+#define A2XX_RBBM_PM_OVERRIDE2_GC_GA_GMEM2_PM_OVERRIDE		0x00000400
+#define A2XX_RBBM_PM_OVERRIDE2_GC_GA_GMEM3_PM_OVERRIDE		0x00000800
 
 #define REG_A2XX_RBBM_DEBUG_OUT					0x000003a0
 

-- 
2.39.2

