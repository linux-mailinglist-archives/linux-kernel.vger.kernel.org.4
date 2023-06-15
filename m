Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08781731280
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbjFOInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbjFOImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD810294D;
        Thu, 15 Jun 2023 01:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F7162C20;
        Thu, 15 Jun 2023 08:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2563C433C0;
        Thu, 15 Jun 2023 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686818570;
        bh=Kk5Cv8hJcuoe/LCGdg/cP74GAed73Sgd3BjIVq+pCak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E3D3MvTx+nnd0OMgQ43XF0zLmIL3G2wOj9bFYBZQoHfq/g6WUAKPnWgRCJHvBKMrp
         okgZq0m2qy8tTj/iFhnWsLUUQcp6KIdYjtHhJ38yhN+L8TzL7qZ940tAbdCbTaFp+k
         PUmpegmN3fEg3AnXu/KKgBZWO9MD3MDdlt46bJspcddikcnEsyrL+4fbq3avHkXH+n
         iU+BmPF2LM7pcM0LNj1vQu4OdKU6XC06EjEtVxwdjGOJbmjzDYb+AEvMtIvs2AeFKH
         Fs6E1DNaKNiaH8wiD8pmxcOHnXCw0G+loMnoDap5ZMKju3kf964ZFF69iTfVKJY5US
         lcKg0EHd5+3aw==
Message-ID: <621fecd9-52ee-b5ba-6702-c283658096ef@kernel.org>
Date:   Thu, 15 Jun 2023 17:42:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: add capacity validation in bdev_add_partition()
Content-Language: en-US
To:     "min15.li" <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org,
        wsa@kernel.org, vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560@epcas5p4.samsung.com>
 <20230615160929.9240-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230615160929.9240-1-min15.li@samsung.com>
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

On 6/16/23 01:09, min15.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> Signed-off-by: min15.li <min15.li@samsung.com>
> ---
>  block/partitions/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 49e0496ff23c..9806a804e1a4 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -445,6 +445,12 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  		goto out;
>  	}
>  
> +	if (start >= get_capacity(disk) ||
> +		start + length > get_capacity(disk)) {

declaring:

	sector_t capacity = get_capacity(disk);

at the beginning of the function would make this check prettier and fit on one line.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (partition_overlaps(disk, start, length, -1)) {
>  		ret = -EBUSY;
>  		goto out;

-- 
Damien Le Moal
Western Digital Research

