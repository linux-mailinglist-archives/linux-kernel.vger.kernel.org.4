Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8826BDAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCPVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCPVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:23:02 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57FDCF59;
        Thu, 16 Mar 2023 14:22:59 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-176261d7f45so3614054fac.11;
        Thu, 16 Mar 2023 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679001778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOLm3MMBl89f2knm/a6i4nSTBzWYSuBzK1XClYHpMY4=;
        b=dSmvj4c+vhVDAQ5Zaj5Yr1DRJ4ybiDnIB4G/ylPHrFHhzAkda0nDV6qsFCC8XDGrq+
         eT863QrK6B/IcIyiPUEC4cRa0GtMAf779fuR3ilmeIz53fivuQJbIrNpTfioj65CSN0H
         EeQrdTv00bm9+R5ydA9cNvPyYFvlb5Cnck9wzX0V9VQxZBd0VDTDVRn3TXCLm3gBmkgv
         aW6YQ2C6DOswHq1c91ga2KdN/R7P23WfSv+rgkxc82u7+5Opfko/BDf2Zi8BEuF7OVQ7
         SKPdGvyXBblcQx6g3Bq8ebiT5ydjjneIU031EZX9bw84Lsn8FMDupirSITw5TxEuucC9
         t07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOLm3MMBl89f2knm/a6i4nSTBzWYSuBzK1XClYHpMY4=;
        b=EEVGH0HzX2bCEzjtQ4SOFCo1sFJeup3abLPOZ2tyj7hsJ7gJObi+XR00OEUJSnBnVf
         kyOegz611tLBK0LLxy38z4C3uvTSo0v4WslZW61AWEbgORklIXKtVjVbaMU9c+o+bk7g
         YWCv7pzztLfRsGPaTISAYCTrlt2w/pLDbZE9dh4u4JLQWrbqbT4y3kWkBDQjA1/aNDTf
         Ot0cpNQb1hxbb4nNEzNe/gZgrdHrHkCgUtc17ffStDaLM6MfoFBeGkmvyRHlit+q8LE5
         h2SDgw6FDhwpKcbxdQK4yCpzIwi2b7/fnT0PCpR3fXAMlp2LEdZvP5u9QnGaw5zuorh/
         jUPQ==
X-Gm-Message-State: AO0yUKX16MfUmOTkvNrUNmF1DPrmlPKpoHn+anU7iPNNu2eqkus3jJuS
        hMp2E+K1kmNLSluRcjTSE8V7R1OuPMREB+fn7Jpm6BVSSeE=
X-Google-Smtp-Source: AK7set+faq17A1DBESVulT7MGuaccV0D25PIH9DGSJys9ZSVMyY9sK6nmcgZ9NZNMc3lxfUhJXYBUInIOT3YmaNi5n0=
X-Received: by 2002:a05:6870:6125:b0:177:be3d:2e4d with SMTP id
 s37-20020a056870612500b00177be3d2e4dmr6744075oae.5.1679001778698; Thu, 16 Mar
 2023 14:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230308155322.344664-1-robdclark@gmail.com>
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 16 Mar 2023 14:22:47 -0700
Message-ID: <CAF6AEGs1A-3vHtCCam+LfweBNG76TPrpsn8u+RzZ8=sq18yrNg@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] dma-fence: Deadline awareness
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:53=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This series adds a deadline hint to fences, so realtime deadlines
> such as vblank can be communicated to the fence signaller for power/
> frequency management decisions.
>
> This is partially inspired by a trick i915 does, but implemented
> via dma-fence for a couple of reasons:
>
> 1) To continue to be able to use the atomic helpers
> 2) To support cases where display and gpu are different drivers
>
> This iteration adds a dma-fence ioctl to set a deadline (both to
> support igt-tests, and compositors which delay decisions about which
> client buffer to display), and a sw_sync ioctl to read back the
> deadline.  IGT tests utilizing these can be found at:
>
>   https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-d=
eadline
>

jfwiw, mesa side of this:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21973

BR,
-R

>
> v1: https://patchwork.freedesktop.org/series/93035/
> v2: Move filtering out of later deadlines to fence implementation
>     to avoid increasing the size of dma_fence
> v3: Add support in fence-array and fence-chain; Add some uabi to
>     support igt tests and userspace compositors.
> v4: Rebase, address various comments, and add syncobj deadline
>     support, and sync_file EPOLLPRI based on experience with perf/
>     freq issues with clvk compute workloads on i915 (anv)
> v5: Clarify that this is a hint as opposed to a more hard deadline
>     guarantee, switch to using u64 ns values in UABI (still absolute
>     CLOCK_MONOTONIC values), drop syncobj related cap and driver
>     feature flag in favor of allowing count_handles=3D=3D0 for probing
>     kernel support.
> v6: Re-work vblank helper to calculate time of _start_ of vblank,
>     and work correctly if the last vblank event was more than a
>     frame ago.  Add (mostly unrelated) drm/msm patch which also
>     uses the vblank helper.  Use dma_fence_chain_contained().  More
>     verbose syncobj UABI comments.  Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
> v7: Fix kbuild complaints about vblank helper.  Add more docs.
> v8: Add patch to surface sync_file UAPI, and more docs updates.
> v9: Drop (E)POLLPRI support.. I still like it, but not essential and
>     it can always be revived later.  Fix doc build warning.
> v10: Update 11/15 to handle multiple CRTCs
>
> Rob Clark (15):
>   dma-buf/dma-fence: Add deadline awareness
>   dma-buf/fence-array: Add fence deadline support
>   dma-buf/fence-chain: Add fence deadline support
>   dma-buf/dma-resv: Add a way to set fence deadline
>   dma-buf/sync_file: Surface sync-file uABI
>   dma-buf/sync_file: Add SET_DEADLINE ioctl
>   dma-buf/sw_sync: Add fence deadline support
>   drm/scheduler: Add fence deadline support
>   drm/syncobj: Add deadline support for syncobj waits
>   drm/vblank: Add helper to get next vblank time
>   drm/atomic-helper: Set fence deadline for vblank
>   drm/msm: Add deadline based boost support
>   drm/msm: Add wait-boost support
>   drm/msm/atomic: Switch to vblank_start helper
>   drm/i915: Add deadline based boost support
>
> Rob Clark (15):
>   dma-buf/dma-fence: Add deadline awareness
>   dma-buf/fence-array: Add fence deadline support
>   dma-buf/fence-chain: Add fence deadline support
>   dma-buf/dma-resv: Add a way to set fence deadline
>   dma-buf/sync_file: Surface sync-file uABI
>   dma-buf/sync_file: Add SET_DEADLINE ioctl
>   dma-buf/sw_sync: Add fence deadline support
>   drm/scheduler: Add fence deadline support
>   drm/syncobj: Add deadline support for syncobj waits
>   drm/vblank: Add helper to get next vblank time
>   drm/atomic-helper: Set fence deadline for vblank
>   drm/msm: Add deadline based boost support
>   drm/msm: Add wait-boost support
>   drm/msm/atomic: Switch to vblank_start helper
>   drm/i915: Add deadline based boost support
>
>  Documentation/driver-api/dma-buf.rst    | 16 ++++-
>  drivers/dma-buf/dma-fence-array.c       | 11 ++++
>  drivers/dma-buf/dma-fence-chain.c       | 12 ++++
>  drivers/dma-buf/dma-fence.c             | 60 ++++++++++++++++++
>  drivers/dma-buf/dma-resv.c              | 22 +++++++
>  drivers/dma-buf/sw_sync.c               | 81 +++++++++++++++++++++++++
>  drivers/dma-buf/sync_debug.h            |  2 +
>  drivers/dma-buf/sync_file.c             | 19 ++++++
>  drivers/gpu/drm/drm_atomic_helper.c     | 37 +++++++++++
>  drivers/gpu/drm/drm_syncobj.c           | 64 +++++++++++++++----
>  drivers/gpu/drm/drm_vblank.c            | 53 +++++++++++++---
>  drivers/gpu/drm/i915/i915_request.c     | 20 ++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 -----
>  drivers/gpu/drm/msm/msm_atomic.c        |  8 ++-
>  drivers/gpu/drm/msm/msm_drv.c           | 12 ++--
>  drivers/gpu/drm/msm/msm_fence.c         | 74 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_fence.h         | 20 ++++++
>  drivers/gpu/drm/msm/msm_gem.c           |  5 ++
>  drivers/gpu/drm/msm/msm_kms.h           |  8 ---
>  drivers/gpu/drm/scheduler/sched_fence.c | 46 ++++++++++++++
>  drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
>  include/drm/drm_vblank.h                |  1 +
>  include/drm/gpu_scheduler.h             | 17 ++++++
>  include/linux/dma-fence.h               | 22 +++++++
>  include/linux/dma-resv.h                |  2 +
>  include/uapi/drm/drm.h                  | 17 ++++++
>  include/uapi/drm/msm_drm.h              | 14 ++++-
>  include/uapi/linux/sync_file.h          | 59 +++++++++++-------
>  28 files changed, 640 insertions(+), 79 deletions(-)
>
> --
> 2.39.2
>
