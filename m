Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088DA65B482
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjABP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:57:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68412E;
        Mon,  2 Jan 2023 07:57:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCA6334231;
        Mon,  2 Jan 2023 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672675050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByCZbSH3Pnyrm7y6TeC3pVkXY7fG5BRTrVtla101aTk=;
        b=ClBl1N6Z7nZhqn7P4Qqf8dd4rmSA3XmFDFccXuJmmkT99w0LIum+p6pOspjZPM2UeQfTny
        S2p4VlzGeFTLabZbFVdH78xVyTYfk0hEnlwc7ArOicAcOKkoMGscsu326i+cnHWcTBK9CM
        +yQKgM7TvXHwCFTsGz9rltDMtEAJ7zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672675050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByCZbSH3Pnyrm7y6TeC3pVkXY7fG5BRTrVtla101aTk=;
        b=1YEZ2wLDPTBcGHzPrJEoX3nj8VUmPI+yH+bes9TYwwOQX1lB/rqw2V7jbe6fHYugxtu/nQ
        hWfl+FA5Px538tAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFCC4139C8;
        Mon,  2 Jan 2023 15:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9A3PLur+smM5dwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:57:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 29502A0742; Mon,  2 Jan 2023 16:57:30 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:57:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 07/10] block, bfq: remove redundant check in
 bfq_put_cooperator
Message-ID: <20230102155730.hkxfmuq6do47dmfc@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:38, Kemeng Shi wrote:
> We have already avoided a circular list in bfq_setup_merge (see comments
> in bfq_setup_merge() for details), so bfq_queue will not appear in it's
> new_bfqq list. Just remove this check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7c91d16dbf6f..89995815dbae 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5273,8 +5273,6 @@ void bfq_put_cooperator(struct bfq_queue *bfqq)
>  	 */
>  	__bfqq = bfqq->new_bfqq;
>  	while (__bfqq) {
> -		if (__bfqq == bfqq)
> -			break;
>  		next = __bfqq->new_bfqq;
>  		bfq_put_queue(__bfqq);
>  		__bfqq = next;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
