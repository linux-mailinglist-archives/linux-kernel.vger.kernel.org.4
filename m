Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF29466409A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjAJMfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjAJMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:35:17 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C03DBD6;
        Tue, 10 Jan 2023 04:35:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NrqyZ1VFqz4f3jqP;
        Tue, 10 Jan 2023 20:35:02 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBnHLB3W71jiJTWBQ--.49270S2;
        Tue, 10 Jan 2023 20:35:04 +0800 (CST)
Subject: Re: [PATCH v2 08/13] blk-mq: simplify flush check in
 blk_mq_dispatch_rq_list
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
 <20230104142259.2673013-9-shikemeng@huaweicloud.com>
 <20230108180611.GG23466@lst.de>
 <86677943-1c5e-370f-ba69-25e10738b67b@huaweicloud.com>
 <20230110080923.GA11231@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <540fdd7d-e13b-fffb-20e2-95b59bac0009@huaweicloud.com>
Date:   Tue, 10 Jan 2023 20:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230110080923.GA11231@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnHLB3W71jiJTWBQ--.49270S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4fXF1rtrWUJr4DGFyxuFg_yoWxZFWrpF
        W5Ja1ayrW8Xr4xX348Jan7uFy3ArsxtrW29rySyw1aqrW5K39aqr43Jry7AF92yr4kCw43
        WF45Xr9Iyr45JrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 1/10/2023 4:09 PM, Christoph Hellwig wrote:
> On Mon, Jan 09, 2023 at 10:27:33AM +0800, Kemeng Shi wrote:
>> After we queue request[s] to one driver queue, we need to notify driver
>> that there are no more request to the queue or driver will keep waiting
>> for the last request to be queued and IO hung could happen.
> 
> Yes.
> 
>> Normaly, we will notify this by setting .last in struct blk_mq_queue_data
>> along with the normal last request .rq in struct blk_mq_queue_data. The
>> extra commit is only needed if normal last information in .last is lost.
>> (See comment in struct blk_mq_ops for commit_rqs).
>>
>> The lost could occur if error happens for sending last request with .last
>> set or error happen in middle of list and we even do not send the request
>> with .last set.
> 
> Yes. So the rule is:
> 
>  1) did not queue everything initially scheduled to queue
> 
> OR
> 
>  2) the last attempt to queue a request failed
> 
> I think we need to find a way to clearly document that and that
> make all callers match it.
> For most this becomes a
> 
> 	if (ret || !list_empty(list))
> 
> or even just
> 
> 	if (ret)
> 
> as an error is often the only way to break out of the submission
> loop.
> 
> I wonder if we need to split the queued clearing from blk_mq_commit_rqs
> and just clear it in the existing callers, so that we can use that
> helpers for all commits, nicely hiding the ->commit_rqs presence
> check, and then move that call to where it is needed directly.  Something
> like this untested patch (which needs to be split up), which also
> makes sure we trace these calls consistently:
Yes, using helper also makes queued check consistently. Currently, most code
only calls commit_rqs if any request is queued, one exception is that
blk_mq_plug_issue_direct calls commit_rqs without queued check.
Besides, we can document the the rule before blk_mq_commit_rqs. Any caller
in future can notice the rule and match it.
I will send next version based on suggested helper.
Thanks.
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c5cf0dbca1db8d..436ca56a0b7172 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2001,6 +2001,15 @@ static void blk_mq_release_budgets(struct request_queue *q,
>  	}
>  }
>  
> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued,
> +			      bool from_schedule)
> +{
> +	if (queued && hctx->queue->mq_ops->commit_rqs) {
> +		trace_block_unplug(hctx->queue, queued, !from_schedule);
> +		hctx->queue->mq_ops->commit_rqs(hctx);
> +	}
> +}
> +
>  /*
>   * Returns true if we did some work AND can potentially do more.
>   */
> @@ -2082,12 +2091,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  	if (!list_empty(&zone_list))
>  		list_splice_tail_init(&zone_list, list);
>  
> -	/* If we didn't flush the entire list, we could have told the driver
> -	 * there was more coming, but that turned out to be a lie.
> -	 */
> -	if ((!list_empty(list) || errors || needs_resource ||
> -	     ret == BLK_STS_DEV_RESOURCE) && q->mq_ops->commit_rqs && queued)
> -		q->mq_ops->commit_rqs(hctx);
> +	if (!list_empty(list) || ret)
> +		blk_mq_commit_rqs(hctx, queued, false);
> +
>  	/*
>  	 * Any items that need requeuing? Stuff them into hctx->dispatch,
>  	 * that is where we will continue on next queue run.
> @@ -2548,16 +2554,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  	spin_unlock(&ctx->lock);
>  }
>  
> -static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
> -			      bool from_schedule)
> -{
> -	if (hctx->queue->mq_ops->commit_rqs) {
> -		trace_block_unplug(hctx->queue, *queued, !from_schedule);
> -		hctx->queue->mq_ops->commit_rqs(hctx);
> -	}
> -	*queued = 0;
> -}
> -
>  static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -2684,17 +2680,17 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  {
>  	struct blk_mq_hw_ctx *hctx = NULL;
> +	blk_status_t ret = BLK_STS_OK;
>  	struct request *rq;
>  	int queued = 0;
> -	int errors = 0;
>  
>  	while ((rq = rq_list_pop(&plug->mq_list))) {
>  		bool last = rq_list_empty(plug->mq_list);
> -		blk_status_t ret;
>  
>  		if (hctx != rq->mq_hctx) {
>  			if (hctx)
> -				blk_mq_commit_rqs(hctx, &queued, from_schedule);
> +				blk_mq_commit_rqs(hctx, queued, from_schedule);
> +			queued = 0;
>  			hctx = rq->mq_hctx;
>  		}
>  
> @@ -2706,21 +2702,15 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  		case BLK_STS_RESOURCE:
>  		case BLK_STS_DEV_RESOURCE:
>  			blk_mq_request_bypass_insert(rq, false, true);
> -			blk_mq_commit_rqs(hctx, &queued, from_schedule);
> -			return;
> +			goto out;
>  		default:
>  			blk_mq_end_request(rq, ret);
> -			errors++;
>  			break;
>  		}
>  	}
> -
> -	/*
> -	 * If we didn't flush the entire list, we could have told the driver
> -	 * there was more coming, but that turned out to be a lie.
> -	 */
> -	if (errors)
> -		blk_mq_commit_rqs(hctx, &queued, from_schedule);
> +out:
> +	if (ret)
> +		blk_mq_commit_rqs(hctx, queued, from_schedule);
>  }
>  
>  static void __blk_mq_flush_plug_list(struct request_queue *q,
> @@ -2804,37 +2794,33 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		struct list_head *list)
>  {
> +	blk_status_t ret = BLK_STS_OK;
> +	struct request *rq;
>  	int queued = 0;
> -	int errors = 0;
> -
> -	while (!list_empty(list)) {
> -		blk_status_t ret;
> -		struct request *rq = list_first_entry(list, struct request,
> -				queuelist);
> +	bool last;
>  
> +	while ((rq = list_first_entry_or_null(list, struct request,
> +			queuelist))) {
>  		list_del_init(&rq->queuelist);
> -		ret = blk_mq_request_issue_directly(rq, list_empty(list));
> -		if (ret != BLK_STS_OK) {
> -			errors++;
> -			if (ret == BLK_STS_RESOURCE ||
> -					ret == BLK_STS_DEV_RESOURCE) {
> -				blk_mq_request_bypass_insert(rq, false,
> -							list_empty(list));
> -				break;
> -			}
> -			blk_mq_end_request(rq, ret);
> -		} else
> +		last = list_empty(list);
> +
> +		ret = blk_mq_request_issue_directly(rq, last);
> +		switch (ret) {
> +		case BLK_STS_OK:
>  			queued++;
> +			break;
> +		case BLK_STS_RESOURCE:
> +		case BLK_STS_DEV_RESOURCE:
> +			blk_mq_request_bypass_insert(rq, false, last);
> +			goto out;
> +		default:
> +			blk_mq_end_request(rq, ret);
> +			break;
> +		}
>  	}
> -
> -	/*
> -	 * If we didn't flush the entire list, we could have told
> -	 * the driver there was more coming, but that turned out to
> -	 * be a lie.
> -	 */
> -	if ((!list_empty(list) || errors) &&
> -	     hctx->queue->mq_ops->commit_rqs && queued)
> -		hctx->queue->mq_ops->commit_rqs(hctx);
> +out:
> +	if (ret)
> +		blk_mq_commit_rqs(hctx, queued, false);
>  }
>  
>  static bool blk_mq_attempt_bio_merge(struct request_queue *q,
> 

-- 
Best wishes
Kemeng Shi

