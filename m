Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A45BDAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiITDYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITDYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:24:19 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316813FB2;
        Mon, 19 Sep 2022 20:24:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQH5dq8_1663644253;
Received: from 30.97.56.91(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQH5dq8_1663644253)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 11:24:14 +0800
Message-ID: <64492fad-e14a-c647-b490-cd1f53a475a8@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 11:24:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
 <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
 <YyhhnbrHTJpW4Xcm@T590>
 <dbc78e92-ede7-fc63-1bee-83794bf1e33b@linux.alibaba.com>
 <Yyktx/xz0qTNxnT4@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyktx/xz0qTNxnT4@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 11:04, Ming Lei wrote:
> On Tue, Sep 20, 2022 at 09:49:33AM +0800, Ziyang Zhang wrote:
> 
> Follows the delta patch against patch 5 for showing the idea:
> 
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4409a130d0b6..60c5786c4711 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -656,7 +656,8 @@ static void ublk_complete_rq(struct request *req)
>   * Also aborting may not be started yet, keep in mind that one failed
>   * request may be issued by block layer again.
>   */
> -static void __ublk_fail_req(struct ublk_io *io, struct request *req)
> +static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> +		struct request *req)
>  {
>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>  
> @@ -667,7 +668,10 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>  				req->tag,
>  				io->flags);
>  		io->flags |= UBLK_IO_FLAG_ABORTED;
> -		blk_mq_end_request(req, BLK_STS_IOERR);
> +		if (ublk_queue_can_use_recovery_reissue(ubq))
> +			blk_mq_requeue_request(req, false);

Here is one problem:
We reset io->flags to 0 in ublk_queue_reinit() and it is called before new
ubq_daemon with FETCH_REQ is accepted. ublk_abort_queue() is not protected with
ub_mutex and it is called many times in monitor_work. So same rq may be requeued
multiple times.

With recovery disabled, there is no such problem since io->flags does not change
until ublk_dev is released.

In my patch 5 I only requeue the same rq once. So re-using ublk_abort_queue() is
hard for recovery feature.
 
> +		else
> +			blk_mq_end_request(req, BLK_STS_IOERR);
>  	}
>  }
>  
> @@ -1018,7 +1022,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  			 */
>  			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
>  			if (rq)
> -				__ublk_fail_req(io, rq);
> +				__ublk_fail_req(ubq, io, rq);
>  		}
>  	}
>  	ublk_put_device(ub);
> @@ -1026,12 +1030,10 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  
>  static bool ublk_check_inflight_rq(struct request *rq, void *data)
>  {
> -	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	struct ublk_io *io = &ubq->ios[rq->tag];
> -	bool *busy = data;
> +	bool *idle = data;
>  
> -	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> -		*busy = true;
> +	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
> +		*idle = false;
>  		return false;
>  	}
>  	return true;
> @@ -1039,16 +1041,15 @@ static bool ublk_check_inflight_rq(struct request *rq, void *data)
>  
>  static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>  {
> -	bool busy = false;
> +	bool idle = true;
>  
>  	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
>  	while (true) {
>  		blk_mq_tagset_busy_iter(&ub->tag_set,
> -				ublk_check_inflight_rq, &busy);
> -		if (busy)
> -			msleep(UBLK_REQUEUE_DELAY_MS);
> -		else
> +				ublk_check_inflight_rq, &idle);
> +		if (idle)
>  			break;
> +		msleep(UBLK_REQUEUE_DELAY_MS);
>  	}
>  }
>  
> @@ -1069,10 +1070,7 @@ static void ublk_quiesce_queue(struct ublk_device *ub,
>  					ublk_queue_can_use_recovery_reissue(ubq) ?
>  					"requeue" : "abort",
>  					ubq->q_id, i, io->flags);
> -			if (ublk_queue_can_use_recovery_reissue(ubq))
> -				blk_mq_requeue_request(rq, false);
> -			else
> -				__ublk_fail_req(io, rq);
> +			__ublk_fail_req(ubq, io, rq);
>  		} else {
>  			pr_devel("%s: done old cmd: qid %d tag %d\n",
>  					__func__, ubq->q_id, i);
> @@ -1092,12 +1090,6 @@ static void ublk_quiesce_dev(struct ublk_device *ub)
>  	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
>  		goto unlock;
>  
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> -
> -		if (!ubq_daemon_is_dying(ubq))
> -			goto unlock;
> -	}
>  	blk_mq_quiesce_queue(ub->ub_disk->queue);
>  	ublk_wait_tagset_rqs_idle(ub);
>  	pr_devel("%s: quiesce ub: dev_id %d\n",
> @@ -1129,14 +1121,13 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
>  		struct ublk_queue *ubq = ublk_get_queue(ub, i);
>  
>  		if (ubq_daemon_is_dying(ubq)) {
> -			if (ublk_queue_can_use_recovery(ubq)) {
> +			if (ublk_queue_can_use_recovery(ubq))
>  				schedule_work(&ub->quiesce_work);
> -			} else {
> +			else
>  				schedule_work(&ub->stop_work);
>  
> -				/* abort queue is for making forward progress */
> -				ublk_abort_queue(ub, ubq);
> -			}
> +			/* abort queue is for making forward progress */
> +			ublk_abort_queue(ub, ubq);
>  		}
>  	}
>  
> 
> 
> 
> 
> Thanks,
> Ming
