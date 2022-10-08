Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D585F8456
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJHIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:43:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F534F72
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:43:43 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MkzB03nB1zVhvG;
        Sat,  8 Oct 2022 16:39:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:43:41 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:43:41 +0800
Message-ID: <e4008fd2-86b3-c515-e9ec-40c11b28545c@huawei.com>
Date:   Sat, 8 Oct 2022 16:43:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] ARM: mmp: Add missing clk_disable_unprepare() in
 mmp_dt_init_timer()
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <olof@lixom.net>,
        <pavel@ucw.cz>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220907061454.3800923-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
In-Reply-To: <20220907061454.3800923-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/9/7 14:14, Chen Lifu 写道:
> mmp_dt_init_timer() may have called clk_prepare_enable() before return
> from failed branches, add missing clk_disable_unprepare() in these cases.
> 
> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   arch/arm/mach-mmp/time.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 41b2e8abc9e6..6d2db1fea1be 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -207,16 +207,20 @@ static int __init mmp_dt_init_timer(struct device_node *np)
>   	} else {
>   		rate = 3250000;
>   	}
>   
>   	irq = irq_of_parse_and_map(np, 0);
> -	if (!irq)
> +	if (!irq) {
> +		clk_disable_unprepare(clk);
>   		return -EINVAL;
> +	}
>   
>   	mmp_timer_base = of_iomap(np, 0);
> -	if (!mmp_timer_base)
> +	if (!mmp_timer_base) {
> +		clk_disable_unprepare(clk);
>   		return -ENOMEM;
> +	}
>   
>   	mmp_timer_init(irq, rate);
>   	return 0;
>   }
>   
friendly ping ...
