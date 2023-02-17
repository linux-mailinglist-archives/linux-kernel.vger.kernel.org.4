Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E169A990
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBQLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBQLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:01:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697E635B9;
        Fri, 17 Feb 2023 03:01:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACAB23376D;
        Fri, 17 Feb 2023 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676631662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYuwxqTnfVCAW7cW6pnYZZcwYDRarjxb/3Ds5tm/d58=;
        b=jW56H0V0c1zN+PO4LYen1+losVtQvYbubjRy4BENiMyI/3mgFLRGxnGZXCcGafrGgF6sHT
        +ea4IAXKM+kAm4VRZQcRR5lrv0udClt11k8L1QDR2l5ReUj4BcfDfdC4kKrAoJRzK8q/2y
        8TFNADawIApVSrzHI0yTCDXCJ48aOhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676631662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYuwxqTnfVCAW7cW6pnYZZcwYDRarjxb/3Ds5tm/d58=;
        b=gOd8yjsBz//UEPPiesH7EW1qLUvimrFS3lhd7rRtwr5Sfx03v5NmS2kvgYbBOvGBmJTkkK
        3Vgu9Yg7dCYVH3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E4D2138E3;
        Fri, 17 Feb 2023 11:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F56ZJm5e72MNPgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:01:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2BC8BA06E1; Fri, 17 Feb 2023 12:01:02 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:01:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 1/2] block: Revert "block: Do not reread partition
 table on exclusively open device"
Message-ID: <20230217110102.la3w7c6pck4pfilo@quack3>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <20230217022200.3092987-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217022200.3092987-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-02-23 10:21:59, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This reverts commit 36369f46e91785688a5f39d7a5590e3f07981316.
> 
> This patch can't fix the problem in a corner case that device can be
> opened exclusively after the checking and before blkdev_get_by_dev().
> We'll use a new solution to fix the problem in the next patch, and
> the new solution doesn't need to change apis.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Sure. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

or Reviewed-by... whatever for the revert :)

								Honza

> ---
>  block/blk.h   |  2 +-
>  block/genhd.c |  7 ++-----
>  block/ioctl.c | 13 ++++++-------
>  3 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index f02381405311..4a166f847ffd 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -439,7 +439,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>  
>  struct request_queue *blk_alloc_queue(int node_id);
>  
> -int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
> +int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
>  
>  int disk_alloc_events(struct gendisk *disk);
>  void disk_add_events(struct gendisk *disk);
> diff --git a/block/genhd.c b/block/genhd.c
> index d09d775c222a..b30d5538710c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -356,7 +356,7 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
>  }
>  EXPORT_SYMBOL_GPL(disk_uevent);
>  
> -int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
> +int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  {
>  	struct block_device *bdev;
>  
> @@ -366,9 +366,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
>  		return -EINVAL;
>  	if (disk->open_partitions)
>  		return -EBUSY;
> -	/* Someone else has bdev exclusively open? */
> -	if (disk->part0->bd_holder && disk->part0->bd_holder != owner)
> -		return -EBUSY;
>  
>  	set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
> @@ -499,7 +496,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  
>  		bdev_add(disk->part0, ddev->devt);
>  		if (get_capacity(disk))
> -			disk_scan_partitions(disk, FMODE_READ, NULL);
> +			disk_scan_partitions(disk, FMODE_READ);
>  
>  		/*
>  		 * Announce the disk and partitions after all partitions are
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 96617512982e..6dd49d877584 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -467,10 +467,10 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
>   * user space. Note the separate arg/argp parameters that are needed
>   * to deal with the compat_ptr() conversion.
>   */
> -static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
> -			       unsigned long arg, void __user *argp)
> +static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
> +			       unsigned int cmd, unsigned long arg,
> +			       void __user *argp)
>  {
> -	struct block_device *bdev = I_BDEV(file->f_mapping->host);
>  	unsigned int max_sectors;
>  
>  	switch (cmd) {
> @@ -528,8 +528,7 @@ static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
>  			return -EACCES;
>  		if (bdev_is_partition(bdev))
>  			return -EINVAL;
> -		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL,
> -					    file);
> +		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
>  	case BLKTRACETEARDOWN:
> @@ -607,7 +606,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  		break;
>  	}
>  
> -	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
> +	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
>  	if (ret != -ENOIOCTLCMD)
>  		return ret;
>  
> @@ -676,7 +675,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  		break;
>  	}
>  
> -	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
> +	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
>  	if (ret == -ENOIOCTLCMD && disk->fops->compat_ioctl)
>  		ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
