Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55735BBDA4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIRLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:40 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9C252B3;
        Sun, 18 Sep 2022 04:37:38 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] md/raid10: fix improper BUG_ON() in
 raise_barrier()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663501057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zkg5e+PHceNZNg0PfBlFTwBxQxADGWdN9+rCaCAkYlM=;
        b=mfT+D2nxiCzvo3fJ3QoWnGc6r0jfDZU9yXbVDhyXeKFNzrftoqWvBF/mbPqiuFCmLuKMQG
        /IDQKGH2YdOvD7eG0JCoLsPTlOJt6zj5iXNxXKHOITYa/Edihggr6CdDu0rWBnit5wIvWx
        Cmh6WiveHm/12X8S59i5fgjNovg7gQI=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-5-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <e6055714-d6da-3dac-8776-281602ffb099@linux.dev>
Date:   Sun, 18 Sep 2022 19:37:25 +0800
MIME-Version: 1.0
In-Reply-To: <20220916113428.774061-5-yukuai1@huaweicloud.com>
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
> 'conf->barrier' is protected by 'conf->resync_lock', reading
> 'conf->barrier' without holding the lock is wrong.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index cf452c25e1e5..9a28abd19709 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -936,8 +936,8 @@ static void flush_pending_writes(struct r10conf *conf)
>   
>   static void raise_barrier(struct r10conf *conf, int force)
>   {
> -	BUG_ON(force && !conf->barrier);
>   	spin_lock_irq(&conf->resync_lock);
> +	BUG_ON(force && !conf->barrier);
>   
>   	/* Wait until no block IO is waiting (unless 'force') */
>   	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
