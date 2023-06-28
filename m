Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7B740CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjF1J1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:24 -0400
Received: from out-2.mta0.migadu.com ([91.218.175.2]:43855 "EHLO
        out-2.mta0.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjF1IJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:09:35 -0400
Message-ID: <490fd0d8-c0b3-cc26-c658-da35d52b6b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687928159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQ68CUVkPH/DtMtvHx22HPkppfpY40d9tzkAnim8HEA=;
        b=gd14pwcZQ7pAUgNaZvwc6+yhnLoa08VYUHT51t9MTHmJbHRbWHAjqm/MY7AF7bZv896gpi
        s9Dd4FSxg9q8v1WeWWXfSI/buhDB081atkCewxWYSGCr6AhvGhhFI4nfeKWVbFu5DIavIz
        xemrMbdSGayHfgkrFfaY+E+fDA+hZUQ=
Date:   Wed, 28 Jun 2023 12:55:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] blk-flush: count inflight flush_data requests
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-3-chengming.zhou@linux.dev>
 <ZJuzYMeVhP5cthbC@ovpn-8-21.pek2.redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJuzYMeVhP5cthbC@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 12:13, Ming Lei wrote:
> On Tue, Jun 27, 2023 at 08:08:52PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The flush state machine use a double list to link all inflight
>> flush_data requests, to avoid issuing separate post-flushes for
>> these flush_data requests which shared PREFLUSH.
>>
>> So we can't reuse rq->queuelist, this is why we need rq->flush.list
>>
>> In preparation of the next patch that reuse rq->queuelist for flush
>> state machine, we change the double linked list to a u64 counter,
>> which count all inflight flush_data requests.
>>
>> This is ok since we only need to know if there is any inflight
>> flush_data request, so a u64 counter is good. The only problem I can
>> think of is that u64 counter may overflow, which should be unlikely happen.
> 
> It won't overflow, q->nr_requests is 'unsigned long', which should have
> been limited to one more reasonable value, such as 2 * BLK_MQ_MAX_DEPTH, so
> u16 should be big enough in theory.

Ah, right. q->nr_requests is 'unsigned long' and q->queue_depth is 'unsigned int',
so 'unsigned long' counter here won't overflow.

Should I change it to smaller 'unsigned short' or just leave it as 'unsigned long' ?
(Now the size of struct blk_flush_queue is exactly 64 bytes)

Thanks.

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  block/blk-flush.c | 9 +++++----
>>  block/blk.h       | 5 ++---
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index dba392cf22be..bb7adfc2a5da 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -187,7 +187,8 @@ static void blk_flush_complete_seq(struct request *rq,
>>  		break;
>>  
>>  	case REQ_FSEQ_DATA:
>> -		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>> +		list_del_init(&rq->flush.list);
>> +		fq->flush_data_in_flight++;
>>  		spin_lock(&q->requeue_lock);
>>  		list_add_tail(&rq->queuelist, &q->flush_list);
>>  		spin_unlock(&q->requeue_lock);
>> @@ -299,7 +300,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>>  		return;
>>  
>>  	/* C2 and C3 */
>> -	if (!list_empty(&fq->flush_data_in_flight) &&
>> +	if (fq->flush_data_in_flight &&
>>  	    time_before(jiffies,
>>  			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
>>  		return;
>> @@ -374,6 +375,7 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
>>  	 * the comment in flush_end_io().
>>  	 */
>>  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>> +	fq->flush_data_in_flight--;
>>  	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
>>  	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>>  
>> @@ -445,7 +447,7 @@ bool blk_insert_flush(struct request *rq)
>>  		blk_rq_init_flush(rq);
>>  		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
>>  		spin_lock_irq(&fq->mq_flush_lock);
>> -		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>> +		fq->flush_data_in_flight++;
>>  		spin_unlock_irq(&fq->mq_flush_lock);
>>  		return false;
>>  	default:
>> @@ -496,7 +498,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>>  
>>  	INIT_LIST_HEAD(&fq->flush_queue[0]);
>>  	INIT_LIST_HEAD(&fq->flush_queue[1]);
>> -	INIT_LIST_HEAD(&fq->flush_data_in_flight);
>>  
>>  	return fq;
>>  
>> diff --git a/block/blk.h b/block/blk.h
>> index 608c5dcc516b..686712e13835 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -15,15 +15,14 @@ struct elevator_type;
>>  extern struct dentry *blk_debugfs_root;
>>  
>>  struct blk_flush_queue {
>> +	spinlock_t		mq_flush_lock;
>>  	unsigned int		flush_pending_idx:1;
>>  	unsigned int		flush_running_idx:1;
>>  	blk_status_t 		rq_status;
>>  	unsigned long		flush_pending_since;
>>  	struct list_head	flush_queue[2];
>> -	struct list_head	flush_data_in_flight;
>> +	unsigned long		flush_data_in_flight;
>>  	struct request		*flush_rq;
>> -
>> -	spinlock_t		mq_flush_lock;
>>  };
> 
> The part of replacing inflight data rq list with counter looks fine.
> 
> Thanks,
> Ming
> 
