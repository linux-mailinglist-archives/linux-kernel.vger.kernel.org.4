Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421845FF09D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJNOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJNOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A22EF45;
        Fri, 14 Oct 2022 07:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4FA221EB2;
        Fri, 14 Oct 2022 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665759005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8T6Ig2kAX7i1ELDm18RCHxPf9499f4Scte73Zgsjgo=;
        b=ElggAD/kgeVTBymIbafVSqYTdqTwbXm+nhPmndMhBX/e/lDy0kt9o7FXsVl+hDApSF4zaw
        7eYQO4QahPf2Qp8TyN05xoqYjoc/I3hlAKSE3qOZ65xwtuRuG5BBcrVsKBjFXutFqj8HLR
        rQWw6Mhm9n9IpF0bS8v86ZPqLdfsqDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665759005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8T6Ig2kAX7i1ELDm18RCHxPf9499f4Scte73Zgsjgo=;
        b=d012M3EAmA4Hg5ffW4BWjg8WNH1e1dpgrlz0HcqC9wDx2YUpEjC4CGXXruradBma/uMyBi
        uGL/aSLXEpleQxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A191213A4A;
        Fri, 14 Oct 2022 14:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/JlJx13SWNKWgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Oct 2022 14:50:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07EB2A06F1; Fri, 14 Oct 2022 16:50:05 +0200 (CEST)
Date:   Fri, 14 Oct 2022 16:50:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: Re: [PATCH] bfq: do try insert merge before bfq_init_rq() call
Message-ID: <20221014145004.gqqpa5uvgg576tej@quack3>
References: <20221013135321.174-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013135321.174-1-Yuwei.Guan@zeekrlife.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-10-22 21:53:21, Yuwei Guan wrote:
> It's useless to do bfq_init_rq(rq), if the rq can do merge first.
> 
> In the patch 5f550ede5edf8, it moved to bfq_init_rq() before
> blk_mq_sched_try_insert_merge(), but it's pointless,
> as the fifo_time of next is not set yet,
> and !list_empty(&next->queuelist) is 0, so it does not
> need to reposition rq's fifo_time.
> 
> And for the "hash lookup, try again" situation, as follow,
> bfq_requests_merged() call can work normally.
> 
> blk_mq_sched_try_insert_merge
>   elv_attempt_insert_merge
>     elv_rqhash_find
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

OK, after some thinking I agree. How much testing has this patch got?
Because I'd like to verify we didn't overlook something.

							Honza

> ---
>  block/bfq-iosched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..9845370a701c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6147,7 +6147,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		bfqg_stats_update_legacy_io(q, rq);
>  #endif
>  	spin_lock_irq(&bfqd->lock);
> -	bfqq = bfq_init_rq(rq);
> +
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>  		spin_unlock_irq(&bfqd->lock);
>  		blk_mq_free_requests(&free);
> @@ -6156,6 +6156,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> +	bfqq = bfq_init_rq(rq);
>  	if (!bfqq || at_head) {
>  		if (at_head)
>  			list_add(&rq->queuelist, &bfqd->dispatch);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
