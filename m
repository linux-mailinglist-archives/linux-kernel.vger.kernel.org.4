Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762C6C6A12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCWNyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjCWNyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:54:25 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954CE07A;
        Thu, 23 Mar 2023 06:54:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x22-20020a056830409600b0069b30fb38f7so12150533ott.5;
        Thu, 23 Mar 2023 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679579656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjOvv/ZPDbSli/SQ67teItUX/ZV6UdqvrawXfnsTP9c=;
        b=fABtsO48pFpSWP4FcJ3dhrQvnIbnb6omivu7xuuBdoBA4dAX6OWqKUf4WBRar8getR
         uUDMYAy1h2w23MXumxi25yo+48vMiJEIn5x8S1NDp366vvkhUGWs+owx8UORr2HoHxlB
         ykH2TgdVhWu5Fksfm3zSNiK49GwWe2X3eh6MX118M+k0gIdAaLNdDqMqn75WkLB4TfR0
         r9/ieRqMhlAB9Kw0+rhmW7lPPju/rMRdNh0TgpA3bu3aA0pl3Qbg/wT4E4pMSI3LEu2y
         yN7mf0oNFNDE0wW+qiibGf6aTFeFcMYFoCHx22IFdOen1v8Yj2+ioZPS7pS0fo1NhOXY
         mGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679579656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjOvv/ZPDbSli/SQ67teItUX/ZV6UdqvrawXfnsTP9c=;
        b=qhIZ4zhWHp+oI6YwbqRP/+LQcodSDBy8yhAqSAmDZMQNyarCUGvPe0VXZ4GYubpKko
         V/LKadxUN+9iAZFGIa+kGiG0uSjA8g1K77hJtUGj6NKNty8TZjidkR3QPgFVxK3EKfMk
         STfpTEY9FimaBSJR2yseyIN2LefkjNeNrD8tGVDolGWXc2zMbnA1QfN/JglR0lEvVkvZ
         hz0G963kg4zgoK27Qdx9E2PyGCGC23RSRzsfuDeDRwa4A2doPJpOQ1UPNkugLAIBl0p5
         rxoojBotrQYZrpQuAIOUgvCEEq4qlrAf8Ac3D/G4611Vihq37lcNLzeZxgLL+wX2eENv
         ltnA==
X-Gm-Message-State: AO0yUKUcyg+cpM2L5hMOD1p90tEpVW/nx5lFjQyDNzeHhzjqQ++IHkDb
        N1LlDzR0Aquz+SwDIvEb/0D8hFY4AuZ9lMOq308=
X-Google-Smtp-Source: AK7set+pjqtGtPO6GLHBGh9hBOwDRWaRvZoOvDszymMlwhM38Q5UfQVowYMdv7Wz5SBe768rCFIMjR8hTTsUyroJSF4=
X-Received: by 2002:a05:6830:1483:b0:68b:cd1e:1ef1 with SMTP id
 s3-20020a056830148300b0068bcd1e1ef1mr2274617otq.7.1679579656288; Thu, 23 Mar
 2023 06:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230322224403.35742-1-robdclark@gmail.com> <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
In-Reply-To: <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 23 Mar 2023 06:54:05 -0700
Message-ID: <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com>
Subject: Re: [RFC] drm/scheduler: Unwrap job dependencies
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.03.23 um 23:44 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Container fences have burner contexts, which makes the trick to store a=
t
> > most one fence per context somewhat useless if we don't unwrap array or
> > chain fences.
>
> Mhm, we intentionally kept them not unwrapped since this way they only
> occupy one fence slot.
>
> But it might be better to unwrap them if you add many of those dependenci=
es.
>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > tbh, I'm not sure why we weren't doing this already, unless there is
> > something I'm overlooking
> >
> >   drivers/gpu/drm/scheduler/sched_main.c | 43 +++++++++++++++++--------=
-
> >   1 file changed, 28 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index c2ee44d6224b..f59e5335afbb 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -41,20 +41,21 @@
> >    * 4. Entities themselves maintain a queue of jobs that will be sched=
uled on
> >    *    the hardware.
> >    *
> >    * The jobs in a entity are always scheduled in the order that they w=
ere pushed.
> >    */
> >
> >   #include <linux/kthread.h>
> >   #include <linux/wait.h>
> >   #include <linux/sched.h>
> >   #include <linux/completion.h>
> > +#include <linux/dma-fence-unwrap.h>
> >   #include <linux/dma-resv.h>
> >   #include <uapi/linux/sched/types.h>
> >
> >   #include <drm/drm_print.h>
> >   #include <drm/drm_gem.h>
> >   #include <drm/gpu_scheduler.h>
> >   #include <drm/spsc_queue.h>
> >
> >   #define CREATE_TRACE_POINTS
> >   #include "gpu_scheduler_trace.h"
> > @@ -665,41 +666,27 @@ void drm_sched_job_arm(struct drm_sched_job *job)
> >       sched =3D entity->rq->sched;
> >
> >       job->sched =3D sched;
> >       job->s_priority =3D entity->rq - sched->sched_rq;
> >       job->id =3D atomic64_inc_return(&sched->job_id_count);
> >
> >       drm_sched_fence_init(job->s_fence, job->entity);
> >   }
> >   EXPORT_SYMBOL(drm_sched_job_arm);
> >
> > -/**
> > - * drm_sched_job_add_dependency - adds the fence as a job dependency
> > - * @job: scheduler job to add the dependencies to
> > - * @fence: the dma_fence to add to the list of dependencies.
> > - *
> > - * Note that @fence is consumed in both the success and error cases.
> > - *
> > - * Returns:
> > - * 0 on success, or an error on failing to expand the array.
> > - */
> > -int drm_sched_job_add_dependency(struct drm_sched_job *job,
> > -                              struct dma_fence *fence)
> > +static int _add_dependency(struct drm_sched_job *job, struct dma_fence=
 *fence)
>
> Please keep the drm_sched_job_ prefix here even for static functions.
> The symbol _add_dependency just sucks in a backtrace, especially when
> it's tail optimized.
>
> >   {
> >       struct dma_fence *entry;
> >       unsigned long index;
> >       u32 id =3D 0;
> >       int ret;
> >
> > -     if (!fence)
> > -             return 0;
> > -
> >       /* Deduplicate if we already depend on a fence from the same cont=
ext.
> >        * This lets the size of the array of deps scale with the number =
of
> >        * engines involved, rather than the number of BOs.
> >        */
> >       xa_for_each(&job->dependencies, index, entry) {
> >               if (entry->context !=3D fence->context)
> >                       continue;
> >
> >               if (dma_fence_is_later(fence, entry)) {
> >                       dma_fence_put(entry);
> > @@ -709,20 +696,46 @@ int drm_sched_job_add_dependency(struct drm_sched=
_job *job,
> >               }
> >               return 0;
> >       }
> >
> >       ret =3D xa_alloc(&job->dependencies, &id, fence, xa_limit_32b, GF=
P_KERNEL);
> >       if (ret !=3D 0)
> >               dma_fence_put(fence);
> >
> >       return ret;
> >   }
> > +
> > +/**
> > + * drm_sched_job_add_dependency - adds the fence as a job dependency
> > + * @job: scheduler job to add the dependencies to
> > + * @fence: the dma_fence to add to the list of dependencies.
> > + *
> > + * Note that @fence is consumed in both the success and error cases.
> > + *
> > + * Returns:
> > + * 0 on success, or an error on failing to expand the array.
> > + */
> > +int drm_sched_job_add_dependency(struct drm_sched_job *job,
> > +                              struct dma_fence *fence)
>
> Maybe name the new function drm_sched_job_unwrap_add_dependency or
> something like this.
>
> I need to double check, but I think for some cases we don't need or
> don't even want this in the driver.

I'd be curious to know the cases where you don't want this.. one thing
I was thinking about, what if you have a container fence with two
contained fences.  One is on the same ctx as the job, one is not but
signals sooner.  You end up artificially waiting on both, which seems
sub-optimal.

Anyways, I can make this a new entrypoint which unwraps, and/or rename
the internal static function, if we think this is a good idea.

BR,
-R

> Christian.
>
> > +{
> > +     struct dma_fence_unwrap iter;
> > +     struct dma_fence *f;
> > +     int ret =3D 0;
> > +
> > +     dma_fence_unwrap_for_each (f, &iter, fence) {
> > +             ret =3D _add_dependency(job, f);
> > +             if (ret)
> > +                     break;
> > +     }
> > +
> > +     return ret;
> > +}
> >   EXPORT_SYMBOL(drm_sched_job_add_dependency);
> >
> >   /**
> >    * drm_sched_job_add_resv_dependencies - add all fences from the resv=
 to the job
> >    * @job: scheduler job to add the dependencies to
> >    * @resv: the dma_resv object to get the fences from
> >    * @usage: the dma_resv_usage to use to filter the fences
> >    *
> >    * This adds all fences matching the given usage from @resv to @job.
> >    * Must be called with the @resv lock held.
>
