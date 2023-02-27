Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630086A4EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjB0WwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB0Wv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA729431
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677538261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pA2l/M+RwgFn7X5RBLShKIcqd1rRLy2xsj8gNSfBQ8=;
        b=gxO9SEur7wfCOAyFNA+xPTU3sp0wbLaTfPxMRApkBBcvr0LFeC9dsvCzzzqgGlkGrrFbM0
        ib7aBV7wpdsa6MonNAzVFPfVNsMisek68Ow9BW35FcfINcIv3EoiV+5OaqaCC/X8oZEZK9
        vViFcyzRqKLQ7+G9sPn1nlXI6idxtTQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-jJRhSaWaPNGSLNWcRpqcJg-1; Mon, 27 Feb 2023 17:44:48 -0500
X-MC-Unique: jJRhSaWaPNGSLNWcRpqcJg-1
Received: by mail-lj1-f197.google.com with SMTP id s8-20020a2eb8c8000000b00295b0c9f6a7so1737034ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pA2l/M+RwgFn7X5RBLShKIcqd1rRLy2xsj8gNSfBQ8=;
        b=QuxsCilAk317rJCsc42ITSXHDWXyFpUKUxkvbjs/5pDj3bVp+H1wH7DyqyfTcvRpIa
         UEzaujSoyaeMDMmDC+qXfcjuuZ6WR4/7gBPWZfL08CotgM5/ZB7luv6gFdhGL7aUXErE
         KBpK4PtRdPI2wGOvb/Iv4HrnwNCJ9XcuaVPUbvdL7HE7f/+cm35YTYQiPnZ6TCL38xLx
         YCsGPIt+3pRtK6upCPCBAZnYHWODHAC7poaq1gX0JznTy42An2yuwUs6YLa5Db3zAYHx
         NBXxe5WI6deflxn4ddP8lomrUHLP9a47KyCQ9R14OO3zDCNux5zegogPKu3xqP8IqP9w
         IsdQ==
X-Gm-Message-State: AO0yUKUZbb62nzQVuRwbR//E96hFv3X7b6MBpOUdADUIutsiUMruCBDv
        +wESX1UP6LZpJyDLvYbT4mD/t5xMt9J1mDxeayY4IzMTdsZ8FE9MdlbjWPtq/gh64SOD3jvC8BC
        cwVt/Z+b3LQyURJ7ztwmZ8CPA5VxdfVQ3s4DFNhbL
X-Received: by 2002:ac2:5197:0:b0:4d5:ca43:7047 with SMTP id u23-20020ac25197000000b004d5ca437047mr56173lfi.10.1677537886878;
        Mon, 27 Feb 2023 14:44:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/XIZXBEKvpsT1DavyreZhhrmi5g65E+sU4BmXMfM2wqaggHe7ObCNkJtwLsRuJuwEQGhfvziGslQ+FmjMDdis=
X-Received: by 2002:ac2:5197:0:b0:4d5:ca43:7047 with SMTP id
 u23-20020ac25197000000b004d5ca437047mr56167lfi.10.1677537886450; Mon, 27 Feb
 2023 14:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20230223113814.3010cedc@eldfell> <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
 <20230224112630.313d7b76@eldfell> <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
 <20230224122403.6a088da1@eldfell> <582a9b92-d246-fce2-cf39-539d9a2db17f@linux.intel.com>
 <20230224130053.3f8939e2@eldfell> <c5d046d6-ab8e-2bc7-5110-dba78b91348b@linux.intel.com>
 <74e409dc-b642-779e-a755-b793c378e43a@amd.com> <CAF6AEGs_yzEj81yNP3KhmVP9Yo3rwTc5vntEVrm9tHw6+w1G_g@mail.gmail.com>
 <Y/0iM+ycUozaVbbC@intel.com> <CAF6AEGtXSEyyjELjGtPvnAN7mX+NwzngmB0PbKHsZqjTm-xYsg@mail.gmail.com>
In-Reply-To: <CAF6AEGtXSEyyjELjGtPvnAN7mX+NwzngmB0PbKHsZqjTm-xYsg@mail.gmail.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Mon, 27 Feb 2023 23:44:34 +0100
Message-ID: <CA+hFU4wtW6wNP2Y0e_iE6NhBSSfVRDxTBUk7kOUNHQPRXpSzrQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Rob Clark <robdclark@gmail.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:20 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 1:36 PM Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> >
> > On Fri, Feb 24, 2023 at 09:59:57AM -0800, Rob Clark wrote:
> > > On Fri, Feb 24, 2023 at 7:27 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
> > > >
> > > > On 2023-02-24 06:37, Tvrtko Ursulin wrote:
> > > > >
> > > > > On 24/02/2023 11:00, Pekka Paalanen wrote:
> > > > >> On Fri, 24 Feb 2023 10:50:51 +0000
> > > > >> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> > > > >>
> > > > >>> On 24/02/2023 10:24, Pekka Paalanen wrote:
> > > > >>>> On Fri, 24 Feb 2023 09:41:46 +0000
> > > > >>>> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> > > > >>>>
> > > > >>>>> On 24/02/2023 09:26, Pekka Paalanen wrote:
> > > > >>>>>> On Thu, 23 Feb 2023 10:51:48 -0800
> > > > >>>>>> Rob Clark <robdclark@gmail.com> wrote:
> > > > >>>>>>
> > > > >>>>>>> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > >>>>>>>>
> > > > >>>>>>>> On Wed, 22 Feb 2023 07:37:26 -0800
> > > > >>>>>>>> Rob Clark <robdclark@gmail.com> wrote:
> > > > >>>>>>>>
> > > > >>>>>>>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > >>>>>>
> > > > >>>>>> ...
> > > > >>>>>>
> > > > >>>>>>>>>> On another matter, if the application uses SET_DEADLINE with one
> > > > >>>>>>>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing with
> > > > >>>>>>>>>> another timestamp, what should happen?
> > > > >>>>>>>>>
> > > > >>>>>>>>> The expectation is that many deadline hints can be set on a fence.
> > > > >>>>>>>>> The fence signaller should track the soonest deadline.
> > > > >>>>>>>>
> > > > >>>>>>>> You need to document that as UAPI, since it is observable to userspace.
> > > > >>>>>>>> It would be bad if drivers or subsystems would differ in behaviour.
> > > > >>>>>>>>
> > > > >>>>>>>
> > > > >>>>>>> It is in the end a hint.  It is about giving the driver more
> > > > >>>>>>> information so that it can make better choices.  But the driver is
> > > > >>>>>>> even free to ignore it.  So maybe "expectation" is too strong of a
> > > > >>>>>>> word.  Rather, any other behavior doesn't really make sense.  But it
> > > > >>>>>>> could end up being dictated by how the hw and/or fw works.
> > > > >>>>>>
> > > > >>>>>> It will stop being a hint once it has been implemented and used in the
> > > > >>>>>> wild long enough. The kernel userspace regression rules make sure of
> > > > >>>>>> that.
> > > > >>>>>
> > > > >>>>> Yeah, tricky and maybe a gray area in this case. I think we eluded
> > > > >>>>> elsewhere in the thread that renaming the thing might be an option.
> > > > >>>>>
> > > > >>>>> So maybe instead of deadline, which is a very strong word, use something
> > > > >>>>> along the lines of "present time hint", or "signalled time hint"? Maybe
> > > > >>>>> reads clumsy. Just throwing some ideas for a start.
> > > > >>>>
> > > > >>>> You can try, but I fear that if it ever changes behaviour and
> > > > >>>> someone notices that, it's labelled as a kernel regression. I don't
> > > > >>>> think documentation has ever been the authoritative definition of UABI
> > > > >>>> in Linux, it just guides drivers and userspace towards a common
> > > > >>>> understanding and common usage patterns.
> > > > >>>>
> > > > >>>> So even if the UABI contract is not documented (ugh), you need to be
> > > > >>>> prepared to set the UABI contract through kernel implementation.
> > > > >>>
> > > > >>> To be the devil's advocate it probably wouldn't be an ABI regression but
> > > > >>> just an regression. Same way as what nice(2) priorities mean hasn't
> > > > >>> always been the same over the years, I don't think there is a strict
> > > > >>> contract.
> > > > >>>
> > > > >>> Having said that, it may be different with latency sensitive stuff such
> > > > >>> as UIs though since it is very observable and can be very painful to users.
> > > > >>>
> > > > >>>> If you do not document the UABI contract, then different drivers are
> > > > >>>> likely to implement it differently, leading to differing behaviour.
> > > > >>>> Also userspace will invent wild ways to abuse the UABI if there is no
> > > > >>>> documentation guiding it on proper use. If userspace or end users
> > > > >>>> observe different behaviour, that's bad even if it's not a regression.
> > > > >>>>
> > > > >>>> I don't like the situation either, but it is what it is. UABI stability
> > > > >>>> trumps everything regardless of whether it was documented or not.
> > > > >>>>
> > > > >>>> I bet userspace is going to use this as a "make it faster, make it
> > > > >>>> hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
> > > > >>>> library that stamps any and all fences with an expired deadline to
> > > > >>>> just squeeze out a little more through some weird side-effect.
> > > > >>>>
> > > > >>>> Well, that's hopefully overboard in scaring, but in the end, I would
> > > > >>>> like to see UABI documented so I can have a feeling of what it is for
> > > > >>>> and how it was intended to be used. That's all.
> > > > >>>
> > > > >>> We share the same concern. If you read elsewhere in these threads you
> > > > >>> will notice I have been calling this an "arms race". If the ability to
> > > > >>> make yourself go faster does not required additional privilege I also
> > > > >>> worry everyone will do it at which point it becomes pointless. So yes, I
> > > > >>> do share this concern about exposing any of this as an unprivileged uapi.
> > > > >>>
> > > > >>> Is it possible to limit access to only compositors in some sane way?
> > > > >>> Sounds tricky when dma-fence should be disconnected from DRM..
> > > > >>
> > > > >> Maybe it's not that bad in this particular case, because we are talking
> > > > >> only about boosting GPU clocks which benefits everyone (except
> > > > >> battery life) and it does not penalize other programs like e.g.
> > > > >> job priorities do.
> > > > >
> > > > > Apart from efficiency that you mentioned, which does not always favor
> > > > > higher clocks, sometimes thermal budget is also shared between CPU and
> > > > > GPU. So more GPU clocks can mean fewer CPU clocks. It's really hard to
> > > > > make optimal choices without the full coordination between both schedulers.
> > > > >
> > > > > But that is even not the main point, which is that if everyone sets the
> > > > > immediate deadline then having the deadline API is a bit pointless. For
> > > > > instance there is a reason negative nice needs CAP_SYS_ADMIN.
> > > > >
> > > > > However Rob has also pointed out the existence of uclamp.min via
> > > > > sched_setattr which is unprivileged and can influence frequency
> > > > > selection in the CPU world, so I conceded on that point. If CPU world
> > > > > has accepted it so can we I guess.
> > > > >
> > > > > So IMO we are back to whether we can agree defining it is a hint is good
> > > > > enough, be in via the name of the ioctl/flag itself or via documentation.
> > > > >
> > > > >> Drivers are not going to use the deadline for scheduling priorities,
> > > > >> right? I don't recall seeing any mention of that.
> > > > >>
> > > > >> ...right?
> > > > >
> > > > > I wouldn't have thought it would be beneficial to preclude that, or
> > > > > assume what drivers would do with the info to begin with.
> > > > >
> > > > > For instance in i915 we almost had a deadline based scheduler which was
> > > > > much fairer than the current priority sorted fifo and in an ideal world
> > > > > we would either revive or re-implement that idea. In which case
> > > > > considering the fence deadline would naturally slot in and give true
> > > > > integration with compositor deadlines (not just boost clocks and pray it
> > > > > helps).
> > > > How is user-space to decide whether to use ioctl(SET_DEADLINE) or
> > > > poll(POLLPRI)?
> > >
> > > Implementation of blocking gl/vk/cl APIs, like glFinish() would use
> > > poll(POLLPRI).  It could also set an immediate deadline and then call
> > > poll() without POLLPRI.
> > >
> > > Other than compositors which do frame-pacing I expect the main usage
> > > of either of these is mesa.
> >
> > Okay, so it looks like we already agreed that having a way to bump frequency
> > from userspace is acceptable. either because there are already other ways
> > that you can waste power and because this already acceptable in the CPU
> > world.
> >
> > But why we are doing this in hidden ways then?
> >
> > Why can't we have this hint per context that is getting executed?
> > (either with a boost-context flag or with some low/med/max or '-1' to '1'
> > value like the latency priority)?
> >
> > I don't like the waitboost because this heurisitic fails in some media cases.
> > I don't like the global setting because we might be alternating a top-priority
> > with low-priority cases...
> >
> > So, why not something per context in execution?
> >
>
> It needs to be finer granularity than per-context, because not all
> waits should trigger boosting.  For example, virglrenderer ends up
> with a thread polling unsignaled fences to know when to signal an
> interrupt to the guest virtgpu.  This alone shouldn't trigger
> boosting.  (We also wouldn't want to completely disable boosting for
> virglrenderer.)  Or the usermode driver could be waiting on a fence to
> know when to do some cleanup.
>
> That is not to say that there isn't room for per-context flags to
> disable/enable boosting for fences created by that context, meaning it
> could be an AND operation for i915 if it needs to be.

First of all, I believe that the fence deadline hint is a good idea.
With that being said, I also don't think it is sufficient in a lot of
cases.

The one thing I was alluding to before and that Pekka mentioned as
well is that mutter for example has a problem where we're missing the
deadline consistently because the clocks don't ramp up fast enough and
there is a MR which is just trying to keep the GPU busy to avoid this.

It would be much better if the kernel could make sure the clocks are
all ramped up when we start submitting work. In the compositor we
actually have a lot of information that *should* influence clocks. We
know when we're going to start submitting work and when the deadline
for that work is beforehand. We know which windows are visible, and
which one should have the highest priority. We know when there are
input events which actually matter. We know when the deadline for
client work is.

In the future we also want to make sure clients know beforehand when
they should start their work and when the deadline is but that's all
very much WIP in both wayland and vulkan.

There are two issues:

1. The compositor has no way to communicate any of that information to
the kernel.
2. The only connection to client work the compositor has is a fence to
the last bit of work that must be done before the deadline after a
wl_surface.commit.

So in both cases a fence is just not the right primitive for us. We
need to be able to provide per-context/queue information for work that
will happen in the future and we need a way to refer to a
context/queue generically and over IPC to boost the clocks of the
device that a client is actually using and maybe even give priority.

But like I said, having a per-fence deadline is probably still a good
idea and doesn't conflict with any of the more coarse information.

>
> BR,
> -R
>

