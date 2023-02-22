Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1581A69FDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBVVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjBVVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:47:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA047402
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n2so8608269lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39aG+iURI09iswW6gk3gC6TBwToV0heQthXAeMfwVro=;
        b=HzIPoQRPbG/dXz63sWAdJwl2JHB79lNtcfUTS1bk6pyYqiR9a92sQZ8oexO++tzYOV
         Tbk9YCRPD6MoPA4l/RV2iTQYtFRDA9eUjNuD9vyQpT59cm9obwO5UfFORpcTVfVTZVuW
         KjJv8fVNIDJArcRFG2m28RQuy4EZhxT13CiysjTbub+h0aDOd1qRTJYWm17Q/Z0cGZkT
         RCBMrM3+QjBRGlUQS+89zQlYptl1+ppeCt9IpLzXzOIo9y4UGBhyeaH5RxrgBqbokBHK
         DUk+Jpr27OC+WEvWbqlIyHOwuz3UvBY3oLUWm3+gFD6W78IP8A3m0KbGa/NSxW1wFv5x
         CdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39aG+iURI09iswW6gk3gC6TBwToV0heQthXAeMfwVro=;
        b=SnQJ5Tx+Gp//N2AoPwuxsyV6CjnYdfvD7Zpt1jDlKPZb4O+xeinZPO07i5GIMzdHx7
         f+nbE30pqrC+d1sdmRRP/4PqWLS1AKkELsS4qNwbmKnfpkap5VxD8N8cpCiA3SN/e2zk
         95PfnphvMdsNLU7CS0qcU7OCONmnOxnniXoYiJrvY113sts8+SZa9p+HluHS3lmzXfXQ
         8Vvz1MsP1nP6aAFgeHGCcqcyWmiLvnhzYrk8Dgfml8BwW2FMeo66Tu6+YcSKTY4hkd+r
         Nx+4iAb0r6fxN1WAIiO9WmGspJj+2p8ZjZROMTYcjJRENoTN/AQ+ux0qF3l7rLXv9Fpp
         3VYA==
X-Gm-Message-State: AO0yUKVg6vcktZXX1aOjgHrTnKYlO4hKYxAansQpVmsNRZroNlgq67G5
        kWjqPPhl/cTSvIR6OLj3Y5lWTg==
X-Google-Smtp-Source: AK7set+nn2KRiV4gLdb9BVSubaqkj4Yacm0rOrroDID/OutRQP5o2HwsQd0w7jcVi9x79C8aqjh0fg==
X-Received: by 2002:ac2:485a:0:b0:4dc:4c56:19ac with SMTP id 26-20020ac2485a000000b004dc4c5619acmr3609922lfy.58.1677102438644;
        Wed, 22 Feb 2023 13:47:18 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b004db5081e3f7sm505126lfm.46.2023.02.22.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:47:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 22 Feb 2023 22:47:14 +0100
Subject: [PATCH 5/5] drm/msm/a5xx: Enable optional icc voting from OPP
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230222-konrad-longbois-next-v1-5-01021425781b@linaro.org>
References: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
In-Reply-To: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677102430; l=807;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TMGW8gjkiQwEJ0fii5rrgM+Nl4d+tDtzpTg1fjmA9zo=;
 b=o1Nbuq1XpVhn6xnmPyYkuaAq0xiZ0aski/AfFD81WLJwQsE/JusmS5elxNiSQcEnM76oc3Ers35U
 eiDijrx9C0uZlUc59nitgz2e4VYiOpcCz4G/cJuX7NgFzniXRWFC
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

Add the dev_pm_opp_of_find_icc_paths() call to let the OPP framework
handle bus voting as part of power level setting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d09221f97f71..a33af0cc27b6 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1775,5 +1775,9 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
 	a5xx_preempt_init(gpu);
 
+	ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return gpu;
 }

-- 
2.39.2

