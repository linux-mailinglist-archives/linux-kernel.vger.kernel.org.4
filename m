Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A05F8B92
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJINel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJINej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:34:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C39CF9;
        Sun,  9 Oct 2022 06:34:36 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mljb75P7VzVhqF;
        Sun,  9 Oct 2022 21:30:11 +0800 (CST)
Received: from [10.67.111.83] (10.67.111.83) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 21:34:33 +0800
Message-ID: <b725c6eb-1026-a010-1e93-50af9a96a0a4@huawei.com>
Date:   Sun, 9 Oct 2022 21:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] power: supply: mt6370: Fix Kconfig dependency
To:     ChiaEn Wu <peterwu.pub@gmail.com>, <sre@kernel.org>,
        <andy.shevchenko@gmail.com>, <chiaen_wu@richtek.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220922023337.15609-1-renzhijie2@huawei.com>
 <904af4cb-147f-a7ba-63e3-c27cad0350f2@gmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <904af4cb-147f-a7ba-63e3-c27cad0350f2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a friendly ping...

Ren

在 2022/9/22 17:58, ChiaEn Wu 写道:
> On 9/22/2022 10:33 AM, Ren Zhijie wrote:
>> If CONFIG_IIO is not set,
>> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
>> will be failed, like this:
>>
>> drivers/power/supply/mt6370-charger.o: In function 
>> `mt6370_chg_mivr_dwork_func':
>> mt6370-charger.c:(.text+0x670): undefined reference to 
>> `iio_read_channel_processed'
>> drivers/power/supply/mt6370-charger.o: In function `mt6370_chg_probe':
>> mt6370-charger.c:(.text+0xb43): undefined reference to 
>> `devm_iio_channel_get_all'
>> make: *** [vmlinux] Error 1
>>
>> To fix this build error, add depends on IIO to config CHARGER_MT6370 
>> dependency.
>>
>> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 
>> charger driver")
>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
>> ---
>>   drivers/power/supply/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 591deb82e2c6..62111f4bb093 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -623,6 +623,7 @@ config CHARGER_MT6370
>>       tristate "MediaTek MT6370 Charger Driver"
>>       depends on MFD_MT6370
>>       depends on REGULATOR
>> +    depends on IIO
>>       select LINEAR_RANGES
>>       help
>>         Say Y here to enable MT6370 Charger Part.
>
> Hi Ren,
>
> Thanks for catching this!
>
> Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>
>
