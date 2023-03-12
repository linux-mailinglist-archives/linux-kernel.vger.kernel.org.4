Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90086B6B30
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCLUmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCLUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235E39B88;
        Sun, 12 Mar 2023 13:42:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y11so10869986plg.1;
        Sun, 12 Mar 2023 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eS81Bbeb7DUO+iRkvmtrK0oB4SfcOjiUFR0rKW60MA0=;
        b=G2a3X2goAyICa7qoVr4TjJ4/OOQ1EmoCBXmcNPEVfAKqhAEIho/AfxQDCMbOYQNb6/
         VsK86lLGHo82G880+GfCwnB7NZj1LH0T7klN9abmbKa3C8/6ysyzwU7sxSjjzz/XL6oO
         vAuH1AamSgl6MUBggR0tNxojaYXKDM1IjIEcV5GY0MN5QC8uZEjZMKvOttvLv58I+FHt
         xQm7dqeB+g/b7H6pg95qji23VUNrDetgUorQn2HxhlXGTz3ne2burkaHbyZqOA/jKSNX
         WdnpofFPER2tIU2FTgT2WccI6i5Vl7jnW7WFD3EdyaZysEXME+eXg3NnWksiH0E54H0O
         oM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eS81Bbeb7DUO+iRkvmtrK0oB4SfcOjiUFR0rKW60MA0=;
        b=al7rG2oF9jCcyyXEB+stLJRMzOK6Ld4g1teJn8yYbFv4sTkLW0QGSp6Y4DAV1P6AQw
         n8sT+5UV8Aahz+QOBLgjYnn4RfNEoihmZe7dH43P75JkYC/M6cMkLE1ghIbvnaUG2Al7
         QBvwDNWiEs358RnrrNK9dzDdHxqvgWlf+XG/G4hK4K+81lXcXu+St5Mu5Ky/Oh8bG/7f
         xwxLQngQFKfWv8AWJpq34WiVnJmoDGXXJqjv5X+nbLToVIrhw8Pg69A/CPwh9NaceUzx
         NSarYgWZNCMdIOUxoShzn2bY5sJ7+nGO1o0KwHCxKXZBNgvuUpPojY7EUyDB/Kzl80RV
         ImwQ==
X-Gm-Message-State: AO0yUKUfUQgwW2DpSEilzUqd3H1KU4ryLcPK9R+lkm/jnRYoIll1aWmx
        LDB6Tvv8yeWdoF4lkkDfkeyakLMd5wc=
X-Google-Smtp-Source: AK7set+UpZ1DihZTdG/FUvyuXyzqzkkjcn3UiFdPutNdqCaUQZDans3Wexm2twEh9BfXyHomUFqSlQ==
X-Received: by 2002:a17:902:a9cb:b0:19a:df76:ddd2 with SMTP id b11-20020a170902a9cb00b0019adf76ddd2mr27656409plr.36.1678653742882;
        Sun, 12 Mar 2023 13:42:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001a049441fc8sm472317plf.193.2023.03.12.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:22 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Gustavo Padovan <gustavo@padovan.org>,
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
Subject: [PATCH 00/13] drm/msm+PM+icc: Make job_run() reclaim-safe
Date:   Sun, 12 Mar 2023 13:41:28 -0700
Message-Id: <20230312204150.1353517-1-robdclark@gmail.com>
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
and use lockdep annotations to yell at us about anything that could
deadlock against shrinker/reclaim.  Anything that can trigger reclaim,
or block on any other thread that has triggered reclaim, can block the
GPU shrinker from releasing memory if it is waiting the job to complete,
causing deadlock.

The first two patches avoid memory allocation for the hw_fence by
embedding it in the already allocated submit object.  The next three
decouple various allocations that were done in the hw_init path, but
only the first time, to let lockdep see that they won't happen in the
job_run() path.  (The hw_init() path re-initializes the GPU after runpm
resume, etc, which can happen in the job_run() path.)

The remaining patches clean up locking issues in various corners of PM
and interconnect which happen in the runpm path.  These fixes can be
picked up independently by the various maintainers.  In all cases I've
added lockdep annotations to help keep the runpm resume path deadlock-
free vs reclaim, but I've broken those out into their own patches.. it
is possible that these might find issues in other code-paths not hit on
the hw I have.  (It is a bit tricky because of locks held across call-
backs, such as devfreq->lock held across devfreq_dev_profile callbacks.
I've audited these and other callbacks in icc, etc, to look for problems
and fixed one I found in smd-rpm.  But that took me through a number of
drivers and subsystems that I am not familiar with so it is entirely
possible that I overlooked some problematic allocations.)

There is one remaining issue to resolve before we can enable the job_run
annotations, but it is entirely self contained in drm/msm/gem.  So it
should not block review of these patches.  So I figured it best to send
out what I have so far.

Rob Clark (13):
  dma-buf/dma-fence: Add dma_fence_init_noref()
  drm/msm: Embed the hw_fence in msm_gem_submit
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

 drivers/base/power/qos.c                   | 83 ++++++++++++++++------
 drivers/devfreq/devfreq.c                  | 52 +++++++-------
 drivers/dma-buf/dma-fence.c                | 43 ++++++++---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 48 ++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 18 +++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 46 ++++++------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  9 +--
 drivers/gpu/drm/msm/msm_fence.c            | 43 +++++------
 drivers/gpu/drm/msm/msm_fence.h            |  2 +-
 drivers/gpu/drm/msm/msm_gem.h              | 10 +--
 drivers/gpu/drm/msm/msm_gem_submit.c       |  8 +--
 drivers/gpu/drm/msm/msm_gpu.c              |  4 +-
 drivers/gpu/drm/msm/msm_gpu.h              |  6 ++
 drivers/gpu/drm/msm/msm_ringbuffer.c       |  4 +-
 drivers/interconnect/core.c                | 18 ++++-
 drivers/soc/qcom/smd-rpm.c                 |  2 +-
 include/linux/dma-fence.h                  |  2 +
 18 files changed, 237 insertions(+), 167 deletions(-)

-- 
2.39.2

