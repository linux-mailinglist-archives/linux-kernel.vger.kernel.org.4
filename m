Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B85E5997
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiIVDWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIVDWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:22:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1B24961;
        Wed, 21 Sep 2022 20:20:31 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY0mw6xrnzWgqh;
        Thu, 22 Sep 2022 11:16:32 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:20:29 +0800
Message-ID: <c0dc4f59-c563-908b-e135-298366372857@huawei.com>
Date:   Thu, 22 Sep 2022 11:20:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
To:     Conor Dooley <conor@kernel.org>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <sudipm.mukherjee@gmail.com>,
        <arnd@arndb.de>, <linux-gpio@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <bagasdotme@gmail.com>
References: <20220915094729.646185-1-kumaravel.thiagarajan@microchip.com>
 <YytAbfmMfxNsIjcy@spud>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <YytAbfmMfxNsIjcy@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/9/22 0:48, Conor Dooley 写道:
> On Thu, Sep 15, 2022 at 03:17:29PM +0530, Kumaravel Thiagarajan wrote:
>> misc: microchip: pci1xxxx: use DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in pci1xxxx's gpio driver
>                                                                      ^^
> FYI, double space in the subject here, rather a mouthful though and
> surely everything after SIMPLE_DEV_PM_OPS() is redundant?
>
>> build errors listed below and reported by Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> for the builds of
>> riscv, s390, csky, alpha and loongarch allmodconfig are fixed in
>> this patch.
> allmodconfig has been broken for a while now, and this patch appears
> to have been sitting for a week & a second fix has shown up at:
> https://lore.kernel.org/all/20220919094250.858716-1-zengheng4@huawei.com/
>
> I do note that Zeng Hang's patch does slightly more than this one does,
> but idk about about the PM APIs /shrug.

Using 'pm_sleep_ptr' here just for telling compiler to optimize the 
struct pci1xxxx_gpio_pm_ops,

which is located in ro_data section.

~~~

0000000000000770 t pci1xxxx_gpio_irq_set_mask
00000000000008b2 t pci1xxxx_gpio_irq_unmask
0000000000000080 r pci1xxxx_gpio_pm_ops        <--
0000000000000000 t pci1xxxx_gpio_probe
0000000000000636 t pci1xxxx_gpio_set

~~~

> Has this just slipped under the radar since so many of us were
> attending conferences etc the last while or are you looking for
> Kumaravel to do something more here?

Just my fault about double check similar patch emails in the concerned area,

or maybe I would pass the warning and not send the patch.

Thanks all.


Best regards,

Zeng Heng

>
> Thanks,
> Conor.
>
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>>    311 | static int pci1xxxx_gpio_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>>    295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~
>>
>> Fixes: 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
>> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
>> ---
>> Changes in v2:
>>    - Mention as Sudip had reported in the commit description
>>      as suggested by Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>   drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
>> index 9cc771c604ed..4cd541166b0c 100644
>> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
>> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
>> @@ -405,7 +405,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
>>   	return devm_gpiochip_add_data(&aux_dev->dev, &priv->gpio, priv);
>>   }
>>   
>> -static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
>> +static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
>>   
>>   static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
>>   	{.name = "mchp_pci1xxxx_gp.gp_gpio"},
>> -- 
>> 2.25.1
>>
>>
