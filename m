Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696E736897
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFTKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjFTKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:00:04 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A0DB;
        Tue, 20 Jun 2023 02:58:31 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFAFD61E5FE03;
        Tue, 20 Jun 2023 11:57:52 +0200 (CEST)
Message-ID: <6f05e7b4-461c-68db-20c5-e3bfd52cc7f6@molgen.mpg.de>
Date:   Tue, 20 Jun 2023 11:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next 3/8] raid5: fix missing io accounting in
 raid5_align_endio()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230619204826.755559-1-yukuai1@huaweicloud.com>
 <20230619204826.755559-4-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230619204826.755559-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patch.

Am 19.06.23 um 22:48 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Io will only be accounted as done from raid5_align_endio() if the io
> succeed, and io inflight counter will be leaked if such io failed.

succeed*s* or succeed*ed*?

> Fix this problem by switching to use md_account_bio() for io accounting.

How can this be tested?

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid5.c | 29 ++++++++---------------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index cef0b400b2ee..4cdb35e54251 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5468,26 +5468,17 @@ static struct bio *remove_bio_from_retry(struct r5conf *conf,
>    */
>   static void raid5_align_endio(struct bio *bi)
>   {
> -	struct md_io_clone *md_io_clone = bi->bi_private;
> -	struct bio *raid_bi = md_io_clone->orig_bio;
> -	struct mddev *mddev;
> -	struct r5conf *conf;
> -	struct md_rdev *rdev;
> +	struct bio *raid_bi = bi->bi_private;
> +	struct md_rdev *rdev = (void *)raid_bi->bi_next;
> +	struct mddev *mddev = rdev->mddev;
> +	struct r5conf *conf = mddev->private;
>   	blk_status_t error = bi->bi_status;
> -	unsigned long start_time = md_io_clone->start_time;
>   
>   	bio_put(bi);
> -
> -	rdev = (void*)raid_bi->bi_next;
>   	raid_bi->bi_next = NULL;
> -	mddev = rdev->mddev;
> -	conf = mddev->private;
> -

This looks like unnecessary refactoring. No idea what the preferred 
style for the subsystem is though. If it is wanted, maybe make it a 
separate commit?

>   	rdev_dec_pending(rdev, conf->mddev);
>   
>   	if (!error) {
> -		if (blk_queue_io_stat(raid_bi->bi_bdev->bd_disk->queue))
> -			bio_end_io_acct(raid_bi, start_time);
>   		bio_endio(raid_bi);
>   		if (atomic_dec_and_test(&conf->active_aligned_reads))
>   			wake_up(&conf->wait_for_quiescent);
> @@ -5506,7 +5497,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
>   	struct md_rdev *rdev;
>   	sector_t sector, end_sector, first_bad;
>   	int bad_sectors, dd_idx;
> -	struct md_io_clone *md_io_clone;
>   	bool did_inc;
>   
>   	if (!in_chunk_boundary(mddev, raid_bio)) {
> @@ -5543,16 +5533,13 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
>   		return 0;
>   	}
>   
> -	align_bio = bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
> -				    &mddev->io_clone_set);
> -	md_io_clone = container_of(align_bio, struct md_io_clone, bio_clone);
> +	md_account_bio(mddev, &raid_bio);
>   	raid_bio->bi_next = (void *)rdev;
> -	if (blk_queue_io_stat(raid_bio->bi_bdev->bd_disk->queue))
> -		md_io_clone->start_time = bio_start_io_acct(raid_bio);
> -	md_io_clone->orig_bio = raid_bio;
>   
> +	align_bio = bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
> +				    &mddev->bio_set);
>   	align_bio->bi_end_io = raid5_align_endio;
> -	align_bio->bi_private = md_io_clone;
> +	align_bio->bi_private = raid_bio;
>   	align_bio->bi_iter.bi_sector = sector;
>   
>   	/* No reshape active, so we can trust rdev->data_offset */


Kind regards,

Paul
