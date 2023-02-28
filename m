Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D86A5C39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjB1PpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjB1PpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:45:10 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA7730B3E;
        Tue, 28 Feb 2023 07:45:07 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso5836576ota.1;
        Tue, 28 Feb 2023 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47Io8bjBgTfpx9irLzQIk7kc2k6GPp2PZ97i5J/VsnU=;
        b=cmBSfjVhL11B7Tk2kzeIA9iNdYDewp+Lj2BTbbj6UDcbnNNnGRKEG9iCWQZ+Zn3g9m
         +0Zx+GlqRizxRKPwVVA4/JaFtaKfoHx9z08Qt2aL2jYElbluHU/qNXZSmld3edT7vPer
         mqK5c2oWjXhedR1BJv6EXjMqwSeGb6qxBliUPUwERul1AYJ+81hovh17DHIbCSD5cK5w
         9gwm8dkKVD7UCQUidLDzlT+m/No89gMZlEDYYGUWzhhwiazV+8nn9uut0WCqrLE6UV/g
         tafJgCdHGRGVm9NWQqu21rdJz8b0ivr1k0uKj14YYV/O5qMTtismWvnVbWfVfSc1EyjJ
         t6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47Io8bjBgTfpx9irLzQIk7kc2k6GPp2PZ97i5J/VsnU=;
        b=1CWJxt/w4tQEzawmcrvTAGCwa51RqUs+FRwDNro+vJ0RFNOANO5gGGcRRSi24/gx5b
         yhlLhDoI8geb5ZNeTLLOfHUoBaiznTaMFdu+k4WRbx7L9+j4B1403/QCIG7kP7YYubeI
         TAgu7z3U8x/9/Si3ZQqwb6sLshcn8Tvz52l2zN9GfjGNedR6YDoukSW0k0JD/uPmKZfz
         5sw1wPkKEkGNV1aMwLgqHAJ9Swa0f8oi6XE0Wfx1nwXgWH0zcw1H9y8GSQTk9BrZ+oc/
         XfHeqLPuvt2rMfE37ZYVjGQ0gv9mPqphjNWLTA8YTHc/tzC3C9NELumsGKLXnqjUTSjh
         v80g==
X-Gm-Message-State: AO0yUKU9Dsm2swe+CdCDI0GCW44hejovqMqY5OOgTIYlchwCLn+gcgJK
        DitYB9aVXkmNu7SMl/QjwbscE+flktTkL9SJZWU=
X-Google-Smtp-Source: AK7set84ZiKu/x5bhuHzdqKQUv7sjdjnKY8F7kTvWRv1lYoh5z8jZHyiBzPqCGMtJV4jXTtlMVk45nk6MjMvbYL6vxQ=
X-Received: by 2002:a9d:128e:0:b0:688:cf52:6e18 with SMTP id
 g14-20020a9d128e000000b00688cf526e18mr1074144otg.4.1677599106749; Tue, 28 Feb
 2023 07:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20230227193535.2822389-1-robdclark@gmail.com> <Y/320d96QmbLe1J8@debian.me>
In-Reply-To: <Y/320d96QmbLe1J8@debian.me>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Feb 2023 07:44:55 -0800
Message-ID: <CAF6AEGuqHDDQS22qcp8sk+5bj16XFiBarCLvpX=qNc2r2euMUw@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] dma-fence: Deadline awareness
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 4:43 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 11:35:06AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This series adds a deadline hint to fences, so realtime deadlines
> > such as vblank can be communicated to the fence signaller for power/
> > frequency management decisions.
> >
> > This is partially inspired by a trick i915 does, but implemented
> > via dma-fence for a couple of reasons:
> >
> > 1) To continue to be able to use the atomic helpers
> > 2) To support cases where display and gpu are different drivers
> >
> > This iteration adds a dma-fence ioctl to set a deadline (both to
> > support igt-tests, and compositors which delay decisions about which
> > client buffer to display), and a sw_sync ioctl to read back the
> > deadline.  IGT tests utilizing these can be found at:
> >
> >   https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline
> >
> >
> > v1: https://patchwork.freedesktop.org/series/93035/
> > v2: Move filtering out of later deadlines to fence implementation
> >     to avoid increasing the size of dma_fence
> > v3: Add support in fence-array and fence-chain; Add some uabi to
> >     support igt tests and userspace compositors.
> > v4: Rebase, address various comments, and add syncobj deadline
> >     support, and sync_file EPOLLPRI based on experience with perf/
> >     freq issues with clvk compute workloads on i915 (anv)
> > v5: Clarify that this is a hint as opposed to a more hard deadline
> >     guarantee, switch to using u64 ns values in UABI (still absolute
> >     CLOCK_MONOTONIC values), drop syncobj related cap and driver
> >     feature flag in favor of allowing count_handles==0 for probing
> >     kernel support.
> > v6: Re-work vblank helper to calculate time of _start_ of vblank,
> >     and work correctly if the last vblank event was more than a
> >     frame ago.  Add (mostly unrelated) drm/msm patch which also
> >     uses the vblank helper.  Use dma_fence_chain_contained().  More
> >     verbose syncobj UABI comments.  Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
> > v7: Fix kbuild complaints about vblank helper.  Add more docs.
> >
>
> I want to apply this series for testing, but it can't be applied cleanly
> on current drm-misc tree. On what tree (and commit) is this series based
> on?

You can find my branch here:

https://gitlab.freedesktop.org/robclark/msm/-/commits/dma-fence/deadline

BR,
-R
