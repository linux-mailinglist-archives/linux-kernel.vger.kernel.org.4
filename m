Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693867CFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjAZPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjAZPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF7234FC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so2143965edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkFbFkSGCftg9vK3KhuB5C5KHQRRp5s7MFTXq3oSOXU=;
        b=Jtg30tmKUbLWZISWIXPATPJyGvDdzOARaqfHtjngPwzKZTLT00A130F95I8DgGT4Y5
         NI+FaLpiGNIYbeDMxLkmR3sIMjno9RV2nKzKo+kAkK6W6Al6xOCR2yaAcBKNvP/EyW+M
         n13ki4W+c2ATtX5UkBBkRVurGbxF64vLO1xP2f5iFFmrpAnwwZuoEJjp4ojrv/bmBqvj
         okaGgNIUX0lFkGEj0KiLfBN1RurMYenCTFEuRd0EKEGgEXgdPLMHSOKbrSdtbVZqpYsk
         NVbz+AiJwctK7n4Z8i1+bpL3ytt0IDEvBx2yVeuF3+QuptmVtEoWplRZ+zp5qdlQskLy
         E3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkFbFkSGCftg9vK3KhuB5C5KHQRRp5s7MFTXq3oSOXU=;
        b=Zc+T5UqPlWMzD10iuj98htEm1RBm8b9wNy1FOu2VPt0SfV25zdhdyIuUxdoNaeXTV1
         P+ZTcELKwNr8ZqfUeoCharU/VzaBIwG44NGo1EajX78NEtVwuF+zcDts8XYIPz3w6/Gw
         bvpIPzoYDbQW3Z4TLtlR+lylrmVJNTuhi8ekncVz/Vw7XdK0tyiErn/OcXCJxXkbR0/Z
         IcO0ZzwrdqYnRmGBrd5LRGbebu3qAHVvbn1CLfuG5OAUhy9zSeNMa+99ij6/HDBsnkFe
         8otjUpIdoibsUB2jZ0RO3i1nyoLtJ7BB+7dNCMJF8cxHUf5MXIHYqiZFRDjNJU0RsHAX
         q1Cw==
X-Gm-Message-State: AO0yUKUAKJ0E4/erJpdWWTo7BsDBN9ZP+pHYzG+UCc8dCM1zBm5pZI+f
        EM/D5yi/jZStlC8rSxCBXqc+DQ==
X-Google-Smtp-Source: AK7set96BkvFoMp+uw6C2kTl76s9zo0QxmZus/Wf/NGW92Dg51mUoa7BnK/qe7pjMt3PITcVKbTnNQ==
X-Received: by 2002:aa7:cd65:0:b0:4a0:e415:d39f with SMTP id ca5-20020aa7cd65000000b004a0e415d39fmr1699657edb.41.1674746278103;
        Thu, 26 Jan 2023 07:17:58 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] drm/msm/a6xx: Use "else if" in GPU speedbin rev matching
Date:   Thu, 26 Jan 2023 16:16:16 +0100
Message-Id: <20230126151618.225127-13-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126151618.225127-1-konrad.dybcio@linaro.org>
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
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

The GPU can only be one at a time. Turn a series of ifs into if +
elseifs to save some CPU cycles.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6d6b71306ee5..452ba32699b2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2150,16 +2150,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
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
2.39.1

