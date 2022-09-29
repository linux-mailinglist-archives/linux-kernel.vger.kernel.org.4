Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E45EF80B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiI2Oxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiI2Oxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:53:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6387D13F2BB;
        Thu, 29 Sep 2022 07:53:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEC591650;
        Thu, 29 Sep 2022 07:53:39 -0700 (PDT)
Received: from [10.1.38.20] (e122027.cambridge.arm.com [10.1.38.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693D83F792;
        Thu, 29 Sep 2022 07:53:30 -0700 (PDT)
Message-ID: <e613a225-dabf-7e87-2624-a3244df8a877@arm.com>
Date:   Thu, 29 Sep 2022 15:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/6] drm/sched: Use parent fence instead of finished
Content-Language: en-GB
To:     Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
        andrey.grodzovsky@amd.com, shashank.sharma@amd.com,
        amaranath.somalapuram@amd.com, Arunpravin.PaneerSelvam@amd.com,
        sumit.semwal@linaro.org, gustavo@padovan.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20220914164321.2156-1-Arvind.Yadav@amd.com>
 <20220914164321.2156-6-Arvind.Yadav@amd.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220914164321.2156-6-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 17:43, Arvind Yadav wrote:
> Using the parent fence instead of the finished fence
> to get the job status. This change is to avoid GPU
> scheduler timeout error which can cause GPU reset.

I'm able to reproduce crashes on Panfrost and I believe this commit is
the cause. Specifically it's possible for job->s_fence->parent to be NULL.

The underlying issue seems to involve drm_sched_resubmit_jobs_ext() - if
the run_jobs() callback returns an error it will set s_fence->parent to
NULL after signalling s_fence->finished:

> 		fence = sched->ops->run_job(s_job);
> 		i++;
> 
> 		if (IS_ERR_OR_NULL(fence)) {
> 			if (IS_ERR(fence))
> 				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> 
> 			s_job->s_fence->parent = NULL;

I don't understand the reasoning behind this change, but it doesn't seem
right to be using the parent fence when we have code which can be
setting that pointer to NULL.

Since I don't understand the reasoning my only suggestion is to revert
this patch (and potentially the dependent patch "dma-buf: Check status
of enable-signaling bit on debug"?).

Can anyone suggest a better fix?

Thanks,

Steve

> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
> 
> changes in v1,v2 - Enable signaling for finished fence in sche_main()
> is removed
> 
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index e0ab14e0fb6b..2ac28ad11432 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -829,7 +829,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>  	job = list_first_entry_or_null(&sched->pending_list,
>  				       struct drm_sched_job, list);
>  
> -	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
> +	if (job && dma_fence_is_signaled(job->s_fence->parent)) {
>  		/* remove job from pending_list */
>  		list_del_init(&job->list);
>  
> @@ -841,7 +841,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>  
>  		if (next) {
>  			next->s_fence->scheduled.timestamp =
> -				job->s_fence->finished.timestamp;
> +				job->s_fence->parent->timestamp;
>  			/* start TO timer for next job */
>  			drm_sched_start_timeout(sched);
>  		}

