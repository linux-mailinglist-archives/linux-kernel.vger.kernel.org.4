Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81EA620E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiKHLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiKHLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:17:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B917E1F;
        Tue,  8 Nov 2022 03:17:35 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N65D55WTLzRp4y;
        Tue,  8 Nov 2022 19:17:25 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:17:32 +0800
Subject: Re: [PATCH next 1/2] gpio: hisi: Add initial device tree support
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <f.fangjian@huawei.com>, <yangyicong@hisilicon.com>,
        <xuwei5@huawei.com>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20221026034219.172880-1-chenweilong@huawei.com>
 <CACRpkdbfZoBsKhH-fDHbuiBMz=LuWJ5kRfRT9JupycJQLFzJZw@mail.gmail.com>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <33794563-ae4b-87e5-09df-d800268828f8@huawei.com>
Date:   Tue, 8 Nov 2022 19:17:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbfZoBsKhH-fDHbuiBMz=LuWJ5kRfRT9JupycJQLFzJZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.106]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/8 18:33, Linus Walleij wrote:
> Hi Weilong,
>
> thanks for your patch!
>
> On Wed, Oct 26, 2022 at 5:34 AM Weilong Chen <chenweilong@huawei.com> wrote:
>
>> Add support for HiSilicon GPIO controller in embedded platform, which
>> boot from devicetree.
>>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> I will provide OF comments, I let Andy and other ACPI experts say
> what is necessary for ACPI.
>
> (...)
>> +#include <linux/acpi.h>
> I don't know if this is necessary, check it.
>
>>  #include <linux/gpio/driver.h>
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>> +#include <linux/of.h>
> This is unnecessary for what you are trying to do. Drop it.
>
>> +#ifdef CONFIG_ACPI
>>  static const struct acpi_device_id hisi_gpio_acpi_match[] = {
>>         {"HISI0184", 0},
>>         {}
>>  };
>>  MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
>> +#endif
> Don't know about this #ifdef, check if it is needed.
>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id hisi_gpio_dts_match[] = {
>> +       { .compatible = "hisilicon,gpio-ascend910", },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
>> +#endif
> Drop the ifdef, it is not needed.
>
>>  static void hisi_gpio_get_pdata(struct device *dev,
>>                                 struct hisi_gpio *hisi_gpio)
>> @@ -310,7 +322,8 @@ static int hisi_gpio_probe(struct platform_device *pdev)
>>  static struct platform_driver hisi_gpio_driver = {
>>         .driver         = {
>>                 .name   = HISI_GPIO_DRIVER_NAME,
>> -               .acpi_match_table = hisi_gpio_acpi_match,
>> +               .acpi_match_table = ACPI_PTR(hisi_gpio_acpi_match),
>> +               .of_match_table = of_match_ptr(hisi_gpio_dts_match),
> Drop of_match_ptr() just assign it.
>
> The reason it works is because we put struct of_device_id into the generic
> headers so we can avoid the ifdefing.
>
> Yours,
> Linus Walleij

Thank for your review，I get it，and make  improvements in subsequent patches.


Best regards,

Weilong Chen.

> .


