Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258767CFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAZPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjAZPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48975B81
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v10so2138409edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY08lSRJ0khJ3YSfU40JW9rAgs8VWCIlhnOm90/cUOg=;
        b=lKSIVY86+zq1xPchzjtResCxNKdOQBD6iUh60NPp69Mm9Vz1hpxXqAJiRUp+UuRoXm
         rt5+/jiDHZQ1nzJf5+m3JmJM4zM4Zbo6j/u9Vc1w0NqwQo/b0ETnG+rnARcvyzzs3qUh
         Mq8WNgi3QKGMpG4B7u1/qOeBxXzBErww35/dMfAfILy8tdEusUwccHpXn4UlNxBXbK0F
         nD0VUFe5qA0F7SIk1rnZ8yWLjk1Cj4hWAPdZxwJSI4BLkbfbkuVwt+XIrkvrNRSyy/uV
         GZZa4OfbKq246VX45TGaOTQ/rwQCpKh3mFUOxpYZKiCQT2pSKsG2l8229l7wXcHP9GUo
         4X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY08lSRJ0khJ3YSfU40JW9rAgs8VWCIlhnOm90/cUOg=;
        b=dTP3cWizSvvH/e5UTF0ZrPkup3AT5luxa4JUKWz5rwsOMJh2m6DQsVmadu1xv6hul6
         oF3MZStWAermAlJAtsDRPdgqskuwN+aSkAq1/bYtXTmF/1IqNx07im5h4sfyEUE+nx61
         t2WDgGRjTcv+DR3jtUzwihCVajrECv1tznE2fsdMazos025nQWjozJVc7CUh53nczVwj
         5Tx9eNrwaKZkWYRlgqgznRQnOio5JzwtM0QO3LWPFQ7aK/IqYbXBo3P/wWsHSf+pZ6sP
         LAwNm/xO0M1NQn+V3H7WhuYB8EsUFF8PX5kbo15Vnhlvuz/iQW4My1M2T9u+CmYVofv9
         KciA==
X-Gm-Message-State: AO0yUKWRldnyuionAOZESTZGIyW/MqEeic5KdFlAuyTnrO0lVYlb+6cD
        9mANfCwEEV0fB8OCGksRph8Prw==
X-Google-Smtp-Source: AK7set/prHz6j9mKe+q0SVim8Gk8tLhMF7E/oyiHuu4Cq5/Ipb7BZO9a0zhELcam1t9manYuz9ECKA==
X-Received: by 2002:aa7:cfc5:0:b0:4a0:b978:4533 with SMTP id r5-20020aa7cfc5000000b004a0b9784533mr3622092edy.32.1674746248802;
        Thu, 26 Jan 2023 07:17:28 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:28 -0800 (PST)
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
        Ricardo Ribalda <ribalda@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] drm/msm/adreno: Disable has_cached_coherent for A610/A619_holi
Date:   Thu, 26 Jan 2023 16:16:09 +0100
Message-Id: <20230126151618.225127-6-konrad.dybcio@linaro.org>
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

These SKUs don't support the feature. Disable it to make the GPU stop
crashing after almost each and every submission - the received data on
the GPU end was simply incomplete in garbled, resulting in almost nothing
being executed properly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 36f062c7582f..82757f005a1a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -540,7 +540,13 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		config.rev.minor, config.rev.patchid);
 
 	priv->is_a2xx = config.rev.core == 2;
-	priv->has_cached_coherent = config.rev.core >= 6;
+
+	if (config.rev.core >= 6) {
+		/* Exclude A610 and A619_holi */
+		if (!(adreno_cmp_rev(ADRENO_REV(6, 1, 0, ANY_ID), config.rev) ||
+		      adreno_cmp_rev(ADRENO_REV(6, 1, 9, 1), config.rev)))
+			priv->has_cached_coherent = true;
+	}
 
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
-- 
2.39.1

