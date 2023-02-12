Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564269370C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBLLg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBLLg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:36:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E0E398;
        Sun, 12 Feb 2023 03:36:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB69207B8;
        Sun, 12 Feb 2023 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676201813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY9kC8oKNJhpV9eyhjn6y9sJ0BjoWhCUKHtfu5N4lZU=;
        b=xUKjeNCMc0FVMvMh/GvU434QDUPgzRg78iXjUczn/2m/HVRnMqlRGhaD9poq0G2YLMxaxZ
        nB/Ns6NNmSJuHb184Jz9a58MMHJYTdPt/c5V7uheFLNCFm9HjuM8igbtWKXDdluC7pR54+
        0tYxTY+BxtNBN6Kc4ddKk+TyEsYNvzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676201813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY9kC8oKNJhpV9eyhjn6y9sJ0BjoWhCUKHtfu5N4lZU=;
        b=yU4eKF31TiM+78CvHJMm48EsfIi7l94M8U2RCJCqsOp3YLXYzIXgkNPekDWKmyJVKKyda3
        bptL7YINTOMIxlAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB2913310;
        Sun, 12 Feb 2023 11:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZIgxElXP6GN0ZwAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 12 Feb 2023 11:36:53 +0000
Message-ID: <9b0b9059-c0f6-df5b-863a-987970f3567d@suse.de>
Date:   Sun, 12 Feb 2023 12:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next RFC 2/3] block: factor out the setting of
 GD_NEED_PART_SCAN
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, jack@suse.cz,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
 <20230212092641.2394146-3-yukuai1@huaweicloud.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230212092641.2394146-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/23 10:26, Yu Kuai wrote:
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
> ---
>   block/genhd.c | 2 +-
>   block/ioctl.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 075d8da284f5..c0d1220bd798 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -367,7 +367,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>   	if (disk->open_partitions)
>   		return -EBUSY;
>   
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
>   	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
>   	if (IS_ERR(bdev))
>   		return PTR_ERR(bdev);
> @@ -493,6 +492,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   		if (ret)
>   			goto out_unregister_bdi;
>   
> +		set_bit(GD_NEED_PART_SCAN, &disk->state);
>   		bdev_add(disk->part0, ddev->devt);
>   		if (get_capacity(disk))
>   			disk_scan_partitions(disk, FMODE_READ);
Usual caveat:
What happens if the flag is already set here?
Wouldn't that imply that another scan is underway?
And wouldn't it be better to use 'test_and_set()'?


> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6dd49d877584..0eefcdb936a0 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -528,6 +528,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>   			return -EACCES;
>   		if (bdev_is_partition(bdev))
>   			return -EINVAL;
> +		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>   		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
>   	case BLKTRACESTART:
>   	case BLKTRACESTOP:
Similar here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

