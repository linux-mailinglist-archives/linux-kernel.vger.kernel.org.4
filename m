Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482AF6B03FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCHKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCHKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:21:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F35B718A;
        Wed,  8 Mar 2023 02:21:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E51CB21A3B;
        Wed,  8 Mar 2023 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678270905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F944mO70bNuhhzlAmwBrF8ILmVHrf5QndLIFiW3fWqQ=;
        b=Uor112j+nKuuTcvlSceiA1u3OTwLKPgulqt7sD+up5rG7BKrtwG7xF4H2EkGWQTxQqMFIu
        BiK1zL3syTOrdeRIufJnYIGtbw3uJBJGkPkOp4OYT+S2JVzP9oWVao2om1YZFmnyNQ18RN
        ACswBQkiFszrHcLg9wsi5XpZCIch/l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678270905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F944mO70bNuhhzlAmwBrF8ILmVHrf5QndLIFiW3fWqQ=;
        b=XaWQZg/C8ar9O6LbL1akRXF/he7A8NhyTSXoXlgbX2hHv0BUpA45zisleCUVrfQRf3q89N
        NEJ+HYNi3JH3U2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4C461391B;
        Wed,  8 Mar 2023 10:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xRoDNLlhCGTIWQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 10:21:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5530BA0709; Wed,  8 Mar 2023 11:21:45 +0100 (CET)
Date:   Wed, 8 Mar 2023 11:21:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, shinichiro.kawasaki@wdc.com,
        paolo.valente@linaro.org, axboe@kernel.dk, glusvardi@posteo.net,
        damien.lemoal@opensource.wdc.com, felicigb@gmail.com,
        inbox@emilianomaccaferri.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Message-ID: <20230308102145.fezf4uj6qtqyxj6d@quack3>
References: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
 <20230308023208.379465-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308023208.379465-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-03-23 10:32:08, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Before commit fd571df0ac5b ("block, bfq: turn bfqq_data into an array
> in bfq_io_cq"), process reference is read before bfq_put_stable_ref(),
> and it's safe if bfq_put_stable_ref() put the last reference, because
> process reference will be 0 and 'stable_merge_bfqq' won't be accessed
> in this case. However, the commit changed the order and  will cause
> uaf for 'stable_merge_bfqq'.
> 
> In order to emphasize that bfq_put_stable_ref() can drop the last
> reference, fix the problem by moving bfq_put_stable_ref() to the end of
> bfq_setup_stable_merge().
> 
> Fixes: fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/linux-block/20230307071448.rzihxbm4jhbf5krj@shindev/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me (with or without getting rid of the stable_merge_bfqq)
variable. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 8a8d4441519c..d9ed3108c17a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2854,11 +2854,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  {
>  	int proc_ref = min(bfqq_process_refs(bfqq),
>  			   bfqq_process_refs(stable_merge_bfqq));
> -	struct bfq_queue *new_bfqq;
> +	struct bfq_queue *new_bfqq = NULL;
>  
> -	if (idling_boosts_thr_without_issues(bfqd, bfqq) ||
> -	    proc_ref == 0)
> -		return NULL;
> +	bfqq_data->stable_merge_bfqq = NULL;
> +	if (idling_boosts_thr_without_issues(bfqd, bfqq) || proc_ref == 0)
> +		goto out;
>  
>  	/* next function will take at least one ref */
>  	new_bfqq = bfq_setup_merge(bfqq, stable_merge_bfqq);
> @@ -2873,6 +2873,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  			new_bfqq_data->stably_merged = true;
>  		}
>  	}
> +
> +out:
> +	/* deschedule stable merge, because done or aborted here */
> +	bfq_put_stable_ref(stable_merge_bfqq);
> +
>  	return new_bfqq;
>  }
>  
> @@ -2933,11 +2938,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  			struct bfq_queue *stable_merge_bfqq =
>  				bfqq_data->stable_merge_bfqq;
>  
> -			/* deschedule stable merge, because done or aborted here */
> -			bfq_put_stable_ref(stable_merge_bfqq);
> -
> -			bfqq_data->stable_merge_bfqq = NULL;
> -
>  			return bfq_setup_stable_merge(bfqd, bfqq,
>  						      stable_merge_bfqq,
>  						      bfqq_data);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
