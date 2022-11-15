Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352B629F39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiKOQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiKOQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:41:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EC2D764;
        Tue, 15 Nov 2022 08:41:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so13764259pgh.4;
        Tue, 15 Nov 2022 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Vs3kQEHL0oTrTy5MR4m4bXaJPdcU0IKOmmtigZy0RQ=;
        b=j1uDJjjED/dprSEJEMlZ1yfYS2WQkBO0HzjJ8V6lD93UppX4bhNioJRu/1W1T22Nma
         w6kGSPxjxKRdya3t1xIGPPkhmONCkzLKlXjQNkkqBk6Ps0/eR1H4zpabOP2tJ4ZxbVo6
         37ZEz5k6P/3ar+DOP7F735TH8riybkRhQOEE4916Rja/Tifsq2caYJG9Wx40EoNQcK2a
         PAqV40oRIg+nuIX2CUSA+jeZOZjqBdqE2tVBl/b7IvDvWSnXBl+1/WRyIAQnnF4Hrc2k
         fTAYMvbufVg14/I/hH4b3FdFAcErksij/c7UmLsnVi8znWi5pXJcVxqt9kIlnQoHVL/e
         q7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Vs3kQEHL0oTrTy5MR4m4bXaJPdcU0IKOmmtigZy0RQ=;
        b=OZk5dWYSZjUGpYTAf4dLkuSCB5VDiRyy2MgKgJUT1hxPFPVFJw7mO2GoOQ8Qt151/F
         Kb5JZX1N8LyXQS05YoJH8PMQ97xlMqtk5ydyMdKOjLYyxljZ6BkAwHiEo/BWxj1hwq1l
         fb0barnZt503ehUvto0jwpdSF7maTQWsb3Hj43kzaPxFY7z1IPcMZL/Tfx4XcXU6O2J9
         4woT5iHB2kdAe4+zSmYXxG5SmSzxaY5TjZZSmko5OwHzLhix0v+OslpN2Fl5ku5RDxbp
         9+/0UTALnb08eoPhleSoq8q5rFshxeQ5Y1YFNS9AOp5bz5Eeh2GjqJBJTVOeNrOYFwwV
         KepQ==
X-Gm-Message-State: ANoB5plgCdBGuhOBahPvMA4L+Uj/PvxSVgQvKPum8Hnrpblwe63DP7rK
        FgA0qd6+7FeCvkCm3lFtWtg=
X-Google-Smtp-Source: AA0mqf7djbrriQQMP2iaGU82u/FSoTUimc0HOuiGEe1GjVChTbR5YA+6lXVDqIK3EDM8kWDtP5UF0Q==
X-Received: by 2002:a63:4d1d:0:b0:44b:d27e:520d with SMTP id a29-20020a634d1d000000b0044bd27e520dmr16272720pgb.124.1668530508704;
        Tue, 15 Nov 2022 08:41:48 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b00186f608c543sm10211678plf.304.2022.11.15.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:41:48 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Enable unpin/eviction by default
Date:   Tue, 15 Nov 2022 08:42:12 -0800
Message-Id: <20221115164212.1619306-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

We've had this enabled in the CrOS kernel for a while now without seeing
issues, so let's flip the switch upstream now.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 8f83454ceedf..f6de1bd9d2e1 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -16,7 +16,7 @@
 /* Default disabled for now until it has some more testing on the different
  * iommu combinations that can be paired with the driver:
  */
-static bool enable_eviction = false;
+static bool enable_eviction = true;
 MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
 module_param(enable_eviction, bool, 0600);
 
-- 
2.38.1

