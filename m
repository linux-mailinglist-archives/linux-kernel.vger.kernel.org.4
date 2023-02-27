Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFE6A4AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB0Tfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjB0Tfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:52 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D924125;
        Mon, 27 Feb 2023 11:35:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id ay18so4272339pfb.2;
        Mon, 27 Feb 2023 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqSkMkOWvo198Qe9ugotk8774STpM+o2a7uvWEbmyhI=;
        b=jpgyHcjyAaGnPsMXVAm2GRBpiP1WcxO7Je/7kLkTA3rtRPpZM63s2qAVsYJzi0Z0gN
         sfedtybQXMObhUoSB6y9kaEQUwpYBvE5uqw2j9KZiJ3AsKHyM8xHBGvHoM1hrJChMfgS
         HW76rauQ4oKtTsGw+TcaRTOsLD8Q3BdSv4+8YA+qJdQZ78IZXFcvMXZg4igKohmUyOSo
         HfVAk60hbp+MRj/bfKwx2ERa55V1Jxq+3hc2nq32saAa2qacGQQPrHqcBl+UWMEpSL3z
         p0vnauDCADHvZvjkSCmWO2Pkb9aJJESQoMbAQB6MqbN6dhdo7mTt9GkkeFELH/jg7Qrn
         CFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqSkMkOWvo198Qe9ugotk8774STpM+o2a7uvWEbmyhI=;
        b=kuq7onsLPbrVnS/Zz2Qvwb/Hragjf94zHRmdlEBkffWOV+E39y3CniP733X6HAFQg8
         b3EMUCdOdgUqcnt+R7hapy7xT2akGfuDW7h+w1pX4Fz1W6qbVyFPbBFv8wpF6p+0hMeA
         bDrBI64/HMXBxKCLr85QVdvGfYd8T85zhetgrGkU7rbogEfvaBssTE0++dgYxC8UIyyJ
         EegZuYMbExKaHh0U1XM0FGnJ9fS3ZYbdNk9xPZ6fJ6AOT32kcgkRUxhFg0octYovENKP
         CIOqWs07GLGPMsIGhyck5A4rvl5uVHEIvfB8jjHLPP+1ZNJqAtYxZkQ5aVqqSxWHM1pg
         qPkQ==
X-Gm-Message-State: AO0yUKU1G9jqYVpVGn9McaU2zlFN7liHFq4yy9HwUTgaV7niFXF+Avwt
        pUpHx3kJ8EI4vxwgUpVzmao=
X-Google-Smtp-Source: AK7set8dR7Le+9Dq5U/mXM+Gk/dwWnvs8RpwgZNM20/ZapctF7B3kGBdAxp4COFbDivh6cmRzWmwoA==
X-Received: by 2002:a05:6a00:47:b0:5a9:b4eb:d262 with SMTP id i7-20020a056a00004700b005a9b4ebd262mr181600pfk.1.1677526547630;
        Mon, 27 Feb 2023 11:35:47 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7854e000000b0056283e2bdbdsm4581119pfn.138.2023.02.27.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:35:47 -0800 (PST)
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
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        intel-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Liu Shixin <liushixin2@huawei.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Subject: [PATCH v7 00/15] dma-fence: Deadline awareness
Date:   Mon, 27 Feb 2023 11:35:06 -0800
Message-Id: <20230227193535.2822389-1-robdclark@gmail.com>
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

This series adds a deadline hint to fences, so realtime deadlines
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
v5: Clarify that this is a hint as opposed to a more hard deadline
    guarantee, switch to using u64 ns values in UABI (still absolute
    CLOCK_MONOTONIC values), drop syncobj related cap and driver
    feature flag in favor of allowing count_handles==0 for probing
    kernel support.
v6: Re-work vblank helper to calculate time of _start_ of vblank,
    and work correctly if the last vblank event was more than a
    frame ago.  Add (mostly unrelated) drm/msm patch which also
    uses the vblank helper.  Use dma_fence_chain_contained().  More
    verbose syncobj UABI comments.  Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
v7: Fix kbuild complaints about vblank helper.  Add more docs.

Rob Clark (15):
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
  drm/msm/atomic: Switch to vblank_start helper
  drm/i915: Add deadline based boost support

 Documentation/driver-api/dma-buf.rst    |  6 ++
 drivers/dma-buf/dma-fence-array.c       | 11 ++++
 drivers/dma-buf/dma-fence-chain.c       | 12 ++++
 drivers/dma-buf/dma-fence.c             | 60 ++++++++++++++++++++
 drivers/dma-buf/dma-resv.c              | 22 ++++++++
 drivers/dma-buf/sw_sync.c               | 58 +++++++++++++++++++
 drivers/dma-buf/sync_debug.h            |  2 +
 drivers/dma-buf/sync_file.c             | 27 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c     | 36 ++++++++++++
 drivers/gpu/drm/drm_syncobj.c           | 64 ++++++++++++++++-----
 drivers/gpu/drm/drm_vblank.c            | 53 +++++++++++++++---
 drivers/gpu/drm/i915/i915_request.c     | 20 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 -----
 drivers/gpu/drm/msm/msm_atomic.c        |  8 ++-
 drivers/gpu/drm/msm/msm_drv.c           | 12 ++--
 drivers/gpu/drm/msm/msm_fence.c         | 74 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_fence.h         | 20 +++++++
 drivers/gpu/drm/msm/msm_gem.c           |  5 ++
 drivers/gpu/drm/msm/msm_kms.h           |  8 ---
 drivers/gpu/drm/scheduler/sched_fence.c | 46 +++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/drm_vblank.h                |  1 +
 include/drm/gpu_scheduler.h             | 17 ++++++
 include/linux/dma-fence.h               | 20 +++++++
 include/linux/dma-resv.h                |  2 +
 include/uapi/drm/drm.h                  | 17 ++++++
 include/uapi/drm/msm_drm.h              | 14 ++++-
 include/uapi/linux/sync_file.h          | 26 +++++++++
 28 files changed, 603 insertions(+), 55 deletions(-)

-- 
2.39.1

