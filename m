Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73F06B0BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCHOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjCHOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA71BC6D7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678286626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ec/IVFu8tTZxwDkNDSwZTiUvqGpL4DGDHvqQihyB9U=;
        b=S3mhoGXuxyfaPF15BW3B67Cfn609Rf4i4GA9rp4TkQa4U9S6odQbQVd5OwCyiXKqJk0xmz
        2daK/1AhBBd39igm6FR1DFgbsmpnamfOcamctz0QKtNvxwRKYdDmdDJdYoWDdc/lrxgrZO
        GslIGAeo5rlQJP0ViOlgZuJLRAV2PeU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ssRlQFWvMyuCghHjLVth-A-1; Wed, 08 Mar 2023 09:43:45 -0500
X-MC-Unique: ssRlQFWvMyuCghHjLVth-A-1
Received: by mail-lj1-f197.google.com with SMTP id s8-20020a2eb8c8000000b00295b0c9f6a7so5463143ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ec/IVFu8tTZxwDkNDSwZTiUvqGpL4DGDHvqQihyB9U=;
        b=dehNlTGdOVLVVWZyDEyDpvZsU8JVNxpX+hFNP9RTr1Kks38LkKPFp5CHMe3XVEveTe
         O/7CWIAP5KPJh/ZQWW34Uthn6Bz6KYOXHtBf5rs896Lm8jTZNvmcPh1ZKmCujPp9JkGt
         UmhjGYN8vjmXgENaX49E8LzsssazI7IlK1it8oSo7DxZneaWimo0OrDqC73pKkcxnMS8
         s2Cp+CvZJiobAunkX4jTlOwkNldRBtSQqqEFRp9vOkZWlEAfujSxWJbqLvJnUZbOgYwV
         oCSuWuUFUOyubw8mnl6YEGL57UziLJ+VpzulTu6mt9OzC7nDuXZttQVTwNE9/m2woEfB
         Mr4g==
X-Gm-Message-State: AO0yUKW6cEHCO3WaQffQBMv4qw/Rz3YYrP/8I7ZfPhGfEmlReo8D5QDn
        XzgkHNZ1xLvgtMVOWPMeftkhOcqjrFPhkU5h/LtMuAJKBpF6LixKy4ssV9Pe72epeRxu0lX9UAs
        BAolsWzg/k05ayJsC35DBVfwXAKHNjxhPNZQwk+lv
X-Received: by 2002:a2e:a612:0:b0:295:d632:ba22 with SMTP id v18-20020a2ea612000000b00295d632ba22mr5704929ljp.8.1678286623714;
        Wed, 08 Mar 2023 06:43:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+VM8PtihslLzNuKh4B+G0qjJyiIzHXOidXvO7lyX27rIZtUnecI3bQqz6Vc4IEJCL68KDme3kfrv4Y+s3Zdhc=
X-Received: by 2002:a2e:a612:0:b0:295:d632:ba22 with SMTP id
 v18-20020a2ea612000000b00295d632ba22mr5704906ljp.8.1678286623395; Wed, 08 Mar
 2023 06:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net> <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
 <CACO55tsnCMQt8UW5_UCY139kpZOdNXbMkBkFfUiB12jW5UgVmA@mail.gmail.com> <0d6cd23b-8c9e-067d-97ff-aa35dbbcf9bf@amd.com>
In-Reply-To: <0d6cd23b-8c9e-067d-97ff-aa35dbbcf9bf@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 8 Mar 2023 15:43:31 +0100
Message-ID: <CACO55tumNMYrcJ0LhnLfTK4DmGLHD-bt3xpXyoPe98V2wmgXQg@mail.gmail.com>
Subject: Re: [PATCH RFC 10/18] drm/scheduler: Add can_run_job callback
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:47=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 08.03.23 um 13:39 schrieb Karol Herbst:
> > On Wed, Mar 8, 2023 at 9:46=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >> Am 07.03.23 um 15:25 schrieb Asahi Lina:
> >>> Some hardware may require more complex resource utilization accountin=
g
> >>> than the simple job count supported by drm_sched internally. Add a
> >>> can_run_job callback to allow drivers to implement more logic before
> >>> deciding whether to run a GPU job.
> >> Well complete NAK.
> >>
> > There hasn't even been any kind of discussion yet you already come
> > around with a "Well complete NAK"
> >
> > First, this can be seen as rude behavior and me being part of the drm
> > community I don't want to have to see this kind of thing.
> >
> > Obviously, any kind of strong "technical" review point is a nak until
> > people settle with an agreement on what to land, there is no point in
> > pointing out a "NAK", especially if that's the first thing you say. If
> > you want to express your strong disagreement with the proposed
> > solution, then state what your pain points are directly.
> >
> > If there is a long discussion and a maintainer feels it's going
> > nowhere and no conclusion will be reached it might be this kind of
> > "speaking with authority" point has to be made. But not as the starter
> > into a discussion. This is unnecessarily hostile towards the
> > contributor. And I wished we wouldn't have to see this kind of
> > behavior here.
> >
> > Yes, some kernel maintainers do this a lot, but kernel maintainers
> > also have this kind of reputation and people don't want to have to
> > deal with this nonsense and decide to not contribute at all. So please
> > just drop this attitude.
>
> Yes, you are completely right with that, but getting this message to the
> recipient is intentional on my side.
>
> I give completely NAKs when the author of a patch has missed such a
> fundamental technical connection that further discussion doesn't make sen=
se.
>
> It's not meant to be in any way rude or offending. I can put a smiley
> behind it if it somehow helps, but we still need a way to raise this big
> red stop sign.
>

"further"? There was no discussion at all, you just started off like
that. If you think somebody misses that connection, you can point out
to documentation/videos whatever so the contributor can understand
what's wrong with an approach. You did that, so that's fine. It's just
starting off _any_ discussion with a "Well complete NAK" is terrible
style. I'd feel uncomfortable if that happened to me and I'm sure
there are enough people like that that we should be more reasonable
with our replies. Just.. don't.

We are all humans here and people react negatively to such things. And
if people do it on purpose it just makes it worse.

> >> This is clearly going against the idea of having jobs only depend on
> >> fences and nothing else which is mandatory for correct memory manageme=
nt.
> >>
> > I'm sure it's all documented and there is a design document on how
> > things have to look like you can point out? Might help to get a better
> > understanding on how things should be.
>
> Yeah, that's the problematic part. We have documented this very
> extensively:
> https://www.kernel.org/doc/html/v5.9/driver-api/dma-buf.html#indefinite-d=
ma-fences
>
> And both Jason and Daniel gave talks about the underlying problem and

fyi:
s/Jason/Faith/g

> try to come up with patches to raise warnings when that happens, but
> people still keep coming up with the same idea over and over again.
>

Yes, and we'll have to tell them over and over again. Nothing wrong
with that. That's just part of maintaining such a big subsystem. And
that's definitely not a valid reason to phrase things like above.

> It's just that the technical relationship between preventing jobs from
> running and with that preventing dma_fences from signaling and the core
> memory management with page faults and shrinkers waiting for those
> fences is absolutely not obvious.
>
> We had at least 10 different teams from different companies falling into
> the same trap already and either the patches were rejected of hand or
> had to painfully reverted or mitigated later on.
>

Sure, but that's just part of the job. And pointing out fundamental
mistakes early on is important, but the situation won't get any better
by being like that. Yes, we'll have to repeat the same words over and
over again, and yes that might be annoying, but that's just how it is.

> Regards,
> Christian.
>
> >
> >> If the hw is busy with something you need to return the fence for this
> >> from the prepare_job callback so that the scheduler can be notified wh=
en
> >> the hw is available again.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Asahi Lina <lina@asahilina.net>
> >>> ---
> >>>    drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
> >>>    include/drm/gpu_scheduler.h            |  8 ++++++++
> >>>    2 files changed, 18 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm=
/scheduler/sched_main.c
> >>> index 4e6ad6e122bc..5c0add2c7546 100644
> >>> --- a/drivers/gpu/drm/scheduler/sched_main.c
> >>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> >>> @@ -1001,6 +1001,16 @@ static int drm_sched_main(void *param)
> >>>                if (!entity)
> >>>                        continue;
> >>>
> >>> +             if (sched->ops->can_run_job) {
> >>> +                     sched_job =3D to_drm_sched_job(spsc_queue_peek(=
&entity->job_queue));
> >>> +                     if (!sched_job) {
> >>> +                             complete_all(&entity->entity_idle);
> >>> +                             continue;
> >>> +                     }
> >>> +                     if (!sched->ops->can_run_job(sched_job))
> >>> +                             continue;
> >>> +             }
> >>> +
> >>>                sched_job =3D drm_sched_entity_pop_job(entity);
> >>>
> >>>                if (!sched_job) {
> >>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.=
h
> >>> index 9db9e5e504ee..bd89ea9507b9 100644
> >>> --- a/include/drm/gpu_scheduler.h
> >>> +++ b/include/drm/gpu_scheduler.h
> >>> @@ -396,6 +396,14 @@ struct drm_sched_backend_ops {
> >>>        struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_j=
ob,
> >>>                                         struct drm_sched_entity *s_en=
tity);
> >>>
> >>> +     /**
> >>> +      * @can_run_job: Called before job execution to check whether t=
he
> >>> +      * hardware is free enough to run the job.  This can be used to
> >>> +      * implement more complex hardware resource policies than the
> >>> +      * hw_submission limit.
> >>> +      */
> >>> +     bool (*can_run_job)(struct drm_sched_job *sched_job);
> >>> +
> >>>        /**
> >>>             * @run_job: Called to execute the job once all of the dep=
endencies
> >>>             * have been resolved.  This may be called multiple times,=
 if
> >>>
>

