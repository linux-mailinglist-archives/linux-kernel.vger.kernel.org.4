Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBF5BC1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiISD4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F05186EC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663559761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HG8HMEb/cIOfLhOlbf6Pwfu6E0VxjMhXeVXcIWhs/kI=;
        b=R38OX1rDJVzyowGrQKC+2Y8NyjO5mdfxy/II/zX8expp2jLdCwbwZwW014chRiqyd5b9PS
        6vw84SUVwJZGqTBE7+dAjxwC9UklMz7Zai/kpRE6mFCr03Dfn/ghZW7zKK9bdWKJhzLw+h
        69FPxAuZL+g+RDwaJbT9isd5wB9vR/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-LuEc13XHNUK5sbGAqxxa6w-1; Sun, 18 Sep 2022 23:55:57 -0400
X-MC-Unique: LuEc13XHNUK5sbGAqxxa6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04A0D82A68B;
        Mon, 19 Sep 2022 03:55:57 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 757772166B26;
        Mon, 19 Sep 2022 03:55:51 +0000 (UTC)
Date:   Mon, 19 Sep 2022 11:55:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <YyfoQuw18kOynxcC@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
> With recovery feature enabled, in ublk_queue_rq or task work
> (in exit_task_work or fallback wq), we requeue rqs instead of
> ending(aborting) them. Besides, No matter recovery feature is enabled
> or disabled, we schedule monitor_work immediately.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 23337bd7c105..b067f33a1913 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>  
>  #define UBLK_REQUEUE_DELAY_MS	3
>  
> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq)) {
> +		blk_mq_requeue_request(rq, false);
> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);

Here you needn't to kick requeue list since we know it can't make
progress. And you can do that once before deleting gendisk
or the queue is recovered.

> +	} else {
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +	}
> +}
> +
>  static inline void __ublk_rq_task_work(struct request *req)
>  {
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> @@ -704,7 +719,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	 * (2) current->flags & PF_EXITING.
>  	 */
>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> -		blk_mq_end_request(req, BLK_STS_IOERR);
> +		__ublk_abort_rq_in_task_work(ubq, req);
>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>  		return;
>  	}
> @@ -779,6 +794,21 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>  	__ublk_rq_task_work(req);
>  }
>  
> +static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq)) {
> +		blk_mq_requeue_request(rq, false);
> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);

Same with above.


Thanks,
Ming

