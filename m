Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B286B9948
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCNPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCNP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:29:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55056157
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i20so16400323lja.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdwglER2agYNfLVPprMx0FPmVS9IVmz+s6GuV4eeQlY=;
        b=lKp64Clb2weIN9LxcJaV7Z/cFUCUng+k5gejt9AiaR21/aN4vDzDPvhnnqAQMxtLvV
         5cOdn/hBnhe521EMwa26x2IMAoVau/YhZvrGCymgpYmFAjVmE4YoaneoXvU7QYVV7W09
         RJtavZi4t2J2NbcXXQBlGm0z6Pf2M7AQk/z+x01Veig1sikXb4vVqjSRBV/nCuI0Rfmu
         mr+1Mb31xbNiAp7QmC9neHPhs7XiuwXNWQz4ZSOaKk5wLWzg8cCL3nX0vmkV5xz1Adso
         B+Zu+3Gy52wzS20RAj2X5SAw4SsTsYyB87kRExR1LSx7g1G4NyeiZSQqvPk79SU0ABMb
         TUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdwglER2agYNfLVPprMx0FPmVS9IVmz+s6GuV4eeQlY=;
        b=KoMfVRoXZwm/73Aeck17VO3BVwEH6O4cfQEgmZUaKoWr2f4DoWMVJIXVcf53JsE9Nf
         oIQ5OjIiUGoWIvrG6AOVNHUbVydBlfFasGfjjrmK7XjvBIjve2rPWf/1pKWD5L4ricSy
         MAt8GNu3w9M40RghnPp3Zs642gyFbrzalofIw8drjTy30WKh9suxRfJVBrQQ42xFBaW5
         h6oqMsMepZbVnzjf7iY4iPAJY9Th4+YvcLhO6fQ1wCcVJWW8fKYPeEdisUG+b0rFtyAG
         Co/5PHQt7HForrvR6tMZAX5++EkrqN3jNVBqmRSGE0dWzKhOFO/yBfd3OyGOalWy5DwC
         PuiQ==
X-Gm-Message-State: AO0yUKUcB+393oDblQtTAcmWFqf8XLLJe7braltywZ1Lx4nY0PsuV2Wt
        3ZYTqMEv5R9Qt83osXEuQQwL1A==
X-Google-Smtp-Source: AK7set8fnrIyrdBk2/7gj5cpgSgzt/Xfpampum2BodPGgG8qvmvSrr5Oz8Aau3qXEqeqcc4co8j24Q==
X-Received: by 2002:a05:651c:2211:b0:298:6e2e:2224 with SMTP id y17-20020a05651c221100b002986e2e2224mr9543190ljq.47.1678807736338;
        Tue, 14 Mar 2023 08:28:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:42 +0100
Subject: [PATCH v4 11/14] drm/msm/a6xx: Use "else if" in GPU speedbin rev
 matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-11-e987eb79d03f@linaro.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=1434;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=D3QGn+nYvlP8x3swaH1kHJwlzdjGFbaFa9zhDHv4lx4=;
 b=ZOerBhWO9wapKFAmKihwL/xjhmOBckfMZSqJGmKAHuDSBy94K3mEfpFoTQaJo9CdyzfCJdViZmhq
 8ZeJc1z3BqzNORvpz6NPoC45eGj51K48M3uSZAPNbuiTEVkmGm0I
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index f699f326021f..dfd2d735e57f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2207,16 +2207,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
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
2.39.2

