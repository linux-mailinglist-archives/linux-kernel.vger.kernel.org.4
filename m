Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD270DC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjEWMTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjEWMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70011AD;
        Tue, 23 May 2023 05:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8EE631A8;
        Tue, 23 May 2023 12:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6E6C433D2;
        Tue, 23 May 2023 12:19:07 +0000 (UTC)
Message-ID: <575f58b9-cf30-a152-8909-7cd827e4cc70@xs4all.nl>
Date:   Tue, 23 May 2023 14:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/13] media: amphion: Use alloc_ordered_workqueue() to
 create ordered workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-5-tj@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230509015032.3768622-5-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 03:50, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered").

That's the wrong patch description, it should be:

4c16bd327c74 ("workqueue: implement NUMA affinity for unbound workqueues")

 Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to
> 
>   alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and

ncessary -> necessary

> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.

Note that the max line length of 75 is exceeded in this commit message.

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Ming Qian <ming.qian@nxp.com>
> Cc: Shijie Qin <shijie.qin@nxp.com>
> Cc: Zhou Peng <eagle.zhou@nxp.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> ---
>  drivers/media/platform/amphion/vpu_core.c | 2 +-
>  drivers/media/platform/amphion/vpu_v4l2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
> index de23627a119a..43d85a54268b 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -254,7 +254,7 @@ static int vpu_core_register(struct device *dev, struct vpu_core *core)
>  	if (vpu_core_is_exist(vpu, core))
>  		return 0;
>  
> -	core->workqueue = alloc_workqueue("vpu", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
> +	core->workqueue = alloc_ordered_workqueue("vpu", WQ_MEM_RECLAIM);
>  	if (!core->workqueue) {
>  		dev_err(core->dev, "fail to alloc workqueue\n");
>  		return -ENOMEM;
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
> index 6773b885597c..a48edb445eea 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -740,7 +740,7 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
>  	inst->fh.ctrl_handler = &inst->ctrl_handler;
>  	file->private_data = &inst->fh;
>  	inst->state = VPU_CODEC_STATE_DEINIT;
> -	inst->workqueue = alloc_workqueue("vpu_inst", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
> +	inst->workqueue = alloc_ordered_workqueue("vpu_inst", WQ_MEM_RECLAIM);
>  	if (inst->workqueue) {
>  		INIT_WORK(&inst->msg_work, vpu_inst_run_work);
>  		ret = kfifo_init(&inst->msg_fifo,

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Feel free to take this with the commit log changes mentioned above.

Regards,

	Hans
