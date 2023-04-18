Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B996E5C21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDRIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDRIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:34:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178F273C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:34:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f17b5552e9so195805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681806894; x=1684398894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK3y0BUQpGH7irvo8NU0fynJnPut9qQ7xlfoCq4CYng=;
        b=gu1Jw5Z+VkRdweBK6KngJhdDB6l0cbDx53nX/TFfWMHLBAxDzS4iiwlhVoYR2WfLG8
         BO8ZxxDSiYGuOUbSxOY9eBe0m1WZw7Ady93EXQop79Ezst8xg2i36ulaVH6lVGELc/A6
         tbWqGXG4mPfSxgfd/BXLIBwym6jER/1MprzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806894; x=1684398894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK3y0BUQpGH7irvo8NU0fynJnPut9qQ7xlfoCq4CYng=;
        b=TExzsqNcz4tdZTbhejetkW0pNi7xYXaH/uCs9Ei1BVmIfjG5WXRPsULtBHqEXRlqGH
         /4iKCT4I20qr9bqpnXhwC+zXvx2glv6dZ7iEeZcfvzTduxpcm3E1dbotSxEfOKMK+CTo
         SWYqj30gXBSL3liFDxDshzYS1stqgdwvWl6NPefKJXfdjbdM9dkAy4JfVLi8RIgwOqyS
         J+Y0MjQKAVn6iXO7PpOHdQ880ZJX5fWqqdq8JxgSqDrKWg4P0Aced075tzF80zcjCbzr
         8wBIQWyd3w/8rqh1yFuAoVo7ysF0KhqL+TbWCNju7jpXVis7v9CLmEa60reCy31ED+cS
         uluw==
X-Gm-Message-State: AAQBX9dveMzb91oIVdc+M6bX3o4I+hvAKy0SCLvohXJocxsZjcUWxUTG
        rEpWYhp9muybKlkpoEg5MKhpOg==
X-Google-Smtp-Source: AKy350Zb/Pmk6fjTuOI1X1TU5gGYDQL8J50cM0uidBzPbaCHSu3IUJ7zuzjH7UgjDGJDOY0mLfD57w==
X-Received: by 2002:a05:600c:6025:b0:3f1:75a5:a369 with SMTP id az37-20020a05600c602500b003f175a5a369mr3356980wmb.3.1681806894329;
        Tue, 18 Apr 2023 01:34:54 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c319000b003f17122587bsm7222453wmp.36.2023.04.18.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:34:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:34:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
Message-ID: <ZD5WLMRNibbRkGQO@phenom.ffwll.local>
Mail-Followup-To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230417201215.448099-1-robdclark@gmail.com>
 <20230417201215.448099-3-robdclark@gmail.com>
 <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:27:49AM +0100, Tvrtko Ursulin wrote:
> 
> On 17/04/2023 21:12, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Make it work in terms of ctx so that it can be re-used for fdinfo.
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
> >   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
> >   drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
> >   drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
> >   drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
> >   5 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index bb38e728864d..43c4e1fea83f 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
> >   		/* Ensure string is null terminated: */
> >   		str[len] = '\0';
> > -		mutex_lock(&gpu->lock);
> > +		mutex_lock(&ctx->lock);
> >   		if (param == MSM_PARAM_COMM) {
> >   			paramp = &ctx->comm;
> > @@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
> >   		kfree(*paramp);
> >   		*paramp = str;
> > -		mutex_unlock(&gpu->lock);
> > +		mutex_unlock(&ctx->lock);
> >   		return 0;
> >   	}
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 3d73b98d6a9c..ca0e89e46e13 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -581,6 +581,8 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
> >   	rwlock_init(&ctx->queuelock);
> >   	kref_init(&ctx->ref);
> > +	ctx->pid = get_pid(task_pid(current));
> 
> Would it simplify things for msm if DRM core had an up to date file->pid as
> proposed in
> https://patchwork.freedesktop.org/patch/526752/?series=109902&rev=4 ? It
> gets updated if ioctl issuer is different than fd opener and this being
> context_init here reminded me of it. Maybe you wouldn't have to track the
> pid in msm?

Can we go one step further and let the drm fdinfo stuff print these new
additions? Consistency across drivers and all that.

Also for a generic trigger I think any driver ioctl is good enough (we
only really need to avoid the auth dance when you're not on a render
node).
-Daniel

> 
> Regards,
> 
> Tvrtko
> 
> > +	mutex_init(&ctx->lock);
> >   	msm_submitqueue_init(dev, ctx);
> >   	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index c403912d13ab..f0f4f845c32d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -327,18 +327,17 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
> >   static void retire_submits(struct msm_gpu *gpu);
> > -static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> > +static void get_comm_cmdline(struct msm_file_private *ctx, char **comm, char **cmd)
> >   {
> > -	struct msm_file_private *ctx = submit->queue->ctx;
> >   	struct task_struct *task;
> > -	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
> > -
> >   	/* Note that kstrdup will return NULL if argument is NULL: */
> > +	mutex_lock(&ctx->lock);
> >   	*comm = kstrdup(ctx->comm, GFP_KERNEL);
> >   	*cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
> > +	mutex_unlock(&ctx->lock);
> > -	task = get_pid_task(submit->pid, PIDTYPE_PID);
> > +	task = get_pid_task(ctx->pid, PIDTYPE_PID);
> >   	if (!task)
> >   		return;
> > @@ -372,7 +371,7 @@ static void recover_worker(struct kthread_work *work)
> >   		if (submit->aspace)
> >   			submit->aspace->faults++;
> > -		get_comm_cmdline(submit, &comm, &cmd);
> > +		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
> >   		if (comm && cmd) {
> >   			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
> > @@ -460,7 +459,7 @@ static void fault_worker(struct kthread_work *work)
> >   		goto resume_smmu;
> >   	if (submit) {
> > -		get_comm_cmdline(submit, &comm, &cmd);
> > +		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
> >   		/*
> >   		 * When we get GPU iova faults, we can get 1000s of them,
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index 7a4fa1b8655b..b2023a42116b 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -377,17 +377,25 @@ struct msm_file_private {
> >   	 */
> >   	int sysprof;
> > +	/** @pid: Process that opened this file. */
> > +	struct pid *pid;
> > +
> > +	/**
> > +	 * lock: Protects comm and cmdline
> > +	 */
> > +	struct mutex lock;
> > +
> >   	/**
> >   	 * comm: Overridden task comm, see MSM_PARAM_COMM
> >   	 *
> > -	 * Accessed under msm_gpu::lock
> > +	 * Accessed under msm_file_private::lock
> >   	 */
> >   	char *comm;
> >   	/**
> >   	 * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
> >   	 *
> > -	 * Accessed under msm_gpu::lock
> > +	 * Accessed under msm_file_private::lock
> >   	 */
> >   	char *cmdline;
> > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > index 0e803125a325..0444ba04fa06 100644
> > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > @@ -61,6 +61,7 @@ void __msm_file_private_destroy(struct kref *kref)
> >   	}
> >   	msm_gem_address_space_put(ctx->aspace);
> > +	put_pid(ctx->pid);
> >   	kfree(ctx->comm);
> >   	kfree(ctx->cmdline);
> >   	kfree(ctx);

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
