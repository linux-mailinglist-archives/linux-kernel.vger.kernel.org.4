Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3564A656536
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiLZV6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLZV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:58:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED87D21BF;
        Mon, 26 Dec 2022 13:58:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5089E2086A;
        Mon, 26 Dec 2022 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672091928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhWabLpDTnB6UAKrZK6Tl8sha0fVHHbdbYiBlIIK1Gw=;
        b=a2EH1N3/k5SUHfA5iOFWkrfswcbGtIUi74pCD8ZD5vyLDQMM5oRWnCtEeCR9yls0ieXCrf
        sycybsVxiodF6JV8RILj3Zi0OxzABSOv6Ws1od+VeFzNRb9DgDB5pdcAmnaQD/prPs0e7d
        ZbO8PRXiYjNsfK10mrM8zx8U485LbGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672091928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhWabLpDTnB6UAKrZK6Tl8sha0fVHHbdbYiBlIIK1Gw=;
        b=GIk2YrUc5+FF2R+STO1MGJBTsXHiE546B7216vGBxvDQjXxqM9KA1fQRHj+GeL8fKBtL6X
        4bMuUKS0oJYP9WDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3811313456;
        Mon, 26 Dec 2022 21:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4QM2DRgZqmMxOAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Dec 2022 21:58:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3B74A0733; Mon, 26 Dec 2022 12:18:48 +0100 (CET)
Date:   Mon, 26 Dec 2022 12:18:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
Message-ID: <20221226111848.oorzy2mecnrignzc@quack3>
References: <20221226030605.1437081-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226030605.1437081-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-12-22 11:06:05, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> will access 'bic->bfqq' in bic_set_bfqq(), however, bfq_exit_icq_bfqq()
> can free bfqq first, and then call bic_set_bfqq(), which will cause uaf.
> 
> Fix the problem by moving bfq_exit_bfqq() behind bic_set_bfqq().
> 
> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Thanks for the patch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 16f43bbc575a..ccf2204477a5 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5317,8 +5317,8 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&bfqd->lock, flags);
> -		bfq_exit_bfqq(bfqd, bfqq);
>  		bic_set_bfqq(bic, NULL, is_sync);
> +		bfq_exit_bfqq(bfqd, bfqq);
>  		spin_unlock_irqrestore(&bfqd->lock, flags);
>  	}
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
