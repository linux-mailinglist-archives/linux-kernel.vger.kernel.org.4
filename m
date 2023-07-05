Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF3748785
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjGEPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjGEPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277D1123
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688569841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0oUPF27DN5scCDEZIBj1Evs/zZhcrQVhVD5HGAd52rM=;
        b=fFmTF2MxXYvnFZX6tOcjL75rXTX4hQULEEPSIdIBp4gjsYS2JEP1qTPkR2FSlVFJ3R7bPx
        mgi4b3EL5LBfXwxxmtukYhOWCKqp97qG+OjzeWEKDDr2T+FctiaHf/u2QkpG7tQQd9BeKM
        nVRJsymxnVscziz4KrphL21m3y6BDcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-kGvdzjCnPnSeuW96lJdd5A-1; Wed, 05 Jul 2023 11:10:38 -0400
X-MC-Unique: kGvdzjCnPnSeuW96lJdd5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 661B2882389;
        Wed,  5 Jul 2023 15:10:37 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4125F492B01;
        Wed,  5 Jul 2023 15:10:32 +0000 (UTC)
Date:   Wed, 5 Jul 2023 23:10:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 2/4] blk-flush: count inflight flush_data requests
Message-ID: <ZKWH5ANh/hq3Eyn0@ovpn-8-34.pek2.redhat.com>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
 <20230629110359.1111832-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-3-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:03:57PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The flush state machine use a double list to link all inflight
> flush_data requests, to avoid issuing separate post-flushes for
> these flush_data requests which shared PREFLUSH.
> 
> So we can't reuse rq->queuelist, this is why we need rq->flush.list
> 
> In preparation of the next patch that reuse rq->queuelist for flush
> state machine, we change the double linked list to unsigned long
> counter, which count all inflight flush_data requests.
> 
> This is ok since we only need to know if there is any inflight
> flush_data request, so unsigned long counter is good.
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

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

