Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702BF62BB68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiKPLVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiKPLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:21:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAD4E41D;
        Wed, 16 Nov 2022 03:09:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57081336F8;
        Wed, 16 Nov 2022 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668596945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0A7d1xzwheDqkXg7izTobfs56vTna3Rm7EV61mYuosY=;
        b=HIH0uKbOsn3eGop72mSfQJlx484DBh9V4E/05LrCn+nmjelHDtWJt4iSOghOq3ca0TuDrD
        TfsbceBYcfAlJbzeAF3Dg7YWjDy+b3IuQBYF4F/UqLzDrWm01ZkdI2a8uB22kEJQfP0//W
        c+mD4PUazw74Qm04tc/6z5Zi1E14JY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668596945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0A7d1xzwheDqkXg7izTobfs56vTna3Rm7EV61mYuosY=;
        b=lXq2kmiQ5yHWm57D2vr6XcBF41+i/Q8Sq5YMEqO6/hfSkQCtSmO70IsdWCh6hVY00XmJFE
        xd/pbLUBSXAq9RCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4990613480;
        Wed, 16 Nov 2022 11:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XATyEdHEdGMRZQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 11:09:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 81F25A0709; Wed, 16 Nov 2022 12:09:04 +0100 (CET)
Date:   Wed, 16 Nov 2022 12:09:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     axboe@kernel.dk, mingo@redhat.com, peterz@infradead.org,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, liusong@linux.alibaba.com,
        chaitanyak@nvidia.com
Subject: Re: [PATCH 3/3] sbitmap: Try each queue to wake up at least one
 waiter
Message-ID: <20221116110904.trhcoxqa6tipevdr@quack3>
References: <20221115224553.23594-1-krisman@suse.de>
 <20221115224553.23594-4-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115224553.23594-4-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-11-22 17:45:53, Gabriel Krisman Bertazi wrote:
> Jan reported the new algorithm as merged might be problematic if the
> queue being awaken becomes empty between the waitqueue_active inside
> sbq_wake_ptr check and the wake up.  If that happens, wake_up_nr will
> not wake up any waiter and we loose too many wake ups.  In order to
> guarantee progress, we need to wake up at least one waiter here, if
> there are any.  This now requires trying to wake up from every queue.
> 
> Instead of walking through all the queues with sbq_wake_ptr, this call
> moves the wake up inside that function.  In a previous version of the
> patch, I found that updating wake_index several times when walking
> through queues had a measurable overhead.  This ensures we only update
> it once, at the end.
> 
> Fixes: 4f8126bb2308 ("sbitmap: Use single per-bitmap counting to wake up queued tags")
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Elegant and looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/sbitmap.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index bea7984f7987..586deb333237 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -560,12 +560,12 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
> -static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
> +static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
>  	int i, wake_index;
>  
>  	if (!atomic_read(&sbq->ws_active))
> -		return NULL;
> +		return;
>  
>  	wake_index = atomic_read(&sbq->wake_index);
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
> @@ -579,20 +579,22 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>  		 */
>  		wake_index = sbq_index_inc(wake_index);
>  
> -		if (waitqueue_active(&ws->wait)) {
> -			if (wake_index != atomic_read(&sbq->wake_index))
> -				atomic_set(&sbq->wake_index, wake_index);
> -			return ws;
> -		}
> +		/*
> +		 * It is sufficient to wake up at least one waiter to
> +		 * guarantee forward progress.
> +		 */
> +		if (waitqueue_active(&ws->wait) &&
> +		    wake_up_nr(&ws->wait, nr))
> +			break;
>  	}
>  
> -	return NULL;
> +	if (wake_index != atomic_read(&sbq->wake_index))
> +		atomic_set(&sbq->wake_index, wake_index);
>  }
>  
>  void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
>  	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
> -	struct sbq_wait_state *ws = NULL;
>  	unsigned int wakeups;
>  
>  	if (!atomic_read(&sbq->ws_active))
> @@ -604,16 +606,10 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  	do {
>  		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
>  			return;
> -
> -		if (!ws) {
> -			ws = sbq_wake_ptr(sbq);
> -			if (!ws)
> -				return;
> -		}
>  	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
>  				     &wakeups, wakeups + wake_batch));
>  
> -	wake_up_nr(&ws->wait, wake_batch);
> +	__sbitmap_queue_wake_up(sbq, wake_batch);
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
