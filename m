Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAE5BBDA7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIRLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIRLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:39:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10D27DD3;
        Sun, 18 Sep 2022 04:38:57 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] md/raid10: prevent unnecessary calls to wake_up()
 in fast path
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663501136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RV6OPhI8PJKT5vEl51soNB+bv12n4mODtQRF3wFhIqY=;
        b=r0jOjpGO8JWFpzyL87wflqGOOqZrFuTd+sgMqSwQYNhIjWVUzwtE8Ef+COLFd6hA1lJ7vK
        0xp+K3NbPqmaHIeX7UKBk9wyujRiABMED+ddpV5W7uOWrxhXag35+0glUENMi6ORwA62P2
        LxzlXkH4FqrFD/lc8mzIiCsmJvTA5eg=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-4-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <5f2b0c5d-209b-9c0c-ff22-781542d5517e@linux.dev>
Date:   Sun, 18 Sep 2022 19:38:50 +0800
MIME-Version: 1.0
In-Reply-To: <20220916113428.774061-4-yukuai1@huaweicloud.com>
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
> Currently, wake_up() is called unconditionally in fast path such as
> raid10_make_request(), which will cause lock contention under high
> concurrency:
>
> raid10_make_request
>   wake_up
>    __wake_up_common_lock
>     spin_lock_irqsave
>
> Improve performance by only call wake_up() if waitqueue is not empty
> in allow_barrier() and raid10_make_request().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index df435d693637..cf452c25e1e5 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -274,6 +274,12 @@ static void put_buf(struct r10bio *r10_bio)
>   	lower_barrier(conf);
>   }
>   
> +static void wake_up_barrier(struct r10conf *conf)
> +{
> +	if (wq_has_sleeper(&conf->wait_barrier))
> +		wake_up(&conf->wait_barrier);
> +}
> +
>   static void reschedule_retry(struct r10bio *r10_bio)
>   {
>   	unsigned long flags;
> @@ -1015,7 +1021,7 @@ static void allow_barrier(struct r10conf *conf)
>   {
>   	if ((atomic_dec_and_test(&conf->nr_pending)) ||
>   			(conf->array_freeze_pending))
> -		wake_up(&conf->wait_barrier);
> +		wake_up_barrier(conf);
>   }
>   
>   static void freeze_array(struct r10conf *conf, int extra)
> @@ -1891,7 +1897,7 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
>   	__make_request(mddev, bio, sectors);
>   
>   	/* In case raid10d snuck in to freeze_array */
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   	return true;
>   }
>   

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
