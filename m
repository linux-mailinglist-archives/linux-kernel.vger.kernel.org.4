Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F496699587
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjBPNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:17:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4C521C1;
        Thu, 16 Feb 2023 05:17:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C03F8223A0;
        Thu, 16 Feb 2023 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676553445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XK/Pa5mX9UF56usF4qKvRVKxkUMbrm0p0QzsUuwpf8=;
        b=1qW0tPQwbvNc7ArfR0GOw+UQ2E3eZeS0NUi/tkgm9nADW6l6pUEVKwVWSYVMUbTyJRpz4p
        p8MEBKgqZXNuWvHMSiA7PccdCbdukUEm9P/VhCCuwXgOll/XkTq8yLjhVvgEeSo9VjAvDn
        faUPO+ZRGtEbyls3JDTdxFfAnFquz7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676553445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XK/Pa5mX9UF56usF4qKvRVKxkUMbrm0p0QzsUuwpf8=;
        b=160pCWlCnDeBkzFOP8tHSiotqv3dphAw5FuXcwJ50kcT95PdSfRECnbEsb98GjT6o/BaTM
        HtS1izVdeGbeymCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB92F13438;
        Thu, 16 Feb 2023 13:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TRrcKeUs7mMRWAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 13:17:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DC2DA06E1; Thu, 16 Feb 2023 14:17:25 +0100 (CET)
Date:   Thu, 16 Feb 2023 14:17:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, jack@suse.cz, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next RFC 2/3] block: factor out the setting of
 GD_NEED_PART_SCAN
Message-ID: <20230216131725.oddv27a7fhz6hx7x@quack3>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
 <20230212092641.2394146-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212092641.2394146-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12-02-23 17:26:40, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In order to prevent scan partition for a device that is opened
> exclusively by someone else, new conditions will be added to
> disk_scan_partitions() in the next patch. Hence if device is opened
> exclusively between bdev_add() and disk_scan_partitions(), the first
> partition scan will fail unexpected. This patch factor out the setting
> of GD_NEED_PART_SCAN to prevent the problem.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I'd rather leave the setting of GD_NEED_PART_SCAN in disk_scan_partitions()
to keep it self-contained. On top of that we can set GD_NEED_PART_SCAN in
device_add_disk() to ensure initial partition scan but we should probably
also make sure flags like GD_SUPPRESS_PART_SCAN or GENHD_FL_NO_PART are not
set to avoid unwanted partition scanning.

								Honza

> ---
>  block/genhd.c | 2 +-
>  block/ioctl.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 075d8da284f5..c0d1220bd798 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -367,7 +367,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  	if (disk->open_partitions)
>  		return -EBUSY;
>  
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
> @@ -493,6 +492,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  		if (ret)
>  			goto out_unregister_bdi;
>  
> +		set_bit(GD_NEED_PART_SCAN, &disk->state);
>  		bdev_add(disk->part0, ddev->devt);
>  		if (get_capacity(disk))
>  			disk_scan_partitions(disk, FMODE_READ);
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6dd49d877584..0eefcdb936a0 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -528,6 +528,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  			return -EACCES;
>  		if (bdev_is_partition(bdev))
>  			return -EINVAL;
> +		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
