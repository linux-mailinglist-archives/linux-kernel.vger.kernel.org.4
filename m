Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D862B635920
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiKWKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiKWKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:06:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66B116A8F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:57:02 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHGjn4N33z15M0R;
        Wed, 23 Nov 2022 17:56:29 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:56:59 +0800
Message-ID: <831d07ac-1cc6-3042-a836-b634cf8af774@huawei.com>
Date:   Wed, 23 Nov 2022 17:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] regulator: core: fix kernfs complain in
 destroy_regulator()
Content-Language: en-US
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <liwei391@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221123091521.1819365-1-zengheng4@huawei.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20221123091521.1819365-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc linux-kernel-mail-list

On 2022/11/23 17:15, Zeng Heng wrote:
> Creating sysfs entry failed is non-fatal exception any more since from
> commit <222cc7b1cefb>, so when try to remove the entry in
> _regulator_put(), it had better to check kernfs_node before calling
> sysfs_remove_link().
>
> Otherwise, kernfs would complain warning as below:
>
> kernfs: can not remove 'rt5759_buck_consumer-default', no directory
> WARNING: CPU: 2 PID: 3383 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
> Call Trace:
>   _regulator_put.part.0+0xca/0x2f0
>   regulator_put+0x37/0x50
>   release_nodes+0x6a/0xa0
>   devres_release_all+0xfe/0x150
>   device_unbind_cleanup+0x19/0xd0
>   device_release_driver_internal+0x17d/0x210
>   bus_remove_device+0x1bd/0x240
>   device_del+0x356/0x780
>   platform_device_del.part.0+0x1a/0x100
>   platform_device_unregister+0x29/0x50
>
> Fixes: 222cc7b1cefb ("regulator: core: Allow multiple requests of a single supply mapping")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   drivers/regulator/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 77126cb1ae8c..ca3981681bbf 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2294,7 +2294,8 @@ static void destroy_regulator(struct regulator *regulator)
>   			device_link_remove(regulator->dev, &rdev->dev);
>   
>   		/* remove any sysfs entries */
> -		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
> +		if (rdev->dev.kobj.sd)
> +			sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
>   	}
>   
>   	regulator_lock(rdev);
