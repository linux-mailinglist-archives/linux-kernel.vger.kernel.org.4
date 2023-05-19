Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E570984B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjESN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjESN30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:29:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF913E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2451b3f1so7929771fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684502963; x=1687094963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xbg/GarYLH0aFj2Z0GcGyUdxXKd4AWIEjgCUU5KwNKM=;
        b=vJuSxGYk/KQ7DJM8LMmmyVUgzqptU4GWlxJl2iPW+t5MM4OSpQeXAOGSISVK5GBoZ5
         lQLfAMinnu3hVvPIQx7So0vMnFfLrNF1Xbro3spArt3sitaMsyprZCiRmesL3LzsFqTe
         bue4u8C7eXuVRgCx9jdHpIMOF6JkQKkkJESB2rUnksQ/SuBvAYmKLxTebQALspUgY6iZ
         GLFAgQ3iOk64ezVs0Q37K3j1Vw81Wyv97Pvo11VMrMS1eqAO/+o+vQCrBBGzlbfvWjHB
         2GkLVfJ1zfm5Hz1mKURus7lkBUYYNighIwJoXV0cFsrJxqxhcq9op8TMrb5/WPlOLjJY
         /fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684502963; x=1687094963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xbg/GarYLH0aFj2Z0GcGyUdxXKd4AWIEjgCUU5KwNKM=;
        b=ccX/uAsXJSgT1EFn4k5C8NpqE82yhCKCdKekw1AIfzzVEpCx6whDhaOuX06nU3Tkzz
         UuvwqNEEG5cODxOpy3h56hhYDGizO9DSRq1JXxCdHVw5AEFKvVczX3QfJEQO6l5N2CPM
         IOM0fY0VZfPRlTsVZBzznrrEs7ukEc/jTbv1NpVCF+s6fJ1U8/lWP4yQgR7tlrW2QsdP
         cxMD/DWC48rM3bEhSCYNhUQVjgsAWQw1KndvxSVimlGrbmSUY4btPjATcELlMtftje1s
         Pk7R5XxcyOm7YdVUo7rBKfQnGKH5Pa4QXwkK/Wbd8t6e7mNAMbya1z2dRHhTMT4VeefR
         Uz0w==
X-Gm-Message-State: AC+VfDxtPKl6O3Pwq4rEoNweEZNO559aA0tF30DJWbBnONQNtJDo9TJ5
        z2o789/vZLEGj0EmDl69hQwoZpIbeRTGG2YWujc=
X-Google-Smtp-Source: ACHHUZ4Yth2SAVNi+Eug5CJ7mED480E+0pZkEVoxH2yZS/EH5piYwWMVhulX5pbYglTdS2y1CwboTQ==
X-Received: by 2002:a2e:2417:0:b0:2aa:3cee:c174 with SMTP id k23-20020a2e2417000000b002aa3ceec174mr887376ljk.13.1684502963335;
        Fri, 19 May 2023 06:29:23 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q24-20020a2e9698000000b002ad92dff470sm821384lji.134.2023.05.19.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:29:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 15:29:10 +0200
Subject: [PATCH v2 5/6] drm/msm/a6xx: Improve GMU force shutdown sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v2-5-5b9daa2b2cf0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684502955; l=999;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tIqOHRwnY5c8M0EJh8c6iF51VO5nfDTSDxvclL4zDow=;
 b=KYPo2qeuYKLdvjj9oKoR1uGIGtpjAhcYDxd18dm3Lwi5iPiyTSKITY8bEUzM2vOEEa3w8ByAg
 sTMUWlNlnzwBn7Mt3wFvyNRhmol24Y9mXySPWHFi9n360y5ZUZIDaAF
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

The GMU force shutdown sequence involves some additional register cleanup
which was not implemented previously. Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ea6d671e7c6c..8004b582e45f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -930,6 +930,13 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	/* Make sure there are no outstanding RPMh votes */
 	a6xx_gmu_rpmh_off(gmu);
 
+	/* Clear the WRITEDROPPED fields and put fence into allow mode */
+	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS_CLR, 0x7);
+	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+
+	/* Make sure the above writes go through */
+	wmb();
+
 	/* Halt the gmu cm3 core */
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
 

-- 
2.40.1

