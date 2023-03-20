Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306E6C1509
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCTOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjCTOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B14A27C;
        Mon, 20 Mar 2023 07:44:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u5so12652277plq.7;
        Mon, 20 Mar 2023 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMhzaRLYEghDDTaAukUOjdZ/Iik/E0y0uW4UbqJ2TqM=;
        b=GvrF+RNzmOBxQ+TqsOlzz04B7n9bV2JsKDO3Hw1WGk/9hFpeAK9/oUPYBYeyZwp1A7
         P7qgFFcG3rtmAU/CB/+CEBhNbJ8BvtmWkG4KDb8MKL02r2dVgp9qkNl+B3Jckp8alNa4
         naCbB7dsaLkwjhlxp5vfO4EygzOO9n9So/JPXF1e+xNRna5OiBZFge5FtMUcQcDeJvMg
         RoERbo3dnKPlpZYx39najggHt4DE+SCAEpkNbxGfsDRjC2DGMt3oQT9P/G8vhtTCl1Ih
         j/oKv2karvzTjIqcDZMQL02/OgaT8AtAYDloCRtsZ2c0xrNcT+5iylz+JmPUvm48SC5R
         Z0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMhzaRLYEghDDTaAukUOjdZ/Iik/E0y0uW4UbqJ2TqM=;
        b=4HgLxbjs/7wvnxf1HrspIPxQ3ALCEGbjr8kfDmCicA5MKKcDOrtyQnQlcxh8Yhnibk
         js2K2fz9N5+ietKsyJJsntlmtnD2/D/wv4e3messp8K9IBskwx08S+pk8n+9d6kKKtmk
         JSFHISKVEkcNEWrBk8/pImDNrz/fyxIDtZhLYcDESs+HTZAfnRblr4WpKmQNTxADmFfT
         BKmCRs84RKaYN9geQHH5ZaCAXMBxbiqL4OM2ret928OUIUtei9XATvMnEvgfZboAvUvA
         ZZzbw30kxnZ/To5ZNbWu3k+2BmfsvuPsfhCT17xAYKSWgC4Aq7kSvvPg1ilIYjbZeQ6D
         7o6Q==
X-Gm-Message-State: AO0yUKW2aJvC4xxxmWlRB0/n33fZfpifyMMVaLMq0WaQQdeVnndQZ5rr
        AvMCwXxI9/WkIukPpieZ4rs=
X-Google-Smtp-Source: AK7set9reBYzkV18C2W+fMnszNOS+kEcYoU78TDsvGmMYca/7z3m6tyw8LOHfjrSRkhQVTmz0g94Hw==
X-Received: by 2002:a17:902:e40d:b0:1a1:a996:feb3 with SMTP id m13-20020a170902e40d00b001a1a996feb3mr8424096ple.26.1679323470941;
        Mon, 20 Mar 2023 07:44:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b0019d397b0f18sm6776907plp.214.2023.03.20.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 00/23] drm/msm+PM+icc: Make job_run() reclaim-safe
Date:   Mon, 20 Mar 2023 07:43:22 -0700
Message-Id: <20230320144356.803762-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Inspired by https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
it seemed like a good idea to get rid of memory allocation in job_run()
fence signaling path, and use lockdep annotations to yell at us about
anything that could deadlock against shrinker/reclaim.  Anything that
can trigger reclaim, or block on any other thread that has triggered
reclaim, can block the GPU shrinker from releasing memory if it is
waiting the job to complete, causing deadlock.

The first patch pre-allocates the hw_fence, splitting allocation and
initialization, to avoid allocation in the job_run() path.  The next
eight decouple the obj lock from job_run(), as the obj lock is required
to pin/unpin backing pages (ie. holding an obj lock in job_run() could
deadlock the shrinker by blocking forward progress towards pinned buffers
becoming idle).  Followed by two so that we could idr_preload() in order
to avoid memory allocations under locks indirectly connected to the
shrinker path.

Next are three paths to decouple initialization (where allocations are
needed) from GPU runpm and devfreq, to avoid allocations in the fence
signaling path.  Followed by various PM devfreq/qos and interconnect
locking fixes to decouple initialization (allocation) from runtime.

And finally, the last patch is a modified version of danvet's patch to
add lockdep annotations to gpu scheduler, but does so conditionally so
that drivers can opt-in.

v2: Switch from embedding hw_fence in submit/job object to preallocating
    the hw_fence.  Rework "fenced unpin" locking to drop obj lock from
    fence signaling path (ie. the part that was still WIP in the first
    iteration of the patchset).  Adds the final patch to enable fence
    signaling annotations now that job_run() and job_free() are safe.
    The PM devfreq/QoS and interconnect patches are unchanged.

Rob Clark (23):
  drm/msm: Pre-allocate hw_fence
  drm/msm: Move submit bo flags update from obj lock
  drm/msm/gem: Tidy up VMA API
  drm/msm: Decouple vma tracking from obj lock
  drm/msm/gem: Simplify vmap vs LRU tracking
  drm/gem: Export drm_gem_lru_move_tail_locked()
  drm/msm/gem: Move update_lru()
  drm/msm/gem: Protect pin_count/madv by LRU lock
  drm/msm/gem: Avoid obj lock in job_run()
  drm/msm: Switch idr_lock to spinlock
  drm/msm: Use idr_preload()
  drm/msm/gpu: Move fw loading out of hw_init() path
  drm/msm/gpu: Move BO allocation out of hw_init
  drm/msm/a6xx: Move ioremap out of hw_init path
  PM / devfreq: Drop unneed locking to appease lockdep
  PM / devfreq: Teach lockdep about locking order
  PM / QoS: Fix constraints alloc vs reclaim locking
  PM / QoS: Decouple request alloc from dev_pm_qos_mtx
  PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
  soc: qcom: smd-rpm: Use GFP_ATOMIC in write path
  interconnect: Fix locking for runpm vs reclaim
  interconnect: Teach lockdep about icc_bw_lock order
  drm/sched: Add (optional) fence signaling annotation

 drivers/base/power/qos.c                   |  83 +++++++++---
 drivers/devfreq/devfreq.c                  |  52 ++++----
 drivers/gpu/drm/drm_gem.c                  |  11 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  48 ++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  18 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  46 ++++---
 drivers/gpu/drm/msm/adreno/adreno_device.c |   6 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   9 +-
 drivers/gpu/drm/msm/msm_drv.c              |   6 +-
 drivers/gpu/drm/msm/msm_fence.c            |  12 +-
 drivers/gpu/drm/msm/msm_fence.h            |   3 +-
 drivers/gpu/drm/msm/msm_gem.c              | 145 ++++++++++++++-------
 drivers/gpu/drm/msm/msm_gem.h              |  29 +++--
 drivers/gpu/drm/msm/msm_gem_submit.c       |  27 ++--
 drivers/gpu/drm/msm/msm_gem_vma.c          |  91 ++++++++++---
 drivers/gpu/drm/msm/msm_gpu.h              |   8 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c       |   9 +-
 drivers/gpu/drm/msm/msm_submitqueue.c      |   2 +-
 drivers/gpu/drm/scheduler/sched_main.c     |   9 ++
 drivers/interconnect/core.c                |  18 ++-
 drivers/soc/qcom/smd-rpm.c                 |   2 +-
 include/drm/drm_gem.h                      |   1 +
 include/drm/gpu_scheduler.h                |   2 +
 23 files changed, 416 insertions(+), 221 deletions(-)

-- 
2.39.2

