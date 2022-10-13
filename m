Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BFD5FE5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJMWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJMWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:55:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EA7F276;
        Thu, 13 Oct 2022 15:55:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gf8so3284600pjb.5;
        Thu, 13 Oct 2022 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW+J4iogIz8BUKDsm9kkznHVxGsNPGpjXWMAol29GNU=;
        b=XSCBTmcnlQx1gymTBIQTpPqTF9MRbmCYxJDXRbeapNDy77zubrwIRhYDIDpzfpEvSb
         JbgQZlQAPMMy+TcJ0Zl9dcDJyp4wBOy6ZJqfjOA3FnvkxD731zzmVy4/mGVQCfMCpGnS
         jWs9+9iTVPM3M0Gjz1Ydn12Ui/269RbphwybvVPLUj3MWc4Cm/yiU36wNPvVuuY3Xbh0
         6dsN5JSmuA41ErGiPLn0/2KuYyPWFD9xSRe3f/fLf/6WNK3KHliihx+S/XH3EC4sQAo7
         ngq1+APG63K7w9KOU5Tb16IKUhDJP8bbIr4HU5FM2xr6Da1P3l8L7eWhu8Q7hTJYPPT1
         TMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW+J4iogIz8BUKDsm9kkznHVxGsNPGpjXWMAol29GNU=;
        b=G/ymWqHuLgfGApp4BVZZ2eeHqxJn0Pgg9fMnONabITi/mEbzJQen5rt93z5OBhSh4a
         nT6TzTAQtPf9wQryEP60RIjy6jKOo1S6+HGhkrApt//6gKKd2LpGIl5bQCvTarg9a3fs
         t5xGTnbif42nItgcqUAQbgJywKdWT6+iwiUlbBLZduN9QC3z0CzBI+hrpkneQkc0EG75
         GrJFLnoH96u3Leo/PI/xx1VrGNKgeUagqLP0EMs5mpHXgcAFsNXxc1wtUzo6nqA6sfci
         1ZXyffUHYVHH81Kf4Up1RR3NAEAztBSR06EXFnTji11lXaC6tVr1N+bIvmWIZ6dPebzx
         X1PA==
X-Gm-Message-State: ACrzQf0Qcdxkmha5yvfA3BL/12yZwA0Q7OvZW86Pp7esF/Ji+wh3/rSh
        cf4FTsRCR3fE9VQe+tw6LSY=
X-Google-Smtp-Source: AMsMyM4XnbS5q2Gnjr9/xh7Q1T5xD9rvWp88uDEg3OCjFW5BXDfhS6gtejtBN21UH89PxfqvVHbiew==
X-Received: by 2002:a17:902:e40a:b0:183:f90:2fb with SMTP id m10-20020a170902e40a00b001830f9002fbmr2311120ple.28.1665701715304;
        Thu, 13 Oct 2022 15:55:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0016dbdf7b97bsm325810plg.266.2022.10.13.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:55:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/msm/a6xx: Fix kvzalloc vs state_kcalloc usage
Date:   Thu, 13 Oct 2022 15:55:13 -0700
Message-Id: <20221013225520.371226-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013225520.371226-1-robdclark@gmail.com>
References: <20221013225520.371226-1-robdclark@gmail.com>
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

adreno_show_object() is a trap!  It will re-allocate the pointer it is
passed on first call, when the data is ascii85 encoded, using kvmalloc/
kvfree().  Which means the data *passed* to it must be kvmalloc'd, ie.
we cannot use the state_kcalloc() helper.

This partially reverts
ec8f1813bf8d ("drm/msm/a6xx: Replace kcalloc() with kvzalloc()"), but
fix the missing kvfree() to fix the memory leak that was present
previously.  And adds a warning comment.

Fixes: ec8f1813bf8d ("drm/msm/a6xx: Replace kcalloc() with kvzalloc()")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/20
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 11 ++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 3c112a6cc8a2..730355f9e2d4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -819,7 +819,7 @@ static struct msm_gpu_state_bo *a6xx_snapshot_gmu_bo(
 
 	snapshot->iova = bo->iova;
 	snapshot->size = bo->size;
-	snapshot->data = state_kcalloc(a6xx_state, 1, snapshot->size);
+	snapshot->data = kvzalloc(snapshot->size, GFP_KERNEL);
 	if (!snapshot->data)
 		return NULL;
 
@@ -1034,6 +1034,15 @@ static void a6xx_gpu_state_destroy(struct kref *kref)
 	struct a6xx_gpu_state *a6xx_state = container_of(state,
 			struct a6xx_gpu_state, base);
 
+	if (a6xx_state->gmu_log)
+		kvfree(a6xx_state->gmu_log->data);
+
+	if (a6xx_state->gmu_hfi)
+		kvfree(a6xx_state->gmu_hfi->data);
+
+	if (a6xx_state->gmu_debug)
+		kvfree(a6xx_state->gmu_debug->data);
+
 	list_for_each_entry_safe(obj, tmp, &a6xx_state->objs, node)
 		kvfree(obj);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 382fb7f9e497..5a0e8491cd3a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -729,7 +729,12 @@ static char *adreno_gpu_ascii85_encode(u32 *src, size_t len)
 	return buf;
 }
 
-/* len is expected to be in bytes */
+/* len is expected to be in bytes
+ *
+ * WARNING: *ptr should be allocated with kvmalloc or friends.  It can be free'd
+ * with kvfree() and replaced with a newly kvmalloc'd buffer on the first call
+ * when the unencoded raw data is encoded
+ */
 void adreno_show_object(struct drm_printer *p, void **ptr, int len,
 		bool *encoded)
 {
-- 
2.37.3

