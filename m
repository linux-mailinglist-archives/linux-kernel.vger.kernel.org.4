Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F76690B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBINzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBINzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:55:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C215ACC6;
        Thu,  9 Feb 2023 05:55:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04FF022CA5;
        Thu,  9 Feb 2023 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675950940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAZJ+cQD8s4AR/8Qi/h4zow9Ix22Yo1Ijwc4ClmMtlw=;
        b=rMkf3JfHiV6TrEDW01gVTUoIWSNmykcXwo28xTRY3sDaMBcYclNscRhMsqZTH1ZT2ZQkeX
        Gfike9soRZ/PIv7FXvslGUuI610wawHLJ22AyL8/7i5y/6yj/c3DaxvR+ZPQEvMqZ8+pTa
        InrGpI6++TNd2TnI/IZn20mZmg7aDXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675950940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAZJ+cQD8s4AR/8Qi/h4zow9Ix22Yo1Ijwc4ClmMtlw=;
        b=q0lKu/4ql0lvDS2izPWW2L26xUCHOu/Euq/UYyeD0WLGz8MwsnTiC2YHy8csr6ukot89P1
        MY9UKl32tWzTwbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBC2B138E4;
        Thu,  9 Feb 2023 13:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yHmJOVv75GOKfwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 13:55:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2D95DA06D8; Thu,  9 Feb 2023 14:55:39 +0100 (CET)
Date:   Thu, 9 Feb 2023 14:55:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] blk-mq: count changed hctx as active in
 blk_mq_get_tag
Message-ID: <20230209135539.mokecz63dsolmemj@quack3>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
 <20230209201116.579809-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209201116.579809-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-02-23 04:11:11, Kemeng Shi wrote:
> Commit d263ed9926823 ("blk-mq: count the hctx as active before allocating
> tag") active hctx before blk_mq_get_tag to avoid petential starvation.
> However, the hctx to alloc tag may change in blk_mq_get_tag if
> BLK_MQ_REQ_NOWAIT is not set, then there are two problems:
> 1. The hctx without real allocation is marked active.
> 2. The starvation problem mentioned in Commit d263ed9926823 ("blk-mq:
> count the hctx as active before allocating tag") still exists on the
> changed hctx as it maybe not marked active before tag allocation.
> 
> For problem 1, the hctx which is marked active probably gets IO
> soon or will be marked inactive after lazy detection of tag idle.
> Mark changed hctx active to fix problem 2.
> 
> Fixes: d263ed992682 ("blk-mq: count the hctx as active before allocating tag")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-mq-tag.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 1d3135acfc98..e566fd96dc26 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -191,6 +191,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		data->ctx = blk_mq_get_ctx(data->q);
>  		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
>  						data->ctx);
> +		if (!(data->rq_flags & RQF_ELV))
> +			blk_mq_tag_busy(data->hctx);
> +
>  		tags = blk_mq_tags_from_data(data);
>  		if (data->flags & BLK_MQ_REQ_RESERVED)
>  			bt = &tags->breserved_tags;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
