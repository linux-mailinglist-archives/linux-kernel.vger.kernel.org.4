Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016535E9D59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiIZJSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiIZJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:17:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B740E3B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:15:24 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbcSD5LXfzlXWZ;
        Mon, 26 Sep 2022 17:11:08 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:15:22 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:15:22 +0800
Message-ID: <e3852bd4-f642-31f7-0855-c65669684d98@huawei.com>
Date:   Mon, 26 Sep 2022 17:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] [ARM] am300epd: Release platform device in case of
 platform_device_add_data() fails
From:   "linyujun (C)" <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>,
        <jayakumar.lkml@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914033455.98964-1-linyujun809@huawei.com>
In-Reply-To: <20220914033455.98964-1-linyujun809@huawei.com>
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

在 2022/9/14 11:34, Lin Yujun 写道:
> The platform device need to be released when platform_device_add_data()
> fails. Use platform_device_put() to release 'pdev' in error path.
>
> Fixes: 4ce255c1420d ("[ARM] 5354/1: mach-pxa: add AM300 platform driver v3")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>   arch/arm/mach-pxa/am300epd.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
> index 4b55bc89db8f..f8542b6aa9b7 100644
> --- a/arch/arm/mach-pxa/am300epd.c
> +++ b/arch/arm/mach-pxa/am300epd.c
> @@ -275,11 +275,14 @@ int __init am300_init(void)
>   		return -ENOMEM;
>   
>   	/* the am300_board that will be seen by broadsheetfb is a copy */
> -	platform_device_add_data(am300_device, &am300_board,
> +	ret = platform_device_add_data(am300_device, &am300_board,
>   					sizeof(am300_board));
> +	if (ret) {
> +		platform_device_put(am300_device);
> +		return ret;
> +	}
>   
>   	ret = platform_device_add(am300_device);
> -
>   	if (ret) {
>   		platform_device_put(am300_device);
>   		return ret;
