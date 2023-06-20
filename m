Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5B736A89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjFTLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjFTLK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:10:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F86E41
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so5887371e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259448; x=1689851448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwTI7UHTcKqCvzBNFhABN4+E8WkvXM5Y1T6fiTPNJV4=;
        b=jt2P+IIoyrMUIbyiSpdBY++NFIk6ttI3RdDAnkK6G7tKIx+GdGOLRSRlz8W3CvtL55
         143qAJo5noCZFYsgJ4v3Xqc4VM4rHGPgeTC5z9BUoa2gGVNNDpjRCQXDRNZ3/IfX8tCQ
         MjcUnJpm4T4fCHYtrN6Y1vdYgiS96MFfWBO6ltPxb+ltTHtncey+kiivDPrydkxtGu85
         wjpOxKZs6711sDHJhi0txe8LKOKKzu/GLB85Qk2+sE1qQijJ0qZXBFtMvHFguzXNrkMa
         z7yJLT8h7JHC9NkCEcGSbl2Sqyt/5S5bJhP893+eYtkawq/hsf5UZLiSx1T9ks0glPhK
         nCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259448; x=1689851448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwTI7UHTcKqCvzBNFhABN4+E8WkvXM5Y1T6fiTPNJV4=;
        b=NimA102EzWRUQ6DIZiQq1Ym3iybc4nIk39icrr9zYqopk8WYijoQdWx3dXA1YX0R7a
         ITru89wJSBMFgtYP61D4XrSl+O44bRrl+OOGqwCn2R0sPIsLa0dXiEOyJGjzXwO5200D
         l7pW98kmAtummJJWoxt8d5y4PmTfj0lD/Z4aT9KOZMrBxWhiE0quBegohiOsMNv/+NEv
         RjcBpoyl0ZlbHdhgTwcoSeokcnfkGh9wuP1lTXKFrB5OkrWRWaHFgCn3NQr/vIIhM4VI
         qbZ5/4doFrj13wp6NPucfeMSb0Ab9r2lz7u88T9RPvxcyC7I2A9EKH2cSMGLe1khebkq
         yqUg==
X-Gm-Message-State: AC+VfDz6toB8vvEiGNsUo0eKn2Ps9Gfn8GFBi81ECiZaLNGWTbss125X
        VUF7bnwwu8lOcG3C/vPwtin1Jv156PsV4dW5cAA=
X-Google-Smtp-Source: ACHHUZ5okQOzj1cMQwrImDYKSsE7ilohlU83tzowZhi+LUS+lB7cGsb0N37uqiCJOu8CuW11a0KNOA==
X-Received: by 2002:a19:2d19:0:b0:4f8:6dbf:401d with SMTP id k25-20020a192d19000000b004f86dbf401dmr3578630lfj.57.1687259448165;
        Tue, 20 Jun 2023 04:10:48 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id u26-20020a056512041a00b004f764716afdsm314395lfk.257.2023.06.20.04.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:10:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:10:41 +0200
Subject: [PATCH v4 6/6] drm/msm/a6xx: Fix up GMU region reservations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v4-6-b16f273a91d4@linaro.org>
References: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259438; l=1342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yg0CsUYst1MC0yCvcYjryDQIsWMdtt76iHZrZNL17WI=;
 b=GB3+ryq3V2BFvCAghxWY0vExkzY2tN7nu7hHmqLlYbOvEVQ11xjN4tpj9GRNP9ReuITm1JCY6
 e6ZBGvYqexUAuYjiW/9pR7KYSYyhlgIf3t2j677KPojp0fufFkJ2xG6
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

Change the order of region allocations to make the addresses match
downstream. This shouldn't matter very much, but helps eliminate one
more difference when comparing register accesses.

Also, make the log region 16K long. That's what it is, unconditionally
on A6xx and A7xx.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 55b12a8066ee..d682c1ed48db 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1640,13 +1640,13 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			goto err_memory;
 	}
 
-	/* Allocate memory for for the HFI queues */
-	ret = a6xx_gmu_memory_alloc(gmu, &gmu->hfi, SZ_16K, 0, "hfi");
+	/* Allocate memory for the GMU log region */
+	ret = a6xx_gmu_memory_alloc(gmu, &gmu->log, SZ_16K, 0, "log");
 	if (ret)
 		goto err_memory;
 
-	/* Allocate memory for the GMU log region */
-	ret = a6xx_gmu_memory_alloc(gmu, &gmu->log, SZ_4K, 0, "log");
+	/* Allocate memory for for the HFI queues */
+	ret = a6xx_gmu_memory_alloc(gmu, &gmu->hfi, SZ_16K, 0, "hfi");
 	if (ret)
 		goto err_memory;
 

-- 
2.41.0

