Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09A706EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEQQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjEQQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387AE59DC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac733b813fso10363681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342222; x=1686934222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoLKDA4nls3CGbrXvxh61SjvP4v8d9SGkB682PI8Y9w=;
        b=i1dbxqi1eNd4Yl7qbKa/DzCua/Zv8bljh0np7sIKjpbnORXCN9UsIhb5KLwUY+3dBD
         u3QBbSJoeQafLR5qSuG5M56upGulM+buDf5h6zXgu6IJ/+z9q21Pc4Bh06H2v0pzwbhE
         yysaAAtLWODaCtqxXB/SZ4cRvzh51IFPxZCyiECJ9CianawcNL6GfVVPvTqSDkChueop
         sx73h9FNmjFTg9uXTkJr3CFgFEodDdOPEK5UN2HIdTHfxVD6iSTXT3KdPrHm1j8NZHqT
         jEUZzg3jTxcRCBziiaA3RJUytD4cQN0zjblIst5AZJQCrV4VLjV+Ma8G2xOLMeoh1+4o
         /4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342222; x=1686934222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoLKDA4nls3CGbrXvxh61SjvP4v8d9SGkB682PI8Y9w=;
        b=SfNGvyleaYq/EP4O+iIEGceTRJAFGg1z65K054LhacaGM0XuFSZuwGTw4FkpqnmWVj
         A5uMSKO24R7Fb3Vcg+9QbklVfBtm2Zl6djijdEVeWkAeQcDWSdhRjWUZghcatWAQDsj8
         FpuCKmeSntY4PSlrpiYEb35QoHsIp9+/bUAGzFmNxSXhZk9k4fwWIsxp3rQtblaWhL4u
         qxDnpacvOHGdeHnhSVT+6abp6BdgSQ6IdwO29nywhHqVghNeKZUIVU0ieiHJND5pkQzm
         K2t/kXyyBsEdEXUrHjV/piU1rjphXQ1PDcPs/dNOz6HiXdVGLFcOmjl33wgs5CBzxuT6
         ZZhg==
X-Gm-Message-State: AC+VfDwtsfVFcgU9ruBnuREXsrPIxiaMXRVEaQ58z4uzKm2R1ei8TN6P
        aK4toE+eMWlIRaIft1HlJ+RJzQ==
X-Google-Smtp-Source: ACHHUZ4jLbe6d4GH4iLPsue2yFWhS8POeGWQvmRFqujlYCuVRms6eu9CsVJJf+zBSskasB3XfoOD2w==
X-Received: by 2002:a2e:a408:0:b0:2ac:6f6f:ff63 with SMTP id p8-20020a2ea408000000b002ac6f6fff63mr11229311ljn.47.1684342222724;
        Wed, 17 May 2023 09:50:22 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:50:13 +0200
Subject: [PATCH 6/6] drm/msm/a6xx: Fix up GMU region reservations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v1-6-7a964f2e99c2@linaro.org>
References: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=1342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=btUFgb1HmX4JzaeMKMcU2R1/tETWRJTF/5M21P54ufE=;
 b=2iOzY8M2I2x7twxabI/OJXdaVxfB9SkZvzqmhiZsOvaZVWXV/x0sZHjUtqXXsmMTWRk4wRQQM
 64+sM1IyjWSAs6uhXWBqPJWO2gwmSn1SumxzfMpgnd2I0KV4SOOH3kn
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
index 8004b582e45f..386c81e1a2f3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1614,13 +1614,13 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
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
2.40.1

