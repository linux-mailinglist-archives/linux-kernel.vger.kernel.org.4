Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE96B0752
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCHMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCHMkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2A92F0A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678279201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJeOz/TwjDaJpvxJ/JatQ2Vwz4TDO8vQcbmv9Au+kic=;
        b=IdbcmiwQXHmfX7F8fWCP8kmUDq7RN+emUUHSmHwEOXkaXnmOOTSjgI5Zsdy4v0k7DZKXdg
        jul2jO3fx00bHp2ntyYsQXO1GFTJn1iT7JJ+dzTXf3PZiq6AbfeTjXgy1kiY/5mDGjPQ5F
        nUFuZFbJnhz4RLjzZJMo9aZlWtbqB6A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-0XrR-8d8PQuA-pao5uQ3qg-1; Wed, 08 Mar 2023 07:39:59 -0500
X-MC-Unique: 0XrR-8d8PQuA-pao5uQ3qg-1
Received: by mail-lj1-f199.google.com with SMTP id g21-20020a2e9cd5000000b00295cbacaf20so5372687ljj.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678279198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJeOz/TwjDaJpvxJ/JatQ2Vwz4TDO8vQcbmv9Au+kic=;
        b=udkyn4xhikrIITwO0azCIfqIVMzf7zPZaw86+YixCSqqo+yexu3K20iXrO4N5/NiJm
         hDBFlVCFiMkZ+3mwA7HCAC3B2JQgf98CRf3j0C1aS3wMLqkh2lBJZlc8Qiom2D/E6thi
         k8rUVcuHY5LOThIiahhE03NE2HkI11og94ufxr1dEghTFMjiyGaBWT/honS2KTz/dhtb
         V0mM7C1Ptcjmgp/6i354judQM5yT3Kro+TmRutmxtnoxNbWVh87sq47Iiq832m8xdCjY
         RY9ez1nCe29q+zP9nlxLdWQnmZbYVI0Ppkz04Pd/L3G+XdbqH0nik6vBBkN08+rCnlVo
         d12g==
X-Gm-Message-State: AO0yUKXVuMQBWl2LjV5aTnFCZc09nAWIbpPxnvawR9/C4e+Csp4AmA3r
        j6DNXiT3qzVcj7IeZHgfHF+ePq1F1srTp3JSMA5SvKnNctlrrR+F8N0DxRPZTdggn1I267xq3JB
        /2REPZNoXyqvbOH3Ew9051datkAXhW4EzAlRP9dTU
X-Received: by 2002:ac2:4117:0:b0:4d5:ca32:7bc5 with SMTP id b23-20020ac24117000000b004d5ca327bc5mr5524029lfi.12.1678279198478;
        Wed, 08 Mar 2023 04:39:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8FUpPht+EPsUrSn5a6+Tar9OiMu+wlN+EYgOwEqyTMD6viZtSkh1MIdkQE1nv3hutVyBf4yr0OssgVzKPbdmA=
X-Received: by 2002:ac2:4117:0:b0:4d5:ca32:7bc5 with SMTP id
 b23-20020ac24117000000b004d5ca327bc5mr5524019lfi.12.1678279198181; Wed, 08
 Mar 2023 04:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net> <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
In-Reply-To: <cd788ccf-0cf1-85d5-1bf8-efc259bd7e11@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 8 Mar 2023 13:39:45 +0100
Message-ID: <CACO55tsnCMQt8UW5_UCY139kpZOdNXbMkBkFfUiB12jW5UgVmA@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 9:46=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 07.03.23 um 15:25 schrieb Asahi Lina:
> > Some hardware may require more complex resource utilization accounting
> > than the simple job count supported by drm_sched internally. Add a
> > can_run_job callback to allow drivers to implement more logic before
> > deciding whether to run a GPU job.
>
> Well complete NAK.
>

There hasn't even been any kind of discussion yet you already come
around with a "Well complete NAK"

First, this can be seen as rude behavior and me being part of the drm
community I don't want to have to see this kind of thing.

Obviously, any kind of strong "technical" review point is a nak until
people settle with an agreement on what to land, there is no point in
pointing out a "NAK", especially if that's the first thing you say. If
you want to express your strong disagreement with the proposed
solution, then state what your pain points are directly.

If there is a long discussion and a maintainer feels it's going
nowhere and no conclusion will be reached it might be this kind of
"speaking with authority" point has to be made. But not as the starter
into a discussion. This is unnecessarily hostile towards the
contributor. And I wished we wouldn't have to see this kind of
behavior here.

Yes, some kernel maintainers do this a lot, but kernel maintainers
also have this kind of reputation and people don't want to have to
deal with this nonsense and decide to not contribute at all. So please
just drop this attitude.

> This is clearly going against the idea of having jobs only depend on
> fences and nothing else which is mandatory for correct memory management.
>

I'm sure it's all documented and there is a design document on how
things have to look like you can point out? Might help to get a better
understanding on how things should be.

> If the hw is busy with something you need to return the fence for this
> from the prepare_job callback so that the scheduler can be notified when
> the hw is available again.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
> >   include/drm/gpu_scheduler.h            |  8 ++++++++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 4e6ad6e122bc..5c0add2c7546 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1001,6 +1001,16 @@ static int drm_sched_main(void *param)
> >               if (!entity)
> >                       continue;
> >
> > +             if (sched->ops->can_run_job) {
> > +                     sched_job =3D to_drm_sched_job(spsc_queue_peek(&e=
ntity->job_queue));
> > +                     if (!sched_job) {
> > +                             complete_all(&entity->entity_idle);
> > +                             continue;
> > +                     }
> > +                     if (!sched->ops->can_run_job(sched_job))
> > +                             continue;
> > +             }
> > +
> >               sched_job =3D drm_sched_entity_pop_job(entity);
> >
> >               if (!sched_job) {
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index 9db9e5e504ee..bd89ea9507b9 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -396,6 +396,14 @@ struct drm_sched_backend_ops {
> >       struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
> >                                        struct drm_sched_entity *s_entit=
y);
> >
> > +     /**
> > +      * @can_run_job: Called before job execution to check whether the
> > +      * hardware is free enough to run the job.  This can be used to
> > +      * implement more complex hardware resource policies than the
> > +      * hw_submission limit.
> > +      */
> > +     bool (*can_run_job)(struct drm_sched_job *sched_job);
> > +
> >       /**
> >            * @run_job: Called to execute the job once all of the depend=
encies
> >            * have been resolved.  This may be called multiple times, if
> >
>

