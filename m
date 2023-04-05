Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B46D7F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbjDEOWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjDEOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:22:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651805FFC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:21:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-4fd1f2a0f82so60290a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680704513; x=1683296513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hEm3Bu1ajK6bUPoSCMbJz7g4+4dYw9soC8zApe4hMc=;
        b=dpunbt78Nu2bqL1/MCP1Yrvt88iEad8oMRiJF84xlTSiCngaKtk5FA3RBCcFzIOsOt
         kgwObyB+ED+hE6Et0bKNge+WJMib2ruloC80JurL5XZQySHnCnIA1r4RRQrkxWk4kT7m
         nMs2nmS1mHd/Ruhd8U1HtKNlbUAe6jhQh1GtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704513; x=1683296513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hEm3Bu1ajK6bUPoSCMbJz7g4+4dYw9soC8zApe4hMc=;
        b=U7e7KzjFl1T7ZyDmnwNqASDr2V5PykIqmH79tePZRxtRvNw8z8JzRai4UOMuZFUTJi
         Fd+e2uSgnHRC0hdWZbvuzf1+E9zlOLV90aKtev0tzSgtcQT3bU4X5Y3WXeg8OLriqT99
         +rz1Uk4tVzL1H9D/AmPpt6PbfWnyJUJGWLbJ0187ykosSYL0QCOxhOj0bBHsEI6gO9fa
         9IQHQcGO/t+rFsHGSXb8xVzW7RDu9FkVPv7/FbVOIkW8muScZ38gfg68oESv+3Ms0nLf
         RJ6ODKezxZTBqUTbZUGWzhYOTFEmBseTxQFeJ9Fnl/cACH+Yg/UNxEWpPCIEqmcy+J+R
         HhvQ==
X-Gm-Message-State: AAQBX9dCO0MqJDEU+v8YL1NOb+eVwzo6tpnchfoVVQWjnxOhs880wS/A
        7NP47rgia2ztDhSIn9JhjRK1OA==
X-Google-Smtp-Source: AKy350bxxApiu6QlBT7LFjNT5HOmCcGl6WDZP6khnW7b0dJcrSCSEyjhjNy22KbR8irHrR8fUaM/Aw==
X-Received: by 2002:a17:906:2093:b0:933:2e79:4632 with SMTP id 19-20020a170906209300b009332e794632mr2053178ejq.1.1680704513565;
        Wed, 05 Apr 2023 07:21:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id r6-20020a1709064d0600b0093034e71b94sm7467929eju.65.2023.04.05.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:21:53 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:21:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
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
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH RFC 10/18] drm/scheduler: Add can_run_job callback
Message-ID: <ZC2D/pQsNgaoSzzh@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net>
 <ZC16Q8MhHEcutX1b@phenom.ffwll.local>
 <20502c4c-c987-3117-119a-2fd38ae5f607@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20502c4c-c987-3117-119a-2fd38ae5f607@amd.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:14:11PM +0200, Christian König wrote:
> Am 05.04.23 um 15:40 schrieb Daniel Vetter:
> > On Tue, Mar 07, 2023 at 11:25:35PM +0900, Asahi Lina wrote:
> > > Some hardware may require more complex resource utilization accounting
> > > than the simple job count supported by drm_sched internally. Add a
> > > can_run_job callback to allow drivers to implement more logic before
> > > deciding whether to run a GPU job.
> > > 
> > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Ok scheduler rules, or trying to summarize the entire discussion:
> > 
> > dma_fence rules are very tricky. The two main chapters in the docs are
> > 
> > https://dri.freedesktop.org/docs/drm/driver-api/dma-buf.html?highlight=dma_buf#dma-fence-cross-driver-contract
> > https://dri.freedesktop.org/docs/drm/driver-api/dma-buf.html?highlight=dma_buf#indefinite-dma-fences
> > 
> > Unforutunately I don't think it's possible to check this at compile time,
> > thus far all we can do is validate at runtime. I've posted two patches for
> > this:
> > 
> > https://lore.kernel.org/dri-devel/20201023122216.2373294-17-daniel.vetter@ffwll.ch/
> > https://lore.kernel.org/dri-devel/20201023122216.2373294-20-daniel.vetter@ffwll.ch/
> > 
> > Unfortunately most drivers are buggy and get this completely wrong, so
> > realistically we'd need to make this a per-driver opt-out and annotate all
> > current drivers. Well except amdgpu is correct by now I think (they'd
> > still need to test that).
> 
> There is still one potential memory allocation in the run_job callback in
> amdgpu which I wasn't able to fix yet.
> 
> But that one is purely academic and could potentially be trivially replaced
> with using GFP_ATOMIC if we ever have to.

I think the modeset in the tdr code was more scary, and I'm not sure you
really managed to get rid of absolutely everything in there yet.
-Daniel

> 
> Christian.
> 
> >   And Rob Clark is working on patches to fix up
> > msm.
> > 
> > I think best here is if you work together with Rob to make sure these
> > annotations are mandatory for any rust drivers (I don't want new buggy
> > drivers at least). Would also be great to improve the kerneldoc for all
> > the driver hooks to explain these restrictions and link to the relevant
> > kerneldocs (there's also one for the dma_fence signalling annotations
> > which might be worth linking too).
> > 
> > I don't see any way to make this explicit in rust types, it's really only
> > something runtime tests (using lockdep) can catch. Somewhat disappointing.
> > 
> > For the other things discussed here:
> > 
> > - Option<Dma_Fence> as the return value for ->prepare_job makes sense to
> >    me.
> > 
> > - I don't see any way a driver can use ->can_run_job without breaking the
> >    above rules, that really doesn't sound like a good idea to me.
> > 
> > Cheers, Daniel
> > 
> > > ---
> > >   drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
> > >   include/drm/gpu_scheduler.h            |  8 ++++++++
> > >   2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > > index 4e6ad6e122bc..5c0add2c7546 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -1001,6 +1001,16 @@ static int drm_sched_main(void *param)
> > >   		if (!entity)
> > >   			continue;
> > > +		if (sched->ops->can_run_job) {
> > > +			sched_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
> > > +			if (!sched_job) {
> > > +				complete_all(&entity->entity_idle);
> > > +				continue;
> > > +			}
> > > +			if (!sched->ops->can_run_job(sched_job))
> > > +				continue;
> > > +		}
> > > +
> > >   		sched_job = drm_sched_entity_pop_job(entity);
> > >   		if (!sched_job) {
> > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > > index 9db9e5e504ee..bd89ea9507b9 100644
> > > --- a/include/drm/gpu_scheduler.h
> > > +++ b/include/drm/gpu_scheduler.h
> > > @@ -396,6 +396,14 @@ struct drm_sched_backend_ops {
> > >   	struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
> > >   					 struct drm_sched_entity *s_entity);
> > > +	/**
> > > +	 * @can_run_job: Called before job execution to check whether the
> > > +	 * hardware is free enough to run the job.  This can be used to
> > > +	 * implement more complex hardware resource policies than the
> > > +	 * hw_submission limit.
> > > +	 */
> > > +	bool (*can_run_job)(struct drm_sched_job *sched_job);
> > > +
> > >   	/**
> > >            * @run_job: Called to execute the job once all of the dependencies
> > >            * have been resolved.  This may be called multiple times, if
> > > 
> > > -- 
> > > 2.35.1
> > > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
