Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF764D92D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLOKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiLOKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:01:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFEA2036F;
        Thu, 15 Dec 2022 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wkAghe3ZNHLtMkd0SpeOhPk85q8HVfUfHIWkbKQ6Tjs=; b=Hvp+NvWQs5Luk958wA57VbeRNK
        OMTEG4yA7yQFAXaOHiEClUFOcpr8R2ndbIlSlETpKMTWVrJdB+1xovmDAeVAKvI48kpqhBwcWAJwj
        JZANyR1PLRmtLYM3JiEZEQF/GtMXeeVt60oO59kNv6lGYmuqk41ljxzBRQJahnQX7Y4UDLbY3zF21
        hBjLWXEkvipV1HSKqCK9pmkQ9XMOqIlHl/vP7cygXrhE7TQQzmNUKR+fxyCmzGoMvsmnJYtwSLsnH
        zFnt1DnoBMJt6OGpXPXUrOr/icR8B/Jmviw8bwjL5QyermsF5Fx+f9C58xG7QmfTH2noGbyiU4XUh
        rnyFmlLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5l3D-008daE-QI; Thu, 15 Dec 2022 10:01:15 +0000
Date:   Thu, 15 Dec 2022 02:01:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/21] block, blksnap: attaching and detaching the
 filter and handling I/O units
Message-ID: <Y5rwa6m3yqo40vz1@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-10-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-10-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool tracker_submit_bio_cb(struct bio *bio)
> +{
> +	struct bdev_filter *flt = bio->bi_bdev->bd_filter;
> +	struct bio_list bio_list_on_stack[2] = { };
> +	struct bio *new_bio;
> +	bool ret = true;
> +	struct tracker *tracker = container_of(flt, struct tracker, flt);
> +	int err;
> +	sector_t sector;
> +	sector_t count;
> +	unsigned int current_flag;
> +
> +	WARN_ON_ONCE(!flt);
> +	if (unlikely(!flt))
> +		return true;

We're called through the filter, so checking this again here (twice)
is a bit silly.

> +	if (bio->bi_opf & REQ_NOWAIT) {
> +		if (!percpu_down_read_trylock(&tracker_submit_lock)) {
> +			bio_wouldblock_error(bio);
> +			return false;
> +		}
> +	} else
> +		percpu_down_read(&tracker_submit_lock);

Does it make sense to make this a global lock vs per-struct tracker?

> +	if (!op_is_write(bio_op(bio)))
> +		goto out;
> +
> +	count = bio_sectors(bio);
> +	if (!count)
> +		goto out;

Just nitpicking, but what about moving all the code below here
into a separate helper that is only called for op_is_write &&
bio_sectors?  It's not going to change anything functionally, but
would make the code easier to follow.

> +	current_flag = memalloc_noio_save();
> +	bio_list_init(&bio_list_on_stack[0]);
> +	current->bio_list = bio_list_on_stack;
> +	barrier();

barrier is just a compiler barrier, so it is unlikely to do what
you want. But without a comment I can't even figure out what it is
trying to do.

> +static int tracker_filter_attach(struct block_device *bdev,
> +				 struct tracker *tracker)
> +{
> +	int ret;
> +	bool is_frozen = false;
> +
> +	pr_debug("Tracker attach filter\n");
> +
> +	if (freeze_bdev(bdev))
> +		pr_err("Failed to freeze device [%u:%u]\n", MAJOR(bdev->bd_dev),
> +		       MINOR(bdev->bd_dev));

I think you need to fail the attachment if we can't freeze the device.

> +static int tracker_filter_detach(struct block_device *bdev)
> +{
> +	int ret;
> +	bool is_frozen = false;
> +
> +	pr_debug("Tracker delete filter\n");
> +	if (freeze_bdev(bdev))
> +		pr_err("Failed to freeze device [%u:%u]\n", MAJOR(bdev->bd_dev),
> +		       MINOR(bdev->bd_dev));

Same here.

> +/**
> + * tracker_wait_for_release - Waiting for all trackers are released.
> + *
> + * Trackers are released in the worker thread. So, this function allows to wait
> + * for the end of the process of releasing trackers.
> + */
> +static void tracker_wait_for_release(void)

This defeats the reason to move it to the workqueue first, as you
can still deadlock on whatever problem that tried to solve, just
out of reach of lockdep.

> +struct tracker *tracker_create_or_get(dev_t dev_id)
> +{
> +	struct tracker *tracker;
> +	struct block_device *bdev;
> +	struct tracked_device *tr_dev;
> +
> +	bdev = blkdev_get_by_dev(dev_id, 0, NULL);

These blkdev_get_by_dev calls are a little problematic, as they
bypass any access restriction (LSMs, containers, etc).  That's
why the kernel generally does a blkdev_get_by_name based on the
actual file name, which does all the proper checks.  I think the
tracker creation also needs to happen based on names to fit into this
security model.  Passing in names should also be much easier for
userspace to start with.


Now for remove, and the other operations on the tracked device:
Is there any reason to not simply add an ioctl method to
bdev_filter_operations, so that you can issue these ioctls against the
tracked device?  That removes the need to find the tracked device
entirely and should simplify a lot of things.

In fact thinking wonder if attachment of a filter driver should
go through the block layer using an ioctl on the tracked device
as well, i.e.

 - add a name field to bdev_filter_operations
 - keep a list of all bdev_filter_operations in the block core
 - new core block layer ioctl to associate a block device with a
   bdev_filter_operations
 - everything after that is done through bdev_filter_operations->ioctl.

