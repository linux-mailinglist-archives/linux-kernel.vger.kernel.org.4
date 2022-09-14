Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10565B8187
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiINGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiINGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:36:48 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22C38444;
        Tue, 13 Sep 2022 23:36:46 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef39.dynamic.kabel-deutschland.de [95.90.239.57])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B8A2561EA192A;
        Wed, 14 Sep 2022 08:36:43 +0200 (CEST)
Message-ID: <0b67df9e-7f64-e710-5928-2098ed8d0f2d@molgen.mpg.de>
Date:   Wed, 14 Sep 2022 08:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/4] md/raid10: cleanup wait_barrier()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220914014914.398712-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for the improved patch. Three minor nits.

Am 14.09.22 um 03:49 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>

In the summary/title, I’d spell *Clean up* with a space. Maybe even use:

md/raid10: Factor out code from wait_barrier() to stop_waiting_barrier()

> Currently the nasty condition is wait_barrier() is hard to read. This
> patch factor out the condition into a function.

The first *is* above can be removed, and factor*s* needs an s.
> There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 56 ++++++++++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 64d6e4cd8a3a..56458a53043d 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -957,44 +957,52 @@ static void lower_barrier(struct r10conf *conf)
>   	wake_up(&conf->wait_barrier);
>   }
>   
> +static bool stop_waiting_barrier(struct r10conf *conf)
> +{
> +	/* barrier is dropped */
> +	if (!conf->barrier)
> +		return true;
> +
> +	/*
> +	 * If there are already pending requests (preventing the barrier from
> +	 * rising completely), and the pre-process bio queue isn't empty, then
> +	 * don't wait, as we need to empty that queue to get the nr_pending
> +	 * count down.
> +	 */
> +	if (atomic_read(&conf->nr_pending)) {
> +		struct bio_list *bio_list = current->bio_list;
> +
> +		if (bio_list && (!bio_list_empty(&bio_list[0]) ||
> +				 !bio_list_empty(&bio_list[1])))
> +			return true;
> +	}
> +
> +	/* move on if recovery thread is blocked by us */
> +	if (conf->mddev->thread->tsk == current &&
> +	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
> +	    conf->nr_queued > 0)
> +		return true;
> +
> +	return false;
> +}
> +
>   static bool wait_barrier(struct r10conf *conf, bool nowait)
>   {
>   	bool ret = true;
>   
>   	spin_lock_irq(&conf->resync_lock);
>   	if (conf->barrier) {
> -		struct bio_list *bio_list = current->bio_list;
> -		conf->nr_waiting++;
> -		/* Wait for the barrier to drop.
> -		 * However if there are already pending
> -		 * requests (preventing the barrier from
> -		 * rising completely), and the
> -		 * pre-process bio queue isn't empty,
> -		 * then don't wait, as we need to empty
> -		 * that queue to get the nr_pending
> -		 * count down.
> -		 */
>   		/* Return false when nowait flag is set */
>   		if (nowait) {
>   			ret = false;
>   		} else {
> +			conf->nr_waiting++;
>   			raid10_log(conf->mddev, "wait barrier");
>   			wait_event_lock_irq(conf->wait_barrier,
> -					    !conf->barrier ||
> -					    (atomic_read(&conf->nr_pending) &&
> -					     bio_list &&
> -					     (!bio_list_empty(&bio_list[0]) ||
> -					      !bio_list_empty(&bio_list[1]))) ||
> -					     /* move on if recovery thread is
> -					      * blocked by us
> -					      */
> -					     (conf->mddev->thread->tsk == current &&
> -					      test_bit(MD_RECOVERY_RUNNING,
> -						       &conf->mddev->recovery) &&
> -					      conf->nr_queued > 0),
> +					    stop_waiting_barrier(conf),
>   					    conf->resync_lock);
> +			conf->nr_waiting--;
>   		}
> -		conf->nr_waiting--;
>   		if (!conf->nr_waiting)
>   			wake_up(&conf->wait_barrier);
>   	}

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
