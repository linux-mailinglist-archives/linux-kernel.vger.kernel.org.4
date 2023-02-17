Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4548669A9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBQLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBQLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:06:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85006642C0;
        Fri, 17 Feb 2023 03:05:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AB871FE6D;
        Fri, 17 Feb 2023 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676631918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdOtg0/SYltH36IBrBWZH6fCciTMyCPOS7VoVpQYu8k=;
        b=uffJtjc/q6yp2J9Zfv2rYKycBOdqYvGpImgpIDcm2M0DouTE1iVLQtH2byGa7Dcmj3UHyJ
        T8KSULHBHEs8i+5gvxzq4ejzNp7DtrSQjTPT0vCki+I4Sok+3YZ0l2vhU5UGin5sHm5ETA
        v8/8ry6l7Jno4oOWMDkOqLHdfxw1alw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676631918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdOtg0/SYltH36IBrBWZH6fCciTMyCPOS7VoVpQYu8k=;
        b=jpDFdf88HaRyhV5YkQFx+EwWCLcDCQjFnPwnOG4t/a9NTpCRrkbaXJsPff7ov5sIHeQ6ZS
        E3klHogDJfytvTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78413138E3;
        Fri, 17 Feb 2023 11:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BrNYHW5f72NwQAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:05:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EAEADA06E1; Fri, 17 Feb 2023 12:05:17 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:05:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 2/2] block: fix scan partition for exclusively open
 device again
Message-ID: <20230217110517.hagxj47e2m4xbmkd@quack3>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <20230217022200.3092987-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217022200.3092987-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-02-23 10:22:00, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As explained in commit 36369f46e917 ("block: Do not reread partition table
> on exclusively open device"), reread partition on the device that is
> exclusively opened by someone else is problematic.
> 
> This patch will make sure partition scan will only be proceed if current
> thread open the device exclusively, or the device is not opened
> exclusively, and in the later case, other scanners and exclusive openers
> will be blocked temporarily until partition scan is done.
> 
> Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me, just two minor comments below:

> diff --git a/block/genhd.c b/block/genhd.c
> index b30d5538710c..3ee5577e1586 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -359,6 +359,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
>  int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  {
>  	struct block_device *bdev;
> +	int ret = 0;
>  
>  	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
>  		return -EINVAL;
> @@ -368,11 +369,27 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  		return -EBUSY;
>  
>  	set_bit(GD_NEED_PART_SCAN, &disk->state);

I'd move the set_bit() after we are sure we have exclusive access to the
bdev. Otherwise we could set GD_NEED_PART_SCAN on a device exclusively open
by someone else and if we race with open in an unfortunate way, we could
trigger unexpected partition scan...

> -	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
> +	/*
> +	 * If the device is opened exclusively by current thread already, it's
> +	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
> +	 * synchronize with other exclusive openers and other partition
> +	 * scanners.
> +	 */
> +	if (!(mode & FMODE_EXCL)) {
> +		ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
>  	if (IS_ERR(bdev))
> -		return PTR_ERR(bdev);
> -	blkdev_put(bdev, mode);
> -	return 0;
> +		ret =  PTR_ERR(bdev);
> +	else
> +		blkdev_put(bdev, mode);
> +
> +	if (!(mode & FMODE_EXCL))
> +		bd_abort_claiming(disk->part0, disk_scan_partitions);
> +	return ret;
>  }
>  
>  /**
> @@ -494,6 +511,11 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  		if (ret)
>  			goto out_unregister_bdi;
>  
> +		/* Make sure the first partition scan will be proceed */
							   ^^^^^^ "will happen"
probably makes more sense here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
