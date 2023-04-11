Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D651F6DE7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDKW63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDKW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:58:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1322D63;
        Tue, 11 Apr 2023 15:58:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q2so14282340pll.7;
        Tue, 11 Apr 2023 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayU9yxyS63GOBM6CjiiY8bjBwmD9ZnU8dUfgj0+el7c=;
        b=VHMVks6NvFNA2/mOKdow01yeN+D6kqEpVibmOQv1tGWfHDT2poOsnsKr7eTZ7pHDvD
         DJY9EFVJaynf/OAjF0rD5h8BRBfY/Nw/R0RnOGYwnDSaz/5zPj5ZEl+RUp8zC7F/fEhs
         x0H7SQF0GF6TFrorb4/00O1gYYJ8B4QdsyIE86JVC6N4ywG1DB2S9J1uP22usScfEJWf
         1dNBvgS2a9bRLfmrPzRWj1BWlbBEs13UEMUl1WBPeS69+JumPmo5V6CEg2Qnaj4jlk+n
         Y0Phzi7RUHipcV/fBRkNwMFXd7mbOCJBMgHT1G4kHzuXt4KaVnrvFYoi7YV7MCNfwHc8
         hZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayU9yxyS63GOBM6CjiiY8bjBwmD9ZnU8dUfgj0+el7c=;
        b=rq2cTS6GT3X9uGNSzoxUTbQYx9RmQ1apTlo1JEXNNKTwjMqX8fP17ZM0OwmetoYt12
         h9Gx1z3n4R9xLTkLeQ5nMUqdpYTee6gjS04DAaCNKHRr6tOH1wb7S5Rd7B6tvSMJYSpS
         2Z8i6zMbQq8KYeABgfNJjfu75F+sncPV7efZyIsgSoGAawsAcA5X7g7zf3z7u0HTrJIS
         rIISNhpMRtput+p8Id0/Ine41KYxkBGn39ubHfjz6FG/L1JZuMjODFpz1G+MFtiF/o1g
         Vl7MDIioqIDfdlRtMWOpkEWXEGRKcwZNiSb5+/vOtPR7Ksv+5CuDGPMvSvh3ZugL6HfY
         moHQ==
X-Gm-Message-State: AAQBX9c0oBWDZCtPAntrid9eZP//KyFR0ju8utc4Pmxnqnk59Lo5jceH
        NtuFtDNOPFopSxJteDXXedo=
X-Google-Smtp-Source: AKy350afowYNd7r6IlQY5UFSM5Gy2/2tZFNE2WZ/1NW240MZr8PnH0GSNz7NIR7TH3mphaC5yTZvWQ==
X-Received: by 2002:a17:903:11c9:b0:1a5:a1e:6f9e with SMTP id q9-20020a17090311c900b001a50a1e6f9emr142303plh.15.1681253881277;
        Tue, 11 Apr 2023 15:58:01 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b00196807b5189sm10087161plp.292.2023.04.11.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:58:00 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 7/7] drm/msm: Add memory stats to fdinfo
Date:   Tue, 11 Apr 2023 15:56:12 -0700
Message-Id: <20230411225725.2032862-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411225725.2032862-1-robdclark@gmail.com>
References: <20230411225725.2032862-1-robdclark@gmail.com>
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

Use the new helper to export stats about memory usage.

v2: Drop unintended hunk
v3: Rebase

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index db6c4e281d75..c32264234ea1 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1096,6 +1096,20 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	return ret;
 }
 
+static enum drm_gem_object_status msm_gem_status(struct drm_gem_object *obj)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	enum drm_gem_object_status status = 0;
+
+	if (msm_obj->pages)
+		status |= DRM_GEM_OBJECT_RESIDENT;
+
+	if (msm_obj->madv == MSM_MADV_DONTNEED)
+		status |= DRM_GEM_OBJECT_PURGEABLE;
+
+	return status;
+}
+
 static const struct vm_operations_struct vm_ops = {
 	.fault = msm_gem_fault,
 	.open = drm_gem_vm_open,
@@ -1110,6 +1124,7 @@ static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.vmap = msm_gem_prime_vmap,
 	.vunmap = msm_gem_prime_vunmap,
 	.mmap = msm_gem_object_mmap,
+	.status = msm_gem_status,
 	.vm_ops = &vm_ops,
 };
 
-- 
2.39.2

