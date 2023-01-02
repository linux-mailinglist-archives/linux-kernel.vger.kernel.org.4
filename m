Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC065B44B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjABPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjABPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:35:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD54CCEE;
        Mon,  2 Jan 2023 07:35:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 918FB34215;
        Mon,  2 Jan 2023 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672673699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxSU7BQCVQRZyJH13xdhDi57U6Cq3OOvoYb4SRQKQ+8=;
        b=TqnW1VOrriFFzJX7NpbogXSbiBbUOlHR7r4zoZJvtV/a4qILbsZ06XJZxIKcvxet0hWXBM
        13c78kbw9DgqZktNCxOEzTLLvAMu189OxtodrBtArhYEFxmcQ2JV+wjgRzgQEEXYtJ/Vua
        /B6gIbJ3ePVkDwJmw2IxLPUH4lHypXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672673699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxSU7BQCVQRZyJH13xdhDi57U6Cq3OOvoYb4SRQKQ+8=;
        b=GDZDwgo32tSKGR0LnrYI5tHwImqQCMXJg8nveBFEEXcjPHqjqSHfrvuo72z/o4w8wf3c5X
        YeVCQeVur6MWQuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 823CE13427;
        Mon,  2 Jan 2023 15:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PbLmH6P5smOCbAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:34:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8CC1A0742; Mon,  2 Jan 2023 16:34:58 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:34:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 05/10] block, bfq: remove unnecessary
 dereference to get async_bfqq
Message-ID: <20230102153458.zg3ku5styjcz2gf3@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-6-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:36, Kemeng Shi wrote:
> The async_bfqq is assigned with bfqq->bic->bfqq[0], use it directly.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, that is a more logical choice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c3c4c83ee95f..ebcafe3c4c3b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4835,7 +4835,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
>  		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
>  		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
>  		    bfq_bfqq_budget_left(async_bfqq))
> -			bfqq = bfqq->bic->bfqq[0];
> +			bfqq = async_bfqq;
>  		else if (bfqq->waker_bfqq &&
>  			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
>  			   bfqq->waker_bfqq->next_rq &&
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
