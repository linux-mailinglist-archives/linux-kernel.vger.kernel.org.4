Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496A173289F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbjFPHRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjFPHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:17:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20AF170E;
        Fri, 16 Jun 2023 00:17:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 471DF6732D; Fri, 16 Jun 2023 09:17:29 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:17:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add capacity validation in
 bdev_add_partition()
Message-ID: <20230616071729.GA29853@lst.de>
References: <CGME20230616030739epcas5p31e705be33bf080f988702d42534ad32f@epcas5p3.samsung.com> <20230616110557.12106-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616110557.12106-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:05:57AM +0000, min15.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> v1->v2: check for overflows of the start + length value and put
> the capacity check at the beginning of the function.
> 
> Signed-off-by: min15.li <min15.li@samsung.com>
> ---
>  block/partitions/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 49e0496ff23c..3546b43d5124 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -438,8 +438,20 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  {
>  	struct block_device *part;
>  	int ret;
> +	sector_t end;
> +	sector_t capacity = get_capacity(disk);

Very minor nitpick, but I think this would read nicer as:

+	sector_t capacity = get_capacity(disk), end;
  	struct block_device *part;
  	int ret;

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
