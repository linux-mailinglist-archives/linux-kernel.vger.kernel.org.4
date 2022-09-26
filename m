Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D85E9D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiIZJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiIZJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:14:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D963A6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:14:39 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbcRZ0nm7zWh64;
        Mon, 26 Sep 2022 17:10:34 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:37 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:36 +0800
Message-ID: <fe9cc0b0-eec0-ce43-e424-2f8b835088a4@huawei.com>
Date:   Mon, 26 Sep 2022 17:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] ARM pxa2xx: Add missing platform_device_put() in
 pxa2xx_set_spi_info()
From:   "linyujun (C)" <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>, <lg@denx.de>,
        <eric.miao@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914033317.98469-1-linyujun809@huawei.com>
In-Reply-To: <20220914033317.98469-1-linyujun809@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

在 2022/9/14 11:33, Lin Yujun 写道:
> In error case in pxa2xx_set_spi_info() after calling
> platform_device_add(), the failed 'pdev' need to be
> release or it will be leak, call platform_device_put()
> to fix this problem.
>
> Fixes: e172274ccc55 ("[ARM] 5088/3: pxa2xx: add pxa2xx_set_spi_info to register pxa2xx-spi platform devices")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>   arch/arm/mach-pxa/devices.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index a7b92dd1ca9e..2727f0138758 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -1087,7 +1087,11 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
>   	}
>   
>   	pd->dev.platform_data = info;
> -	platform_device_add(pd);
> +	if (platform_device_add(pd)) {
> +		printk(KERN_ERR "pxa2xx-spi: failed to add platform device %d\n",
> +			id);
> +		platform_device_put(pd);
> +	}
>   }
>   
>   static struct resource pxa_dma_resource[] = {
