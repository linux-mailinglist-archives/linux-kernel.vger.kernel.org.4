Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6C61FEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKGT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiKGT4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:56:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10320BF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF3961182
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C91C433D6;
        Mon,  7 Nov 2022 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667851001;
        bh=54qh8Q5rz3caqRQgSG/G1B1BGBHhJD+bILGYWgI+c7o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=R3eo68l5gsZpokmHHPQLTtFsrRObn199sCDfXczznBWYjFcKBKlwzTi8vTduFNIhb
         AGNqKxYYN1iNBKAGSl9LK1nEtscO/AHmkWQ1jfZBALezq6CVbptD2v6DDTCNz4/Hgu
         Fy1Katk4H3V8Oj4IgzYtxmm1wGXiZYArZTFphwxa7fb/pM67JneXXctNBf+CkNV2xV
         aoDdwRWsV60cufCtrzIRk9YvNiIz9EVCJG0jeHkepV2VS2UhoNIEFkeqEergcUBXyF
         zQH3aSeRtF1N1yH079TkOwzKz9ac59e8ucNXllkKWdQCXXPaQxItaehqzTFv7u3iNS
         l5Y6vEGJVMRKA==
Message-ID: <83accdc8-2a6f-fa7c-ed82-a7cafc3eda39@kernel.org>
Date:   Mon, 7 Nov 2022 13:56:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] firmware: stratix10-svc: add missing
 gen_pool_destroy() in stratix10_svc_drv_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, richard.gong@intel.com,
        atull@kernel.org, tien.sung.ang@intel.com
References: <20221103070951.1496435-1-yangyingliang@huawei.com>
 <20221103070951.1496435-2-yangyingliang@huawei.com>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221103070951.1496435-2-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/22 02:09, Yang Yingliang wrote:
> In error path in stratix10_svc_drv_probe(), gen_pool_destroy() should be called
> to destroy the memory pool that created by svc_create_memory_pool().
> 
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/firmware/stratix10-svc.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index b4081f4d88a3..1a5640b3ab42 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1138,13 +1138,17 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   
>   	/* allocate service controller and supporting channel */
>   	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
> -	if (!controller)
> -		return -ENOMEM;
> +	if (!controller) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pool;
> +	}
>   
>   	chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
>   				   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
> -	if (!chans)
> -		return -ENOMEM;
> +	if (!chans) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pool;
> +	}
>   
>   	controller->dev = dev;
>   	controller->num_chans = SVC_NUM_CHANNEL;
> @@ -1159,7 +1163,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
>   	if (ret) {
>   		dev_err(dev, "failed to allocate FIFO\n");
> -		return ret;
> +		goto err_destroy_pool;
>   	}
>   	spin_lock_init(&controller->svc_fifo_lock);
>   
> @@ -1221,6 +1225,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   
>   err_free_kfifo:
>   	kfifo_free(&controller->svc_fifo);
> +err_destroy_pool:
> +	gen_pool_destroy(genpool);
>   	return ret;
>   }
>   

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
