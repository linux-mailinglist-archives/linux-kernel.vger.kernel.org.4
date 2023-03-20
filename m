Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2376C1558
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCTOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCTOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734D10405;
        Mon, 20 Mar 2023 07:44:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z18so6709253pgj.13;
        Mon, 20 Mar 2023 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Xvkkg7F6CjyOF2RZo8Gtbu7JFTSy/bgLszOXTif/c=;
        b=pdh6pDbj0hMlQMJiqcjb8EcHHB++Bz4iZs1fWn8cufOZ+Nlx3Cw+6HTaCNHQc1riJo
         sNuYVoJZKGIWIeMkxx9NXtGIedo/FV+PKDgDHWaf9G0Teyo5+mk7ELb+tQFBYD1G0S21
         0PtNuq9gBlinRoOXPX9RrFMMstWiCfJbX6w0UiLfyeU6VyzeB4va8oEX0kp4G/PqgrZ4
         J8x7zIf81il9FWDLwkwoPzsnDUwEcI479IVGKAZjOeVZVZk4yNQNiDf7cUZrYqgllCFZ
         rRGRxpH+E0sP+A0ffVoJH4/hiO7565ux39p3UDwlawoDk1SaGvLvjUCn4t/eGacpTtyc
         c0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Xvkkg7F6CjyOF2RZo8Gtbu7JFTSy/bgLszOXTif/c=;
        b=7+Qhj1vSKnOh9qzyJAuKL3aSa4SXi12ShCNe1fQKfCAOdCj0TzckLX37agv7svEKna
         Fj8SANYxyCkcCtS5mpO52l+f1hdlSBVsT/PEFai8K0yZKsk2lFq/1o6lSzDlIA+ZNhY/
         iAYpW7A+y8pT98r19jyNBXDxoZD9NWvkzoski3gtJoxz+BX8sH/Zrx4gHEkSoX9PmHUx
         IwD96l2dh8Xrdl73SB0dDLfIMQ6ppJov1gTiP4sKkSAj5mkXeS+Y5JAaSD09r6zWfbSh
         Uv5bqBEcIsGsOgYZSGjYB+x2igwFkBizf693qUMBLPgoElggdwIx8qzpiNQruoxu9SEV
         onQA==
X-Gm-Message-State: AO0yUKWSEnuaTUa6DdHsztDNp4P0r0CqEUKI2HYgbuvt+irUnVAbQBUE
        iVuIoxZb4357KQvUOjxKUAI=
X-Google-Smtp-Source: AK7set8KWfMWUfN/rUSfAdvgv538dmuC8YG9xJe+nc38O3y7lCz5M7md+3TF5MvUHCrG2tMwgVLAcQ==
X-Received: by 2002:aa7:9f91:0:b0:627:fc31:1de with SMTP id z17-20020aa79f91000000b00627fc3101demr3121841pfr.7.1679323490696;
        Mon, 20 Mar 2023 07:44:50 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id v22-20020a62a516000000b0058bc7453285sm6389779pfm.217.2023.03.20.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/23] drm/msm: Use idr_preload()
Date:   Mon, 20 Mar 2023 07:43:33 -0700
Message-Id: <20230320144356.803762-12-robdclark@gmail.com>
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

Avoid allocation under idr_lock, to prevent deadlock against the
job_free() path (which runs on same thread as job_run(), which makes
it also part of the fence-signaling path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index b9d81e5acb42..0ab62cb4ed69 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -882,6 +882,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	submit->nr_cmds = i;
 
+	idr_preload(GFP_KERNEL);
+
 	spin_lock(&queue->idr_lock);
 
 	/*
@@ -893,6 +895,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
 			idr_find(&queue->fence_idr, args->fence)) {
 		spin_unlock(&queue->idr_lock);
+		idr_preload_end();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -910,7 +913,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		submit->fence_id = args->fence;
 		ret = idr_alloc_u32(&queue->fence_idr, submit->user_fence,
 				    &submit->fence_id, submit->fence_id,
-				    GFP_KERNEL);
+				    GFP_NOWAIT);
 		/*
 		 * We've already validated that the fence_id slot is valid,
 		 * so if idr_alloc_u32 failed, it is a kernel bug
@@ -923,10 +926,11 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		 */
 		submit->fence_id = idr_alloc_cyclic(&queue->fence_idr,
 						    submit->user_fence, 1,
-						    INT_MAX, GFP_KERNEL);
+						    INT_MAX, GFP_NOWAIT);
 	}
 
 	spin_unlock(&queue->idr_lock);
+	idr_preload_end();
 
 	if (submit->fence_id < 0) {
 		ret = submit->fence_id;
-- 
2.39.2

