Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4276A62F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1W6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1W6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5793D3;
        Tue, 28 Feb 2023 14:58:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so10783812pjg.4;
        Tue, 28 Feb 2023 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXsjpwtlnyMWpUcP40lgkqlHQ7uJRKYUw/6jLM5vJqk=;
        b=pNGt9FXPNHxIFLIMXbAFQUQKVYLquAXGLnud5+PuFJdfGNG+WQTA607yuuQVswCJjO
         nu2JvggHvy5G2ca5u6W9xrHk9fUoIlokgivzx7J37gN8hpbrhzrDcLvLZYYQMqMkwGud
         rYATJR2Ga+HOGWUvKl8+Gy6v4YWn9BO7+4EQ7nPRqy83U8k6DshPVz0H322DxYKRCS7x
         suVehWL7N3G5bV1UtE0Am3ba9LUNh2UAK/2swHByR+yV0Kf1Gdek+UKBxrlzHjLtIbbL
         B2DCG94Xt2B4JcEm/iQJ53tt0fjl7TGVswFSKp8TjTUw6BapPAzlp7sV3hnXY74iYQFH
         8M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXsjpwtlnyMWpUcP40lgkqlHQ7uJRKYUw/6jLM5vJqk=;
        b=v7oxKNVy+mDD+TkBwC6UmK/optWb5eKMC+6kx0xw+elTu6AXQqWdSuxgiacDi80WvA
         Pg1pUqfmb4NgLlFdCTjzNupmPtJETbGfQ8Z+WQ5q5guRSGS0p6E3V0KPOXRDLHpZ8Wts
         aNHJze+1uJVkDySZRsULFM7zeAmDmEpfrUORRVv9zZvuombw92cak6Q0l6Z/d5WfW5n1
         Gk4bVv9PdSYh7JwtKmawngohqGhdo2dyGcj+PVAO/yy2HYO83pZI8kd6yNWxztpZfdMk
         9a+Eu7IZauSVByG2PhkSDf6T8tAlxRBUP9vT0N9ABUIB9Ft6uxasXLphsEQN7w8UpOzL
         tc+w==
X-Gm-Message-State: AO0yUKVREv2A/8Ox0kI0aUhfuFug0QRzPgIgBYYwnvxQzzK8rqUVOETK
        zl4RHw6U3ZrPY01Ps92l6BQ3q2xi2ytMGA==
X-Google-Smtp-Source: AK7set+C3xNzqZCGpCumm9At8wGLtRcuF+g93KGvpizYASCuQcBJjXnqvRaiPQltpCOgrBN/EwgrlQ==
X-Received: by 2002:a17:902:bd82:b0:19c:e664:5e64 with SMTP id q2-20020a170902bd8200b0019ce6645e64mr4013466pls.2.1677625117613;
        Tue, 28 Feb 2023 14:58:37 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b0019aa4c00ff4sm7033478pls.206.2023.02.28.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:37 -0800 (PST)
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
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Subject: [PATCH v8 00/16] dma-fence: Deadline awareness
Date:   Tue, 28 Feb 2023 14:58:04 -0800
Message-Id: <20230228225833.2920879-1-robdclark@gmail.com>
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
v8: Add patch to surface sync_file UAPI, and more docs updates.

Rob Clark (16):
  dma-buf/dma-fence: Add deadline awareness
  dma-buf/fence-array: Add fence deadline support
  dma-buf/fence-chain: Add fence deadline support
  dma-buf/dma-resv: Add a way to set fence deadline
  dma-buf/sync_file: Surface sync-file uABI
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

 Documentation/driver-api/dma-buf.rst    | 16 ++++-
 drivers/dma-buf/dma-fence-array.c       | 11 ++++
 drivers/dma-buf/dma-fence-chain.c       | 12 ++++
 drivers/dma-buf/dma-fence.c             | 60 ++++++++++++++++++
 drivers/dma-buf/dma-resv.c              | 22 +++++++
 drivers/dma-buf/sw_sync.c               | 81 +++++++++++++++++++++++++
 drivers/dma-buf/sync_debug.h            |  2 +
 drivers/dma-buf/sync_file.c             | 27 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c     | 36 +++++++++++
 drivers/gpu/drm/drm_syncobj.c           | 64 +++++++++++++++----
 drivers/gpu/drm/drm_vblank.c            | 53 +++++++++++++---
 drivers/gpu/drm/i915/i915_request.c     | 20 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 -----
 drivers/gpu/drm/msm/msm_atomic.c        |  8 ++-
 drivers/gpu/drm/msm/msm_drv.c           | 12 ++--
 drivers/gpu/drm/msm/msm_fence.c         | 74 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_fence.h         | 20 ++++++
 drivers/gpu/drm/msm/msm_gem.c           |  5 ++
 drivers/gpu/drm/msm/msm_kms.h           |  8 ---
 drivers/gpu/drm/scheduler/sched_fence.c | 46 ++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/drm_vblank.h                |  1 +
 include/drm/gpu_scheduler.h             | 17 ++++++
 include/linux/dma-fence.h               | 22 +++++++
 include/linux/dma-resv.h                |  2 +
 include/uapi/drm/drm.h                  | 17 ++++++
 include/uapi/drm/msm_drm.h              | 14 ++++-
 include/uapi/linux/sync_file.h          | 57 ++++++++++-------
 28 files changed, 646 insertions(+), 78 deletions(-)

-- 
2.39.1

