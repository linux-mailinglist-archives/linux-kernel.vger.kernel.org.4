Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6956622A01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiKILP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKILPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:15:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59F63D7;
        Wed,  9 Nov 2022 03:14:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA141F936;
        Wed,  9 Nov 2022 11:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667992495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBJNC132wrJOYPzZz8Zdp7calOKLvevZppIFTW+gJuM=;
        b=CVqcj5Gt3xYk90dcFGC2cxqxoQmTGXfbDZUzlUXQckr4yifsslPYqJJSQZHD5eGhOQ29L6
        x1xgVsWku8H9SXkYIDCxTqDLIHRHUvxUxGxu4H3F0kjZDCT/jPKlZC3/0l47NHWBNBlpid
        O13oAmJYhkVRk7bTJw6WBiCN6sD3X6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667992495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBJNC132wrJOYPzZz8Zdp7calOKLvevZppIFTW+gJuM=;
        b=ijtTnpk73GGUYYvmUx+rD2j5KgO8y7hqusqNqUUxIgks/0UkffAHdqqqCMWiOYyqIL1qpN
        I/GTIzMz1C+L5fDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B1CD1331F;
        Wed,  9 Nov 2022 11:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gj8EHq+La2NUMwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 11:14:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03B05A0704; Wed,  9 Nov 2022 12:14:54 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:14:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
        Jan Kara <jack@suse.cz>, Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH 2/2] bfq: ignore oom_bfqq in bfq_check_waker
Message-ID: <20221109111454.w7ikajdugzgsac6g@quack3>
References: <20221103013937.603626-1-khazhy@google.com>
 <20221108181030.1611703-1-khazhy@google.com>
 <20221108181030.1611703-2-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108181030.1611703-2-khazhy@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-11-22 10:10:30, Khazhismel Kumykov wrote:
> oom_bfqq is just a fallback bfqq, so shouldn't be used with waker
> detection.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ca04ec868c40..267baf84870f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2135,7 +2135,9 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  	if (!bfqd->last_completed_rq_bfqq ||
>  	    bfqd->last_completed_rq_bfqq == bfqq ||
>  	    bfq_bfqq_has_short_ttime(bfqq) ||
> -	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC)
> +	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
> +	    bfqd->last_completed_rq_bfqq == &bfqd->oom_bfqq ||
> +	    bfqq == &bfqd->oom_bfqq)
>  		return;
>  
>  	/*
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
