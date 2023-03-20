Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551A6C1512
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCTOom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjCTOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E6AD22;
        Mon, 20 Mar 2023 07:44:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so16743708pjt.2;
        Mon, 20 Mar 2023 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOKgIqKype2FtcfBEs8DzVnGdB8jDwzY52kLns1gHeQ=;
        b=VnF+6G2rX3V3uiMnbJNUCShKHEg3qSXYFZW2BadyVGNW0EATEl8lpaMebXjsuGk82j
         6uNC/eXNRKXC6LHgJEGqwFVgVpKr8Ft2sQSWlWoJNn2mcPP6CjiXAakf5VgjfGk741GP
         sIHFQgcHBE6gPMKsa9eAIRJpEMN/RO4X6UIOevibBEhmVCdoZdol18YJKBu4jexGjC/y
         xW2lLDNDlqC2S0GLUL1feKz6u5E6vwZDYvzQtXJzzQd8X1JJtWfI4To24/vDTwEUXx1m
         F3Vs7SviqMHjK5T10Q782LncWJWcxm7mshYIhZNh48C6PEae62pRbnFZfPIvZvxobGNO
         Zrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOKgIqKype2FtcfBEs8DzVnGdB8jDwzY52kLns1gHeQ=;
        b=pi5qHJ7SjUuUHV7uDaBhNVfXi9oBe4l/WhLwJKLH9IJJbrzhjhxnvl4Ldbc5ZIUIha
         ygAck0Yw9TvKkYRPonfFYrLX482BhupzwffIG+ouG33UhpzbA3q9G0nrsaMXKaOH4LDm
         GygrmLrtD7bFkmKlDUqWRJAyICU7gN03YbvG5tjRLhCXWrIvTdHo/hzhtXZDELLBokM5
         Ziao/0n5+gfVz41UEXx3yM72fQmmcGw6k9zGoabNriXVRBrmjAJM8PWx45Aov2/GWIl/
         J7+OJwA9c28Z4WoYtsdZUiwdKYVV+GnlMiS5NE8G8+R0IILiGJSvAplga1Wa+z94W1Gx
         4euQ==
X-Gm-Message-State: AO0yUKUYmOgai/ksN/n9YzU5wyuNM7Vr0HwV81XtQmWBLUi/H2xL5Nat
        pLQktBieAi1moKoka0C8EsE=
X-Google-Smtp-Source: AK7set87GLedaxfP6MTlGWAVIi2V/FMub1LUUnVtxXaItSj0lTXwOwSmnXTsGsDYl2P+bImVpBwAtQ==
X-Received: by 2002:a05:6a20:bb12:b0:da:24f5:ff25 with SMTP id fc18-20020a056a20bb1200b000da24f5ff25mr1307876pzb.48.1679323474431;
        Mon, 20 Mar 2023 07:44:34 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id c26-20020a631c5a000000b00507249cde91sm6186039pgm.91.2023.03.20.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/23] drm/msm: Move submit bo flags update from obj lock
Date:   Mon, 20 Mar 2023 07:43:24 -0700
Message-Id: <20230320144356.803762-3-robdclark@gmail.com>
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

The flags are only accessed (1) when submit is constructed, before
enqueuing to gpu sched (ie. when still visible to only the task calling
the submit ioctl), (2) here, where we own a reference to the submit and
are serialized on the gpu sched thread, and (3) after the submit is
retired and last reference is dropped, which is serialized on the
submit's reference count.  Hence locking is unneeded here.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index a62b45e5a8c3..a80447c8764e 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -26,8 +26,8 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 		msm_gem_lock(obj);
 		msm_gem_unpin_vma_fenced(submit->bos[i].vma, fctx);
 		msm_gem_unpin_locked(obj);
-		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
 		msm_gem_unlock(obj);
+		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
 	}
 
 	/* TODO move submit path over to using a per-ring lock.. */
-- 
2.39.2

