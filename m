Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E573B477
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFWKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFWKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:24 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878F26AD;
        Fri, 23 Jun 2023 03:04:13 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBEE761E5FE03;
        Fri, 23 Jun 2023 12:03:40 +0200 (CEST)
Message-ID: <d1778341-549e-6f88-0282-3096bfcd6614@molgen.mpg.de>
Date:   Fri, 23 Jun 2023 12:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] md/raid10: optimize fix_read_error
To:     linan666@huaweicloud.com
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <20230623173236.2513554-2-linan666@huaweicloud.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230623173236.2513554-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Li,


Thank you for your patch.

Am 23.06.23 um 19:32 schrieb linan666@huaweicloud.com:
> From: Li Nan <linan122@huawei.com>
> 
> We dereference r10_bio->read_slot too many times in fix_read_error().
> Optimize it by using a variable to store read_slot.

I am always cautious reading about optimizations without any benchmarks 
or object code analysis. Although your explanation makes sense, did you 
check, that performance didn’t decrease in some way? (Maybe the compiler 
even generates the same code.)


Kind regards,

Paul


> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 381c21f7fb06..94ae294c8a3c 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2725,10 +2725,10 @@ static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
>   static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10bio *r10_bio)
>   {
>   	int sect = 0; /* Offset from r10_bio->sector */
> -	int sectors = r10_bio->sectors;
> +	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
>   	struct md_rdev *rdev;
>   	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
> -	int d = r10_bio->devs[r10_bio->read_slot].devnum;
> +	int d = r10_bio->devs[slot].devnum;
>   
>   	/* still own a reference to this rdev, so it cannot
>   	 * have been cleared recently.
> @@ -2749,13 +2749,13 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
>   			  mdname(mddev), rdev->bdev);
>   		md_error(mddev, rdev);
> -		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
> +		r10_bio->devs[slot].bio = IO_BLOCKED;
>   		return;
>   	}
>   
>   	while(sectors) {
>   		int s = sectors;
> -		int sl = r10_bio->read_slot;
> +		int sl = slot;
>   		int success = 0;
>   		int start;
>   
> @@ -2790,7 +2790,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			sl++;
>   			if (sl == conf->copies)
>   				sl = 0;
> -		} while (!success && sl != r10_bio->read_slot);
> +		} while (!success && sl != slot);
>   		rcu_read_unlock();
>   
>   		if (!success) {
> @@ -2798,16 +2798,16 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			 * as bad on the first device to discourage future
>   			 * reads.
>   			 */
> -			int dn = r10_bio->devs[r10_bio->read_slot].devnum;
> +			int dn = r10_bio->devs[slot].devnum;
>   			rdev = conf->mirrors[dn].rdev;
>   
>   			if (!rdev_set_badblocks(
>   				    rdev,
> -				    r10_bio->devs[r10_bio->read_slot].addr
> +				    r10_bio->devs[slot].addr
>   				    + sect,
>   				    s, 0)) {
>   				md_error(mddev, rdev);
> -				r10_bio->devs[r10_bio->read_slot].bio
> +				r10_bio->devs[slot].bio
>   					= IO_BLOCKED;
>   			}
>   			break;
> @@ -2816,7 +2816,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   		start = sl;
>   		/* write it back and re-read */
>   		rcu_read_lock();
> -		while (sl != r10_bio->read_slot) {
> +		while (sl != slot) {
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
> @@ -2850,7 +2850,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			rcu_read_lock();
>   		}
>   		sl = start;
> -		while (sl != r10_bio->read_slot) {
> +		while (sl != slot) {
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
