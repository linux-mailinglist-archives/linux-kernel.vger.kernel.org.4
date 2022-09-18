Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AC5BBDA9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIRLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:40:11 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBC140A4;
        Sun, 18 Sep 2022 04:40:10 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] md/raid10: don't modify 'nr_waitng' in
 wait_barrier() for the case nowait
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663501208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtAcz5n9Gq5Z6nHxhUIlkRTvcNCgVDAusc9EIqHo+Ao=;
        b=CfUtqDH4N7xYonCB1NH1X8s3TgQqDfjZqo5jZGOl7YLuppaRt5YLIDRP7dEHu7VylpGNuZ
        bNLRy2D0k6d8b1ERo6I6yOAg/6SygltF0vK3PQQrKp3wWw9yGKGu2qm4FIsys6sE2MtOy5
        zvOnjkMJr5Q9jhrVEG6xzjVoww/DT+s=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-3-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <fbf58ad3-2eff-06df-6426-3b4629408e94@linux.dev>
Date:   Sun, 18 Sep 2022 19:40:04 +0800
MIME-Version: 1.0
In-Reply-To: <20220916113428.774061-3-yukuai1@huaweicloud.com>
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
> For the case nowait in wait_barrier(), there is no point to increase
> nr_waiting and then decrease it.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 37fd9284054e..df435d693637 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -990,17 +990,17 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
>   
>   	spin_lock_irq(&conf->resync_lock);
>   	if (conf->barrier) {
> -		conf->nr_waiting++;
>   		/* Return false when nowait flag is set */
>   		if (nowait) {
>   			ret = false;
>   		} else {
> +			conf->nr_waiting++;
>   			raid10_log(conf->mddev, "wait barrier");
>   			wait_event_lock_irq(conf->wait_barrier,
>   					    stop_waiting_barrier(conf),
>   					    conf->resync_lock);
> +			conf->nr_waiting--;
>   		}
> -		conf->nr_waiting--;
>   		if (!conf->nr_waiting)
>   			wake_up(&conf->wait_barrier);
>   	}

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
