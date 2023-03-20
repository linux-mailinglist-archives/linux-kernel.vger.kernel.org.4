Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9383A6C1563
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCTOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCTOpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98488B459;
        Mon, 20 Mar 2023 07:45:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w4so4587895plg.9;
        Mon, 20 Mar 2023 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRudoYKJ/9RBEgJ+2j3GsDNIAjaLf24fOR0Git+DXzM=;
        b=FSiCBrQqb/DttiCvh4W10nxnr4IwYmxqhvZrOxgMDQkWUirVLq87/u2vJrBad/daDh
         qw++XRKpNrVXUMtZedrPPKhpDSyZukdY/4ufBj5U2makZ08JuIbMHnJSOiC4xm1bzrjS
         HzPLQJOPxkS0Er/frUYuRF9+wzmCTAdEXPRxpH9m4E1e4+TSidc5nWZdbGAXgA9UJObW
         LQ8eG98up+TO8k88KCpl5YaCgqinGhFAOq+NXZiPa6fHGsmnWtfhPJltAZ0vlG4R9Kn2
         hJvQqOIM1WcqtU43N+oX6hFcHJ9/IKX54VNK/yLNmLJEvxRuIOe1TvBoZvweJE5xupP+
         mKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRudoYKJ/9RBEgJ+2j3GsDNIAjaLf24fOR0Git+DXzM=;
        b=0OJdm5aZeCUW885rLQNB4S0YOREn1Bvqq50NBa7CMwF4xgxHmCZO68vSC5f6jFfZyW
         F/RT2OwtjMNrOvSwOQI9kPpjbFBxdc++/7xDL0D31Bs04aItgRgO85shf6vDt17Cc+fx
         9UrcRNzHjy4bcP+KL7VKBygoQQxTisjfr4jZ0m2C+WjM3seM39E6BkNEKBvNyv8nXMU6
         6UUD3TP5rj6aYwZL6xcmYqAXvUO9Ut8AFMlQ089XP91uE9KnlhuyyZa/kuo4cwIBtt87
         CrES5JU/7IJDN+NiJH0UaxYFFPg7HQlWUmFbIAH2M9fsmukCQwR909bcacD09Y8kfo1X
         cjUg==
X-Gm-Message-State: AO0yUKU5v1IqvoBWPlf/+jBHMsd2KzlwAsEjrL5mdLGOhCHzbhv0XX3V
        eQMiO4U1BoISrZcNODwTKOg=
X-Google-Smtp-Source: AK7set9ulfPXo9jK6KpDY96RxgLMtzdpXoEn31dcDtWIB8HP/mch1ngRHsDe2j2Y+tM8AsYX9Ahm6g==
X-Received: by 2002:a17:902:e5c3:b0:19e:7d67:84e6 with SMTP id u3-20020a170902e5c300b0019e7d6784e6mr21119604plf.0.1679323502456;
        Mon, 20 Mar 2023 07:45:02 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id az8-20020a170902a58800b0019aa5528a5csm6793088plb.144.2023.03.20.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:01 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/23] drm/msm/a6xx: Move ioremap out of hw_init path
Date:   Mon, 20 Mar 2023 07:43:36 -0700
Message-Id: <20230320144356.803762-15-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Move the one-time RPMh setup to a6xx_gmu_init().  To get rid of the hack
for one-time init vs start, add in an extra a6xx_rpmh_stop() at the end
of the init sequence.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f3c9600221d4..30a1bf39ea83 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -621,6 +621,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	/* ensure no writes happen before the uCode is fully written */
 	wmb();
 
+	a6xx_rpmh_stop(gmu);
+
 err:
 	if (!IS_ERR_OR_NULL(pdcptr))
 		iounmap(pdcptr);
@@ -753,7 +755,6 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 
 static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 {
-	static bool rpmh_init;
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	int ret;
@@ -776,15 +777,9 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		/* Turn on register retention */
 		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
 
-		/* We only need to load the RPMh microcode once */
-		if (!rpmh_init) {
-			a6xx_gmu_rpmh_init(gmu);
-			rpmh_init = true;
-		} else {
-			ret = a6xx_rpmh_start(gmu);
-			if (ret)
-				return ret;
-		}
+		ret = a6xx_rpmh_start(gmu);
+		if (ret)
+			return ret;
 
 		ret = a6xx_gmu_fw_load(gmu);
 		if (ret)
@@ -1633,6 +1628,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	/* Set up the HFI queues */
 	a6xx_hfi_init(gmu);
 
+	/* Initialize RPMh */
+	a6xx_gmu_rpmh_init(gmu);
+
 	gmu->initialized = true;
 
 	return 0;
-- 
2.39.2

