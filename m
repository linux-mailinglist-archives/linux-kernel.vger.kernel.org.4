Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CB66988E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBOXue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBOXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:50:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A92ED45;
        Wed, 15 Feb 2023 15:50:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r3so363428pfh.4;
        Wed, 15 Feb 2023 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeIoX4RDWl3f+nhG+Pkar8Woaq/FoxjOB1t6jgPazJQ=;
        b=l5qD+x9Nq6Q8eFXBnLD2JP5DpZJ5D0HO0afceUtRjxa8Z+s7yb/ay9AlicklsmlEEw
         3e4Rj36HY8jLFGQGubTa5jW8tNGAI0hR46V9Chl+bP0tALpancQEy8IHLrrcSKDtjIg2
         kd6Llo+VeClFPVTTcEKTtD2bMvCfInlONN/36JtjfpQbZ7BwFlCJCIR4rPy2hYbwUsZK
         zHBOTJlZm2GcXslUCSf4XusKH4awMsXWYun5YQ8smTpEXzovscwAWdc6PYw8DLjWoLIs
         aezpJuj+RbLreYYAy63wF/LsmoxdyWkKskghzUhBMuKDs2ueRq7s1huiAayMldfdHjZw
         N9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeIoX4RDWl3f+nhG+Pkar8Woaq/FoxjOB1t6jgPazJQ=;
        b=MLiU+8cjJoGqN7b7gBfX33RrBVYQQyQdXBy/5aL0k/i+eeg/8nJ2mWBdNJVlePEAyO
         m7gLQPYTmoDOrxAHdBleubqcsRA30GnaEEYmcWIZbEHOFKvnkbnnKL5o+LDIlhkwlXQy
         I+2/GNAtsW2MO2wxrYegJUiFAPaSIopFKhurNNASEzONhmcCKML2RGzTBxui6mIJ6jyS
         jUeTDyVv1fky9T0DWRlOui61OfRvF8RwLM+a0zOQDAJINRHl7Nydbq2h3B6gAnlmNDn3
         lCPo9jOQlREpU3Eiq0zkd0E0ZzSAKazukp9Zvm5UrWcJNKcRVE8jSn4yQoGvmAf2bdSh
         /XjQ==
X-Gm-Message-State: AO0yUKUaF3fp7PwrsOU3YVBOSd9WrU6a/ibiC9iuQcWlkOGHIYCgQ9X0
        YXcHaMiuLvr2ceCbevqN98Ve26p93S4=
X-Google-Smtp-Source: AK7set+S1yWm3qNcB1PUzuuK7xDX0SA6y0sMOop00NqJPMGuJW2NkOnni+n/RHRe/RWoADbNnOcE1A==
X-Received: by 2002:aa7:973d:0:b0:5a8:be36:65a8 with SMTP id k29-20020aa7973d000000b005a8be3665a8mr3307802pfg.27.1676505031706;
        Wed, 15 Feb 2023 15:50:31 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0058d8db0e4adsm12628278pfa.171.2023.02.15.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:50:31 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix potential invalid ptr free
Date:   Wed, 15 Feb 2023 15:50:48 -0800
Message-Id: <20230215235048.1166484-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
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

The error path cleanup expects that chain and syncobj are either NULL or
valid pointers.  But post_deps was not allocated with __GFP_ZERO.

Fixes: ab723b7a992a ("drm/msm: Add syncobj support.")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6503220e5a4b..e4d13540300e 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -640,8 +640,8 @@ static struct msm_submit_post_dep *msm_parse_post_deps(struct drm_device *dev,
 	int ret = 0;
 	uint32_t i, j;
 
-	post_deps = kmalloc_array(nr_syncobjs, sizeof(*post_deps),
-	                          GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY);
+	post_deps = kcalloc(nr_syncobjs, sizeof(*post_deps),
+			    GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY);
 	if (!post_deps)
 		return ERR_PTR(-ENOMEM);
 
@@ -656,7 +656,6 @@ static struct msm_submit_post_dep *msm_parse_post_deps(struct drm_device *dev,
 		}
 
 		post_deps[i].point = syncobj_desc.point;
-		post_deps[i].chain = NULL;
 
 		if (syncobj_desc.flags) {
 			ret = -EINVAL;
-- 
2.39.1

