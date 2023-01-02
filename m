Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FF65B47E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjABPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjABPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:54:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3924FF6E;
        Mon,  2 Jan 2023 07:54:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD38133E13;
        Mon,  2 Jan 2023 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672674856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zuod7z+5UPCG454P5NyNY251FiSdc6kVNmMzVnEJn7U=;
        b=Sf8atC5GTLPoKO/IsmR7Sdu4UIOzsLK1m316FJ92+qJNBOAUU/GbHR/ii7MmC0wachcTBB
        9Y68PNxHvJ/9PkBLc+drC8mq0FHxElYyBwty0anFs8ySYEXgNWjQ9zQBYgLWbG6rLKXV0j
        OCzg1VUs+G4wvvxpqH9wRc3lRFbkdEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672674856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zuod7z+5UPCG454P5NyNY251FiSdc6kVNmMzVnEJn7U=;
        b=qodcG15AMrzWKSWHeNJCLjZ+i3Vt83QcINgNUOKWNHMW9CDo+hqo8eZmLw/7ov+pDi2vaQ
        csGnpujTUC6PUJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98C94139C8;
        Mon,  2 Jan 2023 15:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tl1DJSj+smOKdQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:54:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 661B2A0742; Mon,  2 Jan 2023 16:54:15 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:54:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 06/10] block, bfq: remove redundant
 bfqd->rq_in_driver > 0 check in bfq_add_request
Message-ID: <20230102155415.pvl57qtzjk2acwf6@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-7-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-7-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:37, Kemeng Shi wrote:
> The bfqd->rq_in_driver > 0 check is along with previous
> "bfqd->rq_in_driver == 0 ||" check, so no need to re-check
> bfqd->rq_in_driver > 0.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I have nothing against this but OTOH in this complex condition the original
version looks more readable than the new one to me.

								Honza

> ---
>  block/bfq-iosched.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ebcafe3c4c3b..7c91d16dbf6f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2204,8 +2204,7 @@ static void bfq_add_request(struct request *rq)
>  		 */
>  		if (bfqq == bfqd->in_service_queue &&
>  		    (bfqd->rq_in_driver == 0 ||
> -		     (bfqq->last_serv_time_ns > 0 &&
> -		      bfqd->rqs_injected && bfqd->rq_in_driver > 0)) &&
> +		     (bfqq->last_serv_time_ns > 0 && bfqd->rqs_injected)) &&
>  		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
>  					      msecs_to_jiffies(10))) {
>  			bfqd->last_empty_occupied_ns = ktime_get_ns();
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
