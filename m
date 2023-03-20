Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11566C22C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCTUdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCTUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:32:59 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FC7D8B;
        Mon, 20 Mar 2023 13:32:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w2so3070935oiv.5;
        Mon, 20 Mar 2023 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PtNLjV7iuzWid1kzKLl77sk4WYUZ8FOv4+N6gzs8sI=;
        b=HeqJeprrNl5/vk7X1eAw7lmrGamJCZjLBSnMVH3QHjezjvIoMR73/Wq8ZzqKOkFB5N
         atRxNwUb3cHURFE7latn17tFQ8yLJkHprLyjdp9Vydlntu+0A5EHB2rJyKtrS1+1y81I
         ukl33H9vCwntemYpjEToqC/v5hhPXFuEq8ZaBA9NaY0FOUXxqpLwP7C1O9cdG1B1DSRC
         PXqRrgbikK/KHC2NlWdIWC9Wmq/rASHk5jI+K7czu3cPa4UzKrykhI9QBV8WWZAtlPPO
         bK9sT7n00/rWO8dSAo1TPubS2mnScaGxD4le5Sb3lmSymjIEnMRn4O6kvifzG6r0IGoz
         oEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PtNLjV7iuzWid1kzKLl77sk4WYUZ8FOv4+N6gzs8sI=;
        b=k7tdLmxnqTw7+VTFolNCWQK4sUGbKbgoX5Q90tarJWTKWCbSKh9C1x5lEmJmy6CUB4
         0XvGMHMfOQG6jzLs7nO8Gpt+cMeiBHFVfgl7nxgufyI6wq7OoYY3ePm6a5G9PUHxF9Hb
         4qiiEo6XrYg5JSHFJ4fv2rhYw/tW8AfBd3JCKUwOYWkDyG67QreoF5Eo1XBmlWfXI02q
         xAD4MWLszl9icUB03suOTdYtnWfauWxslD8WCDYxaOJRKI6T2clAp3Cutpewu2F4kJev
         44fAvgXZipK/NEM2UBxQPf36yo9fcEKOAMuNFwVwfO/eFUMIhQwdU1Tm47jjSRuslaZK
         ZXrA==
X-Gm-Message-State: AO0yUKUElPerOWbBHRu/R1ljiFgBZlh8UcNT9Q1qar137epStzfG2uIZ
        sOGiE7pluCq4wZaK8wo/u4eVY9j2Rz+JwELeqF0=
X-Google-Smtp-Source: AK7set+Z8dm+jxrjXl9udF5iuBLZsy2vXRBn1hk4Q0LgCSqrniaiZyZA8FUks4Jf+kvfsz6lfqPFa4aG1yMoSgx//Zc=
X-Received: by 2002:aca:1009:0:b0:384:1cf9:912e with SMTP id
 9-20020aca1009000000b003841cf9912emr445842oiq.5.1679344373225; Mon, 20 Mar
 2023 13:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230320144356.803762-1-robdclark@gmail.com> <20230320144356.803762-2-robdclark@gmail.com>
 <25bd9a77-a703-6eb6-e142-5da9e54754a0@amd.com>
In-Reply-To: <25bd9a77-a703-6eb6-e142-5da9e54754a0@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Mar 2023 13:32:41 -0700
Message-ID: <CAF6AEGuhkEy-RebX76wT+MVYvsArDKmHsqcBcdE95p2bW_zfGg@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] drm/msm: Pre-allocate hw_fence
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
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

On Mon, Mar 20, 2023 at 9:52=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 20.03.23 um 15:43 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Avoid allocating memory in job_run() by pre-allocating the hw_fence.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_fence.c      | 12 +++++++++---
> >   drivers/gpu/drm/msm/msm_fence.h      |  3 ++-
> >   drivers/gpu/drm/msm/msm_gem_submit.c |  7 +++++++
> >   drivers/gpu/drm/msm/msm_ringbuffer.c |  2 +-
> >   4 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_=
fence.c
> > index 56641408ea74..bab3d84f1686 100644
> > --- a/drivers/gpu/drm/msm/msm_fence.c
> > +++ b/drivers/gpu/drm/msm/msm_fence.c
> > @@ -99,7 +99,7 @@ static const struct dma_fence_ops msm_fence_ops =3D {
> >   };
> >
> >   struct dma_fence *
> > -msm_fence_alloc(struct msm_fence_context *fctx)
> > +msm_fence_alloc(void)
> >   {
> >       struct msm_fence *f;
> >
> > @@ -107,10 +107,16 @@ msm_fence_alloc(struct msm_fence_context *fctx)
> >       if (!f)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     return &f->base;
> > +}
> > +
> > +void
> > +msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx=
)
> > +{
> > +     struct msm_fence *f =3D to_msm_fence(fence);
> > +
> >       f->fctx =3D fctx;
> >
> >       dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
> >                      fctx->context, ++fctx->last_fence);
> > -
> > -     return &f->base;
> >   }
> > diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/msm_=
fence.h
> > index 7f1798c54cd1..f913fa22d8fe 100644
> > --- a/drivers/gpu/drm/msm/msm_fence.h
> > +++ b/drivers/gpu/drm/msm/msm_fence.h
> > @@ -61,7 +61,8 @@ void msm_fence_context_free(struct msm_fence_context =
*fctx);
> >   bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fen=
ce);
> >   void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)=
;
> >
> > -struct dma_fence * msm_fence_alloc(struct msm_fence_context *fctx);
> > +struct dma_fence * msm_fence_alloc(void);
> > +void msm_fence_init(struct dma_fence *fence, struct msm_fence_context =
*fctx);
> >
> >   static inline bool
> >   fence_before(uint32_t a, uint32_t b)
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm=
/msm_gem_submit.c
> > index be4bf77103cd..2570c018b0cb 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -41,6 +41,13 @@ static struct msm_gem_submit *submit_create(struct d=
rm_device *dev,
> >       if (!submit)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     submit->hw_fence =3D msm_fence_alloc();
> > +     if (IS_ERR(submit->hw_fence)) {
> > +             ret =3D PTR_ERR(submit->hw_fence);
> > +             kfree(submit);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> >       ret =3D drm_sched_job_init(&submit->base, queue->entity, queue);
> >       if (ret) {
> >               kfree(submit);
>
> You probably need some error handling here or otherwise leak
> submit->hw_fence.

ah, right.. thx

BR,
-R

> Apart from that looks good to me.
>
> Christian.
>
> > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm=
/msm_ringbuffer.c
> > index 57a8e9564540..a62b45e5a8c3 100644
> > --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> > @@ -18,7 +18,7 @@ static struct dma_fence *msm_job_run(struct drm_sched=
_job *job)
> >       struct msm_gpu *gpu =3D submit->gpu;
> >       int i;
> >
> > -     submit->hw_fence =3D msm_fence_alloc(fctx);
> > +     msm_fence_init(submit->hw_fence, fctx);
> >
> >       for (i =3D 0; i < submit->nr_bos; i++) {
> >               struct drm_gem_object *obj =3D &submit->bos[i].obj->base;
>
