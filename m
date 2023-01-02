Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BE65B3F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjABPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjABPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:13:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79816C05;
        Mon,  2 Jan 2023 07:13:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20EF8341EB;
        Mon,  2 Jan 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672672410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iF4lIS/VOnabmzZaspeI/Uwaz6CXxQLuyWFUv2Qg6QY=;
        b=NnySPLVoxcMk+k4AODtJ8SrzMiNPaeUHfKvZ+CtN/cLSAHL+c9quOMu9xRPEcBbRBd4rKq
        /0Z3mAoncGDg3S9umRGepbosFAW5yjSAq7C9ZCl6raZszPSivM6pS6b1d9SUQ51wmCY3Og
        UQ47qBQqaHsC/fWsEect7DDF4SJ/RpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672672410;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iF4lIS/VOnabmzZaspeI/Uwaz6CXxQLuyWFUv2Qg6QY=;
        b=Pzcx5WPhBBdVc+I1zDTw24szHqW05J4vzutHB+yz/up04PKBUHhzzvnGJiCN0ITTI81cI0
        1JanLR2eYD0c7PAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10AC213427;
        Mon,  2 Jan 2023 15:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pq4OBJr0smPyYQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:13:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90FE5A073E; Mon,  2 Jan 2023 16:13:29 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:13:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 01/10] block, bfq: correctly raise inject limit
 in bfq_choose_bfqq_for_injection
Message-ID: <20230102151329.xzjalwcphmupf4jm@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:32, Kemeng Shi wrote:
> Function bfq_choose_bfqq_for_injection may temporarily raise inject limit
> to one request if current inject_limit is 0 before search of the source
> queue for injection. However the search below will reset inject limit to
> bfqd->in_service_queue which is zero for raised inject limit. Then the
> temporarily raised inject limit never works as expected.
> Assigment limit to bfqd->in_service_queue in search is needed as limit
> maybe overwriten to min_t(unsigned int, 1, limit) for condition that
> a large in-flight request is on non-rotational devices in found queue.
> So we need to reset limit to bfqd->in_service_queue for normal case.
> 
> Actually, we have already make sure bfqd->rq_in_driver is < limit before
> search, then
>  -Limit is >= 1 as bfqd->rq_in_driver is >= 0. Then min_t(unsigned int,
> 1, limit) is always 1. So we can simply check bfqd->rq_in_driver with
> 1 instead of result of min_t(unsigned int, 1, limit) for larget request in
> non-rotational device case to avoid overwritting limit and the bug is gone.
>  -For normal case, we have already check bfqd->rq_in_driver is < limit,
> so we can return found bfqq unconditionally to remove unncessary check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

The fix looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index a72304c728fc..1220c41fc767 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4641,12 +4641,10 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  			 */
>  			if (blk_queue_nonrot(bfqd->queue) &&
>  			    blk_rq_sectors(bfqq->next_rq) >=
> -			    BFQQ_SECT_THR_NONROT)
> -				limit = min_t(unsigned int, 1, limit);
> -			else
> -				limit = in_serv_bfqq->inject_limit;
> -
> -			if (bfqd->rq_in_driver < limit) {
> +			    BFQQ_SECT_THR_NONROT &&
> +			    bfqd->rq_in_driver >= 1)
> +				continue;
> +			else {
>  				bfqd->rqs_injected = true;
>  				return bfqq;
>  			}
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
