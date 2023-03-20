Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23F6C1544
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCTOpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjCTOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4EEF87;
        Mon, 20 Mar 2023 07:44:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so16726690pjv.5;
        Mon, 20 Mar 2023 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmpOBRevcWufl9+ZPvYmrN7HY3DEyxJ7D+2z8txKnGY=;
        b=QJDUUDwrP9t1D0nGIJK5gSCB/5iP/M2PNO7hkTIuenIDr5wOAdLaLWvmdhSrAoP/Zn
         B0qM1MmtBAJr1CyCWUOKfjFjWfXiPohphc2rf4b+HHRa3dnAPQaj2dN5SytZOLW1aBjm
         wU7c8/Rm1GCxHMXyEgPQUNkZ0f7Qm514ozSU9oM0jiEtQd0nParCwFrrGGCOhuKTXOEv
         qbGIpvuvl0cREN8lGQyEnOoCu+t6B0413wo/TgUKr2RJMEJhpIoCyG/4vn19q+rnv8IP
         ybxZ27mbTr37mHchmTQe59dNGfiGprzmckYERDAUkWEsIp34IcYsjDydR3Yyvk6NWB/X
         +qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmpOBRevcWufl9+ZPvYmrN7HY3DEyxJ7D+2z8txKnGY=;
        b=G4RfVGTfD8f9DRuuIJzOE5V+1MDZa+8+MudPXrctX6fVELajKiuzN1GG9kI2cAVlKE
         n7602BOJQdG367k78zi5vfSQ2d/d4y+UpgB6xkIp3id3+REr/drbKN4b+68jZrCvS0ZY
         wb5Fjqyk09MD2kWiI3edw5bEGaO63yJ32uE5zu8V3rNjVT1K/DP5O1IvxBjzS6WWPE/V
         7kXxBvHFtrT5vRAetbDwlAZR7AGvP+4bgbN9XmL2c7VD7ufBEi+2q8RIpV3gz9pwQEEA
         oCRUB+ShqQo4B+0R4hjr2K2J1jaiVC5KGZ7KrRKMOnX6Sx2F6FMqllt0c8xdOKRFXDUs
         kvRA==
X-Gm-Message-State: AO0yUKUlRlrYN67tBOvQeFAPF/P1zpvzKx4ePtE1CIxEnJtZK/J4QAD6
        HCRHwFLuXmNLXaCS1hWmxVw=
X-Google-Smtp-Source: AK7set8xl+EwAB385uyueRZZJelsCmcMVEJo9Hgr+BjmAy9/CkKpfcsmJ83hqOSj+Zn0Gh1/n/okSA==
X-Received: by 2002:a05:6a20:7a81:b0:d9:240c:acdd with SMTP id u1-20020a056a207a8100b000d9240cacddmr5912063pzh.40.1679323479922;
        Mon, 20 Mar 2023 07:44:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id d22-20020a63fd16000000b00502f9fba637sm6180061pgh.68.2023.03.20.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:39 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/23] drm/msm/gem: Simplify vmap vs LRU tracking
Date:   Mon, 20 Mar 2023 07:43:27 -0700
Message-Id: <20230320144356.803762-6-robdclark@gmail.com>
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

vmap'ing is just pinning in disguise.  So treat it as such and simplify
the LRU tracking.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 6734aecf0703..009a34b3a49b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -626,6 +626,7 @@ int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	struct page **pages;
 	int ret = 0;
 
 	msm_gem_assert_locked(obj);
@@ -639,6 +640,10 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 		return ERR_PTR(-EBUSY);
 	}
 
+	pages = msm_gem_pin_pages_locked(obj);
+	if (IS_ERR(pages))
+		return ERR_CAST(pages);
+
 	/* increment vmap_count *before* vmap() call, so shrinker can
 	 * check vmap_count (is_vunmapable()) outside of msm_obj lock.
 	 * This guarantees that we won't try to msm_gem_vunmap() this
@@ -648,25 +653,19 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 	msm_obj->vmap_count++;
 
 	if (!msm_obj->vaddr) {
-		struct page **pages = get_pages(obj);
-		if (IS_ERR(pages)) {
-			ret = PTR_ERR(pages);
-			goto fail;
-		}
 		msm_obj->vaddr = vmap(pages, obj->size >> PAGE_SHIFT,
 				VM_MAP, msm_gem_pgprot(msm_obj, PAGE_KERNEL));
 		if (msm_obj->vaddr == NULL) {
 			ret = -ENOMEM;
 			goto fail;
 		}
-
-		update_lru(obj);
 	}
 
 	return msm_obj->vaddr;
 
 fail:
 	msm_obj->vmap_count--;
+	msm_gem_unpin_locked(obj);
 	return ERR_PTR(ret);
 }
 
@@ -705,6 +704,7 @@ void msm_gem_put_vaddr_locked(struct drm_gem_object *obj)
 	GEM_WARN_ON(msm_obj->vmap_count < 1);
 
 	msm_obj->vmap_count--;
+	msm_gem_unpin_locked(obj);
 }
 
 void msm_gem_put_vaddr(struct drm_gem_object *obj)
@@ -813,10 +813,9 @@ static void update_lru(struct drm_gem_object *obj)
 
 	if (!msm_obj->pages) {
 		GEM_WARN_ON(msm_obj->pin_count);
-		GEM_WARN_ON(msm_obj->vmap_count);
 
 		drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
-	} else if (msm_obj->pin_count || msm_obj->vmap_count) {
+	} else if (msm_obj->pin_count) {
 		drm_gem_lru_move_tail(&priv->lru.pinned, obj);
 	} else if (msm_obj->madv == MSM_MADV_WILLNEED) {
 		drm_gem_lru_move_tail(&priv->lru.willneed, obj);
-- 
2.39.2

