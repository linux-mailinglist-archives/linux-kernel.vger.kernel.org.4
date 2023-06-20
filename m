Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A92736A79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFTLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFTLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:10:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C0B2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so6031661e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259444; x=1689851444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXvgXObuLUXgh3jnIU3RKwPMBc4ZARc1+vOEfqXJtnQ=;
        b=nj1bLjFxDQ8N1dngAIoD5fFA5vBatazLEV7Rkl0NVSdLk7EjRHn3nPn4q7ZzwtgXn7
         tefqdg+t7D7rjBfnifRhTu8ym5omzboW5s1nHWfyceXGDZtFvr2pZWVSPoK/TJDe96Ah
         SnBI6tzr6oJJ6aWQKzesHnLdvvBQNsvxBLHq6tDJsFVz+zNjLIC5L34SX7pT3/ziD6M0
         LF6bvc2/iH9ZAGbbrlcvrR2X+t38B5zSLvcldDfW2HMyAv4oXs7EAIa/242H6P5RI45X
         fTRACPTRJ06NnffMOsUA//H9n/kwB1d8MbVfiP0Yw5D7M44x14/5EWok0qua/xoSP02a
         IsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259444; x=1689851444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXvgXObuLUXgh3jnIU3RKwPMBc4ZARc1+vOEfqXJtnQ=;
        b=NuRfL3DvdP8KsB00cX6j49jMiT6zUhITN8IGpF73ae2PqJ8/XU3Zyvk7mNDaXyYvQK
         LRcFq4oaBdTfGkqxXVm7ZPUqrYuIKMUprPRW/TI6/klt92tYLUTrOPbsV/JumPpbW2By
         7nCg2TDwS9WzlqVj2rCENz7yfzm1ui6nmQgi9egVSVN4vucUuY9ruD8HmDsSqr/QWsi+
         QmeZZUeY4sv+iaTNitomY+jSGmCyY4aH0Nnr+J9YaGwEps8ZE2dW1FSDG65MBYdB2p1z
         AYjarPVI+VhFdyqD4LHYfwsA3FZxukxNUS6yoR8Kz7jku181UR67WD7jAN9CaoJgrpCK
         BflA==
X-Gm-Message-State: AC+VfDwRCxVJbBo9Fc6lWSOKPNS/gMz0zIDAMca3nEWULkHWqkNtAxTJ
        KinJTHsZx7YS4LuqQf/s+BVrfQ==
X-Google-Smtp-Source: ACHHUZ6o3H7FAjbFA36EUJYGnILaT5rNS6XDXr+aoTe+0XtS9Br+u9XgsLwORLTiCrZ54S13+jDAtw==
X-Received: by 2002:a19:e346:0:b0:4f8:3b17:e0c7 with SMTP id c6-20020a19e346000000b004f83b17e0c7mr6453920lfk.7.1687259444302;
        Tue, 20 Jun 2023 04:10:44 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id u26-20020a056512041a00b004f764716afdsm314395lfk.257.2023.06.20.04.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:10:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:10:38 +0200
Subject: [PATCH v4 3/6] drm/msm/a6xx: Skip empty protection ranges entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v4-3-b16f273a91d4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259438; l=1073;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=p7u0J4uljF3tZrz5h1ZuKJqCS/MqBnjZGFZOc1JmV0E=;
 b=aa/j+YpmthCxcgLQSQsqmjhv6KqCYw+HpswdGPxAmK2MGKVBAQcwQbn13IonEP6CnlhShwK15
 MsAo00yuU40DIum5DT5f74Z+YZ1dhhJaV2mUJOkFqvPWhqBVEVF+Grs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index cd0c9bccdc19..488c69cf08d3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -935,8 +935,11 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 		  A6XX_CP_PROTECT_CNTL_ACCESS_FAULT_ON_VIOL_EN |
 		  A6XX_CP_PROTECT_CNTL_LAST_SPAN_INF_RANGE);
 
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
2.41.0

