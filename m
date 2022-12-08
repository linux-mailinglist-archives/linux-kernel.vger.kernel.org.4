Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5D64710E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLHNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLHNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:53:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D93B9C6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:53:23 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NSbF92WXszRphv;
        Thu,  8 Dec 2022 21:52:29 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 21:53:21 +0800
Subject: Re: [PATCH] mfd: core: fix UAF while using device of node
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <lee@kernel.org>, <krzysztof.kozlowski@canonical.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20221116074116.1022139-1-yangyingliang@huawei.com>
Message-ID: <9ad01578-9982-fd55-14a3-a74bf0906165@huawei.com>
Date:   Thu, 8 Dec 2022 21:53:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221116074116.1022139-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/11/16 15:41, Yang Yingliang wrote:
> I got the following UAF report:
>
>    refcount_t: underflow; use-after-free.
>    WARNING: CPU: 1 PID: 270 at lib/refcount.c:29 refcount_warn_saturate+0x121/0x180
>    ...
>    OF: ERROR: memory leak, expected refcount 1 instead of -1073741824,
>    of_node_get()/of_node_put() unbalanced - destroy cset entry:
>    attach overlay node /i2c/pmic@62/powerkey
>
> The of_node of device assigned in mfd_match_of_node_to_dev() need be
> get, and it will be put in platform_device_release().
>
> Fixes: 002be8114007 ("mfd: core: Add missing of_node_put for loop iteration")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Is this patch good or do you have any suggestion ?

Thanks,
Yang
> ---
>   drivers/mfd/mfd-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 16d1861e9682..8e57f67719cf 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -161,7 +161,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>   	of_entry->np = np;
>   	list_add_tail(&of_entry->list, &mfd_of_node_list);
>   
> -	pdev->dev.of_node = np;
> +	pdev->dev.of_node = of_node_get(np);
>   	pdev->dev.fwnode = &np->fwnode;
>   #endif
>   	return 0;
