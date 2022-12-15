Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5938C64D8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiLOJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLOJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:45:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D564414D20;
        Thu, 15 Dec 2022 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ngEPy5SgkQAXzrDrGQ4y5fn8QjLL1hAd1sk2qSi+fc0=; b=M8Gs6M1azvQ5whxKV4gsBan5e0
        7/QEDmiPUm+2alXDzA+/jyfouaoah8t8D/USCRDwhBME+qGuilhleIGTge/patyPnoE+W72c4rMGk
        ySKsFFKP1xuoAQWNAL9hURCoU2YpsrIwxqsLNlzkVuupwYOlhuDhcwM5QIXpMXPgcDqS10/t636OG
        IcxJycWqpfL1b59n+zGbw1W6s0qgxVDtloLLRi+Q5FoNGqUvqLwYZ0zJ611MiGAtXUlC1zQgM84Ws
        QDuOzH5o+ShmUMCy51OAjjnoYE02cx4rovniH0hZ0zfd4JKSJOSgdEzB/AGgZXc7qgPs40r6YTSPz
        9wOsX1xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5ko2-008T1Y-9W; Thu, 15 Dec 2022 09:45:34 +0000
Date:   Thu, 15 Dec 2022 01:45:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/21] block, blksnap: snapshot image block device
Message-ID: <Y5rsvibCBNGMwnn+@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-18-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-18-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:23:27PM +0100, Sergei Shtepa wrote:
> +static int snapimage_kthread_worker_fn(void *param);

Any chance to order th code so that you can avoid forward declarations
wherever possible.

> +static inline int snapimage_start_worker(struct snapimage *snapimage)
> +{
> +	struct task_struct *task;
> +
> +	spin_lock_init(&snapimage->queue_lock);
> +	bio_list_init(&snapimage->queue);
> +
> +	task = kthread_create(snapimage_kthread_worker_fn,
> +			      snapimage,
> +			      BLK_SNAP_IMAGE_NAME "%d",
> +			      MINOR(snapimage->image_dev_id));
> +	if (IS_ERR(task))
> +		return -ENOMEM;
> +
> +	snapimage->worker = get_task_struct(task);

There's not need to grab and put an extra reference to the task_struct,
the kthread code already holds one.

> +	while (!kthread_should_stop()) {
> +		bio = get_bio_from_queue(snapimage);
> +		if (!bio) {
> +			schedule_timeout_interruptible(HZ / 100);

Do you need a timeout sleep here?  All new arrivals should properly
wake the thread.

> +			continue;
> +		}
> +
> +		snapimage_process_bio(snapimage, bio);
> +	}
> +
> +	while ((bio = get_bio_from_queue(snapimage)))
> +		snapimage_process_bio(snapimage, bio);

It seems like the loop could be simplified to:

	for (;; {
		while ((bio = get_bio_from_queue(snapimage)))
			snapimage_process_bio(snapimage, bio);
		if (kthread_should_stop())
			break;
		schedule();
	}

	return 0;


> +static void snapimage_submit_bio(struct bio *bio)
> +{
> +	struct snapimage *snapimage = bio->bi_bdev->bd_disk->private_data;
> +	gfp_t gfp = GFP_NOIO;
> +
> +	if (bio->bi_opf & REQ_NOWAIT)
> +		gfp |= GFP_NOWAIT;

gfp isn't actually used anywhere.

> +	if (snapimage->is_ready) {
> +		spin_lock(&snapimage->queue_lock);
> +		bio_list_add(&snapimage->queue, bio);
> +		spin_unlock(&snapimage->queue_lock);
> +
> +		wake_up_process(snapimage->worker);
> +	} else
> +		bio_io_error(bio);
> +}

I think you can do away with the is_ready flag entirely by just
calling del_gendisk early enough.  See below.

> +void snapimage_free(struct snapimage *snapimage)
> +{
> +	pr_info("Snapshot image disk [%u:%u] delete\n",
> +		MAJOR(snapimage->image_dev_id), MINOR(snapimage->image_dev_id));
> +
> +	blk_mq_freeze_queue(snapimage->disk->queue);
> +	snapimage->is_ready = false;
> +	blk_mq_unfreeze_queue(snapimage->disk->queue);
> +
> +	snapimage_stop_worker(snapimage);
> +
> +	del_gendisk(snapimage->disk);

Just move the snapimage_stop_worker after del_gendisk here, and
you should be fine.

> +	put_disk(snapimage->disk);
> +
> +	diff_area_put(snapimage->diff_area);
> +	cbt_map_put(snapimage->cbt_map);
> +
> +	ida_free(&snapimage_devt_ida, MINOR(snapimage->image_dev_id));
> +	kfree(snapimage);

.. and then implement the free_disk block_device operation, and
move all code after the put_disk into it, which means all your
data structures are alive until the very last gendisk reference goes
away.

> +#ifdef GENHD_FL_NO_PART_SCAN
> +	disk->flags |= GENHD_FL_NO_PART_SCAN;
> +#else
> +	disk->flags |= GENHD_FL_NO_PART;
> +#endif

GENHD_FL_NO_PART_SCAN is gone, so this ifdef goes away.

> +	disk->major = _major;
> +	disk->first_minor = minor;
> +	disk->minors = 1; /* One disk has only one partition */

No new driver should manage the major/minor numbers manually, as
the block layer just assigns a dev_t by default if you don't se these.

> +	wake_up_process(snapimage->worker);

I don't think this wake_up is needed - the first queue bio should
wake the helper thread up.

> +int snapimage_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = register_blkdev(0, BLK_SNAP_IMAGE_NAME);
> +	if (ret < 0) {
> +		pr_err("Failed to register snapshot image block device\n");
> +		return ret;
> +	}
> +
> +	_major = ret;
> +	pr_info("Snapshot image block device major %d was registered\n",
> +		_major);
> +
> +	return 0;
> +}
> +
> +void snapimage_done(void)
> +{
> +	unregister_blkdev(_major, BLK_SNAP_IMAGE_NAME);
> +	pr_info("Snapshot image block device [%d] was unregistered\n", _major);
> +}

And with block layer managed dev_t all this boilerplate can go away
as well.

> +#include <linux/blk_types.h>
> +#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>

If you already include blk-mq.h, there is no need for the other two
headers as they are already implictly included.
