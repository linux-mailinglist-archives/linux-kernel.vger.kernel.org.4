Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22BA66399D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjAJG5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjAJG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:57:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BE392D8;
        Mon,  9 Jan 2023 22:57:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFF2F68D06; Tue, 10 Jan 2023 07:57:38 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:57:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, kernel@pankajraghav.com,
        linux-kernel@vger.kernel.org, hare@suse.de, bvanassche@acm.org,
        snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 6/7] dm-zone: use generic helpers to calculate offset
 from zone start
Message-ID: <20230110065738.GE10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338@eucas1p1.samsung.com> <20230106083317.93938-7-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-7-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 09:33:16AM +0100, Pankaj Raghav wrote:
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of open coding.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-zone.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3dafc0e8b7a9..ac6fc1293d41 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  		/* Writes must be aligned to the zone write pointer */
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if (bdev_offset_from_zone_start(md->disk->part0,
> +						clone->bi_iter.bi_sector) != zwp_offset)

I can't see how this actually cleans antyhing up, while it does add an
overly long line.

>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
>  			orig_bio->bi_iter.bi_sector +=
> -				clone->bi_iter.bi_sector & mask;
> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);

Same here.
