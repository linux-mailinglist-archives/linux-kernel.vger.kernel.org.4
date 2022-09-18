Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E365BBDAB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIRLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIRLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:40:47 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFC1BEA0;
        Sun, 18 Sep 2022 04:40:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] md/raid10: factor out code from wait_barrier() to
 stop_waiting_barrier()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663501241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t08SrInbOJDjT7X8EVgVj14ede6g4alfa14vdQ30/d4=;
        b=iRrxbT3YV0dSVUBot0mDSMuvH15xV+/B+FDb+AjegCgkQw7DMr/k2jKcpN/qi9MXUwsU4s
        tRf09xBmvD3M8IePI2gS9t71qe36zWEMtDiOXPcYALQQaKapA5gAEQj09WW214xvweRBv+
        jef4S/gwQq9Xwvuz0uZfiQupyhm6Vu0=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-2-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <f1b32a05-ec47-cc57-9922-c917b7893547@linux.dev>
Date:   Sun, 18 Sep 2022 19:40:37 +0800
MIME-Version: 1.0
In-Reply-To: <20220916113428.774061-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 7:34 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently the nasty condition in wait_barrier() is hard to read. This
> patch factors out the condition into a function.
>
> There are no functional changes.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/md/raid10.c | 50 +++++++++++++++++++++++++--------------------
>   1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 64d6e4cd8a3a..37fd9284054e 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -957,41 +957,47 @@ static void lower_barrier(struct r10conf *conf)
>   	wake_up(&conf->wait_barrier);
>   }
>   
> +static bool stop_waiting_barrier(struct r10conf *conf)
> +{
> +	struct bio_list *bio_list = current->bio_list;
> +
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
> +	if (atomic_read(&conf->nr_pending) && bio_list &&
> +	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
> +		return true;
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
>   		conf->nr_waiting++;
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
>   		}
>   		conf->nr_waiting--;

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
