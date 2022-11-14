Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F11628134
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiKNNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:23:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB4D289;
        Mon, 14 Nov 2022 05:23:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4CA1FFC2;
        Mon, 14 Nov 2022 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668432194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgngAVDEPp8EfnFAkGovAM0IoAOtRXmUhxn9JytQBRU=;
        b=QaX1bmsOwlS7n+JHBoAG9LGcDphDpD6JHyPsfBZnTZpRnkwPy50oc94lQX93JkzCUOIR7c
        XlyIR6OmEG0zGvAo/0TItE9ToCl/wB3Y/aCe0pi1TsHVxnJj3YiFcQ8BfwL73jBd3nXQGr
        QUEqg5/YToKNWcVxX7xTt9KOIpHWcvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668432194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgngAVDEPp8EfnFAkGovAM0IoAOtRXmUhxn9JytQBRU=;
        b=h7dIhAmyLiiT2zNqT0H+llkwqR1qNlDpSX2CWc2v2sGymNc9ER0iOkQCKPIPSGfFtPN/QW
        5xMO/d3cfy0ISCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F07D13A8C;
        Mon, 14 Nov 2022 13:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VWYrF0JBcmN0RQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 13:23:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8FFDDA0709; Mon, 14 Nov 2022 14:23:13 +0100 (CET)
Date:   Mon, 14 Nov 2022 14:23:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Message-ID: <20221114132313.5cqhvzxarm7rwvmt@quack3>
References: <20221105231055.25953-1-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel, when looking through this patch, I've noticed we can loose wakeups
after your latest simplifications. See below for details:

On Sat 05-11-22 19:10:55, Gabriel Krisman Bertazi wrote:
> @@ -587,7 +571,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>  
> -		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
> +		if (waitqueue_active(&ws->wait)) {
>  			if (wake_index != atomic_read(&sbq->wake_index))
>  				atomic_set(&sbq->wake_index, wake_index);
>  			return ws;

Neither sbq_wake_ptr() nor sbitmap_queue_wake_up() now increment the
wake_index after performing the wakeup. Thus we would effectively keep
waking tasks from a single waitqueue until it becomes empty and only then
go for the next waitqueue. This creates unnecessary unfairness in task
wakeups and even possible starvation issues. So I think we need to advance
wake_index somewhere. Perhaps here before returning waitqueue.

> @@ -599,83 +583,31 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>  	return NULL;
>  }
>  
> -static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
> +	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
> +	struct sbq_wait_state *ws = NULL;
> +	unsigned int wakeups;
>  
> +	if (!atomic_read(&sbq->ws_active))
> +		return;
>  
> +	atomic_add(nr, &sbq->completion_cnt);
> +	wakeups = atomic_read(&sbq->wakeup_cnt);
>  
>  	do {
> +		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> +			return;
>  
> +		if (!ws) {
> +			ws = sbq_wake_ptr(sbq);
> +			if (!ws)
> +				return;
> +		}
> +	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
> +				     &wakeups, wakeups + wake_batch));
>  
>  	wake_up_nr(&ws->wait, wake_batch);

Now this may be also problematic - when we were checking the number of woken
waiters in the older version of the patch (for others: internal version of
the patch) this was fine but now it may happen that the 'ws' we have
selected has no waiters anymore. And in that case we need to find another
waitqueue because otherwise we'd be loosing too many wakeups and we could
deadlock. So I think this rather needs to be something like:

	do {
		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
			return;
	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
				     &wakeups, wakeups + wake_batch));

	do {
		ws = sbq_wake_ptr(sbq);
		if (!ws)
			return;
	} while (!wake_up_nr(&ws->wait, wake_batch));

with our original version of wake_up_nr() returning number of woken
waiters. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
