Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E265B49E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjABQFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjABQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:05:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC1DE5E;
        Mon,  2 Jan 2023 08:05:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C009A5C487;
        Mon,  2 Jan 2023 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672675505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmGsCrBzS6Uv+XJl7JWGbpklMz8TH25ZcuNsmqXhnDk=;
        b=lRzjC/5Navli0KbqjStN9XwLarrVPGlRmE4OmA0M4JZhXhqZLzyhbPACvdawKzSYhUHn6H
        bDXYZgny8+ilahI8SWhJ4QDr8BwapD8uPU1PbePazOTfBSVkbCRKWthxmLnf19f2UbGlyY
        Z6o05FQvuK3Ma0wh9OOsQybNqQL0ZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672675505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmGsCrBzS6Uv+XJl7JWGbpklMz8TH25ZcuNsmqXhnDk=;
        b=R2F8pNepQY5RcOO0KZ/GWfOENC+kRQg8fuPfjv2M+KweFQ52RYAmbe8jLeru/V0CV+pRww
        GcCmXqdapAa4hgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8DB1139C8;
        Mon,  2 Jan 2023 16:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QXExKbEAs2PdegAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 16:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3531AA0742; Mon,  2 Jan 2023 17:05:05 +0100 (CET)
Date:   Mon, 2 Jan 2023 17:05:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 10/10] block, bfq: remove check of
 bfq_wr_max_softrt_rate which is always greater than 0
Message-ID: <20230102160505.2r26ct5wadfhyr23@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-11-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-11-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:41, Kemeng Shi wrote:
> bfqd->bfq_wr_max_softrt_rate is assigned with 7000 in bfq_init_queue and
> never changed. So we can remove bfqd->bfq_wr_max_softrt_rate > 0 check
> which is always true.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I would just leave these checks for documentation purposes and for possible
experiments (e.g. disabling this logic by setting bfq_wr_max_softrt_rate to
0). Alternatively, we could just define a constant for this and
then we can remove all the checks, that would be a clean solution as well.

								Honza

> ---
>  block/bfq-iosched.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 91bc68fba72d..00cdd42ac02a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1788,8 +1788,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	 *   to control its weight explicitly)
>  	 */
>  	in_burst = bfq_bfqq_in_large_burst(bfqq);
> -	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
> -		!BFQQ_TOTALLY_SEEKY(bfqq) &&
> +	soft_rt = !BFQQ_TOTALLY_SEEKY(bfqq) &&
>  		!in_burst &&
>  		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
>  		bfqq->dispatched == 0 &&
> @@ -4284,8 +4283,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>  	if (bfqd->low_latency && bfqq->wr_coeff == 1)
>  		bfqq->last_wr_start_finish = jiffies;
>  
> -	if (bfqd->low_latency && bfqd->bfq_wr_max_softrt_rate > 0 &&
> -	    RB_EMPTY_ROOT(&bfqq->sort_list)) {
> +	if (bfqd->low_latency && RB_EMPTY_ROOT(&bfqq->sort_list)) {
>  		/*
>  		 * If we get here, and there are no outstanding
>  		 * requests, then the request pattern is isochronous
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
