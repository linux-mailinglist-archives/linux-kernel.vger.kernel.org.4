Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBAB65B43E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjABPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjABPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:31:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D42AE7;
        Mon,  2 Jan 2023 07:31:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DA6E20178;
        Mon,  2 Jan 2023 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672673494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2F11xUiDzXli+fkwzboFgES4G1zpWWoKOQc4R+WpSds=;
        b=cPY8bJHmi/8/Vygj6+IGupdiwuStqHqA3V8pmUkgf/EGfLl67/ILyfULN57nN/Ac4J3kjR
        YP24cCNW2ySHsnjJk66bqsRw4t5Oqy9/kyAn78bsR8F2bSBzIr8Ja0sLXRMA1iQ4rbFKyQ
        pOaiJnHKZwzNgREllsmP/O3wyJMInRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672673494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2F11xUiDzXli+fkwzboFgES4G1zpWWoKOQc4R+WpSds=;
        b=XcDFX/EQgVgrsvTzpgeZ7NFXtCHv0ze5r6iRd/hsIcqefp47bW7oRIxC6C3Xd23EFW2YJC
        i4ovpK6OF8TzJoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9087213427;
        Mon,  2 Jan 2023 15:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EW1JI9b4smOsagAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:31:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27269A0742; Mon,  2 Jan 2023 16:31:34 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:31:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 04/10] block, bfq: use helper macro RQ_BFQQ to
 get bfqq of request
Message-ID: <20230102153134.hifz5alouhkkxx4o@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:35, Kemeng Shi wrote:
> Use helper macro RQ_BFQQ to get bfqq of request.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, why not. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9441fc98961a..c3c4c83ee95f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6683,14 +6683,14 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  		return NULL;
>  
>  	/*
> -	 * Assuming that elv.priv[1] is set only if everything is set
> +	 * Assuming that RQ_BFQQ(rq) is set only if everything is set
>  	 * for this rq. This holds true, because this function is
>  	 * invoked only for insertion or merging, and, after such
>  	 * events, a request cannot be manipulated any longer before
>  	 * being removed from bfq.
>  	 */
> -	if (rq->elv.priv[1])
> -		return rq->elv.priv[1];
> +	if (RQ_BFQQ(rq))
> +		return RQ_BFQQ(rq);
>  
>  	bic = icq_to_bic(rq->elv.icq);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
