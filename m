Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3575E9D18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiIZJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiIZJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:14:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02B402C6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:14:07 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbcT25zCJzHqSv;
        Mon, 26 Sep 2022 17:11:50 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:05 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:14:05 +0800
Message-ID: <99fd22ab-1b14-55bc-8bb7-dc26f1f454af@huawei.com>
Date:   Mon, 26 Sep 2022 17:14:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] powerpc: Avoid platform device Leak in the event of
 platform_device_add() fails
From:   "linyujun (C)" <linyujun809@huawei.com>
To:     <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <Julia.Lawall@inria.fr>, <joel@jms.id.au>, <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20220914032659.96388-1-linyujun809@huawei.com>
In-Reply-To: <20220914032659.96388-1-linyujun809@huawei.com>
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

在 2022/9/14 11:26, Lin Yujun 写道:
> Use platform_device_put() to free the platform device and return
> directly in the event platform_device_add() fails.
>
> Fixes: a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>   arch/powerpc/platforms/powermac/low_i2c.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index c1c430c66dc9..5171635c3450 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1487,6 +1487,7 @@ static int __init pmac_i2c_create_platform_devices(void)
>   {
>   	struct pmac_i2c_bus *bus;
>   	int i = 0;
> +	int ret;
>   
>   	/* In the case where we are initialized from smp_init(), we must
>   	 * not use the timer (and thus the irq). It's safe from now on
> @@ -1502,7 +1503,11 @@ static int __init pmac_i2c_create_platform_devices(void)
>   			return -ENOMEM;
>   		bus->platform_dev->dev.platform_data = bus;
>   		bus->platform_dev->dev.of_node = bus->busnode;
> -		platform_device_add(bus->platform_dev);
> +		ret = platform_device_add(bus->platform_dev);
> +		if (ret) {
> +			platform_device_put(bus->platform_dev);
> +			return ret;
> +		}
>   	}
>   
>   	/* Now call platform "init" functions */
