Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774B6D7E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjDENww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjDENwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:52:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB362A7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:52:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-4fd1f2a0f82so56336a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680702767; x=1683294767;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXtQjGw17H5KOM9fCmdg0BPHMgZVeRXg+E6JWWNf2fI=;
        b=P+Lx3ar4PUX0HJk98OXE7iFGrn7nhB+lYPUC8wXGiqKRy6S70N3Ng45OxWoAGkfH1s
         bNGpklNDiWeffGTYk5+TLlWg/ifLkO87VVaScR4HmPnJwhm+ZkQqXXkQwIS1t6bm72zP
         mSLYN71g8EKZQ6qxtP5GskYiCOT405XyL84Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702767; x=1683294767;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXtQjGw17H5KOM9fCmdg0BPHMgZVeRXg+E6JWWNf2fI=;
        b=PhROPvkT5uhMfg86NSLIREd3lpPVHZJg2tku1rxa+MxwVBfYvFnNUWgtUe3wIWQeqp
         HV+qDfUbjz3LUvrvgveZL+qIn6jJ62kJNcRKFROQlNreTJEmc476nnOFJyjt51vC/Ux6
         Lbh/z3a9PdzXB92nwBJsMSvC0KxeSIQYyaicpEo3KypjFaN4bPlRtD6BfqM1YsEkfEwY
         f1BRSoxIGrfj87roanYEM1WTwfIuuY0T16ruNV1rnRlAAh/Jjio+byehFVIdVqhv8Bfl
         OTyeGaB6GwULa9kgSijR84EHy2npVdzBp6JC+QbJetUB7epZdxJTGNllG+dDU+HZf1bi
         uXrw==
X-Gm-Message-State: AAQBX9fBkxC50hJ95x8uf6CNUdpRUx8Enw3S+0h+/diZ/eqCraG7IDf4
        Z0/z6qpXZRZHdca1x81INvfHqw==
X-Google-Smtp-Source: AKy350YRt7QlO0W2+ZPyrVbabYLe9e11BeFrLSx/MNYzH+68ns/TWKRF8HkPS+0QYOxACPnonTzaJA==
X-Received: by 2002:a05:6402:524e:b0:4fd:2978:d80 with SMTP id t14-20020a056402524e00b004fd29780d80mr2100686edd.1.1680702767368;
        Wed, 05 Apr 2023 06:52:47 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id ee55-20020a056402293700b004aef147add6sm7218800edb.47.2023.04.05.06.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:52:46 -0700 (PDT)
Date:   Wed, 5 Apr 2023 15:52:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH RFC 11/18] drm/scheduler: Clean up jobs when the
 scheduler is torn down
Message-ID: <ZC19LIsNlhFC+7ME@phenom.ffwll.local>
Mail-Followup-To: Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
 <20230307-rust-drm-v1-11-917ff5bc80a8@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-rust-drm-v1-11-917ff5bc80a8@asahilina.net>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:25:36PM +0900, Asahi Lina wrote:
> drm_sched_fini() currently leaves any pending jobs dangling, which
> causes segfaults and other badness when job completion fences are
> signaled after the scheduler is torn down.
> 
> Explicitly detach all jobs from their completion callbacks and free
> them. This makes it possible to write a sensible safe abstraction for
> drm_sched, without having to externally duplicate the tracking of
> in-flight jobs.
> 
> This shouldn't regress any existing drivers, since calling
> drm_sched_fini() with any pending jobs is broken and this change should
> be a no-op if there are no pending jobs.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 5c0add2c7546..0aab1e0aebdd 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1119,10 +1119,33 @@ EXPORT_SYMBOL(drm_sched_init);
>  void drm_sched_fini(struct drm_gpu_scheduler *sched)
>  {
>  	struct drm_sched_entity *s_entity;
> +	struct drm_sched_job *s_job, *tmp;
>  	int i;
>  
> -	if (sched->thread)
> -		kthread_stop(sched->thread);
> +	if (!sched->thread)
> +		return;
> +
> +	/*
> +	 * Stop the scheduler, detaching all jobs from their hardware callbacks
> +	 * and cleaning up complete jobs.
> +	 */
> +	drm_sched_stop(sched, NULL);
> +
> +	/*
> +	 * Iterate through the pending job list and free all jobs.
> +	 * This assumes the driver has either guaranteed jobs are already stopped, or that
> +	 * otherwise it is responsible for keeping any necessary data structures for
> +	 * in-progress jobs alive even when the free_job() callback is called early (e.g. by
> +	 * putting them in its own queue or doing its own refcounting).
> +	 */

This comment makes me wonder whether we shouldn't go one step further and
have a drm_sched_quiescent, which waits for any in-flight jobs to complete
and cancels everything else. Because even if rust guarantees that you
don't have any memory bugs, if you just leak things by sprinkling
reference-counted pointer wrappers everywhere you still have a semantic
bug.

Except now it's much harder to realize that because there's no Oops and
KASAN doesn't tell you about it either. I think it would be much better if
the scheduler code and rust abstraction provider drivers the correct
lifetimes and very strongly encourage them to only have borrowed
references and not additional refcounting of their own.

I think Christian mentioned that this would block in close() or context
destruction, which is no good at all. And with the 1:1
drm_scheduler:drm_sched_entity design for there's no other place. This is
way I've suggested in the Xe threads that we should make the current
drm_scheduler an implementation detail hidden from drivers, with a new
drm_scheduler which is always per-engine for all cases as the driver api
interface.  And the internal scheduler attached to either that (for
current drivers) or drm_sched_entity (for fw scheduling drivers) as
needed. With that
- the sched_entity cleanup could take care of this code here for the fw
  scheduler case
- the drm_sched_fini could take care of blocking appropriately before the
  driver is unloaded for any lagging in-flight jobs, without blocking
  userspace
- drivers should not end up with any need to reference-count either
  per-ctx/drm_sched_entity or per-drm_sched_job data, ever

Because any comment that's along the lines of "drivers need to refcount"
is bad business, because it either means leaks (rust) or crashes (C). I
much prefer when drivers have to put in extra effort to get things wrong
because by default the lifetimes are Just Right(tm).
-Daniel

> +	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
> +		spin_lock(&sched->job_list_lock);
> +		list_del_init(&s_job->list);
> +		spin_unlock(&sched->job_list_lock);
> +		sched->ops->free_job(s_job);
> +	}
> +
> +	kthread_stop(sched->thread);
>  
>  	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>  		struct drm_sched_rq *rq = &sched->sched_rq[i];
> 
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
