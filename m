Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD273F397
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF0EnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjF0EmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB53AAA;
        Mon, 26 Jun 2023 21:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286AA60ECF;
        Tue, 27 Jun 2023 04:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC554C433C8;
        Tue, 27 Jun 2023 04:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687840768;
        bh=N1xeksPjBTEfFLV5yHQeo/RrVa2KsLpcqtc1W4KXkPk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pzchJo4srR1jvJI/1GqOZG7XlCrlK+OgKAUUaKXAutWIpbzg2cu+QlaVSJLZIcmLa
         QDNuEFVtobR9dfqXRhXLuKj4SltQWyvpQBMkEwbENUtxDRJHtxGUD6UO0D71LE3pTK
         JC6CmjAvMn4FSIIq1XInRvjwPhQGqBmJPRCRKPa0L7ct0FKygJRHSf1srusOBUdiaY
         GsEPhLy7MvtD1gDSDom6yuvz5EENriFC1hjdFuWNO0J4bo25PI0TUOBJB0TSN9E1Pg
         Mghq7pM6GAj4cqC9FrjEDiUYEAYYb6Ti04TT8ySYvzoETgIRXWBkb7KMNWAKfKzdIl
         u3ABlVI0k+qgw==
Message-ID: <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
Date:   Tue, 27 Jun 2023 13:39:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Content-Language: en-US
To:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
 <20230627110918.7608-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230627110918.7608-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 20:09, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> Signed-off-by: Min Li <min15.li@samsung.com>

See Greg's comment: this likely need a "Fixes:" tag. And I think that the tag
is: fa9156ae597c ("block: refactor blkpg_ioctl"). But please double check.

> 
> ---
> Changes from v1:
> 
> - Add a space after /* and before */.
> - Move length alignment check before the "start = p.start >> SECTOR_SHIFT"
> - Move check for p.start being aligned together with this length alignment check.
> ---
>  block/ioctl.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 3be11941fb2d..c40b382dd58f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -33,14 +33,18 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  	if (op == BLKPG_DEL_PARTITION)
>  		return bdev_del_partition(disk, p.pno);
>  
> +	/* check if partition is aligned to blocksize */
> +	if (p.start & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +	/* check if length is aligned to blocksize */
> +	if (p.length & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;

	long long blksz_mask = bdev_logical_block_size(bdev) - 1;

	/* Check that the partition is aligned to the block size */
	if ((p.start & blksz_mask) || (p.length & blksz_mask))
		return -EINVAL;

would be cleaner and avoid the rather redundant comments.

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

