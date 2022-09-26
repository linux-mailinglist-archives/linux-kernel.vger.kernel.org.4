Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C865E9D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiIZJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiIZJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:17:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50D422F8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:15:37 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbcRs5QgyzHtgp;
        Mon, 26 Sep 2022 17:10:49 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:15:35 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:15:35 +0800
Message-ID: <978a3b27-24dc-e015-cd04-4b2be16b825c@huawei.com>
Date:   Mon, 26 Sep 2022 17:15:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] [ARM] am200epd: Release platform device in case of
 platform_device_add_data() fails
From:   "linyujun (C)" <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>,
        <eric.miao@marvell.com>, <krzysztof.h1@wp.pl>,
        <jayakumar.lkml@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914033621.99499-1-linyujun809@huawei.com>
In-Reply-To: <20220914033621.99499-1-linyujun809@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

在 2022/9/14 11:36, Lin Yujun 写道:
> The platform resources need to be released when platform_device_add_data()
> fails. Release the platform device and unregister the client notifier like
> the error handling of platform_device_add().
>
> Fixes: 922613436ae5 ("[ARM] 5200/1: am200epd: use fb notifiers and gpio api")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>   arch/arm/mach-pxa/am200epd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
> index cac0bb09db14..069b90df0759 100644
> --- a/arch/arm/mach-pxa/am200epd.c
> +++ b/arch/arm/mach-pxa/am200epd.c
> @@ -370,12 +370,16 @@ int __init am200_init(void)
>   		return -ENOMEM;
>   
>   	/* the am200_board that will be seen by metronomefb is a copy */
> -	platform_device_add_data(am200_device, &am200_board,
> +	ret = platform_device_add_data(am200_device, &am200_board,
>   					sizeof(am200_board));
> +	if (ret) {
> +		platform_device_put(am200_device);
> +		fb_unregister_client(&am200_fb_notif);
> +		return ret;
> +	}
>   
>   	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
>   	ret = platform_device_add(am200_device);
> -
>   	if (ret) {
>   		platform_device_put(am200_device);
>   		fb_unregister_client(&am200_fb_notif);
