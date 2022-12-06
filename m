Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49800644C68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLFTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLFTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:21:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F63FB9B;
        Tue,  6 Dec 2022 11:21:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so4726572pjr.3;
        Tue, 06 Dec 2022 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCOE6UB3AU4sZjM0eLrxIRHE8DSLTlCxmBapLp+bPNQ=;
        b=oxisaQx/rtHyRTCMpb85wCfSx3JaiXt6gpFSAXSp4FBtH8KRxOuGMFodPB4T4nmghi
         LcuqFFHpATlLWmrV7wfOj+JZrOaYqN7hKH40bPzvwfkj09li3lm2tueUfFt/orlTAFyT
         tvxrbkSNTTXmQ/0GakqDsx0uzmMHOh07GiNu540gt6qTrdXvItuM50ztfPXxxZBhCkMQ
         phB/7HgkIHCFtm2GWm9HjrDIrNaywELLXZVvacLeV4cp2oAz4NCBlxWaPI4ynblR3n2q
         GsIfFyt8NS6Q7XBycZrQLky8jXgBpCr0adp6/sflDfVKMoDMgF30XtMMM6BRZIWBfDLA
         hbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCOE6UB3AU4sZjM0eLrxIRHE8DSLTlCxmBapLp+bPNQ=;
        b=b2Jn8icqej4Hj2I2j5r1Zv6sDLjpk5ZFyAkAu1CKSarZV7crQKTow7L6qHkB/pxosg
         Pzlf6dnNajyXGQofHW7oruq/qTf2LH5V65vw+wYB7SUuz4CMTQQ8S4AS2rVnIhmq0p40
         47xv+iJLGbQvUMdchO3X5bTPcplvRa/yhkjw5IdDLzm7NMX/94nEe3E4tiMbJ9dTp97S
         1XRApMkGxV5Z4BrFzASLXvfQ3yBwS4NG28aEm2WZ2PPgHWEBA6hp0wqp++vXZd1NMTX2
         LXpM7NxigchFwNIQ3uxHd85GbVALKt9jqdSaZLS/Ss/MwOrkDuwTldBExU7tQWCsSWYl
         3oxQ==
X-Gm-Message-State: ANoB5plU2ZYzAAAVk8ln4uLnt+VFwTTLGmVzJ0jdbjIP8y/YQk7/vxX2
        GeA5IgJgP1dneuXBp5HwxJg=
X-Google-Smtp-Source: AA0mqf6exKLZJ3n5EhVh3nDm8ZR2z+CSHRWSi0xA8aPelGwpxWfZfGSsbERAoO8DlqExqBSnR0M+ig==
X-Received: by 2002:a17:902:f7ca:b0:189:b203:9e2f with SMTP id h10-20020a170902f7ca00b00189b2039e2fmr382970plw.56.1670354482458;
        Tue, 06 Dec 2022 11:21:22 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id v25-20020a634659000000b00473c36ea150sm5434632pgk.92.2022.12.06.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:21:21 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Chia-I Wu <olvaffe@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Add MSM_SUBMIT_BO_NO_IMPLICIT
Date:   Tue,  6 Dec 2022 11:21:23 -0800
Message-Id: <20221206192123.661448-1-robdclark@gmail.com>
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

In cases where implicit sync is used, it is still useful (for things
like sub-allocation, etc) to allow userspace to opt-out of implicit
sync on per-BO basis.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c        |  3 ++-
 drivers/gpu/drm/msm/msm_gem_submit.c | 11 +++++++++++
 include/uapi/drm/msm_drm.h           |  4 +++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 017a512982a2..e0e1199a822f 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -45,9 +45,10 @@
  * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
  * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
  * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
+ * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	9
+#define MSM_VERSION_MINOR	10
 #define MSM_VERSION_PATCHLEVEL	0
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index eb3536e3d66a..8bad07a04f85 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -334,9 +334,20 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 		if (ret)
 			return ret;
 
+		/* If userspace has determined that explicit fencing is
+		 * used, it can disable implicit sync on the entire
+		 * submit:
+		 */
 		if (no_implicit)
 			continue;
 
+		/* Otherwise userspace can ask for implicit sync to be
+		 * disabled on specific buffers.  This is useful for internal
+		 * usermode driver managed buffers, suballocation, etc.
+		 */
+		if (submit->bos[i].flags & MSM_SUBMIT_BO_NO_IMPLICIT)
+			continue;
+
 		ret = drm_sched_job_add_implicit_dependencies(&submit->base,
 							      obj,
 							      write);
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index f54b48ef6a2d..329100016e7c 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -222,10 +222,12 @@ struct drm_msm_gem_submit_cmd {
 #define MSM_SUBMIT_BO_READ             0x0001
 #define MSM_SUBMIT_BO_WRITE            0x0002
 #define MSM_SUBMIT_BO_DUMP             0x0004
+#define MSM_SUBMIT_BO_NO_IMPLICIT      0x0008
 
 #define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
 					MSM_SUBMIT_BO_WRITE | \
-					MSM_SUBMIT_BO_DUMP)
+					MSM_SUBMIT_BO_DUMP | \
+					MSM_SUBMIT_BO_NO_IMPLICIT)
 
 struct drm_msm_gem_submit_bo {
 	__u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
-- 
2.38.1

