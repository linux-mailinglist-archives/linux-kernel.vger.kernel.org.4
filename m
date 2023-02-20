Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867569D49A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjBTUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019BCDDD;
        Mon, 20 Feb 2023 12:19:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so2595319pjb.2;
        Mon, 20 Feb 2023 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3iZVIEmRSqrThUkMgFnNzdxbCW0+gwLuKMdSEBTZdk=;
        b=XudzNzCm0FKe2lIo1qRVr5sLuN77pLHRaJAkpk5nN+kAMt5yxOrww7exfQ1KGHBxvw
         Qfq44H7k2ZhIY4RKNIWr1Ig2n9JnpB/KLPeADSuGGggoSD99Kp/QDnvcqkJPleFaVd3t
         V5GQuD1elokWuQM+NpoVHXi17Jc5JatN7pvdSJmtv2906bbPCITMy01jb/RVSAhrH1s2
         WYEGJpXDRWTfffqIQb7PFW5bDjSIhaozxo5JpWKIJfrha99mGl0ggB4dyMk8L3V1Lt2n
         csH0zYdlwff/KHZIEDaTvd0GdzhjJRBcfCQ8rbqF0wRmYRf0o3kXSpsmxnUkZqkJo9iR
         5PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3iZVIEmRSqrThUkMgFnNzdxbCW0+gwLuKMdSEBTZdk=;
        b=zcy666zCJBUZDMM5qs4S+g6n2rtf1nGxMzl0Vj1iT7O959gltISxlNRbGgGBsOCctm
         KP3ITwbnszuo46bbCRzXnYcMlSyY7qso1qxsUT1fpMwlh+lkzxFKyzPkZJdSmeZHVRn4
         WsV9wTcMM7koTLNANjLBZkBirE5jotVDPHAHOisrY1Q0xzKC69t+ewVCuYRFHIWlsMOA
         Yo6XzzkQwAahApo9s1U1WCvRu0y2H8FEqhUCS4iPP0H7CR1CjZk7HRdBYDEttrUZ9GCd
         J1pIdPGL5gJjPTuIbSoylnwjN5BpOPvIywFsG9jyxdH4ys/jA6foiYtsJcF6/aroaK4T
         SCww==
X-Gm-Message-State: AO0yUKWCPwHOdqRotdE8DXHq6DeKD2Kwd07bnphdiihmQiMzLQ6nLiR7
        LeMYwrmclwLnaadowIhhWhd2+30RecA=
X-Google-Smtp-Source: AK7set98IO8l+gABanedVbXmDYUvdtim10BgWM5gyRskazHJbLVCeykOeOFx9FaeUCzP6cQ+Vn5YOQ==
X-Received: by 2002:a17:90b:4a43:b0:234:10c:a0d0 with SMTP id lb3-20020a17090b4a4300b00234010ca0d0mr2998947pjb.6.1676924359710;
        Mon, 20 Feb 2023 12:19:19 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090ad24e00b0023087e8adf8sm1839664pjw.21.2023.02.20.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:19 -0800 (PST)
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
Subject: [PATCH v5 00/14] dma-fence: Deadline awareness
Date:   Mon, 20 Feb 2023 12:18:47 -0800
Message-Id: <20230220201916.1822214-1-robdclark@gmail.com>
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
 drivers/dma-buf/dma-fence.c             | 21 +++++++
 drivers/dma-buf/dma-resv.c              | 22 ++++++++
 drivers/dma-buf/sw_sync.c               | 58 +++++++++++++++++++
 drivers/dma-buf/sync_debug.h            |  2 +
 drivers/dma-buf/sync_file.c             | 27 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c     | 36 ++++++++++++
 drivers/gpu/drm/drm_syncobj.c           | 59 +++++++++++++++-----
 drivers/gpu/drm/drm_vblank.c            | 32 +++++++++++
 drivers/gpu/drm/i915/i915_request.c     | 20 +++++++
 drivers/gpu/drm/msm/msm_drv.c           | 12 ++--
 drivers/gpu/drm/msm/msm_fence.c         | 74 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_fence.h         | 20 +++++++
 drivers/gpu/drm/msm/msm_gem.c           |  5 ++
 drivers/gpu/drm/scheduler/sched_fence.c | 46 +++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/drm_vblank.h                |  1 +
 include/drm/gpu_scheduler.h             |  8 +++
 include/linux/dma-fence.h               | 20 +++++++
 include/linux/dma-resv.h                |  2 +
 include/uapi/drm/drm.h                  |  5 ++
 include/uapi/drm/msm_drm.h              | 14 ++++-
 include/uapi/linux/sync_file.h          | 23 ++++++++
 24 files changed, 513 insertions(+), 20 deletions(-)

-- 
2.39.1

