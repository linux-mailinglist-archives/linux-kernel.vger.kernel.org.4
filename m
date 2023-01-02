Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32CA65B43C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjABPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjABPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:30:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41085D5B;
        Mon,  2 Jan 2023 07:30:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0131D3420D;
        Mon,  2 Jan 2023 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672673457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDqqFLETDv1ymt0DZxMHzXB+9Y/0AhFHnAfV6WurXFk=;
        b=MWDnQYXY8j5PrDK6N6D20bjkFYb3FqQ7ACY4PzqPraRe5C1Ox7nUVF9QXfzdctt2WhSHmU
        DfS6J87G9/CAYId9pXb+Rn+fSXw2nbswublbUykxpP5UTF2ToJSJzafqj+8YnDcnIf8AeV
        J0jPFP6gKJA3V4MzDfQXNxg5roRuywU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672673457;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDqqFLETDv1ymt0DZxMHzXB+9Y/0AhFHnAfV6WurXFk=;
        b=MUWJkZsZuo4i8t7uImvlVUUU//U+20SwkKZqP4tx3XBMmRRc4wPR+bC5PPdE6v0nwhCGYh
        c5zWOJ+pxEEy9UBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E419813427;
        Mon,  2 Jan 2023 15:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HzCxN7D4smNaagAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:30:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 24943A0742; Mon,  2 Jan 2023 16:30:56 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:30:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 03/10] block, bfq: initialize
 bfqq->decrease_time_jif correctly
Message-ID: <20230102153056.gdofu7rp5s4arz2n@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:34, Kemeng Shi wrote:
> Inject limit is updated or reset when time_is_before_eq_jiffies(
> decrease_time_jif + several msecs) or think-time state changes.
> decrease_time_jif is initialized to 0 and will be set to current jiffies
> when inject limit is updated or reset. If the jiffies is slightly greater
> than LONG_MAX, time_is_after_eq_jiffies(0) will keep for a long time, so as
> time_is_after_eq_jiffies(decrease_time_jif + several msecs). If the
> think-time state never chages, then the injection will not work as expected
> for long time.
> 
> To be more specific:
> Function bfq_update_inject_limit maybe triggered when jiffies pasts
> decrease_time_jif + msecs_to_jiffies(10) in bfq_add_request by setting
> bfqd->wait_dispatch to true.
> Function bfq_reset_inject_limit are called in two conditions:
> 1. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(1000) in
> function bfq_add_request.
> 2. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(100) or
> bfq think-time state change from short to long.
> 
> Fix this by initializing bfqq->decrease_time_jif to current jiffies
> to trigger service injection soon when service injection conditions
> are met.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I agree that initializing jiffies timer to 0 is just a bad practice and
current time is much saner choice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 5a6d9e8c329d..9441fc98961a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5491,6 +5491,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  
>  	/* first request is almost certainly seeky */
>  	bfqq->seek_history = 1;
> +
> +	bfqq->decrease_time_jif = jiffies;
>  }
>  
>  static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
