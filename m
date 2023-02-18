Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46CA69BC12
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBRVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBRVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:15:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8F12070;
        Sat, 18 Feb 2023 13:15:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g2so1465797pjp.2;
        Sat, 18 Feb 2023 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly4gQbq9/GnWUeWA60KPz/G+dzGxkcXgw5HCdzXbiDM=;
        b=TqzurTwkIi7vl6x42AjsrYN5etY5UrhYSRhuhRA0DcAed3BQ7kd+EShu6ZYUuzSWS6
         f2ShdvpTlDiEddzw1Pngzl0gliC9vI89r49p462MNjyf7n2fk9K5rG40sbyi9YeAuXKx
         2IlQ6wVLZDk4ujSNogI1BVXRPnZyG9XodQul+Gt/IjgeqRh2hZMfbddpy2FwGlj/orZk
         nSpYnyQj/uh7kMZhl+cXvFJ9VgfGaRbtRluybITkUr1SLZHCZANTXG1WLO5m6DiwYoul
         TaCi+7mlADXeBpnG/jw9xXwtKwm9Focdx2Pr+MJUZva3Y7KD/ZaKPJ7prjd0RN12Eg1h
         3+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly4gQbq9/GnWUeWA60KPz/G+dzGxkcXgw5HCdzXbiDM=;
        b=GFvocMVmL6+bPKoHR4aH/4qbjgr0L4O17fZtRloMtui0Y7xr+DaxYvInBqm6SVrstI
         N1pqGxTTHzfoAOCgeBy+WTD1ESX/5nKu0mrQfjPv/8rBfMJxOO4bR/vF2ZWbY4XOqAoI
         d9qtGNX1BrNrpy8F/diqiij70wgpGKe0Ayw6ZgjbpOwLjcFFSNdKhiuTKsI/zSsUr9zJ
         6zUpsUOhBrTPW9c4fPmmXr4v8qRy8lT/sObAeoIvfSmCwhXpvHZvJJ+2Y05oYimTc4HT
         VUmNURSdDNj78GHwoAj8nV7hxfsT+nHDHQaGqBFAy8ZNLc9dntRn2nKLrH+VQMpdBpUg
         iAyQ==
X-Gm-Message-State: AO0yUKVlS1W4vKwZSyK7S4Zycv7g8m9bDggAhC8jdbv89A216dP8RYM1
        /YbuMuBq4mKe4CH+V/TKYi8=
X-Google-Smtp-Source: AK7set8ereILC0V3ZBU5NrGgoh8oJHY1jqZ0fuA0KAdXBnGUn7hGdkEc1QzSShEe+BIohVgIIE6grw==
X-Received: by 2002:a17:90a:31c:b0:234:2627:d9b0 with SMTP id 28-20020a17090a031c00b002342627d9b0mr1042232pje.32.1676754948302;
        Sat, 18 Feb 2023 13:15:48 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id gl19-20020a17090b121300b00230da56ddecsm1292126pjb.27.2023.02.18.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:47 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        intel-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Sean Paul <sean@poorly.run>
Subject: [PATCH v4 00/14] dma-fence: Deadline awareness
Date:   Sat, 18 Feb 2023 13:15:43 -0800
Message-Id: <20230218211608.1630586-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds deadline awareness to fences, so realtime deadlines
such as vblank can be communicated to the fence signaller for power/
frequency management decisions.

This is partially inspired by a trick i915 does, but implemented
via dma-fence for a couple of reasons:

1) To continue to be able to use the atomic helpers
2) To support cases where display and gpu are different drivers

This iteration adds a dma-fence ioctl to set a deadline (both to
support igt-tests, and compositors which delay decisions about which
client buffer to display), and a sw_sync ioctl to read back the
deadline.  IGT tests utilizing these can be found at:

  https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline


v1: https://patchwork.freedesktop.org/series/93035/
v2: Move filtering out of later deadlines to fence implementation
    to avoid increasing the size of dma_fence
v3: Add support in fence-array and fence-chain; Add some uabi to
    support igt tests and userspace compositors.
v4: Rebase, address various comments, and add syncobj deadline
    support, and sync_file EPOLLPRI based on experience with perf/
    freq issues with clvk compute workloads on i915 (anv)

Rob Clark (14):
  dma-buf/dma-fence: Add deadline awareness
  dma-buf/fence-array: Add fence deadline support
  dma-buf/fence-chain: Add fence deadline support
  dma-buf/dma-resv: Add a way to set fence deadline
  dma-buf/sync_file: Add SET_DEADLINE ioctl
  dma-buf/sync_file: Support (E)POLLPRI
  dma-buf/sw_sync: Add fence deadline support
  drm/scheduler: Add fence deadline support
  drm/syncobj: Add deadline support for syncobj waits
  drm/vblank: Add helper to get next vblank time
  drm/atomic-helper: Set fence deadline for vblank
  drm/msm: Add deadline based boost support
  drm/msm: Add wait-boost support
  drm/i915: Add deadline based boost support

 drivers/dma-buf/dma-fence-array.c       | 11 ++++
 drivers/dma-buf/dma-fence-chain.c       | 13 +++++
 drivers/dma-buf/dma-fence.c             | 20 +++++++
 drivers/dma-buf/dma-resv.c              | 19 +++++++
 drivers/dma-buf/sw_sync.c               | 58 +++++++++++++++++++
 drivers/dma-buf/sync_debug.h            |  2 +
 drivers/dma-buf/sync_file.c             | 27 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c     | 36 ++++++++++++
 drivers/gpu/drm/drm_ioctl.c             |  3 +
 drivers/gpu/drm/drm_syncobj.c           | 59 ++++++++++++++++----
 drivers/gpu/drm/drm_vblank.c            | 32 +++++++++++
 drivers/gpu/drm/i915/i915_driver.c      |  2 +-
 drivers/gpu/drm/i915/i915_request.c     | 20 +++++++
 drivers/gpu/drm/msm/msm_drv.c           | 16 ++++--
 drivers/gpu/drm/msm/msm_fence.c         | 74 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_fence.h         | 20 +++++++
 drivers/gpu/drm/msm/msm_gem.c           |  5 ++
 drivers/gpu/drm/scheduler/sched_fence.c | 46 +++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/drm_drv.h                   |  6 ++
 include/drm/drm_vblank.h                |  1 +
 include/drm/gpu_scheduler.h             |  8 +++
 include/linux/dma-fence.h               | 20 +++++++
 include/linux/dma-resv.h                |  2 +
 include/uapi/drm/drm.h                  | 16 +++++-
 include/uapi/drm/msm_drm.h              | 14 ++++-
 include/uapi/linux/sync_file.h          | 22 ++++++++
 27 files changed, 532 insertions(+), 22 deletions(-)

-- 
2.39.1

