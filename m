Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1D73DB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFZJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFZJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132DDC;
        Mon, 26 Jun 2023 02:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151D660DBF;
        Mon, 26 Jun 2023 09:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF897C433C9;
        Mon, 26 Jun 2023 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687772300;
        bh=ahzSom5WrWgfJ+H+CGnj7o11RaZMEt1ei4pjJwpiac8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EzmjwqC+Fcup+VoqKVVAT3fE4dvL795jxiqSzrFguEbCBK75+A0kYb07HTlp+GBNu
         WZPqjtXhLn6SLqS4aVn4aypOCfVm8nLZLgl351Y0xrQRFG+SgIznZ9q4FcmlHoLzS7
         TbFVKvkD7lEdDAdoBtQPp/hIXgrm4QN0wQqAkEpMcIKQHzeOH17RNoWxaFhwNZMP+s
         Pepe5gzBM3Ghrep/HE0NJILpCq659Tdr4Pra0xt7fO8uvJnwXvMvHmK2Y9+8HnIXR3
         Dj5c9bbF7jVfq5hsfqWhwbl3lkJJw9gt+igOCFbu+u74shtniTn+1ycaP8pGZRVXTk
         STbPLjT+0LnCQ==
Message-ID: <c84c740a-582e-ff9e-2827-bf8eef5e6b0d@kernel.org>
Date:   Mon, 26 Jun 2023 18:38:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: add check that partition length needs to be
 aligned with block size
Content-Language: en-US
To:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e@epcas5p2.samsung.com>
 <20230626171021.5895-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230626171021.5895-1-min15.li@samsung.com>
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

On 6/27/23 02:10, Min Li wrote:
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
> ---
>  block/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c5f637ff153..aa95b5561169 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -35,6 +35,9 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  
>  	start = p.start >> SECTOR_SHIFT;
>  	length = p.length >> SECTOR_SHIFT;
> +	/*check if length is aligned to blocksize*/

Please add a space after /* and before */.

> +	if (p.length & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;

I would move this check before the "start = ...;" And while at it, I would also
move the check for p.start being aligned out of the "case BLKPG_ADD_PARTITION:"
together with this length alignment check. The p.start check is not needed for
BLKPG_RESIZE_PARTITION, but it will not hurt either.

>  
>  	switch (op) {
>  	case BLKPG_ADD_PARTITION:

-- 
Damien Le Moal
Western Digital Research

