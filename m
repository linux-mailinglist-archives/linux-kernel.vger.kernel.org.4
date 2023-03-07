Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031366ADB09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjCGJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:53:31 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41B28D0D;
        Tue,  7 Mar 2023 01:53:28 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6039860027689;
        Tue,  7 Mar 2023 10:53:27 +0100 (CET)
Message-ID: <7684548b-5e6b-975b-67c2-98c686a4925f@molgen.mpg.de>
Date:   Tue, 7 Mar 2023 10:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next] radi10: fix leak of 'r10bio->remaining' for
 recovery
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230307022739.2656920-1-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230307022739.2656920-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patch.

Am 07.03.23 um 03:27 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>

There is a small typo in the prefix of the commit message summary: raid10.

It also seems common to use md/raid10 as prefix.

> raid10_sync_request() will add 'r10bio->remaining' for both rdev and
> replacement rdev. However, if the read io failed,

fails (present tense for problem description/summary)

> recovery_request_write() will return without issuring the write io, in

1.  return*s*
2.  assuring?

> this case, end_sync_request() is only called once and 'remaining' is
> leaked, which will cause io hang.

leaked, causing an io hang.

> Fix the probleming by decreasing 'remaining' according to if 'bio' and

problem

> 'repl_bio' is valid.
> 
> Fixes: 24afd80d99f8 ("md/raid10: handle recovery of replacement devices.")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index a8b5fecef136..f7002a1aa9cf 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2611,11 +2611,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   {
>   	struct r10conf *conf = mddev->private;
>   	int d;
> -	struct bio *wbio, *wbio2;
> +	struct bio *wbio = r10_bio->devs[1].bio;
> +	struct bio *wbio2 = r10_bio->devs[1].repl_bio;
> +
> +	/* Need to test wbio2->bi_end_io before we call
> +	 * submit_bio_noacct as if the former is NULL,
> +	 * the latter is free to free wbio2.
> +	 */
> +	if (wbio2 && !wbio2->bi_end_io)
> +		wbio2 = NULL;
>   
>   	if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
>   		fix_recovery_read_error(r10_bio);
> -		end_sync_request(r10_bio);
> +		if (wbio->bi_end_io)
> +			end_sync_request(r10_bio);
> +		if (wbio2)
> +			end_sync_request(r10_bio);
>   		return;
>   	}
>   
> @@ -2624,14 +2635,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   	 * and submit the write request
>   	 */
>   	d = r10_bio->devs[1].devnum;
> -	wbio = r10_bio->devs[1].bio;
> -	wbio2 = r10_bio->devs[1].repl_bio;
> -	/* Need to test wbio2->bi_end_io before we call
> -	 * submit_bio_noacct as if the former is NULL,
> -	 * the latter is free to free wbio2.
> -	 */
> -	if (wbio2 && !wbio2->bi_end_io)
> -		wbio2 = NULL;
>   	if (wbio->bi_end_io) {
>   		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>   		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));


Kind regards,

Paul
