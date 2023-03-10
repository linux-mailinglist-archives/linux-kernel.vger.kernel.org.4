Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63CF6B4EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCJRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCJRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:39:13 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A984711BB31;
        Fri, 10 Mar 2023 09:38:33 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id e21so4841289oie.1;
        Fri, 10 Mar 2023 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678469910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsOaKf3a4jZHrbik3Jd7qbDgnpqS0mM6+x0lu8IoHfM=;
        b=pjkdNpNmt+ALlrJrHctUkhawmSaFrE2Be37KvOgtI9iz4GCFVXVY87aRwdtVMH+rpu
         fJunVMhRYDIwNCorEZ9lHSDFyI8ohk7ZPO9jdbCfgTbUEp/OShCEvP2bnnwWfU4t/UZ+
         F9zqdmkfotow9b0NdVq/IpOfPEr9xt7QuydItnh1gVxwdqP2OReJo898JV+2ayHrr3rQ
         Npb+E0ol5xi5nDs94aQKMEoGzaw9rr56dP09XOzogtpYLOlw4kFLdX3B+JnXEPpuO4Fy
         glKtOkJltX83HJax73YyRqB7UEOhw1E2fLWB/Aw47hX9Rrlm05o0TAJJ/cD4gfFXfIX8
         IQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678469910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsOaKf3a4jZHrbik3Jd7qbDgnpqS0mM6+x0lu8IoHfM=;
        b=PHccRoQWP49OIifnhCixcrWhKkpca5FkOygIOy8kxeQH1WqAftjCR1fd2nrv3ftTU6
         GJw+P3BlwUJanW40GF9nngcdgUyIe2KvjjvLfrLomeyP6uS+AW+T7gh8L9wighRcN2RL
         RctlZnIUD4H3k9yd4UiGBxSN6Vi0laahN6s2NhLREak0r85jqe+tUCfi6JY6SI0bN8V+
         l4/3s/FJ6TJbsfn5d4FaJ0qB5mL8N6gIGTFP60O8SyZjJHRkqguKv6N9H7zOMfFk0t37
         jf1thGiP4dJEMTwBCQHTU/X0RExunxgoepu1ddofJ3L6dXI9/1cS2ILY5hkuZN9JofLZ
         c5aQ==
X-Gm-Message-State: AO0yUKVzQtmQi8JEGjHS023O164oi8f6a8zi+wEw8KmzM3Cu283PypkP
        fehpaCDWRFFuU6pw8oVYkJlHiJXQJgpSOpRDzYo=
X-Google-Smtp-Source: AK7set80Va96YaUkueCKeimiOQ/Nf2+CqzU5px/wg2FuCZZCw9TM3btgVcDxhyt0C8qXiFNfx/s0JhtJXkhdAdISJd8=
X-Received: by 2002:a54:4501:0:b0:383:f933:98ae with SMTP id
 l1-20020a544501000000b00383f93398aemr8811212oil.3.1678469909709; Fri, 10 Mar
 2023 09:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20230308155322.344664-1-robdclark@gmail.com> <20230308155322.344664-2-robdclark@gmail.com>
 <ZAtQspuFjPtGy7ze@gmail.com>
In-Reply-To: <ZAtQspuFjPtGy7ze@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 10 Mar 2023 09:38:18 -0800
Message-ID: <CAF6AEGsGOr5+Q10wX=5ttrWCSUJfn7gzHW8QhxFC0GDLgagMHg@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] dma-buf/dma-fence: Add deadline awareness
To:     =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
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

On Fri, Mar 10, 2023 at 7:45=E2=80=AFAM Jonas =C3=85dahl <jadahl@gmail.com>=
 wrote:
>
> On Wed, Mar 08, 2023 at 07:52:52AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a way to hint to the fence signaler of an upcoming deadline, such a=
s
> > vblank, which the fence waiter would prefer not to miss.  This is to ai=
d
> > the fence signaler in making power management decisions, like boosting
> > frequency as the deadline approaches and awareness of missing deadlines
> > so that can be factored in to the frequency scaling.
> >
> > v2: Drop dma_fence::deadline and related logic to filter duplicate
> >     deadlines, to avoid increasing dma_fence size.  The fence-context
> >     implementation will need similar logic to track deadlines of all
> >     the fences on the same timeline.  [ckoenig]
> > v3: Clarify locking wrt. set_deadline callback
> > v4: Clarify in docs comment that this is a hint
> > v5: Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
> > v6: More docs
> > v7: Fix typo, clarify past deadlines
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
>
> Hi Rob!
>
> >  Documentation/driver-api/dma-buf.rst |  6 +++
> >  drivers/dma-buf/dma-fence.c          | 59 ++++++++++++++++++++++++++++
> >  include/linux/dma-fence.h            | 22 +++++++++++
> >  3 files changed, 87 insertions(+)
> >
> > diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/drive=
r-api/dma-buf.rst
> > index 622b8156d212..183e480d8cea 100644
> > --- a/Documentation/driver-api/dma-buf.rst
> > +++ b/Documentation/driver-api/dma-buf.rst
> > @@ -164,6 +164,12 @@ DMA Fence Signalling Annotations
> >  .. kernel-doc:: drivers/dma-buf/dma-fence.c
> >     :doc: fence signalling annotation
> >
> > +DMA Fence Deadline Hints
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> > +   :doc: deadline hints
> > +
> >  DMA Fences Functions Reference
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 0de0482cd36e..f177c56269bb 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -912,6 +912,65 @@ dma_fence_wait_any_timeout(struct dma_fence **fenc=
es, uint32_t count,
> >  }
> >  EXPORT_SYMBOL(dma_fence_wait_any_timeout);
> >
> > +/**
> > + * DOC: deadline hints
> > + *
> > + * In an ideal world, it would be possible to pipeline a workload suff=
iciently
> > + * that a utilization based device frequency governor could arrive at =
a minimum
> > + * frequency that meets the requirements of the use-case, in order to =
minimize
> > + * power consumption.  But in the real world there are many workloads =
which
> > + * defy this ideal.  For example, but not limited to:
> > + *
> > + * * Workloads that ping-pong between device and CPU, with alternating=
 periods
> > + *   of CPU waiting for device, and device waiting on CPU.  This can r=
esult in
> > + *   devfreq and cpufreq seeing idle time in their respective domains =
and in
> > + *   result reduce frequency.
> > + *
> > + * * Workloads that interact with a periodic time based deadline, such=
 as double
> > + *   buffered GPU rendering vs vblank sync'd page flipping.  In this s=
cenario,
> > + *   missing a vblank deadline results in an *increase* in idle time o=
n the GPU
> > + *   (since it has to wait an additional vblank period), sending a sig=
nal to
> > + *   the GPU's devfreq to reduce frequency, when in fact the opposite =
is what is
> > + *   needed.
>
> This is the use case I'd like to get some better understanding about how
> this series intends to work, as the problematic scheduling behavior
> triggered by missed deadlines has plagued compositing display servers
> for a long time.
>
> I apologize, I'm not a GPU driver developer, nor an OpenGL driver
> developer, so I will need some hand holding when it comes to
> understanding exactly what piece of software is responsible for
> communicating what piece of information.
>
> > + *
> > + * To this end, deadline hint(s) can be set on a &dma_fence via &dma_f=
ence_set_deadline.
> > + * The deadline hint provides a way for the waiting driver, or userspa=
ce, to
> > + * convey an appropriate sense of urgency to the signaling driver.
> > + *
> > + * A deadline hint is given in absolute ktime (CLOCK_MONOTONIC for use=
rspace
> > + * facing APIs).  The time could either be some point in the future (s=
uch as
> > + * the vblank based deadline for page-flipping, or the start of a comp=
ositor's
> > + * composition cycle), or the current time to indicate an immediate de=
adline
> > + * hint (Ie. forward progress cannot be made until this fence is signa=
led).
>
> Is it guaranteed that a GPU driver will use the actual start of the
> vblank as the effective deadline? I have some memories of seing
> something about vblank evasion browsing driver code, which I might have
> misunderstood, but I have yet to find whether this is something
> userspace can actually expect to be something it can rely on.

I guess you mean s/GPU driver/display driver/ ?  It makes things more
clear if we talk about them separately even if they happen to be the
same device.

Assuming that is what you mean, nothing strongly defines what the
deadline is.  In practice there is probably some buffering in the
display controller.  For ex, block based (including bandwidth
compressed) formats, you need to buffer up a row of blocks to
efficiently linearize for scanout.  So you probably need to latch some
time before you start sending pixel data to the display.  But details
like this are heavily implementation dependent.  I think the most
reasonable thing to target is start of vblank.

Also, keep in mind the deadline hint is just that.  It won't magically
make the GPU finish by that deadline, but it gives the GPU driver
information about lateness so it can realize if it needs to clock up.

> Can userspace set a deadline that targets the next vblank deadline
> before GPU work has been flushed e.g. at the start of a paint cycle, and
> still be sure that the kernel has the information it needs to know it sho=
uld
> make its clocks increase their speed in time for when the actual work
> has been actually flushed? Or is it needed that the this deadline is set
> at the end?

You need a fence to set the deadline, and for that work needs to be
flushed.  But you can't associate a deadline with work that the kernel
is unaware of anyways.

> What I'm more or less trying to ask is, will a mode setting compositor
> be able to tell the kernel to boost its clocks at the time it knows is
> best, and how will it in practice achieve this?

The anticipated usage for a compositor is that, when you receive a
<buf, fence> pair from an app, you immediately set a deadline for
upcoming start-of-vblank on the fence fd passed from the app.  (Or for
implicit sync you can use DMA_BUF_IOCTL_EXPORT_SYNC_FILE).  For the
composite step, no need to set a deadline as this is already done on
the kernel side in drm_atomic_helper_wait_for_fences().

> For example relying on the atomic mode setting commit setting the
> deadline is fundamentally flawed, since user space will at times want to
> purposefully delay committing until as late as possible, without doing
> so causing an increased risk of missing the deadline due to the kernel
> not speeding up clocks at the right time for GPU work that has already
> been flushed long ago.

Right, this is the point for exposing the ioctl to userspace.

> Relying on commits also has no effect on GPU work queued by
> a compositor drawing only to dma-bufs that are never intended to be
> presented using mode setting. How can we make sure a compositor can
> provide hints that the kernel will know to respect despite the
> compositor not being drm master?

It doesn't matter if there are indirect dependencies.  Even if the
compositor completely ignores deadline hints and fancy tricks like
delaying composite decisions, the indirect dependency (app rendering)
will delay the direct dependency (compositor rendering) of the page
flip.  So the driver will still see whether it is late or early
compared to the deadline, allowing it to adjust freq in the
appropriate direction for the next frame.

BR,
-R

>
> Jonas
>
> > + *
> > + * Multiple deadlines may be set on a given fence, even in parallel.  =
See the
> > + * documentation for &dma_fence_ops.set_deadline.
> > + *
> > + * The deadline hint is just that, a hint.  The driver that created th=
e fence
> > + * may react by increasing frequency, making different scheduling choi=
ces, etc.
> > + * Or doing nothing at all.
> > + */
> > +
> > +/**
> > + * dma_fence_set_deadline - set desired fence-wait deadline hint
> > + * @fence:    the fence that is to be waited on
> > + * @deadline: the time by which the waiter hopes for the fence to be
> > + *            signaled
> > + *
> > + * Give the fence signaler a hint about an upcoming deadline, such as
> > + * vblank, by which point the waiter would prefer the fence to be
> > + * signaled by.  This is intended to give feedback to the fence signal=
er
> > + * to aid in power management decisions, such as boosting GPU frequenc=
y
> > + * if a periodic vblank deadline is approaching but the fence is not
> > + * yet signaled..
> > + */
> > +void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> > +{
> > +     if (fence->ops->set_deadline && !dma_fence_is_signaled(fence))
> > +             fence->ops->set_deadline(fence, deadline);
> > +}
> > +EXPORT_SYMBOL(dma_fence_set_deadline);
> > +
> >  /**
> >   * dma_fence_describe - Dump fence describtion into seq_file
> >   * @fence: the 6fence to describe
> > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > index 775cdc0b4f24..d54b595a0fe0 100644
> > --- a/include/linux/dma-fence.h
> > +++ b/include/linux/dma-fence.h
> > @@ -257,6 +257,26 @@ struct dma_fence_ops {
> >        */
> >       void (*timeline_value_str)(struct dma_fence *fence,
> >                                  char *str, int size);
> > +
> > +     /**
> > +      * @set_deadline:
> > +      *
> > +      * Callback to allow a fence waiter to inform the fence signaler =
of
> > +      * an upcoming deadline, such as vblank, by which point the waite=
r
> > +      * would prefer the fence to be signaled by.  This is intended to
> > +      * give feedback to the fence signaler to aid in power management
> > +      * decisions, such as boosting GPU frequency.
> > +      *
> > +      * This is called without &dma_fence.lock held, it can be called
> > +      * multiple times and from any context.  Locking is up to the cal=
lee
> > +      * if it has some state to manage.  If multiple deadlines are set=
,
> > +      * the expectation is to track the soonest one.  If the deadline =
is
> > +      * before the current time, it should be interpreted as an immedi=
ate
> > +      * deadline.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     void (*set_deadline)(struct dma_fence *fence, ktime_t deadline);
> >  };
> >
> >  void dma_fence_init(struct dma_fence *fence, const struct dma_fence_op=
s *ops,
> > @@ -583,6 +603,8 @@ static inline signed long dma_fence_wait(struct dma=
_fence *fence, bool intr)
> >       return ret < 0 ? ret : 0;
> >  }
> >
> > +void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)=
;
> > +
> >  struct dma_fence *dma_fence_get_stub(void);
> >  struct dma_fence *dma_fence_allocate_private_stub(void);
> >  u64 dma_fence_context_alloc(unsigned num);
> > --
> > 2.39.2
> >
