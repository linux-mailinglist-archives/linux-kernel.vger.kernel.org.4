Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB5683AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjAaX7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjAaX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:59:15 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE183D9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:58:30 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h24so7167225qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vIQf0a6iEAUT12k4trn79P1fVoQICHB1aSjSKSg7wk=;
        b=qBdMTX8wR5lh6AA1Hl7xTYPz1ArTZg/C38BvQZvb3T9Mq2tQ6Q2UTlWlvVORIKWci6
         +c2g3eZbAV3xwChj5kte1YEvb6hqj2vo7MWs9L9z3/oKgojiymRpXwSnMdTolpMk3pdA
         08at77BpSW9zpfDsKDOb1l38I9h+XkEn1CSj8V44G2q1V3S12Nx5vdDUZR++3v2TIviI
         6IgTPBCQCnaKSZe1zCZsVZw4frapBKIIz3XBjdz4e+QsT8TPbXcRsvkk5SMdjYXURT7R
         zpFmTwK5l7oLKWy4nItMHQGujixDQL+j5KyDAMk+lhS3NAuDulAKPQWtdpon1Y6kh+YH
         QKuw==
X-Gm-Message-State: AO0yUKUchS9ypgz32+eKlHpujPgtvHVN7o+32Co0zP602z0zbUpcF4pa
        ZKCqtf1q7UopVljsIglsrG6l
X-Google-Smtp-Source: AK7set9pRgnf40Mb2ZHzeSYJaZfnDJ+8lSeeU97IXIqs4L3d5aGqi7bIP2E3qtPVhbAnyYRyZOGPzw==
X-Received: by 2002:ac8:57d6:0:b0:3b8:6cd5:eda with SMTP id w22-20020ac857d6000000b003b86cd50edamr1086689qta.47.1675209509939;
        Tue, 31 Jan 2023 15:58:29 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id e24-20020ac80118000000b003b848759ed8sm6729656qtg.47.2023.01.31.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:58:29 -0800 (PST)
Date:   Tue, 31 Jan 2023 18:58:28 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Message-ID: <Y9mrJJDFnMNWR7Vn@redhat.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-3-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2022 at  9:23P -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> Allows to attach block device filters to the block devices. Kernel
> modules can use this functionality to extend the capabilities of the
> block layer.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/bdev.c              | 70 ++++++++++++++++++++++++++++++++++++++
>  block/blk-core.c          | 19 +++++++++--
>  include/linux/blk_types.h |  2 ++
>  include/linux/blkdev.h    | 71 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index d699ecdb3260..b820178824b2 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -427,6 +427,7 @@ static void init_once(void *data)
>  
>  static void bdev_evict_inode(struct inode *inode)
>  {
> +	bdev_filter_detach(I_BDEV(inode));
>  	truncate_inode_pages_final(&inode->i_data);
>  	invalidate_inode_buffers(inode); /* is it needed here? */
>  	clear_inode(inode);
> @@ -502,6 +503,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  		return NULL;
>  	}
>  	bdev->bd_disk = disk;
> +	bdev->bd_filter = NULL;
>  	return bdev;
>  }
>  
> @@ -1092,3 +1094,71 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  
>  	blkdev_put_no_open(bdev);
>  }
> +
> +/**
> + * bdev_filter_attach - Attach the filter to the original block device.
> + * @bdev:
> + *	Block device.
> + * @flt:
> + *	Filter that needs to be attached to the block device.
> + *
> + * Before adding a filter, it is necessary to initialize &struct bdev_filter
> + * using a bdev_filter_init() function.
> + *
> + * The bdev_filter_detach() function allows to detach the filter from the block
> + * device.
> + *
> + * Return: 0 if succeeded, or -EALREADY if the filter already exists.
> + */
> +int bdev_filter_attach(struct block_device *bdev,
> +				     struct bdev_filter *flt)
> +{
> +	int ret = 0;
> +
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	blk_mq_quiesce_queue(bdev->bd_queue);
> +
> +	if (bdev->bd_filter)
> +		ret = -EALREADY;
> +	else
> +		bdev->bd_filter = flt;
> +
> +	blk_mq_unquiesce_queue(bdev->bd_queue);
> +	blk_mq_unfreeze_queue(bdev->bd_queue);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(bdev_filter_attach);
> +
> +/**
> + * bdev_filter_detach - Detach the filter from the block device.
> + * @bdev:
> + *	Block device.
> + *
> + * The filter should be added using the bdev_filter_attach() function.
> + *
> + * Return: 0 if succeeded, or -ENOENT if the filter was not found.
> + */
> +int bdev_filter_detach(struct block_device *bdev)
> +{
> +	int ret = 0;
> +	struct bdev_filter *flt = NULL;
> +
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	blk_mq_quiesce_queue(bdev->bd_queue);
> +
> +	flt = bdev->bd_filter;
> +	if (flt)
> +		bdev->bd_filter = NULL;
> +	else
> +		ret = -ENOENT;
> +
> +	blk_mq_unquiesce_queue(bdev->bd_queue);
> +	blk_mq_unfreeze_queue(bdev->bd_queue);
> +
> +	if (flt)
> +		bdev_filter_put(flt);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(bdev_filter_detach);

What about bio-based devices? (DM, MD, etc)

DM uses freeze_bdev() and thaw_bdev(), seems like you're missing some
work here.

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5487912befe8..284b295a7b23 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -678,9 +678,24 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  	 * to collect a list of requests submited by a ->submit_bio method while
>  	 * it is active, and then process them after it returned.
>  	 */
> -	if (current->bio_list)
> +	if (current->bio_list) {
>  		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> +		return;
> +	}
> +
> +	if (bio->bi_bdev->bd_filter && !bio_flagged(bio, BIO_FILTERED)) {

Shouldn't this be: if (unlikely(...))?

But that obviously assumes a fair amount about the only consumer
(temporary filter that lasts as long as it takes to do a backup).

> +		bool pass;
> +
> +		pass = bio->bi_bdev->bd_filter->fops->submit_bio_cb(bio);
> +		bio_set_flag(bio, BIO_FILTERED);
> +		if (!pass) {
> +			bio->bi_status = BLK_STS_OK;
> +			bio_endio(bio);
> +			return;
> +		}
> +	}
> +
> +	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
>  		__submit_bio_noacct_mq(bio);
>  	else
>  		__submit_bio_noacct(bio);

And you currently don't allow for blkfilter to be involved if a bio
recurses (which is how bio splitting works now).  Not sure it
matters, just mentioning it...

But taking a step back, in the hopes of stepping out of your way:

Myself and others on the DM team (past and present) have always hoped
all block devices could have the flexibility of DM. It was that hope
that caused my frustration when I first saw your blkfilter approach.

But I was too idealistic that a byproduct of your efforts
(blk-interposer before and blkfilter now) would usher in _all_ block
devices being able to comprehensively change their identity (and IO
processing) like DM enjoys.

DM showcases all the extra code needed to achieve its extreme IO
remapping and stacking flexibilty -- I don't yet see a way to distill
the essence of what DM achieves without imposing too much on all block
core.

So I do think blkfilter is a pragmatic way to achieve your goals.

Mike
