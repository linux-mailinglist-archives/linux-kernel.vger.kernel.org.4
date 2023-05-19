Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC5709844
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjESN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjESN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:29:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C439180
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac90178fdaso35585501fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684502960; x=1687094960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doFIHuCbi1YVLGjN4vxnw9b75i10GnebCx9q/QOL15k=;
        b=vpC3ulkASRqGn8JDBs5tnXu2hHqQIx4ICIOpPmVLaDtQLh9IcY1j2VIAg4oQTPi2VZ
         5+1WsiWBj47Au35av90euQMg8riW7tadqA1QMvKRCqt8Q2Pq2K2rKPQtTWV4kmvwTQqK
         S/WjN4MxV3mBkbDcbJ2upI+GVVpJGrsY4SmOEIZOGqauNhy7qFaSH6SmZ9s7IUCyUOo+
         gUuMN74J6bJ62kPEIICPLxEb5VnjMNdaHfzh4Fv1NFz2uXAcLHy4hOAU6PoSe2Cl/+ju
         LB8SRb767qiigjewmeKGZBr7UANxz4ACVhjSqRkZI5rn3qZTRpDMjlzRaBg/M2uS9N9z
         6NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684502960; x=1687094960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doFIHuCbi1YVLGjN4vxnw9b75i10GnebCx9q/QOL15k=;
        b=ik3uIyxwhQE3APz2ZJBJ/hnSd6NDabqljdjRdldr4aCIod+jmzsVohTUzFLxNaOSCq
         yC2/U4tHOQ7km/OPgN88fyarGrPuuzfFobW+1LpJeql0ORnzsIkIi/dIj7ollC1A1Bz4
         fO2lYYBdT7ey21H5T2n7xWiB4tCQsZf5R/oCiu17WrtKeRv9wU1lthnwG3SsN8+d/lW5
         xWR7/KRZQOdeCG9NFO3UWDLoiMLRzRhahoNqzLtbYPkllkrck+EA+alCiUiJxdFWmIf0
         ghM36pAVY8/3BcxQN1eXBIwoqli3rl5Y8xjJJFSpAZyc3AgANt2fadzhKViB5YytJPEM
         0JTA==
X-Gm-Message-State: AC+VfDxDVqZkn3WBNN544xKlqTg0FWx/CDm7TwhLdl8khDc6laJawV8U
        dg8h59XJlGoh9m685oOiqfTI8jrPUCPeUr57JwM=
X-Google-Smtp-Source: ACHHUZ50bmhAbe1oi24zRF/8KffXoT3mBKIYDg3bqRNVsvlHDe8AFm3aTVWehD8gfdv1uUdgzNLnqw==
X-Received: by 2002:a2e:9008:0:b0:2a8:e44e:c75a with SMTP id h8-20020a2e9008000000b002a8e44ec75amr701082ljg.32.1684502960706;
        Fri, 19 May 2023 06:29:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q24-20020a2e9698000000b002ad92dff470sm821384lji.134.2023.05.19.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:29:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 15:29:08 +0200
Subject: [PATCH v2 3/6] drm/msm/a6xx: Skip empty protection ranges entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v2-3-5b9daa2b2cf0@linaro.org>
References: <20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684502955; l=1049;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3GlljK/1BVjiAo5f22OuFyyc96OvFEAFjCCjuTjlQ3o=;
 b=bKZaZzUq5kYs/sf4jVMg+tulUXXSPOs9cKM9Zmu9anxjshVp8a3LrjoUZMPM461mYhJbXqfEg
 qMBLVFezKetD8NdwTyoRO+QuKHUO87LXt8BxebSTJjMvJVRYH/9MjAv
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

Some specific SKUs leave certain protection range registers empty.
Allow for that behavior.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index deed42675fe2..8707e8b6ac7e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -778,8 +778,11 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 	 */
 	gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL, BIT(0) | BIT(1) | BIT(3));
 
-	for (i = 0; i < count - 1; i++)
-		gpu_write(gpu, REG_A6XX_CP_PROTECT(i), regs[i]);
+	for (i = 0; i < count - 1; i++) {
+		/* Intentionally skip writing to some registers */
+		if (regs[i])
+			gpu_write(gpu, REG_A6XX_CP_PROTECT(i), regs[i]);
+	}
 	/* last CP_PROTECT to have "infinite" length on the last entry */
 	gpu_write(gpu, REG_A6XX_CP_PROTECT(count_max - 1), regs[i]);
 }

-- 
2.40.1

