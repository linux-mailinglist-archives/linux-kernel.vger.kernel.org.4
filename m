Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE285BB590
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIQC21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIQC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:28:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E4BBBA5B;
        Fri, 16 Sep 2022 19:28:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTvrG73dZzNm74;
        Sat, 17 Sep 2022 10:23:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 10:28:20 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 10:28:20 +0800
Subject: Re: [PATCH -next 1/2] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>
References: <20220915151438.699763-1-yangyingliang@huawei.com>
 <20220916190114.nnzc54nvv76jbd7k@soft-dev3-1.localhost>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <af4a818f-a182-79ee-d030-ee70ac181c05@huawei.com>
Date:   Sat, 17 Sep 2022 10:28:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220916190114.nnzc54nvv76jbd7k@soft-dev3-1.localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/17 3:01, Horatiu Vultur wrote:
> The 09/15/2022 23:14, Yang Yingliang wrote:
>
> Hi Yang,
>
>> Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
>> in error path.
>>
>> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/pinctrl/pinctrl-ocelot.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
>> index d9c0184c077f..83703a3d291c 100644
>> --- a/drivers/pinctrl/pinctrl-ocelot.c
>> +++ b/drivers/pinctrl/pinctrl-ocelot.c
>> @@ -2072,15 +2072,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>>          info->pincfg_data = &data->pincfg_data;
>>
>>          reset = devm_reset_control_get_optional_shared(dev, "switch");
>> -       if (IS_ERR(reset))
>> -               return dev_err_probe(dev, PTR_ERR(reset),
>> -                                    "Failed to get reset\n");
>> +       if (IS_ERR(reset)) {
>> +               ret = dev_err_probe(dev, PTR_ERR(reset),
>> +                                   "Failed to get reset\n");
>> +               goto err_out;
>> +       }
>>          reset_control_reset(reset);
>>
>>          base = devm_ioremap_resource(dev,
>>                          platform_get_resource(pdev, IORESOURCE_MEM, 0));
>> -       if (IS_ERR(base))
>> -               return PTR_ERR(base);
>> +       if (IS_ERR(base)) {
>> +               ret = PTR_ERR(base);
>> +               goto err_out;
>> +       }
>>
>>          info->stride = 1 + (info->desc->npins - 1) / 32;
>>
>> @@ -2089,7 +2093,8 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>>          info->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>>          if (IS_ERR(info->map)) {
>>                  dev_err(dev, "Failed to create regmap\n");
>> -               return PTR_ERR(info->map);
>> +               ret = PTR_ERR(info->map);
>> +               goto err_out;
>>          }
>>          dev_set_drvdata(dev, info);
>>          info->dev = dev;
>> @@ -2105,15 +2110,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>>
>>          ret = ocelot_pinctrl_register(pdev, info);
>>          if (ret)
>> -               return ret;
>> +               goto err_out;
> Wouldn't be better actually to add the allocation of the workqueue here?
> In this way, you will not need all the previous changes.
Yes, thanks.

Yang
>>          ret = ocelot_gpiochip_register(pdev, info);
>>          if (ret)
>> -               return ret;
>> +               goto err_out;
>>
>>          dev_info(dev, "driver registered\n");
>>
>>          return 0;
>> +
>> +err_out:
>> +       destroy_workqueue(info->wq);
>> +       return ret;
>>   }
>>
>>   static int ocelot_pinctrl_remove(struct platform_device *pdev)
>> --
>> 2.25.1
>>
