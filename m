Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A972BA77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjFLI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjFLIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:25:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A43ABF;
        Mon, 12 Jun 2023 01:24:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 888BB20462;
        Mon, 12 Jun 2023 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686558278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aAYHdkXBZ/E7sjjmPx9fP1mf8Z5RHaHuCNgT5tE+58=;
        b=JCoH45X2G47FQUK6RPb8UYlFWQ0FS92BeAxrljBkrzTZ2w3e0SdvLXHAwETe4K7uHEBf+2
        ouMuOhR/HUYO1JyuLdNMl9nTfudGh7fzrW7SEoQTGrLi6My3X8obiQsq1/C8GD1FMoCk8a
        wKIHbLDHE2alUB8ISuwjtz8xSMmzMdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686558278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aAYHdkXBZ/E7sjjmPx9fP1mf8Z5RHaHuCNgT5tE+58=;
        b=cwEWXJqGsE+Ay1jobUaIFjaieYeTAKxkMS+hjBr8Qq58VMehIqtUqP5ntvZ6bQBz0HlxL9
        JQEASTEOzfRQdbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A789138EC;
        Mon, 12 Jun 2023 08:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oqTYHUbWhmTsdQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 08:24:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A4B3A0717; Mon, 12 Jun 2023 10:24:38 +0200 (CEST)
Date:   Mon, 12 Jun 2023 10:24:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, qiulaibin@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2] blk-mq: fix potential io hang by wrong
 'wake_batch'
Message-ID: <20230612082438.qwt3gozbhts5jpm6@quack3>
References: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-06-23 10:30:43, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
> 'wake_batch' is not atomic:
> 
> t1:			t2:
> _blk_mq_tag_busy	blk_mq_tag_busy
> inc active_queues
> // assume 1->2
> 			inc active_queues
> 			// 2 -> 3
> 			blk_mq_update_wake_batch
> 			// calculate based on 3
> blk_mq_update_wake_batch
> /* calculate based on 2, while active_queues is actually 3. */
> 
> Fix this problem by protecting them wih 'tags->lock', this is not a hot
> path, so performance should not be concerned. And now that all writers
> are inside the lock, switch 'actives_queues' from atomic to unsigned
> int.
> 
> Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
>  - switch 'active_queues' from atomic to unsigned int.
> 
>  block/blk-mq-debugfs.c |  2 +-
>  block/blk-mq-tag.c     | 15 ++++++++++-----
>  block/blk-mq.h         |  3 +--
>  include/linux/blk-mq.h |  3 +--
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 68165a50951b..c3b5930106b2 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -401,7 +401,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
>  	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
>  	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
>  	seq_printf(m, "active_queues=%d\n",
> -		   atomic_read(&tags->active_queues));
> +		   READ_ONCE(tags->active_queues));
>  
>  	seq_puts(m, "\nbitmap_tags:\n");
>  	sbitmap_queue_show(&tags->bitmap_tags, m);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index dfd81cab5788..cc57e2dd9a0b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -38,6 +38,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
>  void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	unsigned int users;
> +	struct blk_mq_tags *tags = hctx->tags;
>  
>  	/*
>  	 * calling test_bit() prior to test_and_set_bit() is intentional,
> @@ -55,9 +56,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> -	users = atomic_inc_return(&hctx->tags->active_queues);
> -
> -	blk_mq_update_wake_batch(hctx->tags, users);
> +	spin_lock_irq(&tags->lock);
> +	users = tags->active_queues + 1;
> +	WRITE_ONCE(tags->active_queues, users);
> +	blk_mq_update_wake_batch(tags, users);
> +	spin_unlock_irq(&tags->lock);
>  }
>  
>  /*
> @@ -90,9 +93,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> -	users = atomic_dec_return(&tags->active_queues);
> -
> +	spin_lock_irq(&tags->lock);
> +	users = tags->active_queues - 1;
> +	WRITE_ONCE(tags->active_queues, users);
>  	blk_mq_update_wake_batch(tags, users);
> +	spin_unlock_irq(&tags->lock);
>  
>  	blk_mq_tag_wakeup_all(tags, false);
>  }
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 8c642e9f32f1..1743857e0b01 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -412,8 +412,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>  			return true;
>  	}
>  
> -	users = atomic_read(&hctx->tags->active_queues);
> -
> +	users = READ_ONCE(hctx->tags->active_queues);
>  	if (!users)
>  		return true;
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 59b52ec155b1..f401067ac03a 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -739,8 +739,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  struct blk_mq_tags {
>  	unsigned int nr_tags;
>  	unsigned int nr_reserved_tags;
> -
> -	atomic_t active_queues;
> +	unsigned int active_queues;
>  
>  	struct sbitmap_queue bitmap_tags;
>  	struct sbitmap_queue breserved_tags;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
