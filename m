Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E2740B10
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjF1IVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234270AbjF1IP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687940076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1KUy+mSETB0Ymbiz3MZDrs6ZOWnVr5ABuTlCCBNInE=;
        b=S3tqJeTclGtKSCj1KDso5UE0hinm13urRDY2nXdqGLYfta4B3Lq+gDI3X4sv/PZoboVyZh
        zv/hmleOmlkB3l5L9r6s2o+5Wgl3Ml8CMzqbAgIZuXHxdUGb22dkqFcnH7UQWICdd727j3
        N3HekIW1wT4oDMC9qGPnWO6g7M/nDHg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-PNS-UaNNObak31gAYQU7LQ-1; Wed, 28 Jun 2023 00:13:47 -0400
X-MC-Unique: PNS-UaNNObak31gAYQU7LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C1F61C04B55;
        Wed, 28 Jun 2023 04:13:46 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C68B8111F3B0;
        Wed, 28 Jun 2023 04:13:25 +0000 (UTC)
Date:   Wed, 28 Jun 2023 12:13:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 2/4] blk-flush: count inflight flush_data requests
Message-ID: <ZJuzYMeVhP5cthbC@ovpn-8-21.pek2.redhat.com>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627120854.971475-3-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:08:52PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The flush state machine use a double list to link all inflight
> flush_data requests, to avoid issuing separate post-flushes for
> these flush_data requests which shared PREFLUSH.
> 
> So we can't reuse rq->queuelist, this is why we need rq->flush.list
> 
> In preparation of the next patch that reuse rq->queuelist for flush
> state machine, we change the double linked list to a u64 counter,
> which count all inflight flush_data requests.
> 
> This is ok since we only need to know if there is any inflight
> flush_data request, so a u64 counter is good. The only problem I can
> think of is that u64 counter may overflow, which should be unlikely happen.

It won't overflow, q->nr_requests is 'unsigned long', which should have
been limited to one more reasonable value, such as 2 * BLK_MQ_MAX_DEPTH, so
u16 should be big enough in theory.

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-flush.c | 9 +++++----
>  block/blk.h       | 5 ++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index dba392cf22be..bb7adfc2a5da 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -187,7 +187,8 @@ static void blk_flush_complete_seq(struct request *rq,
>  		break;
>  
>  	case REQ_FSEQ_DATA:
> -		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> +		list_del_init(&rq->flush.list);
> +		fq->flush_data_in_flight++;
>  		spin_lock(&q->requeue_lock);
>  		list_add_tail(&rq->queuelist, &q->flush_list);
>  		spin_unlock(&q->requeue_lock);
> @@ -299,7 +300,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  		return;
>  
>  	/* C2 and C3 */
> -	if (!list_empty(&fq->flush_data_in_flight) &&
> +	if (fq->flush_data_in_flight &&
>  	    time_before(jiffies,
>  			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
>  		return;
> @@ -374,6 +375,7 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
>  	 * the comment in flush_end_io().
>  	 */
>  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
> +	fq->flush_data_in_flight--;
>  	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
>  	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>  
> @@ -445,7 +447,7 @@ bool blk_insert_flush(struct request *rq)
>  		blk_rq_init_flush(rq);
>  		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
>  		spin_lock_irq(&fq->mq_flush_lock);
> -		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> +		fq->flush_data_in_flight++;
>  		spin_unlock_irq(&fq->mq_flush_lock);
>  		return false;
>  	default:
> @@ -496,7 +498,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>  
>  	INIT_LIST_HEAD(&fq->flush_queue[0]);
>  	INIT_LIST_HEAD(&fq->flush_queue[1]);
> -	INIT_LIST_HEAD(&fq->flush_data_in_flight);
>  
>  	return fq;
>  
> diff --git a/block/blk.h b/block/blk.h
> index 608c5dcc516b..686712e13835 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -15,15 +15,14 @@ struct elevator_type;
>  extern struct dentry *blk_debugfs_root;
>  
>  struct blk_flush_queue {
> +	spinlock_t		mq_flush_lock;
>  	unsigned int		flush_pending_idx:1;
>  	unsigned int		flush_running_idx:1;
>  	blk_status_t 		rq_status;
>  	unsigned long		flush_pending_since;
>  	struct list_head	flush_queue[2];
> -	struct list_head	flush_data_in_flight;
> +	unsigned long		flush_data_in_flight;
>  	struct request		*flush_rq;
> -
> -	spinlock_t		mq_flush_lock;
>  };

The part of replacing inflight data rq list with counter looks fine.

Thanks,
Ming

