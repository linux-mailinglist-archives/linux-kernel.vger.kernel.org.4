Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B97324CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFPBqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbjFPBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:46:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12DC430CF;
        Thu, 15 Jun 2023 18:45:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxKurKvotkZckFAA--.12326S3;
        Fri, 16 Jun 2023 09:45:46 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeTJvotkZLocAA--.16087S3;
        Fri, 16 Jun 2023 09:45:45 +0800 (CST)
Subject: Re: [PATCH v3 3/3] soc: loongson2_pm: add power management support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
 <CAAhV-H4Z13wpOsj5GxkuwMK1D6N6=sArQ52yHjcdiEen=dUpjg@mail.gmail.com>
 <9edfe58a-7901-c2d1-8e01-5f10b3a51287@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <a9292d85-83b5-5b43-6c2a-7e393213c6c9@loongson.cn>
Date:   Fri, 16 Jun 2023 09:45:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9edfe58a-7901-c2d1-8e01-5f10b3a51287@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeTJvotkZLocAA--.16087S3
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


Hi huacai,


在 2023/6/15 下午7:15, zhuyinbo 写道:
> 
> 
> 在 2023/6/15 下午6:00, Huacai Chen 写道:
> 
>>> +static void loongson2_pm_status_clear(void)
>>> +{
>>> +       u16 value;
>>> +
>>> +       value = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
>>> +       value |= (LOONGSON2_PM1_PWRBTN_STS | 
>>> LOONGSON2_PM1_PCIEXP_WAKE_STS |
>>> +                 LOONGSON2_PM1_WAKE_STS);
>>> +       loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
>>> +       loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG),
>>> +                           LOONGSON2_GPE0_STS_REG);
>> Long-line warnings is removed in latest kernel, so you don't need to 
>> split here.
> 
> 
> okay, I got it.
> 
>>
>>> +}
>>> +
>>> +static void loongson2_power_button_irq_enable(void)
>>
>> Using loongson2_pm_irq_enable is a little better.
> 
> 

Previously, you suggested that I combine loongson2_pm_irq_enable() and
power button irq enable code as loongson2_power_button_irq_enable, then
I remove the function loongson2_pm_irq_enable, in this case that I won't
be able to call loongson2_pm_irq_enable, so have I misunderstood your
meaning ? or only rename loongson2_power_button_irq_enable as
loongson2_pm_irq_enable ?

Thanks,
Yinbo

> 
> ...
> 
>>> +static int loongson2_suspend_valid_state(suspend_state_t state)
>>> +{
>>> +       if (state == PM_SUSPEND_MEM)
>>> +               return 1;
>>> +
>>> +       return 0;
>> "return (state == PM_SUSPEND_MEM)" is enough.
> 
> 
> okay, I got it.
> 
> 
> Thanks,
> Yinbo
> 

