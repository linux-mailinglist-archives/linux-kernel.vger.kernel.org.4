Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259E6D1347
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjC3X0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjC3XZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:25:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D661BF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so26680402lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680218739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJtkSDvqvd+N2tN3r+04S+rFblpzh6izfhKCgwy399E=;
        b=s/HQPOIdCM2wx2RJyNPmcY8kV97ZK8TPWptMk4d6ChufFzl048iV/b0pKilbqFYFLM
         fctgLgBgPNtgNKads49nSe5vS+rLAtQVuL9a+yYSNcVoTB8JMy3Kk5m/b3jaqc2/XMvQ
         0tVWo+ncgHjFdoUK3n4NOk/beBq1RiIIDAQJ3Qco1DQJQBN+IoG/2w9X+7Kia0WY3pRC
         ze/1Nrv13evTUnj68o0qPswjVD/wOlvfp9ZjP+xqoDC+OeKzABkYRkbfdXS2NYqmOa8E
         HBclZC+f95kzpkBktPHPl5FZZXOYiyZ4AyC9NUkCwl/yzZ4TTmyZc4UJTyDHdsqnW7oD
         kaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJtkSDvqvd+N2tN3r+04S+rFblpzh6izfhKCgwy399E=;
        b=sRm3Ka2A6ZELZauJd14zRGZ2DvwmxGyiN6a1yqMF0xYFQtZbOdV+FqLtsUJbWzSjgQ
         Am50oSe/4L2r+S3IrHdlsH8l6gQiOufRp2Z+iyto+Z4m/F7jPCVhWfesjn2Xy1N7bu8E
         efChZ0IODUjSFEmJ3uAY1+rj6vwfAWV5bt3R5J6/trJW5W1dqTfi3TJOoSBjEXKWEXEB
         eoK0L1FU296S92w3gxvZT3lVZjemD2qFzHwR/fSOvmLsUEsAn8+R48PiDNacLDUZvAji
         uocVXtul9A0f/iWFUHLbuDSFDFYK7U7tHxSdvYufVzlfCn9mHV7/jfhbAwcrgvDtxPcl
         ieAQ==
X-Gm-Message-State: AAQBX9cARHcQu4WH3XdaLFtHwANMaMhDTmg8x3zD/TNaRdhn4aMwVDhf
        vOxxk1Pgt08WCH+i97aU1JhV8g==
X-Google-Smtp-Source: AKy350bMoH8wrzy9X0rOyF6hSdT6cQnVC6QTyeEWjyMPdHp3rpeoxywyZ1y63v6eDY9URujHnuYDyg==
X-Received: by 2002:a19:910f:0:b0:4dc:8049:6f36 with SMTP id t15-20020a19910f000000b004dc80496f36mr2150438lfd.1.1680218739267;
        Thu, 30 Mar 2023 16:25:39 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g26-20020ac2539a000000b004dda80cabf0sm127241lfh.172.2023.03.30.16.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:25:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 01:25:26 +0200
Subject: [PATCH v5 12/15] drm/msm/a6xx: Use "else if" in GPU speedbin rev
 matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v5-12-bf774b9a902a@linaro.org>
References: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
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
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680218720; l=1434;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=s5xbHS5B3ZCiDUXL36LQuQu/YVWHv1Qws9XL8zObDRw=;
 b=0lrLA/hfvQb9236UuY0WgfSVa7GWwFJWUOE4cP7zBhaQUQVZPEH06Zl/rGSuLhfW8wRkV8u9tTsT
 woreoyUMDHtF32a1vNknVlAKJy5ylWmHmItoggCtDa0EAchVD7A9
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

The GPU can only be one at a time. Turn a series of ifs into if +
elseifs to save some CPU cycles.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1f553451ffa5..87ff48f7f3be 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2224,16 +2224,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
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
2.40.0

