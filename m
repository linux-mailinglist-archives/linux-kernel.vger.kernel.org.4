Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAF7690ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBINn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjBINnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:43:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A54EF7;
        Thu,  9 Feb 2023 05:43:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50C1837520;
        Thu,  9 Feb 2023 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675950230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFbQcVJyIgmubWJ3BH8e+P9uwLq7imStPXckAJa3rJ0=;
        b=lobpFbm1ZUT1T7CHLid4x0nju3D2+FzMftrIXDUIaY4LEQqmXqtFwPj9XJiAglFDK599LX
        YOaZfGb+E9csvzELAQfoAo7yyALrJdnpqocD+vSQ/KQfAajyYbBEM9Z6LrVeZbT4WcvDfT
        vJtILaY17eFeSClwVb6/ukszJvBvtng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675950230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFbQcVJyIgmubWJ3BH8e+P9uwLq7imStPXckAJa3rJ0=;
        b=u3qgcAbJZ1IgCHtwHPCOmQZrQeopvl2qa/aP/B3MHnrTuj+RIZMWecg5lycfjSigHsBHIx
        q/Er6C2iq4K/6OCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4314F1339E;
        Thu,  9 Feb 2023 13:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bdpaEJb45GO2eQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 13:43:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C725AA06D8; Thu,  9 Feb 2023 14:43:49 +0100 (CET)
Date:   Thu, 9 Feb 2023 14:43:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] blk-mq: sync wake_batch update and users number
 change
Message-ID: <20230209134349.vspcytw7drt7sqnn@quack3>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
 <20230209201116.579809-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209201116.579809-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-02-23 04:11:10, Kemeng Shi wrote:
> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
> added recalculation of wake_batch when active_queues changes to avoid io
> hung.
> Function blk_mq_tag_idle and blk_mq_tag_busy can be called concurrently,
> then wake_batch maybe updated with old users number. For example, if
> tag alloctions for two shared queue happen concurrently, blk_mq_tag_busy
> maybe executed as following:
> thread1  			thread2
> atomic_inc_return
> 				atomic_inc_return
> 				blk_mq_update_wake_batch
> blk_mq_update_wake_batch
> 
> 1.Thread1 adds active_queues from zero to one.
> 2.Thread2 adds active_queues from one to two.
> 3.Thread2 calculates wake_batch with latest active_queues number two.
> 4.Thread1 calculates wake_batch with stale active_queues number one.
> Then wake_batch is inconsistent with actual active_queues. If wake_batch
> is calculated with active_queues number smaller than actual active_queues
> number, wake_batch will be greater than it supposed to be and cause io
> hung.
> 
> Sync wake_batch update and users number change to keep wake_batch
> consistent with active_queues to fix this.
> 
> Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

OK, luckily this extra spin_lock happens only when adding and removing a
busy queue which should be reasonably rare. So looks good to me. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-mq-tag.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9eb968e14d31..1d3135acfc98 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -39,7 +39,9 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
>   */
>  void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
> +	struct blk_mq_tags *tags = hctx->tags;
>  	unsigned int users;
> +	unsigned long flags;
>  
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
> @@ -53,9 +55,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
>  	}
>  
> -	users = atomic_inc_return(&hctx->tags->active_queues);
> +	spin_lock_irqsave(&tags->lock, flags);
> +	users = atomic_inc_return(&tags->active_queues);
>  
> -	blk_mq_update_wake_batch(hctx->tags, users);
> +	blk_mq_update_wake_batch(tags, users);
> +	spin_unlock_irqrestore(&tags->lock, flags);
>  }
>  
>  /*
> @@ -76,6 +80,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct blk_mq_tags *tags = hctx->tags;
>  	unsigned int users;
> +	unsigned long flags;
>  
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
> @@ -88,9 +93,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> +	spin_lock_irqsave(&tags->lock, flags);
>  	users = atomic_dec_return(&tags->active_queues);
>  
>  	blk_mq_update_wake_batch(tags, users);
> +	spin_unlock_irqrestore(&tags->lock, flags);
>  
>  	blk_mq_tag_wakeup_all(tags, false);
>  }
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
