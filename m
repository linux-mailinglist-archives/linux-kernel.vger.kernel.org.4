Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422B6C4706
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCVJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:54:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9110CD;
        Wed, 22 Mar 2023 02:52:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D7253397C;
        Wed, 22 Mar 2023 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679478774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzMHyOdi3M1oFdxmInUs087qpDgl9pNZ0oaO0+rMEPk=;
        b=B3dWGc6HiwwJQ4iCU+EMaTIyhtYPcbwEXoQDeJeccjWWWW1kbrQfctel2hnDQTQ4bSK6M2
        Pq4WdIZ9YWd5HntYhoOPyXdAGb3U+CCkAce31bEMxHUZm5RjdCkKoPAAuXNDNNPOvuqW4h
        VbAx+flptB2w0V5Bc8hxk/nsJgNoepw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679478774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzMHyOdi3M1oFdxmInUs087qpDgl9pNZ0oaO0+rMEPk=;
        b=bVlKWQlg6j26d7aS7zpSTttD9JVtk7JrnEexCZsgnB90+ErOjWgqkkEtCvqsNg5N1Fredc
        9uGZ0Pyqp6ovD5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CD7113416;
        Wed, 22 Mar 2023 09:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pqKQGvbPGmRifAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Mar 2023 09:52:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA136A071C; Wed, 22 Mar 2023 10:52:53 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:52:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     ming.lei@redhat.com, jack@suse.cz, hch@infradead.org,
        axboe@kernel.dk, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <20230322095253.gznm43rees5vpkmh@quack3>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322035926.1791317-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-23 11:59:26, Yu Kuai wrote:
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

This looks good to me. I've actually noticed this problem already when
looking at the patch resulting in commit e5cfefa97bcc but Jens merged it
before I got to checking it and then I've convinced myself it's not serious
enough to redo the patch. Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza 

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
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(disk->part0, disk_scan_partitions);
>  	return ret;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
