Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50753741E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjF2CiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF2CiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0442C1FE7;
        Wed, 28 Jun 2023 19:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97763614B1;
        Thu, 29 Jun 2023 02:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2436CC433C8;
        Thu, 29 Jun 2023 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688006292;
        bh=FWOZ/ZJdPy5FL/tkQTTsC7J+jkU3D+c3SQjxTWY/6MI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NTmhwC7qwr0S/9kpQZIZvJq5erqVXUdv/V02ssGw9DYjqcnGdAVR2otF8VMUZZ2EE
         Kka+0/J9lAJ5cQo+LUbjxi9r4GnURc+Zg0fFyRIaQSfqJeKcugNp0yIgU6Ez2sFV9C
         u3wh75d0L1xxZJgUXd3yWNJnZAvmg4LGgFMVoekfMER7VOaFHSCYaJsejFn9sQCz2x
         A1Fqce82RHWuPb++DBKvrzuazd/4WjGCzsCGsucGo9IQRhiAtedErmF/E/L0VPrEzs
         R+HuTGOuqXYq9cpFmg3y2CYcJolIPi4VhgWGZYYaELwVwdawnaXhyL8Wi9bsm+IJmY
         v8fizZBXmBvBQ==
Message-ID: <fe796add-74f6-5b52-69b3-4823b93cd54c@kernel.org>
Date:   Thu, 29 Jun 2023 11:38:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] block: add check that partition length needs to be
 aligned with block size
Content-Language: en-US
To:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <CGME20230629022807epcas5p23765f81f547eed72135c802f83543908@epcas5p2.samsung.com>
 <20230629102623.7410-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230629102623.7410-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 19:26, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Min Li <min15.li@samsung.com>>
> ---
> Changes from v1:
> 
> - Add a space after /* and before */.
> - Move length alignment check before the "start = p.start >> SECTOR_SHIFT"
> - Move check for p.start being aligned together with this length alignment check.
> 
> Changes from v2:
> 
> - Add the assignment on the first line and merge the two lines into one.
> 
> Changes from v3:
> 
> - Change the blksz to unsigned int.
> - Add check if p.start and p.length are negative.
> ---
>  block/ioctl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 3be11941fb2d..a8061c2fcae0 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -16,9 +16,10 @@
>  static int blkpg_do_ioctl(struct block_device *bdev,
>  			  struct blkpg_partition __user *upart, int op)
>  {
> +	unsigned int blksz = bdev_logical_block_size(bdev);
>  	struct gendisk *disk = bdev->bd_disk;
>  	struct blkpg_partition p;
> -	long long start, length;
> +	sector_t start, length;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> @@ -33,14 +34,17 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  	if (op == BLKPG_DEL_PARTITION)
>  		return bdev_del_partition(disk, p.pno);
>  
> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
> +		return -EINVAL;
> +	/* Check that the partition is aligned to the block size */
> +	if (!IS_ALIGNED(p.start | p.length, blksz))

Minor nit: blksz is used only here now, so this could be changed to:

	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))

to not use that local variable.

With or without this addressed, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		return -EINVAL;
> +
>  	start = p.start >> SECTOR_SHIFT;
>  	length = p.length >> SECTOR_SHIFT;
>  
>  	switch (op) {
>  	case BLKPG_ADD_PARTITION:
> -		/* check if partition is aligned to blocksize */
> -		if (p.start & (bdev_logical_block_size(bdev) - 1))
> -			return -EINVAL;
>  		return bdev_add_partition(disk, p.pno, start, length);
>  	case BLKPG_RESIZE_PARTITION:
>  		return bdev_resize_partition(disk, p.pno, start, length);

-- 
Damien Le Moal
Western Digital Research

