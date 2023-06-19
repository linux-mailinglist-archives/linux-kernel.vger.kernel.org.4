Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41153734B75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFSFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSFz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:55:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986B1B5;
        Sun, 18 Jun 2023 22:55:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26AAE1F893;
        Mon, 19 Jun 2023 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687154126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz0ylscT0iQMeeO7bZHzABXDMYozwbLtr3UR7JBADas=;
        b=1lQan1JNf0mftmkXqZ16o7VKMQchmCPm5wv5I15ECeL4ZyqYxu5xE265fljB2451sSpbfM
        4uqMcMFNfr0qnF+WvEW33kI/yD+vNFpNve7j7yzIRryESE8eirlMbRvhRnYSr+x9LRdqoG
        iMxEeWKeQERQwcdHHXUpnPhg3xSsuTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687154126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz0ylscT0iQMeeO7bZHzABXDMYozwbLtr3UR7JBADas=;
        b=7gMSFGhVyOn4ZcOMxMp0tc5DkhgEn7+ckkR0nS9PrBdnEKKOB2BMda9UNcjOeWXOal+fnW
        +gAJA51/6qNuUCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC189139C2;
        Mon, 19 Jun 2023 05:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T3SZNM3tj2SfVAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 19 Jun 2023 05:55:25 +0000
Message-ID: <091d7daa-2782-66a0-57f4-ab62bbb82daf@suse.de>
Date:   Mon, 19 Jun 2023 07:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 2/7] blk-mq: delay tag fair sharing until fail to get
 driver tag
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, bvanassche@acm.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-3-yukuai1@huaweicloud.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230618160738.54385-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 18:07, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Start tag fair sharing when a device start to issue io will waste
> resources, same number of tags will be assigned to each disk/hctx,
> and such tags can't be used for other disk/hctx, which means a disk/hctx
> can't use more than assinged tags even if there are still lots of tags
> that is assinged to other disks are unused.
> 
> Add a new api blk_mq_driver_tag_busy(), it will be called when get
> driver tag failed, and move tag sharing from blk_mq_tag_busy() to
> blk_mq_driver_tag_busy().
> 
> This approch will work well if total tags are not exhausted, and follow
> up patches will try to refactor how tag is shared to handle this case.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq-debugfs.c |  4 ++-
>   block/blk-mq-tag.c     | 60 ++++++++++++++++++++++++++++++++++--------
>   block/blk-mq.c         |  4 ++-
>   block/blk-mq.h         | 13 ++++++---
>   include/linux/blk-mq.h |  6 +++--
>   include/linux/blkdev.h |  1 +
>   6 files changed, 70 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 431aaa3eb181..de5a911b07c2 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -400,8 +400,10 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
>   {
>   	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
>   	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
> -	seq_printf(m, "active_queues=%d\n",
> +	seq_printf(m, "active_queues=%u\n",
>   		   READ_ONCE(tags->ctl.active_queues));
> +	seq_printf(m, "share_queues=%u\n",
> +		   READ_ONCE(tags->ctl.share_queues));
>   
>   	seq_puts(m, "\nbitmap_tags:\n");
>   	sbitmap_queue_show(&tags->bitmap_tags, m);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index fe41a0d34fc0..1c2bde917195 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -29,6 +29,32 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
>   			users);
>   }
>   
> +void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct blk_mq_tags *tags = hctx->tags;
> +
> +	/*
> +	 * calling test_bit() prior to test_and_set_bit() is intentional,
> +	 * it avoids dirtying the cacheline if the queue is already active.
> +	 */
> +	if (blk_mq_is_shared_tags(hctx->flags)) {
> +		struct request_queue *q = hctx->queue;
> +
> +		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
> +			return;
> +	} else {
> +		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
> +			return;
> +	}
> +
> +	spin_lock_irq(&tags->lock);
> +	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
> +	blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
> +	spin_unlock_irq(&tags->lock);
> +}
> +
>   /*
>    * If a previously inactive queue goes active, bump the active user count.
>    * We need to do this before try to allocate driver tag, then even if fail
> @@ -37,7 +63,6 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
>    */
>   void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   {
> -	unsigned int users;
>   	struct blk_mq_tags *tags = hctx->tags;
>   
>   	/*
> @@ -57,9 +82,7 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   	}
>   
>   	spin_lock_irq(&tags->lock);
> -	users = tags->ctl.active_queues + 1;
> -	WRITE_ONCE(tags->ctl.active_queues, users);
> -	blk_mq_update_wake_batch(tags, users);
> +	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues + 1);

Why did you remove the call to blk_mq_update_wake_batch() here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

