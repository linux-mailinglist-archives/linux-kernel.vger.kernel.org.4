Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7876E6C447F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCVH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C41DB89
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679471928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8Ne1p2uicICYZ7xBH6jyVNfKiAf/Oat/UHSOLhhvvU=;
        b=FjM/frXZII9Ae80dIzIxdqy01BxIzO6fNk1L6dH5kkgQ/obULEwilratP5YxT9twBLSIxX
        B/oOGvZJ/bfrPN67NHgzpL2Jf8yhmLcdEmz18XXMbgs4KbSa0stt1tZIiUMJKZXONvNEdU
        fVFFYwmvxHr1dzJuWWum3GykImD+osM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-ew3BiCPcNQGT8dgmsdGtbw-1; Wed, 22 Mar 2023 03:58:46 -0400
X-MC-Unique: ew3BiCPcNQGT8dgmsdGtbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E198385C075;
        Wed, 22 Mar 2023 07:58:45 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 730B940C20FA;
        Wed, 22 Mar 2023 07:58:39 +0000 (UTC)
Date:   Wed, 22 Mar 2023 15:58:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, axboe@kernel.dk,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, ming.lei@redhat.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322035926.1791317-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> set, and partition scan will be proceed again when blkdev_get_by_dev()
> is called. However, this will cause a problem that re-assemble partitioned
> raid device will creat partition for underlying disk.
> 
> Test procedure:
> 
> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> sgdisk -n 0:0:+100MiB /dev/md0
> blockdev --rereadpt /dev/sda
> blockdev --rereadpt /dev/sdb
> mdadm -S /dev/md0
> mdadm -A /dev/md0 /dev/sda /dev/sdb
> 
> Test result: underlying disk partition and raid partition can be
> observed at the same time
> 
> Note that this can still happen in come corner cases that
> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> device.
> 
> Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

The issue still can't be avoided completely, such as, after rebooting,
/dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
should be underlying partitions scanned before re-assembling raid, I
guess it may not be easy to avoid.

Also seems the following change added in e5cfefa97bcc isn't necessary:

                /* Make sure the first partition scan will be proceed */
                if (get_capacity(disk) && !(disk->flags & GENHD_FL_NO_PART) &&
                    !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
                        set_bit(GD_NEED_PART_SCAN, &disk->state);

since the following disk_scan_partitions() in device_add_disk() should cover
partitions scan.

> ---
>  block/genhd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 08bb1a9ec22c..a72e27d6779d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -368,7 +368,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  	if (disk->open_partitions)
>  		return -EBUSY;
>  
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	/*
>  	 * If the device is opened exclusively by current thread already, it's
>  	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
> @@ -381,12 +380,19 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  			return ret;
>  	}
>  
> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
>  	if (IS_ERR(bdev))
>  		ret =  PTR_ERR(bdev);
>  	else
>  		blkdev_put(bdev, mode & ~FMODE_EXCL);
>  
> +	/*
> +	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
> +	 * and this will cause that re-assemble partitioned raid device will
> +	 * creat partition for underlying disk.
> +	 */
> +	clear_bit(GD_NEED_PART_SCAN, &disk->state);

I feel GD_NEED_PART_SCAN becomes a bit hard to follow.

So far, it is only consumed by blkdev_get_whole(), and cleared in
bdev_disk_changed(). That means partition scan can be retried
if bdev_disk_changed() fails.

Another mess is that more drivers start to touch this flag, such as
nbd/sd, probably it is better to change them into one API of
blk_disk_need_partition_scan(), and hide implementation detail
to drivers.


thanks,
Ming

