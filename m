Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE8654210
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLVNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:41:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D801758F;
        Thu, 22 Dec 2022 05:41:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 586C57627B;
        Thu, 22 Dec 2022 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671716507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80uSG4REOYDnwTcxufeyQWdVmFAMAACOx5v1wn/OAFU=;
        b=HDbQ74ZppVs3jcB0C96IgTwB6HhlWaLdtXWmIiXg9gNjWAYr1XhSP07dKP3m6ZNkIV7GPc
        hyeWiKxKS2RW1mQjkP4V/GD7TjpcNuftG04bUaMtLKXz7ZFtuVaVIbtKbJzh3q+2grmKem
        rKbyBhHIhQRFFuYhZmcxxV4NT6Xj5aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671716507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80uSG4REOYDnwTcxufeyQWdVmFAMAACOx5v1wn/OAFU=;
        b=MMJ1OTaj0NyDpdjh/EwPG/zDvMZblvFAnsBifBjJDTEkIKQt9W0D0gyS8crTwIj3a1GHZa
        9a5imKfhmtmuraCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4766A138FD;
        Thu, 22 Dec 2022 13:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3edjEZtepGNvNgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 13:41:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9320BA0732; Thu, 22 Dec 2022 14:41:46 +0100 (CET)
Date:   Thu, 22 Dec 2022 14:41:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, kbusch@kernel.org,
        Laibin Qiu <qiulaibin@huawei.com>
Subject: Re: [PATCH RESEND v2 5/5] sbitmap: correct wake_batch recalculation
 to avoid potential IO hung
Message-ID: <20221222134146.khucy5afnxwl75px@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222143353.598042-6-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-12-22 22:33:53, Kemeng Shi wrote:
> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
> mentioned that in case of shared tags, there could be just one real
> active hctx(queue) because of lazy detection of tag idle. Then driver tag
> allocation may wait forever on this real active hctx(queue) if wake_batch
> is > hctx_max_depth where hctx_max_depth is available tags depth for the
> actve hctx(queue). However, the condition wake_batch > hctx_max_depth is
> not strong enough to avoid IO hung as the sbitmap_queue_wake_up will only
> wake up one wait queue for each wake_batch even though there is only one
> waiter in the woken wait queue. After this, there is only one tag to free
> and wake_batch may not be reached anymore. Commit 180dccb0dba4f ("blk-mq:
> fix tag_get wait task can't be awakened") methioned that driver tag
> allocation may wait forever. Actually, the inactive hctx(queue) will be
> truely idle after at most 30 seconds and will call blk_mq_tag_wakeup_all
> to wake one waiter per wait queue to break the hung. But IO hung for 30
> seconds is also not acceptable. Set batch size to small enough that depth
> of the shared hctx(queue) is enough to wake up all of the queues like
> sbq_calc_wake_batch do to fix this potential IO hung.
> 
> Although hctx_max_depth will be clamped to at least 4 while wake_batch
> recalculation does not do the clamp, the wake_batch will be always
> recalculated to 1 when hctx_max_depth <= 4.
> 
> Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

So the condition in sbitmap_queue_recalculate_wake_batch() also seemed
strange to me and the changelogs of commits 180dccb0dba4 and 10825410b95
("blk-mq: Fix wrong wakeup batch configuration which will cause hang")
didn't add much confidence about the magic batch setting to 4. Let me add
to CC original author of this code if he has any thoughts on why using
wake batch of 4 is safe for cards with say 32 tags in case active_users is
currently 32. Because I don't see why that is correct either.

								Honza

> ---
>  lib/sbitmap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index b6d3bb1c3675..804fe99783e4 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -458,13 +458,10 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
>  					    unsigned int users)
>  {
>  	unsigned int wake_batch;
> -	unsigned int min_batch;
>  	unsigned int depth = (sbq->sb.depth + users - 1) / users;
>  
> -	min_batch = sbq->sb.depth >= (4 * SBQ_WAIT_QUEUES) ? 4 : 1;
> -
>  	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
> -			min_batch, SBQ_WAKE_BATCH);
> +			1, SBQ_WAKE_BATCH);
>  
>  	WRITE_ONCE(sbq->wake_batch, wake_batch);
>  }
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
