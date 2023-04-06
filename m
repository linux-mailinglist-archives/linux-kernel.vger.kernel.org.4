Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367D6D91E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjDFIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjDFIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:44:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23633A9C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:44:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-930bc91df7bso127403766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680770689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xD/oYoQmuVCYYubj5pYyTF5ZwsHVOlBiTynaZ7UdEo=;
        b=lcbb76ASGT9XunpGIKRHlL1NPUWe0RRcE7vN4hvsN2AHoEgTP/z0CWxD9QokJhrbbT
         50m9X0ayvwxJXw2ss/DFCMVGbZRpXiWK26LuwCSrA0i6TU971igU0ayFB6yoJKj66R/Y
         ffo4+hkTjhOMw1X/oXy0///sj/3o6sFrwLmww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xD/oYoQmuVCYYubj5pYyTF5ZwsHVOlBiTynaZ7UdEo=;
        b=X/mFR6qyJR55rRwyp+0vTQynieOLXlDu4Lkn+cEg31rdOMcNiPjfGSkCFhEAoQ9eTG
         NPf0UeP0b+n5uKgulqF+fXsjrVwKsgj06H+s5f3A67MMFnuNIOLvEi0J6liWJ/K3++7N
         7TbCToOKWSEcD+UfuuS1GE01J5AKy2RERpfbDe/imShdayvBVLh5bTDIn/fjWQGuW7Iz
         NkpqzgdoJeyEnI0dDslgfDKnB58Ovb/ujCfliXgV51xuQVNrmyQxXYuETE1ld26PbAXR
         z2o7qW0+Uny64885+HO/SmWn5cq1+jDQqnv5lI4eKug7ii7TbNDgqTR3LxpkBHg8SHGr
         wDEA==
X-Gm-Message-State: AAQBX9cdAlFg9KnrEY6xOZMWyAK+LPV3YJeHO94Rb5+Aw4MiGUU7pfpX
        QgM01ao2dZ2XaBuKlp63GDOM3g==
X-Google-Smtp-Source: AKy350ao3Soq7NyBpEE8Islj/4luT04kQkrbekAL/uoxDlAdQ7a6fvIRUFarl1zcrCtbql5vi7w7zw==
X-Received: by 2002:a17:906:2216:b0:947:bff2:1c2d with SMTP id s22-20020a170906221600b00947bff21c2dmr5786279ejs.3.1680770689396;
        Thu, 06 Apr 2023 01:44:49 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906074500b00930569e6910sm530809ejb.16.2023.04.06.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:44:49 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:44:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
Message-ID: <ZC6Gf+vl5Jem44Fw@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Asahi Lina <lina@asahilina.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
References: <20230406-scheduler-uaf-1-v1-1-8e5662269d25@asahilina.net>
 <6b3433ee-0712-f789-51ee-3047ead9bb79@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b3433ee-0712-f789-51ee-3047ead9bb79@amd.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:29:57AM +0200, Christian König wrote:
> Am 05.04.23 um 18:34 schrieb Asahi Lina:
> > A signaled scheduler fence can outlive its scheduler, since fences are
> > independently reference counted.
> 
> Well that is actually not correct. Schedulers are supposed to stay around
> until the hw they have been driving is no longer present.
> 
> E.g. the reference was scheduler_fence->hw_fence->driver->scheduler.
> 
> Your use case is now completely different to that and this won't work any
> more.

This is why I'm a bit a broken record suggesting that for the fw scheduler
case, where we have drm_sched_entity:drm_scheduler 1:1 and created at
runtime, we really should rework the interface exposed to drivers:

- drm_scheduler stays the thing that's per-engine and stays around for as
  long as the driver

- We split out a drm_sched_internal, which is either tied to drm_scheduler
  (ringbuffer scheduler mode) or drm_sched_entity (fw ctx scheduling
  mode).

- drm/sched internals are updated to dtrt in all these cases. And there's
  a lot, stuff like drm_sched_job is quite tricky if each driver needs to
  protect against concurrent ctx/entity creation/destruction, and I really
  don't like the idea that drivers hand-roll this kind of tricky state
  transition code that's used in the exceptional tdr/gpu/fw-death
  situation all themselves.
 
> This here might just be the first case where that breaks.

Yeah I expect there's going to be a solid stream of these, and we're just
going to random-walk in circles if this effort doesn't come with at least
some amount of design.

Thus far no one really comment on the above plan though, so I'm not sure
what the consensu plan is among all the various fw-scheduling driver
efforts ...
-Daniel

> 
> Regards,
> Christian.
> 
> >   Therefore, we can't reference the
> > scheduler in the get_timeline_name() implementation.
> > 
> > Fixes oopses on `cat /sys/kernel/debug/dma_buf/bufinfo` when shared
> > dma-bufs reference fences from GPU schedulers that no longer exist.
> > 
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > ---
> >   drivers/gpu/drm/scheduler/sched_entity.c | 7 ++++++-
> >   drivers/gpu/drm/scheduler/sched_fence.c  | 4 +++-
> >   include/drm/gpu_scheduler.h              | 5 +++++
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> > index 15d04a0ec623..8b3b949b2ce8 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -368,7 +368,12 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
> >   		/*
> >   		 * Fence is from the same scheduler, only need to wait for
> > -		 * it to be scheduled
> > +		 * it to be scheduled.
> > +		 *
> > +		 * Note: s_fence->sched could have been freed and reallocated
> > +		 * as another scheduler. This false positive case is okay, as if
> > +		 * the old scheduler was freed all of its jobs must have
> > +		 * signaled their completion fences.
> >   		 */
> >   		fence = dma_fence_get(&s_fence->scheduled);
> >   		dma_fence_put(entity->dependency);
> > diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> > index 7fd869520ef2..33b145dfa38c 100644
> > --- a/drivers/gpu/drm/scheduler/sched_fence.c
> > +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> > @@ -66,7 +66,7 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
> >   static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
> >   {
> >   	struct drm_sched_fence *fence = to_drm_sched_fence(f);
> > -	return (const char *)fence->sched->name;
> > +	return (const char *)fence->sched_name;
> >   }
> >   static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
> > @@ -168,6 +168,8 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
> >   	unsigned seq;
> >   	fence->sched = entity->rq->sched;
> > +	strlcpy(fence->sched_name, entity->rq->sched->name,
> > +		sizeof(fence->sched_name));
> >   	seq = atomic_inc_return(&entity->fence_seq);
> >   	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
> >   		       &fence->lock, entity->fence_context, seq);
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index 9db9e5e504ee..49f019731891 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -295,6 +295,11 @@ struct drm_sched_fence {
> >            * @lock: the lock used by the scheduled and the finished fences.
> >            */
> >   	spinlock_t			lock;
> > +        /**
> > +         * @sched_name: the name of the scheduler that owns this fence. We
> > +         * keep a copy here since fences can outlive their scheduler.
> > +         */
> > +	char sched_name[16];
> >           /**
> >            * @owner: job owner for debugging
> >            */
> > 
> > ---
> > base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> > change-id: 20230406-scheduler-uaf-1-994ec34cac93
> > 
> > Thank you,
> > ~~ Lina
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
