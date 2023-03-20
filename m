Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62796C1553
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjCTOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjCTOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8EDBE6;
        Mon, 20 Mar 2023 07:44:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw3so12663328plb.6;
        Mon, 20 Mar 2023 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjYkvhqut592WuSff3dyR3ovhFafDwjiBPIXBsiPTHA=;
        b=cOHoQlJ0xxnowDvRyQrlnClAHszOToY1+vnIF0VIIDgXA0RnF2Cl/GALLiqwt6XHAT
         y/tzmqUYHn53FusOSShO8LGtYTuDrh8DpRq9qd/Nl4y1IlQwOqIna913gt16RmzfHQZ9
         dZokgnhA/xss3xcfz35c3fKoCxs4ER9SNrjg6JXx1uXkxJNtRp7vYXmZSgx70JronGD6
         x0eXU6uMwh8V1hK9cpM87TFtDBhc/dbqaNahA2gbQYZ2ZhqNsT7TEC/ZfzmbYa2PqgOn
         GR8DiN6vcuIOnfYIrTW8fveCVpMVqlYu3eAeVKXbW3jBGGD4yoY5LJnyDt7t6GQF/mqx
         peUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjYkvhqut592WuSff3dyR3ovhFafDwjiBPIXBsiPTHA=;
        b=t+KP6zp9Lg1lF6b90wAYzUoNWR4q5WXdo29VpU+5vXjULDFBe/Fn8qPBnrd1+Iaa0T
         +z4DGricViep9YmHnlWbTmeQq3fUmJio8P2YN2/00ihZJOAMKvnKfoxteccnqxw9A1A1
         H8gthmY910ixicZTz1Inhd3SQI6d+AuWJNfuAYL9yMEObjJavDEvoNB50kvZ5XlDiNRi
         he0ijBwMD/98IpnZXD4UP4Hr+IjUrPjZQcySKjC3bKckcgzhJiMYGsHEdas4GysmJk+H
         dck9Qotm7ypxCyB98zDxO4T8UhOZkdHYbQFwH7uOe3GnrVhJG+LC7mYP5mdNgJULFVPv
         9lkA==
X-Gm-Message-State: AO0yUKUIEFBe5nVqwbXMd8hEAxy+wf+P5OwQH5rg2LuvNjCVjMihxB7Y
        mxLC/6/x9R6mFMeDtPgL/H0=
X-Google-Smtp-Source: AK7set8QgTzNPHFdn6ePXThhc0O7gvvVmy/zOlqo83fcmxzg8pOx366lz1ZPhithPcnrmPwO40UgtQ==
X-Received: by 2002:a17:903:186:b0:19e:6d83:8277 with SMTP id z6-20020a170903018600b0019e6d838277mr21841308plg.51.1679323483402;
        Mon, 20 Mar 2023 07:44:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902728300b0019c32968271sm6809626pll.11.2023.03.20.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:43 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/23] drm/msm/gem: Move update_lru()
Date:   Mon, 20 Mar 2023 07:43:29 -0700
Message-Id: <20230320144356.803762-8-robdclark@gmail.com>
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

Just code-motion.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 46 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 009a34b3a49b..c97dddf3e2f2 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -19,8 +19,6 @@
 #include "msm_gpu.h"
 #include "msm_mmu.h"
 
-static void update_lru(struct drm_gem_object *obj);
-
 static dma_addr_t physaddr(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
@@ -63,6 +61,28 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 	dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 }
 
+static void update_lru(struct drm_gem_object *obj)
+{
+	struct msm_drm_private *priv = obj->dev->dev_private;
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+
+	msm_gem_assert_locked(&msm_obj->base);
+
+	if (!msm_obj->pages) {
+		GEM_WARN_ON(msm_obj->pin_count);
+
+		drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
+	} else if (msm_obj->pin_count) {
+		drm_gem_lru_move_tail(&priv->lru.pinned, obj);
+	} else if (msm_obj->madv == MSM_MADV_WILLNEED) {
+		drm_gem_lru_move_tail(&priv->lru.willneed, obj);
+	} else {
+		GEM_WARN_ON(msm_obj->madv != MSM_MADV_DONTNEED);
+
+		drm_gem_lru_move_tail(&priv->lru.dontneed, obj);
+	}
+}
+
 /* allocate pages from VRAM carveout, used when no IOMMU: */
 static struct page **get_pages_vram(struct drm_gem_object *obj, int npages)
 {
@@ -804,28 +824,6 @@ void msm_gem_vunmap(struct drm_gem_object *obj)
 	msm_obj->vaddr = NULL;
 }
 
-static void update_lru(struct drm_gem_object *obj)
-{
-	struct msm_drm_private *priv = obj->dev->dev_private;
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-
-	msm_gem_assert_locked(&msm_obj->base);
-
-	if (!msm_obj->pages) {
-		GEM_WARN_ON(msm_obj->pin_count);
-
-		drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
-	} else if (msm_obj->pin_count) {
-		drm_gem_lru_move_tail(&priv->lru.pinned, obj);
-	} else if (msm_obj->madv == MSM_MADV_WILLNEED) {
-		drm_gem_lru_move_tail(&priv->lru.willneed, obj);
-	} else {
-		GEM_WARN_ON(msm_obj->madv != MSM_MADV_DONTNEED);
-
-		drm_gem_lru_move_tail(&priv->lru.dontneed, obj);
-	}
-}
-
 bool msm_gem_active(struct drm_gem_object *obj)
 {
 	msm_gem_assert_locked(obj);
-- 
2.39.2

