Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20F65BD5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjACJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjACJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:44:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79DE0D5;
        Tue,  3 Jan 2023 01:44:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 120D83825B;
        Tue,  3 Jan 2023 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672739090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9d33HEzxSlB3aWdhyISRr5Fj3AshfOOVeWRm3q0aSQ=;
        b=dKiKaiVuzqWQLU16r4Itx7y8XqtIAzQ6BeSjKjYn2lVdjgyp003gWZFV++vJ99AxyELn8E
        KoTn+Gdur7lM/i/CedKASpXAIwyJTi/ioEE9Sf0yug2xHzFeZ5BKXzEtVOX4DeXByfQwlU
        g/fNrf8iYSgouEtHzKHNdeGZ9crfRSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672739090;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9d33HEzxSlB3aWdhyISRr5Fj3AshfOOVeWRm3q0aSQ=;
        b=ZnZqVLV55JADBFuAx1wD64/UKUmFDMQdkEfKp3jFPu3mDA7FX/yF63/jnLW5Oh1m0StGDo
        jLG3z1zpLJwo7/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 033CE1392B;
        Tue,  3 Jan 2023 09:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bFfHABL5s2N1LQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Jan 2023 09:44:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83845A0742; Tue,  3 Jan 2023 10:44:49 +0100 (CET)
Date:   Tue, 3 Jan 2023 10:44:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     jack@suse.com, paolo.valente@linaro.org, axboe@kernel.dk,
        hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] block, bfq: remove unnecessary goto tag in
 bfq_dispatch_rq_from_bfqq
Message-ID: <20230103094449.caq2hoftxdhmnv6e@quack3>
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
 <20230103095303.2223546-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103095303.2223546-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-01-23 17:53:02, Kemeng Shi wrote:
> We jump to tag only for returning current rq. Return directly to
> remove this tag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9ff424c78e9b..a11be312ac77 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4966,7 +4966,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	bfq_dispatch_remove(bfqd->queue, rq);
>  
>  	if (bfqq != bfqd->in_service_queue)
> -		goto return_rq;
> +		return rq;
>  
>  	/*
>  	 * If weight raising has to terminate for bfqq, then next
> @@ -4986,12 +4986,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	 * belongs to CLASS_IDLE and other queues are waiting for
>  	 * service.
>  	 */
> -	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
> -		goto return_rq;
> +	if (bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq))
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
