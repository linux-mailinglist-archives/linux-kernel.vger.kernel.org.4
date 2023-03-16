Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7AA6BD116
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCPNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCPNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:40:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25E1C081A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m35so1280549wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1678974045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EczCGKLk4fBTHmXyHSJ7ilvmJkZQHqbhf3hkS/Fo9ig=;
        b=PcXHkg2DYEsN4SGmyoKoPXIk7dghTl5j1DrVQd/I+VAlz8ytLioRVaYUlY0BsynH1D
         Re0TvwlalBhQsYImYDkeNrZBpsj3te+fCYUSH+1Xmy/rxOPP2nbxuLR3tfsCx4KO/eoZ
         h9Bz2UewqJAlReH7xWEXkMxtktP7ySRXi5cJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EczCGKLk4fBTHmXyHSJ7ilvmJkZQHqbhf3hkS/Fo9ig=;
        b=YlKj34qosRsKLfuGHosZy0ANVgcLB/c94xuyfJBv5eLyFSJVp/mIlB+N6FNbUQ9o56
         9A80REJc94Q9H7ZmdwJvu7Q9zbY6izX6jShHK6lDOQVpkns6+zN+wL7BdykVP854eX0w
         56/YEQe1lTfRt9sBz5LAaj8hzcu1SdXqyMG72XkfE7G15k5+ndq5rZN9MySxEsf9abFM
         9IkZkNfitsNYXL6jRf4/y1OOiTHNjwpvUwfHUViJ5iwqvhWTuBImdwJ2FWEY23lF6XPJ
         J5AZqX5WRVdcR6+wJOXJ/eSQAJZVJ40m5ZvvMg4Cl7ZPB8UcYbWknJLZOfrLQzMMg5mg
         U1ag==
X-Gm-Message-State: AO0yUKWDwgtf1kR5su0HDaEV3MT/V0eMf4TCTFR7fsCu4b3RpMWRuOuN
        sCsIl5r2bEkB32YOTIwAm2ZxzA==
X-Google-Smtp-Source: AK7set/fjat3yH3Fc06VMIK6e7qPeFsvuNYHOJTB0RKC8hvnm2dYtyI5Jh2XJJySBg2aaliqjCVONw==
X-Received: by 2002:a05:600c:3b92:b0:3eb:42f6:ac55 with SMTP id n18-20020a05600c3b9200b003eb42f6ac55mr2688631wms.1.1678974044966;
        Thu, 16 Mar 2023 06:40:44 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b003ed23845666sm4915002wmq.45.2023.03.16.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:40:44 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:40:42 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH RFC 10/18] drm/scheduler: Add can_run_job callback
Message-ID: <ZBMcWuu+W2zfP64O@phenom.ffwll.local>
Mail-Followup-To: Karol Herbst <kherbst@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net>
 <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
 <CACO55tsnCMQt8UW5_UCY139kpZOdNXbMkBkFfUiB12jW5UgVmA@mail.gmail.com>
 <0d6cd23b-8c9e-067d-97ff-aa35dbbcf9bf@amd.com>
 <CACO55tumNMYrcJ0LhnLfTK4DmGLHD-bt3xpXyoPe98V2wmgXQg@mail.gmail.com>
 <269c4fb7-60f6-6778-444d-15703febea58@amd.com>
 <CACO55tuVVnC-_iVmX=SGGVF=0t6kqqr0Cy0pGe3YoppBgUbiXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACO55tuVVnC-_iVmX=SGGVF=0t6kqqr0Cy0pGe3YoppBgUbiXw@mail.gmail.com>
X-Operating-System: Linux phenom 6.1.0-5-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:19:17PM +0100, Karol Herbst wrote:
> On Wed, Mar 8, 2023 at 4:09 PM Christian König <christian.koenig@amd.com> wrote:
> >
> > Am 08.03.23 um 15:43 schrieb Karol Herbst:
> > > [SNIP]
> > > "further"? There was no discussion at all,
> >
> > Yeah, well that is exactly what I wanted to archive.
> >
> > >   you just started off like
> > > that. If you think somebody misses that connection, you can point out
> > > to documentation/videos whatever so the contributor can understand
> > > what's wrong with an approach. You did that, so that's fine. It's just
> > > starting off _any_ discussion with a "Well complete NAK" is terrible
> > > style. I'd feel uncomfortable if that happened to me and I'm sure
> > > there are enough people like that that we should be more reasonable
> > > with our replies. Just.. don't.
> > >
> > > We are all humans here and people react negatively to such things. And
> > > if people do it on purpose it just makes it worse.
> >
> > I completely see your point, I just don't know how to improve it.
> >
> > I don't stop people like this because I want to make them uncomfortable
> > but because I want to prevent further discussions on that topic.
> >
> > In other words how can I make people notice that this is something
> > fundamental while still being polite?

Ask them to improve the docs. Gets them on board, and for bonus point you
- can check they actually get it when you review the doc patch
- get scheduler docs for free
- have an easily pasteable link for next time around instead of just an
  aggressive NAK that helps no one really (aside from getting people
  boiling).

It's not really about being polite but making sure that efficient
communiction happens and that you don't have to repeat yourself. In rare
cases you get to type the docs themself when people are too dense to learn
(like what I had to do with the various dma_fence docs).

> I think a little improvement over this would be to at least wait a few
> replies before resorting to those strong statements. Just before it
> becomes a risk in just wasting time.

See above what I'm trying to do. When the message doesn't sink in as
either a proper doc patch or when linking to the doc patch for next time
around (because let's face it, this entire concept of "dma_fence committed
for execution" is extremely trick, there will be repeations of this
question until we've sunset dma_fence, which is probably decades away).

If the learning does not happen, then it's the time to whack the big
hammer (and if people don't get it, you can escalate to Dave&me, we have
tools to make sure people get the message). But this really should be the
end, not the start of the escalation chain :-)

Cheers, Daniel

> 
> > >>>> This is clearly going against the idea of having jobs only depend on
> > >>>> fences and nothing else which is mandatory for correct memory management.
> > >>>>
> > >>> I'm sure it's all documented and there is a design document on how
> > >>> things have to look like you can point out? Might help to get a better
> > >>> understanding on how things should be.
> > >> Yeah, that's the problematic part. We have documented this very
> > >> extensively:
> > >> https://www.kernel.org/doc/html/v5.9/driver-api/dma-buf.html#indefinite-dma-fences
> > >>
> > >> And both Jason and Daniel gave talks about the underlying problem and
> > > fyi:
> > > s/Jason/Faith/g
> >
> > +1. I wasn't aware of that.
> >
> > >> try to come up with patches to raise warnings when that happens, but
> > >> people still keep coming up with the same idea over and over again.
> > >>
> > > Yes, and we'll have to tell them over and over again. Nothing wrong
> > > with that. That's just part of maintaining such a big subsystem. And
> > > that's definitely not a valid reason to phrase things like above.
> > >
> > >> It's just that the technical relationship between preventing jobs from
> > >> running and with that preventing dma_fences from signaling and the core
> > >> memory management with page faults and shrinkers waiting for those
> > >> fences is absolutely not obvious.
> > >>
> > >> We had at least 10 different teams from different companies falling into
> > >> the same trap already and either the patches were rejected of hand or
> > >> had to painfully reverted or mitigated later on.
> > >>
> > > Sure, but that's just part of the job. And pointing out fundamental
> > > mistakes early on is important, but the situation won't get any better
> > > by being like that. Yes, we'll have to repeat the same words over and
> > > over again, and yes that might be annoying, but that's just how it is.
> >
> > Well I have no problem explaining people why a solution doesn't work.
> >
> > But what usually happens is that people don't realize that they need to
> > back of from a design and completely start over.
> >
> > Regards,
> > Christian.
> >
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >>>> If the hw is busy with something you need to return the fence for this
> > >>>> from the prepare_job callback so that the scheduler can be notified when
> > >>>> the hw is available again.
> > >>>>
> > >>>> Regards,
> > >>>> Christian.
> > >>>>
> > >>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
> > >>>>> ---
> > >>>>>     drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
> > >>>>>     include/drm/gpu_scheduler.h            |  8 ++++++++
> > >>>>>     2 files changed, 18 insertions(+)
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > >>>>> index 4e6ad6e122bc..5c0add2c7546 100644
> > >>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
> > >>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > >>>>> @@ -1001,6 +1001,16 @@ static int drm_sched_main(void *param)
> > >>>>>                 if (!entity)
> > >>>>>                         continue;
> > >>>>>
> > >>>>> +             if (sched->ops->can_run_job) {
> > >>>>> +                     sched_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
> > >>>>> +                     if (!sched_job) {
> > >>>>> +                             complete_all(&entity->entity_idle);
> > >>>>> +                             continue;
> > >>>>> +                     }
> > >>>>> +                     if (!sched->ops->can_run_job(sched_job))
> > >>>>> +                             continue;
> > >>>>> +             }
> > >>>>> +
> > >>>>>                 sched_job = drm_sched_entity_pop_job(entity);
> > >>>>>
> > >>>>>                 if (!sched_job) {
> > >>>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > >>>>> index 9db9e5e504ee..bd89ea9507b9 100644
> > >>>>> --- a/include/drm/gpu_scheduler.h
> > >>>>> +++ b/include/drm/gpu_scheduler.h
> > >>>>> @@ -396,6 +396,14 @@ struct drm_sched_backend_ops {
> > >>>>>         struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
> > >>>>>                                          struct drm_sched_entity *s_entity);
> > >>>>>
> > >>>>> +     /**
> > >>>>> +      * @can_run_job: Called before job execution to check whether the
> > >>>>> +      * hardware is free enough to run the job.  This can be used to
> > >>>>> +      * implement more complex hardware resource policies than the
> > >>>>> +      * hw_submission limit.
> > >>>>> +      */
> > >>>>> +     bool (*can_run_job)(struct drm_sched_job *sched_job);
> > >>>>> +
> > >>>>>         /**
> > >>>>>              * @run_job: Called to execute the job once all of the dependencies
> > >>>>>              * have been resolved.  This may be called multiple times, if
> > >>>>>
> >
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
