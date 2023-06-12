Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0848172B957
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjFLH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjFLH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:56:35 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48D16AD;
        Mon, 12 Jun 2023 00:55:43 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cx8OhCz4Zkno8DAA--.5867S3;
        Mon, 12 Jun 2023 15:54:42 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxVeRBz4Zkb0gVAA--.61490S3;
        Mon, 12 Jun 2023 15:54:41 +0800 (CST)
Subject: Re: [PATCH v2 3/3] soc: loongson2_pm: add power management support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522093320.7176-1-zhuyinbo@loongson.cn>
 <CAAhV-H5wF28E5k+uHvPP1xErr=v=icTSMWdygfd4pYdwiBk=LA@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <f2aaa71e-c8c0-1ab7-2338-328759ca5f9f@loongson.cn>
Date:   Mon, 12 Jun 2023 15:54:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5wF28E5k+uHvPP1xErr=v=icTSMWdygfd4pYdwiBk=LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxVeRBz4Zkb0gVAA--.61490S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/12 下午12:36, Huacai Chen 写道:
> Hi, Yinbo,
> 
> On Mon, May 22, 2023 at 5:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>> The Loongson-2's Power Management Controller was ACPI, supports ACPI
>> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
>> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>> (USB, GMAC, PWRBTN, etc.). This driver was to add Power Management
>> Controller support that base on dts for Loongson-2 series SoCs.
>>
>> Signed-off-by: Liu Yun <liuyun@loongson.cn>
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   MAINTAINERS                         |   1 +
>>   drivers/soc/loongson/Kconfig        |  10 ++
>>   drivers/soc/loongson/Makefile       |   1 +
>>   drivers/soc/loongson/loongson2_pm.c | 235 ++++++++++++++++++++++++++++
>>   4 files changed, 247 insertions(+)
>>   create mode 100644 drivers/soc/loongson/loongson2_pm.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bcd05f1fa5c1..7c4ad0cbaeff 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12195,6 +12195,7 @@ M:      Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:     linux-pm@vger.kernel.org
>>   S:     Maintained
>>   F:     Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>> +F:     drivers/soc/loongson/loongson2_pm.c
>>
>>   LOONGSON-2 SOC SERIES PINCTRL DRIVER
>>   M:     zhanghongchen <zhanghongchen@loongson.cn>
>> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
>> index 707f56358dc4..2431a0bcbd84 100644
>> --- a/drivers/soc/loongson/Kconfig
>> +++ b/drivers/soc/loongson/Kconfig
>> @@ -16,3 +16,13 @@ config LOONGSON2_GUTS
>>           SoCs. Initially only reading SVR and registering soc device are
>>           supported. Other guts accesses, such as reading firmware configuration
>>           by default, should eventually be added into this driver as well.
>> +
>> +config LOONGSON2_PM
>> +       bool "Loongson-2 SoC Power Management Controller Driver"
>> +       depends on LOONGARCH && OF
>> +       help
>> +        The Loongson-2's Power Management Controller was ACPI, supports ACPI
>> +        S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
>> +        Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>> +        (USB, GMAC, PWRBTN, etc.). This driver was to add Power Management
>> +        Controller support that base on dts for Loongson-2 series SoCs.
>> diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
>> index 263c486df638..4118f50f55e2 100644
>> --- a/drivers/soc/loongson/Makefile
>> +++ b/drivers/soc/loongson/Makefile
>> @@ -4,3 +4,4 @@
>>   #
>>
>>   obj-$(CONFIG_LOONGSON2_GUTS)           += loongson2_guts.o
>> +obj-$(CONFIG_LOONGSON2_PM)             += loongson2_pm.o
>> diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/loongson2_pm.c
>> new file mode 100644
>> index 000000000000..cd96a1ebbb6c
>> --- /dev/null
>> +++ b/drivers/soc/loongson/loongson2_pm.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Loongson-2 PM Support
>> + *
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/init.h>
>> +#include <linux/input.h>
>> +#include <linux/suspend.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/pm_wakeirq.h>
>> +#include <linux/platform_device.h>
>> +#include <asm/bootinfo.h>
>> +#include <asm/suspend.h>
>> +
>> +#define LOONGSON2_PM1_CNT_REG          0x14
>> +#define LOONGSON2_PM1_STS_REG          0x0c
>> +#define LOONGSON2_PM1_ENA_REG          0x10
>> +#define LOONGSON2_GPE0_STS_REG         0x28
>> +#define LOONGSON2_GPE0_ENA_REG         0x2c
>> +
>> +#define LOONGSON2_PM1_PWRBTN_STS       BIT(8)
>> +#define LOONGSON2_PM1_PCIEXP_WAKE_STS  BIT(14)
>> +#define LOONGSON2_PM1_WAKE_STS         BIT(15)
>> +#define LOONGSON2_PM1_CNT_INT_EN       BIT(0)
>> +#define LOONGSON2_PM1_PWRBTN_EN                LOONGSON2_PM1_PWRBTN_STS
>> +
>> +static struct loongson2_pm {
>> +       void __iomem                    *base;
>> +       struct input_dev                *dev;
>> +       bool                            suspended;
>> +} loongson2_pm;
>> +
>> +#define loongson2_pm_readw(reg)                readw(loongson2_pm.base + reg)
>> +#define loongson2_pm_readl(reg)                readl(loongson2_pm.base + reg)
>> +#define loongson2_pm_writew(val, reg)  writew(val, loongson2_pm.base + reg)
>> +#define loongson2_pm_writel(val, reg)  writel(val, loongson2_pm.base + reg)
>> +
>> +static void loongson2_pm_status_clear(void)
>> +{
>> +       u16 value;
>> +
>> +       value = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
>> +       value |= (LOONGSON2_PM1_PWRBTN_STS | LOONGSON2_PM1_PCIEXP_WAKE_STS |
>> +                 LOONGSON2_PM1_WAKE_STS);
>> +       loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
>> +       loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG),
>> +                           LOONGSON2_GPE0_STS_REG);
>> +}
>> +
>> +static void loongson2_pm_irq_enable(void)
>> +{
>> +       u16 value;
>> +
>> +       value = loongson2_pm_readw(LOONGSON2_PM1_CNT_REG);
>> +       value |= LOONGSON2_PM1_CNT_INT_EN;
>> +       loongson2_pm_writew(value, LOONGSON2_PM1_CNT_REG);
>> +}
>> +
>> +static void loongson2_pm_pwrbtn_irq_enable(void)
>> +{
>> +       u16 value;
>> +
>> +       loongson2_pm_irq_enable();
>> +
>> +       value = loongson2_pm_readw(LOONGSON2_PM1_ENA_REG);
>> +       value |= LOONGSON2_PM1_PWRBTN_EN;
>> +       loongson2_pm_writew(value, LOONGSON2_PM1_ENA_REG);
>> +}
> You can combine these two functions as loongson2_power_button_irq_enable().


okay, I got it.

> 
>> +
>> +static void loongson2_pm_mach_resume(void)
>> +{
>> +       loongson_common_resume();
>> +       loongson2_pm_irq_enable();
>> +}
>> +
>> +static void loongson2_pm_mach_suspend(void)
>> +{
>> +       loongson2_pm_status_clear();
>> +       loongson_common_suspend();
>> +}
>> +
>> +static int loongson2_suspend_enter(suspend_state_t state)
>> +{
>> +       loongson2_pm_mach_suspend();
>> +       loongson_suspend_enter();
>> +       pm_set_resume_via_firmware();
>> +       loongson2_pm_mach_resume();
>> +
>> +       return 0;
>> +}
> After some thinkings, I found these three simple function can be combined as:
> static int loongson2_suspend_enter(suspend_state_t state)
> {
>         loongson2_pm_status_clear();
>         loongson_common_suspend();
>         loongson_suspend_enter();
>         loongson_common_resume();
>         loongson2_pm_irq_enable();
>         pm_set_resume_via_firmware();
> 
>         return 0;
> }
> 
> After this combining,
> loongson_common_suspend()/loongson_suspend_enter()/loongson_common_resume()
> can be still use the old naming
> loongarch_common_suspend()/loongarch_suspend_enter()/loongarch_common_resume().
> 


okay, I got it.

>> +
>> +static int loongson2_suspend_begin(suspend_state_t state)
>> +{
>> +       pm_set_suspend_via_firmware();
>> +
>> +       return 0;
>> +}
>> +
>> +static int loongson2_suspend_valid_state(suspend_state_t state)
>> +{
>> +       if (state == PM_SUSPEND_MEM)
>> +               return !!loongson_sysconf.suspend_addr;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct platform_suspend_ops loongson2_suspend_ops = {
>> +       .valid  = loongson2_suspend_valid_state,
>> +       .begin  = loongson2_suspend_begin,
>> +       .enter  = loongson2_suspend_enter,
>> +};
>> +
>> +static int loongson2_pm_pwrbtn_init(struct device *dev, int irq)
>> +{
>> +       int ret;
>> +       struct input_dev *pwrbt;
> Rename  loongson2_pm_pwrbtn_init() to  loongson2_power_button_init()
> and rename 'pwrbt' to 'pwrbtn' or just 'button' is better.


okay, I got it.

Thanks,
Yinbo

