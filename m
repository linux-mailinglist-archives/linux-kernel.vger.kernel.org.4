Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB46E5BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjDRI2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:27:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC5199A;
        Tue, 18 Apr 2023 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681806477; x=1713342477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lxl9CmQ8kSrqA53q/Kd2vsC6iLrXfQuizeP/KK0MkNc=;
  b=kG0+GuNtosHxbpmsUCdufiVhJ9hydpOtaKnpGN1M35/+L5+d8YXRfVhg
   ihnTvPZjlFD6RIRJcluge3V9XvbdSZSkXq55tGe7T715LVHi5T5e2AI+a
   C6jVbDSKjWgkzuKkVWDePe96fub/iQzk1pXqsF2oaHAjypGQnIU6NsIxc
   5SZLEqXRDQyv08GK6IySWZR53rg3OasCZzmbDTqTGp9vk5X4qusTWj6Iz
   iyHB5Ks66lcW53KNVgJYYQuajgLSHbWOzvtfwnldKcGH1k4i7A3UWjehh
   DQN3XIMU97OdtBItCdsmNp0jfR1Lba199IDpyOeotC/VYoHwLSPe5iG8t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431397768"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="431397768"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723550830"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="723550830"
Received: from dilipban-mobl.ger.corp.intel.com (HELO [10.213.234.43]) ([10.213.234.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:27:51 -0700
Message-ID: <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com>
Date:   Tue, 18 Apr 2023 09:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
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
References: <20230417201215.448099-1-robdclark@gmail.com>
 <20230417201215.448099-3-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230417201215.448099-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2023 21:12, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Make it work in terms of ctx so that it can be re-used for fdinfo.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
>   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
>   drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
>   drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
>   drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
>   5 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index bb38e728864d..43c4e1fea83f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>   		/* Ensure string is null terminated: */
>   		str[len] = '\0';
>   
> -		mutex_lock(&gpu->lock);
> +		mutex_lock(&ctx->lock);
>   
>   		if (param == MSM_PARAM_COMM) {
>   			paramp = &ctx->comm;
> @@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>   		kfree(*paramp);
>   		*paramp = str;
>   
> -		mutex_unlock(&gpu->lock);
> +		mutex_unlock(&ctx->lock);
>   
>   		return 0;
>   	}
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 3d73b98d6a9c..ca0e89e46e13 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -581,6 +581,8 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
>   	rwlock_init(&ctx->queuelock);
>   
>   	kref_init(&ctx->ref);
> +	ctx->pid = get_pid(task_pid(current));

Would it simplify things for msm if DRM core had an up to date file->pid 
as proposed in 
https://patchwork.freedesktop.org/patch/526752/?series=109902&rev=4 ? It 
gets updated if ioctl issuer is different than fd opener and this being 
context_init here reminded me of it. Maybe you wouldn't have to track 
the pid in msm?

Regards,

Tvrtko

> +	mutex_init(&ctx->lock);
>   	msm_submitqueue_init(dev, ctx);
>   
>   	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index c403912d13ab..f0f4f845c32d 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -327,18 +327,17 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
>   
>   static void retire_submits(struct msm_gpu *gpu);
>   
> -static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> +static void get_comm_cmdline(struct msm_file_private *ctx, char **comm, char **cmd)
>   {
> -	struct msm_file_private *ctx = submit->queue->ctx;
>   	struct task_struct *task;
>   
> -	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
> -
>   	/* Note that kstrdup will return NULL if argument is NULL: */
> +	mutex_lock(&ctx->lock);
>   	*comm = kstrdup(ctx->comm, GFP_KERNEL);
>   	*cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
> +	mutex_unlock(&ctx->lock);
>   
> -	task = get_pid_task(submit->pid, PIDTYPE_PID);
> +	task = get_pid_task(ctx->pid, PIDTYPE_PID);
>   	if (!task)
>   		return;
>   
> @@ -372,7 +371,7 @@ static void recover_worker(struct kthread_work *work)
>   		if (submit->aspace)
>   			submit->aspace->faults++;
>   
> -		get_comm_cmdline(submit, &comm, &cmd);
> +		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
>   
>   		if (comm && cmd) {
>   			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
> @@ -460,7 +459,7 @@ static void fault_worker(struct kthread_work *work)
>   		goto resume_smmu;
>   
>   	if (submit) {
> -		get_comm_cmdline(submit, &comm, &cmd);
> +		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
>   
>   		/*
>   		 * When we get GPU iova faults, we can get 1000s of them,
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 7a4fa1b8655b..b2023a42116b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -377,17 +377,25 @@ struct msm_file_private {
>   	 */
>   	int sysprof;
>   
> +	/** @pid: Process that opened this file. */
> +	struct pid *pid;
> +
> +	/**
> +	 * lock: Protects comm and cmdline
> +	 */
> +	struct mutex lock;
> +
>   	/**
>   	 * comm: Overridden task comm, see MSM_PARAM_COMM
>   	 *
> -	 * Accessed under msm_gpu::lock
> +	 * Accessed under msm_file_private::lock
>   	 */
>   	char *comm;
>   
>   	/**
>   	 * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
>   	 *
> -	 * Accessed under msm_gpu::lock
> +	 * Accessed under msm_file_private::lock
>   	 */
>   	char *cmdline;
>   
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index 0e803125a325..0444ba04fa06 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -61,6 +61,7 @@ void __msm_file_private_destroy(struct kref *kref)
>   	}
>   
>   	msm_gem_address_space_put(ctx->aspace);
> +	put_pid(ctx->pid);
>   	kfree(ctx->comm);
>   	kfree(ctx->cmdline);
>   	kfree(ctx);
