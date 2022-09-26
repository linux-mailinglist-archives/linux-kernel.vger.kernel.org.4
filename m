Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4925E9D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiIZJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiIZJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:14:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207244056B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:14:26 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbcTP2y7gzHqS5;
        Mon, 26 Sep 2022 17:12:09 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:24 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:24 +0800
Message-ID: <33e0b148-198c-b2f1-92d4-f6267fd0436f@huawei.com>
Date:   Mon, 26 Sep 2022 17:14:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] pxa: Release platform device in case of
 platform_device_add() fails.
From:   "linyujun (C)" <linyujun809@huawei.com>
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <eric.miao@marvell.com>, <chagas@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914032437.95609-1-linyujun809@huawei.com>
In-Reply-To: <20220914032437.95609-1-linyujun809@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping

在 2022/9/14 11:24, Lin Yujun 写道:
> The platform device is not released when platform_device_add()
> fails. Use platform_device_put() to release these resource.
>
> Fixes: 49cbe78637eb ("[ARM] pxa: add base support for Marvell's PXA168 processor line")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>   arch/arm/mach-mmp/devices.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
> index 79f4a2aa5475..e918f419bc4c 100644
> --- a/arch/arm/mach-mmp/devices.c
> +++ b/arch/arm/mach-mmp/devices.c
> @@ -53,20 +53,23 @@ int __init mmp_register_device(struct mmp_device_desc *desc,
>   	}
>   
>   	ret = platform_device_add_resources(pdev, res, nres);
> -	if (ret) {
> -		platform_device_put(pdev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_put_pdev;
>   
>   	if (data && size) {
>   		ret = platform_device_add_data(pdev, data, size);
> -		if (ret) {
> -			platform_device_put(pdev);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_put_pdev;
>   	}
>   
> -	return platform_device_add(pdev);
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err_put_pdev;
> +	return ret;
> +
> +err_put_pdev:
> +	platform_device_put(pdev);
> +	return ret;
>   }
>   
>   #if IS_ENABLED(CONFIG_USB) || IS_ENABLED(CONFIG_USB_GADGET)
