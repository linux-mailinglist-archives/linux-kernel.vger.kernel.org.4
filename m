Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1523061FEF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiKGT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiKGT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:56:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF420BF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:56:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C302261182
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD05CC433C1;
        Mon,  7 Nov 2022 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667851014;
        bh=9Gw5ielawai1k0lHkT3AtsBinr/hUjBwVfaH8303Y5A=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=QO/Db6bika00SoO8YDEQuD85vgy8uQxkoiAgeZx5DViCHkhuCFKdNykkdDN9NPtZ4
         L/TKsXzRQG02nq8Rtm2W4TOnflUvVuPeyABdG/2IerMEOz5Zogk8u+4NVuw6fN2cMn
         qizUTbgm9vZcI2x+dnothGqpJcRWP2DKcGcc7GVi631y1ARc7b9cIdx1ErXoXF7IlB
         dnJ6+F/yI7QV5mPUzI+qx7eiiK6jJEcWDGmtUTEVMrpPLk1CqJD9z5dvyF9x3SZmR5
         QArInIEP5Rd/yQcQzYkJNuB60ZOPNJsnF7+WRX5xnBoZ+0yENvjOFaSEXRQmoAlyKK
         qMHXMgxtB8bOg==
Message-ID: <5a93b446-6302-1305-071d-5d25d9f9d0a1@kernel.org>
Date:   Mon, 7 Nov 2022 13:56:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] firmware: stratix10-svc: fix error handle while
 alloc/add device failed
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, richard.gong@intel.com,
        atull@kernel.org, tien.sung.ang@intel.com
References: <20221103070951.1496435-1-yangyingliang@huawei.com>
 <20221103070951.1496435-3-yangyingliang@huawei.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221103070951.1496435-3-yangyingliang@huawei.com>
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
> If add device "stratix10-rsu" failed in stratix10_svc_drv_probe(),
> the 'svc_fifo' and 'genpool' need be freed in the error path.
> 
> If allocate or add device "intel-fcs" failed in stratix10_svc_drv_probe(),
> the device "stratix10-rsu" need be unregistered in the error path.
> 
> Fixes: e6281c26674e ("firmware: stratix10-svc: Add support for FCS")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/firmware/stratix10-svc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 1a5640b3ab42..bde1f543f529 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1202,19 +1202,20 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   	ret = platform_device_add(svc->stratix10_svc_rsu);
>   	if (ret) {
>   		platform_device_put(svc->stratix10_svc_rsu);
> -		return ret;
> +		goto err_free_kfifo;
>   	}
>   
>   	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
>   	if (!svc->intel_svc_fcs) {
>   		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_unregister_dev;
>   	}
>   
>   	ret = platform_device_add(svc->intel_svc_fcs);
>   	if (ret) {
>   		platform_device_put(svc->intel_svc_fcs);
> -		return ret;
> +		goto err_unregister_dev;
>   	}
>   
>   	dev_set_drvdata(dev, svc);
> @@ -1223,6 +1224,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_unregister_dev:
> +	platform_device_unregister(svc->stratix10_svc_rsu);
>   err_free_kfifo:
>   	kfifo_free(&controller->svc_fifo);
>   err_destroy_pool:

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
