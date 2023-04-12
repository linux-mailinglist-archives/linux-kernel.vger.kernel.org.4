Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C996E021A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLWoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDLWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:43:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B488A54;
        Wed, 12 Apr 2023 15:43:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso702339pjb.3;
        Wed, 12 Apr 2023 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681339418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayU9yxyS63GOBM6CjiiY8bjBwmD9ZnU8dUfgj0+el7c=;
        b=VfrlzRoNCK4XsqcugPJpoWdrroAMxteTFc/L6PQaqDod7DJXTTC5ZBLFbKWLVQXpp5
         RUxb3F3mYzwJrzNQTLRXXh9tB47WMMY4NE2xKUQ5mgqatwH0Z5mbhRxNqtFbgZrsIa9W
         wjCNuOGM/OGpJzmpIFik9KVsHBC6FROlCrPgABRalPKRP9i0BmoROJbW4WoE7LX+t70/
         2V4p47c/XDHyaMH0Gyo1OLT++OXCgld3H/afKxh8Piqwd2CwmEl1Zdzxl0qm63c/DOd0
         TVKYKfRQZavdBmIUkh9XNUh3ARrZlrd9sc3yfsuhxkebSRWsTlZOWuqjy5r2PZ9e/ASb
         Eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayU9yxyS63GOBM6CjiiY8bjBwmD9ZnU8dUfgj0+el7c=;
        b=W8GGHusgIzfwiZyTnO4ZU4Mu7WiYQmUTi7/AI6q8VQicow0+41bc3+vMx86rovh4SC
         U8kTR4KZEP67Gq8EgyGOqZYSS3xbGsNPdSgNdQMyhv7BQWFpY5h6d2KsGy5YfKZkvvUu
         SD8FWYQrXuPYieu7g0f6TfuywDoFZ7iqrksVNI3/rCs6LCmLaHZw7bB8lczr4jXywawb
         SqB3abp1NWNNi38QelT6ZME1C6ZAuiDOyXeXw8AhZ0pcnKNYjA/EH3/OHNlpHsqNJl6H
         lgclF3iP4fErxyHB7bf1iDh+MenSGhmJxfqRJ5S0cxt7ENJF3cf8/Jd5tvRFwUaP/vUa
         fuPw==
X-Gm-Message-State: AAQBX9cEGx/UeJC8YXqCUIaeRnoJVg0ZdeysqUrsbBQxBb37OJpaEQcO
        yW4hPAVcIkMutyhl3p0+VfUewQg01HQ=
X-Google-Smtp-Source: AKy350ayS5D/zHRR78ThM4V0cSLwnHYLRtGPjJA3NJ3nigkuqTP4ZO/iq+VDPy3OWnt61WTBYVL0aw==
X-Received: by 2002:a17:90a:440d:b0:246:e9ab:aca5 with SMTP id s13-20020a17090a440d00b00246e9abaca5mr6823525pjg.18.1681339418302;
        Wed, 12 Apr 2023 15:43:38 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001a183ade911sm103481plt.56.2023.04.12.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:43:38 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] drm/msm: Add memory stats to fdinfo
Date:   Wed, 12 Apr 2023 15:42:58 -0700
Message-Id: <20230412224311.23511-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412224311.23511-1-robdclark@gmail.com>
References: <20230412224311.23511-1-robdclark@gmail.com>
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

