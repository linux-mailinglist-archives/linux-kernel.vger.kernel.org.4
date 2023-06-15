Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17408732394
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbjFOXXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFOXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:22:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E1730F3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so11307535e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871307; x=1689463307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYVg5xWLgAw8ObPKuarwHrvQ8MbLRWVq3Hh2y66RuC0=;
        b=itrD0BtgTqh/hrdK7JoqVEhInsJX5xlPkjyH3iWs4fsesWXjXeFux5kPxjwoBxdA9h
         AlCi/gFKU+7i6M8N/y9JtJrcz9WnR50EYjea87OeCJy/BHLIcw5K2d4KkMVKWBDWEI5r
         w5Numc3CkC3nEB1aKUOclOwd2LvS6sBmTXPEpigZhJDtCsHvM0uj12mUWpjMyEiv69dr
         cFReB/eFRIks+KFmgv+8Pw8Y7NurVwWPlkcFnBAchfBRdLH+ERmw6ar6F8jKZWu5WKJE
         B1EmThmuNuwcqkZyQpJ5DsFrE48QjjRcxge6ciPfXfBaknRpbmY1oBe9MxZZTjNDaTtb
         bFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871307; x=1689463307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYVg5xWLgAw8ObPKuarwHrvQ8MbLRWVq3Hh2y66RuC0=;
        b=JPVIna7Ww2+MixjxwrlwMkWO94B5B/XNPp0MV7O5Q06L0IlhKMHmIkQnRv5X04JMJ9
         qP1qDdmzsKvEbvmT6j7SlD2Lcu+5Mq1Ehh8pRBnQs8RmYKHSqXx5mqB7f5kCgP1Wj5PF
         pQ6U7bLx3Pi9dx6y2Fk+rwVM81k2YlM6o7g2Snw23uPXnM6GVZ+3/sF58wnFRlmpt1Ze
         QcnQHROO39IowhvwwelQyy61K7uAf+tB7G6P427hWnCs4cosYliZVkSkrhYEdjmeyHYp
         3O6sANFsnpWZ3fN76BqsPmjdlLbcAwd2/Msa+hCFQB8RtdiJ9E7KqiDr+Iur9JzP47TV
         VGqg==
X-Gm-Message-State: AC+VfDyyUD09SA+EBK7S6mejL3O6saB2R9NEeXsJAROSwz49kENmZna9
        9FUCMwybYkpjOBLGZtGqY17T7A==
X-Google-Smtp-Source: ACHHUZ6w6RF6n9HK1f1WuQMH+vYnBy57Yg9QjeE9N1JkSjR0N7RmOTNO+MYVTCryzpH0E/lj51deTQ==
X-Received: by 2002:ac2:4982:0:b0:4f6:4616:9f68 with SMTP id f2-20020ac24982000000b004f646169f68mr110832lfl.38.1686871307097;
        Thu, 15 Jun 2023 16:21:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:21:00 +0200
Subject: [PATCH v9 19/20] drm/msm/a6xx: Add A619_holi speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-19-890d8f470c8b@linaro.org>
References: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=2089;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NX9ATH/Ev8PlZhCVhECzg9N+SgoP/jwCI/pQ0YNJQOY=;
 b=YrJ5CN8SWgMcflHDAkdH4AO6i2fC6lh3OlFqiDjWhiSOCXFO3qusmmxcSIxOKmmAc/apeUeP7
 kpCV/GnTH9pAV0Son2yVEiFfcmldMHDzlXfXs2vLVHKp0dlfI7MgkU5
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

A619_holi is implemented on at least two SoCs: SM4350 (holi) and SM6375
(blair). This is what seems to be a first occurrence of this happening,
but it's easy to overcome by guarding the SoC-specific fuse values with
of_machine_is_compatible(). Do just that to enable frequency limiting
on these SoCs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d7139eae0f73..ff9a8d342c77 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2216,6 +2216,34 @@ static u32 a618_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a619_holi_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) two SoCs implementing A619_holi: SM4350 (holi)
+	 * and SM6375 (blair). Limit the fuse matching to the corresponding
+	 * SoC to prevent bogus frequency setting (as improbable as it may be,
+	 * given unexpected fuse values are.. unexpected! But still possible.)
+	 */
+
+	if (fuse == 0)
+		return 0;
+
+	if (of_machine_is_compatible("qcom,sm4350")) {
+		if (fuse == 138)
+			return 1;
+		else if (fuse == 92)
+			return 2;
+	} else if (of_machine_is_compatible("qcom,sm6375")) {
+		if (fuse == 190)
+			return 1;
+		else if (fuse == 177)
+			return 2;
+	} else
+		pr_warn("Unknown SoC implementing A619_holi!\n");
+
+	return UINT_MAX;
+}
+
 static u32 a619_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2276,6 +2304,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_is_a619_holi(adreno_gpu))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 

-- 
2.41.0

