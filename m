Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9863239F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKUNcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKUNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:32:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD06E3F;
        Mon, 21 Nov 2022 05:32:25 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG7WK6pH6zqSXM;
        Mon, 21 Nov 2022 21:28:29 +0800 (CST)
Received: from [10.67.111.83] (10.67.111.83) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 21:32:22 +0800
Message-ID: <4b0ca9bc-00ba-1055-8bd9-68affd47b1bd@huawei.com>
Date:   Mon, 21 Nov 2022 21:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] pinctrl: pinctrl-loongson2: fix Kconfig dependency
To:     <linus.walleij@linaro.or>, <zhanghongchen@loongson.cn>,
        <zhuyinbo@loongson.cn>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>
References: <20221121131422.217806-1-renzhijie2@huawei.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <20221121131422.217806-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

     I misspell the email address of linus, please ignore this email. 
Thanks.

Ren

在 2022/11/21 21:14, Ren Zhijie 写道:
> If CONFIG_PINCTRL_LOONGSON2=y and CONFIG_OF is not set,
> gcc complained about undefined reference:
>
> drivers/pinctrl/pinctrl-loongson2.o: In function `pinconf_generic_dt_node_to_map_all':
> pinctrl-loongson2.c:(.text+0x1c4): undefined reference to
> `pinconf_generic_dt_node_to_map'
>
> To fix this error, add depends on OF to
> config PINCTRL_LOONGSON2.
>
> Fixes: f73f88acbc18 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   drivers/pinctrl/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 35f167f70829..7d5f5458c72e 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -260,7 +260,7 @@ config PINCTRL_FALCON
>   
>   config PINCTRL_LOONGSON2
>   	tristate "Pinctrl driver for the Loongson-2 SoC"
> -	depends on LOONGARCH || COMPILE_TEST
> +	depends on OF && (LOONGARCH || COMPILE_TEST)
>   	select PINMUX
>   	select GENERIC_PINCONF
>   	help
