Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A526154F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKAW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:29:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA5DFB7;
        Tue,  1 Nov 2022 15:29:12 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so2258744oop.9;
        Tue, 01 Nov 2022 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkzEUyl2aPrJCEJ2Lx0JtWG1kofrnzJEL+LzA1fV9kY=;
        b=hJPWI/W8Az+4Bg3JBiOZWgsQ+Xy47ABvBcSkEeA82TNgCKvtkOuYKGlBpsvruRFpXC
         cu4UrriQYP4Kf0G2+9MSBbduChVcRtzOe5mkEaiD+I6TNU27OfDAEEfk4bj5LOZKP52z
         PALf61PnQ5nWA+fCyi2esvLMVs/Rvo9i5X3d/YPReX/C3FVV3SqOufuDpN85gYu2L2uu
         zabo+KZWbikMk62XNFVezW3T+iyajM3zj+4ItlRg6fWiJZZIxeGM2x8tOTvaOhgx/9eb
         WRW/ciOULrABT9vozx6g2g1juieEHAef2CzNgWUqbu+b+h5LXrGOG5rlj8QLaJw+ecOi
         cfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkzEUyl2aPrJCEJ2Lx0JtWG1kofrnzJEL+LzA1fV9kY=;
        b=WOlX8iiATUeB6vj7l3dLpXdnzPiEUGER8wqRsMPvKU9MyR4e/+mf3QUNT6vs7L7omB
         hFqxDgsIx9LDloNiqjXeNbJSSTx6chuv07aQZbsKskcY1mgySpm70bJ4Fw1gvmYNRWM4
         YocquZDCSJpFFY2XOPkfXa6HPJJYl8d9f2XnljMyDB9tEcE2ZKtl+ny2KV/UP1JrxBLr
         u4AD2xNrKoUwrIDlnDKqWeMhqRpSmsK3VMKNbtKRwt3ajRonjQYmQYHnaKlkhHe83PF/
         2tTDEgj7a6f4f+yl5TaKxlPsuzbmMKiENWQ9Bz7D0/xCWbkBXNu0CWHLYO7WHsriFGoM
         Y7sQ==
X-Gm-Message-State: ACrzQf1PwtvyczwiaMOO6nJg7SL2jeASIRf0ugTXTiGXgGsKxAB2MzTB
        NbwnNXELG9whf5sIdF1PT2H/uGC+c1WKyN2yjzw=
X-Google-Smtp-Source: AMsMyM5ymTtkXNGeFfcHFDpfAeD/6wct1Bkjuwddmtg784RsHfgUiImexNdheVrN9Cf/lqfEr2i17R6o+ICXNRu+x1o=
X-Received: by 2002:a4a:e2d3:0:b0:497:e693:10d6 with SMTP id
 l19-20020a4ae2d3000000b00497e69310d6mr8939311oot.92.1667341751801; Tue, 01
 Nov 2022 15:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221031225414.1280169-1-robdclark@gmail.com> <20221031225414.1280169-3-robdclark@gmail.com>
 <fa56debb-41cb-6b91-3f22-f41ffca98fdc@quicinc.com>
In-Reply-To: <fa56debb-41cb-6b91-3f22-f41ffca98fdc@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 1 Nov 2022 15:29:28 -0700
Message-ID: <CAF6AEGvvbEhAEuWP3Go9otFF5fBtvp-QMmx4xxjAnr=AwvuxnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: Hangcheck progress detection
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Nov 1, 2022 at 12:54 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 11/1/2022 4:24 AM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If the hangcheck timer expires, check if the fw's position in the
> > cmdstream has advanced (changed) since last timer expiration, and
> > allow it up to three additional "extensions" to it's alotted time.
> > The intention is to continue to catch "shader stuck in a loop" type
> > hangs quickly, but allow more time for things that are actually
> > making forward progress.
> >
> > Because we need to sample the CP state twice to detect if there has
> > not been progress, this also cuts the the timer's duration in half.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 34 +++++++++++++++++++++++++++
> >   drivers/gpu/drm/msm/msm_drv.h         |  8 ++++++-
> >   drivers/gpu/drm/msm/msm_gpu.c         | 20 +++++++++++++++-
> >   drivers/gpu/drm/msm/msm_gpu.h         |  5 +++-
> >   drivers/gpu/drm/msm/msm_ringbuffer.h  | 24 +++++++++++++++++++
> >   5 files changed, 88 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 1ff605c18ee6..3b8fb7a11dff 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1843,6 +1843,39 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> >       return ring->memptrs->rptr = gpu_read(gpu, REG_A6XX_CP_RB_RPTR);
> >   }
> >
> > +static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> > +{
> > +     struct msm_cp_state cp_state = {
> > +             .ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
> > +             .ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
> > +             .ib1_rem  = gpu_read(gpu, REG_A6XX_CP_IB1_REM_SIZE),
> > +             .ib2_rem  = gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE),
> > +     };
> > +     bool progress;
> > +
> > +     /*
> > +      * Adjust the remaining data to account for what has already been
> > +      * fetched from memory, but not yet consumed by the SQE.
> > +      *
> > +      * This is not *technically* correct, the amount buffered could
> > +      * exceed the IB size due to hw prefetching ahead, but:
> > +      *
> > +      * (1) We aren't trying to find the exact position, just whether
> > +      *     progress has been made
> > +      * (2) The CP_REG_TO_MEM at the end of a submit should be enough
> > +      *     to prevent prefetching into an unrelated submit.  (And
> > +      *     either way, at some point the ROQ will be full.)
> > +      */
> > +     cp_state.ib1_rem += gpu_read(gpu, REG_A6XX_CP_CSQ_IB1_STAT) >> 16;
> > +     cp_state.ib2_rem += gpu_read(gpu, REG_A6XX_CP_CSQ_IB1_STAT) >> 16;
> REG_A6XX_CP_CSQ_IB1_STAT -> REG_A6XX_CP_CSQ_IB2_STAT

oops, will fix in v2

> With that, Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>
> -Akhil.
> > +
> > +     progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state));
> > +
> > +     ring->last_cp_state = cp_state;
> > +
> > +     return progress;
> > +}
> > +
> >   static u32 a618_get_speed_bin(u32 fuse)
> >   {
> >       if (fuse == 0)
> > @@ -1961,6 +1994,7 @@ static const struct adreno_gpu_funcs funcs = {
> >               .create_address_space = a6xx_create_address_space,
> >               .create_private_address_space = a6xx_create_private_address_space,
> >               .get_rptr = a6xx_get_rptr,
> > +             .progress = a6xx_progress,
> >       },
> >       .get_timestamp = a6xx_get_timestamp,
> >   };
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> > index efcd7260f428..970a1a0ab34f 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -226,7 +226,13 @@ struct msm_drm_private {
> >
> >       struct drm_atomic_state *pm_state;
> >
> > -     /* For hang detection, in ms */
> > +     /**
> > +      * hangcheck_period: For hang detection, in ms
> > +      *
> > +      * Note that in practice, a submit/job will get at least two hangcheck
> > +      * periods, due to checking for progress being implemented as simply
> > +      * "have the CP position registers changed since last time?"
> > +      */
> >       unsigned int hangcheck_period;
> >
> >       /**
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index 3dffee54a951..136f5977b0bf 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -500,6 +500,21 @@ static void hangcheck_timer_reset(struct msm_gpu *gpu)
> >                       round_jiffies_up(jiffies + msecs_to_jiffies(priv->hangcheck_period)));
> >   }
> >
> > +static bool made_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> > +{
> > +     if (ring->hangcheck_progress_retries >= DRM_MSM_HANGCHECK_PROGRESS_RETRIES)
> > +             return false;
> > +
> > +     if (!gpu->funcs->progress)
> > +             return false;
> > +
> > +     if (!gpu->funcs->progress(gpu, ring))
> > +             return false;
> > +
> > +     ring->hangcheck_progress_retries++;
> > +     return true;
> > +}
> > +
> >   static void hangcheck_handler(struct timer_list *t)
> >   {
> >       struct msm_gpu *gpu = from_timer(gpu, t, hangcheck_timer);
> > @@ -511,9 +526,12 @@ static void hangcheck_handler(struct timer_list *t)
> >       if (fence != ring->hangcheck_fence) {
> >               /* some progress has been made.. ya! */
> >               ring->hangcheck_fence = fence;
> > -     } else if (fence_before(fence, ring->fctx->last_fence)) {
> > +             ring->hangcheck_progress_retries = 0;
> > +     } else if (fence_before(fence, ring->fctx->last_fence) &&
> > +                     !made_progress(gpu, ring)) {
> >               /* no progress and not done.. hung! */
> >               ring->hangcheck_fence = fence;
> > +             ring->hangcheck_progress_retries = 0;
> >               DRM_DEV_ERROR(dev->dev, "%s: hangcheck detected gpu lockup rb %d!\n",
> >                               gpu->name, ring->id);
> >               DRM_DEV_ERROR(dev->dev, "%s:     completed fence: %u\n",
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index 585fd9c8d45a..d8f355e9f0b2 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -78,6 +78,8 @@ struct msm_gpu_funcs {
> >       struct msm_gem_address_space *(*create_private_address_space)
> >               (struct msm_gpu *gpu);
> >       uint32_t (*get_rptr)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> > +
> > +     bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> >   };
> >
> >   /* Additional state for iommu faults: */
> > @@ -236,7 +238,8 @@ struct msm_gpu {
> >        */
> >   #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> >
> > -#define DRM_MSM_HANGCHECK_DEFAULT_PERIOD 500 /* in ms */
> > +#define DRM_MSM_HANGCHECK_DEFAULT_PERIOD 250 /* in ms */
> > +#define DRM_MSM_HANGCHECK_PROGRESS_RETRIES 3
> >       struct timer_list hangcheck_timer;
> >
> >       /* Fault info for most recent iova fault: */
> > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > index 2a5045abe46e..e3d33bae3380 100644
> > --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > @@ -35,6 +35,11 @@ struct msm_rbmemptrs {
> >       volatile u64 ttbr0;
> >   };
> >
> > +struct msm_cp_state {
> > +     uint64_t ib1_base, ib2_base;
> > +     uint32_t ib1_rem, ib2_rem;
> > +};
> > +
> I think we can add CP_RB_RPTR too here.

I originally was going to, but I figured if it is making progress in
the RB, probably fences will be getting updated.  And if not at least
IB1 state should be changing, since we don't write all that much into
RB other than CP_INDIRECT_BRANCH (ie. nothing that would take long
enough to run for hangcheck timer to expire)

I guess I could at least add a comment.

BR,
-R

> >   struct msm_ringbuffer {
> >       struct msm_gpu *gpu;
> >       int id;
> > @@ -64,6 +69,25 @@ struct msm_ringbuffer {
> >       uint64_t memptrs_iova;
> >       struct msm_fence_context *fctx;
> >
> > +     /**
> > +      * hangcheck_progress_retries:
> > +      *
> > +      * The number of extra hangcheck duration cycles that we have given
> > +      * due to it appearing that the GPU is making forward progress.
> > +      *
> > +      * If the GPU appears to be making progress (ie. the CP has advanced
> > +      * in the command stream, we'll allow up to DRM_MSM_HANGCHECK_PROGRESS_RETRIES
> > +      * expirations of the hangcheck timer before killing the job.  In other
> > +      * words we'll let the submit run for up to
> > +      * DRM_MSM_HANGCHECK_DEFAULT_PERIOD *  DRM_MSM_HANGCHECK_PROGRESS_RETRIES
> > +      */
> > +     int hangcheck_progress_retries;
> > +
> > +     /**
> > +      * last_cp_state: The state of the CP at the last call to gpu->progress()
> > +      */
> > +     struct msm_cp_state last_cp_state;
> > +
> >       /*
> >        * preempt_lock protects preemption and serializes wptr updates against
> >        * preemption.  Can be aquired from irq context.
>
