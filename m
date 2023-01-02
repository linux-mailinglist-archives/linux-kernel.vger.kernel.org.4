Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359F65B48A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjABP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbjABP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:59:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C96A473;
        Mon,  2 Jan 2023 07:59:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E44634234;
        Mon,  2 Jan 2023 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672675180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAD2I7A+92nfnOrgaJQpcRpPaLoVnETUE2u22fz3QUw=;
        b=d7GDafFabP4JAmRr2p/kXRh2/CBUJogzeDL9DnTsEHR3rN/sXTvgaulfNyq89ujdjTLsIF
        sw0+4x15gMW0NARY7stiiLm14O73lqHMVqSdIL0x7cPNs5url+aKn1angnQDEFnAN810Ls
        zswPVo1fA6Y2S2nuI7vSfRK3bTXz/Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672675180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAD2I7A+92nfnOrgaJQpcRpPaLoVnETUE2u22fz3QUw=;
        b=HKBSCNhyGSj//rMcOV5/2bliSAg7/frOGHhTCNmlyo4Z2cix2Dw2yNEbNejGcW2EVWdmwr
        woPEx1ZS7hMI1tAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01B95139C8;
        Mon,  2 Jan 2023 15:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5VoAGz/smMjeAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:59:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8F4E1A0742; Mon,  2 Jan 2023 16:59:39 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:59:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 08/10] block, bfq: remove unnecessary goto tag
 in bfq_dispatch_rq_from_bfqq
Message-ID: <20230102155939.otg3gum2zlzgvfx5@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-9-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:39, Kemeng Shi wrote:
> We jump to tag only for returning current rq. Return directly to
> remove this tag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

One nit below.

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 89995815dbae..195cdc6be087 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4965,7 +4965,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	bfq_dispatch_remove(bfqd->queue, rq);
>  
>  	if (bfqq != bfqd->in_service_queue)
> -		goto return_rq;
> +		return rq;
>  
>  	/*
>  	 * If weight raising has to terminate for bfqq, then next
> @@ -4985,12 +4985,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	 * belongs to CLASS_IDLE and other queues are waiting for
>  	 * service.
>  	 */
> -	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
> -		goto return_rq;
> +	if ((bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
            ^ unnecessary brace here

									Honza

> +		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
>  
> -	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
> -
> -return_rq:
>  	return rq;
>  }
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
