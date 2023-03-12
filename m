Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51726B6B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCLUnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCLUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFCE3B661;
        Sun, 12 Mar 2023 13:42:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so661072pjv.5;
        Sun, 12 Mar 2023 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRudoYKJ/9RBEgJ+2j3GsDNIAjaLf24fOR0Git+DXzM=;
        b=jQHWp50cIbgFsYptQZpllmJz454EJw91wUkU36Mtn+BFjJ1KkKFlXKHQE4CD2k3fqt
         R9w6zD1Ur0ZYjqP/HCptWfNuORhvp3bVnDdWgVPsSOsdkGEpFTTekL5GIBo8YkcCThxw
         KJmK2CNRlazKs/TjnabSUDXQm196ZmaPE6stbW8BjE8IDd9fpZoIqdjlZRCFMJYGlHEF
         ds7/zOB4Vodj7eVo7sWY8eezHGBmQy0Qc9g6l536lL4gHdSZl1itSm7OrpLutDqq5vac
         fHHRZ8xfjqfsomr0xZPrKu3bg6VFI83riSU4X6El/VahepCHA59roZlre8XRJzmdseIc
         wfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRudoYKJ/9RBEgJ+2j3GsDNIAjaLf24fOR0Git+DXzM=;
        b=mYknP63vqtUNyadhDINupu41RMsAoBkemtVKx31kJIlYmKW2N53IwhdTl9a7MQ+2c1
         t3z3bvI0C8nD44H1s91YYn5VYiQOFyI9cT4603UjRrLCBNw7xIl/PUEtCzD7+YSqUioy
         3rSL1JfsqpMnoMixJ7NoQ1FmscfRe2WD5ec3NRV4xQFcT6FNhickiVQWv3Lg9W45o1ER
         DoY5MYP1TVwNXhn68ow31b1ChC3RJdJKGK609It9vrkLmd47RixXQWYKOcLnyBjs5L+U
         F5TBYzv9aYmaWRaPg0ObGqhPpTFlu+mssDakvzYMhpRGKq8eWxFyHMDxG9ZSsxHu/qNd
         KjDA==
X-Gm-Message-State: AO0yUKWjaKW4zngrf0XlSFi4UlT3b0yx8NTWZsIQaFVY+SGblzZnwOHO
        4oKtbC2OnjpvMpR7a+3tO+1zNhlbQ2c=
X-Google-Smtp-Source: AK7set8yV2BoZ9JJxlsH9b0dOMTtNPJpLetrWEzDudK0gwZElbsqmXNI+JUw9daPKMtYln8cw4MD0g==
X-Received: by 2002:a05:6a20:4930:b0:d4:78f7:c4e8 with SMTP id ft48-20020a056a20493000b000d478f7c4e8mr550004pzb.25.1678653757748;
        Sun, 12 Mar 2023 13:42:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id l28-20020a63ba5c000000b00502fdc69b97sm3177777pgu.67.2023.03.12.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:37 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Douglas Anderson <dianders@chromium.org>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/13] drm/msm/a6xx: Move ioremap out of hw_init path
Date:   Sun, 12 Mar 2023 13:41:33 -0700
Message-Id: <20230312204150.1353517-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
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

