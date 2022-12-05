Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8266422E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLEGEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEGEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:04:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C1F3E021;
        Sun,  4 Dec 2022 22:04:11 -0800 (PST)
Received: from loongson.cn (unknown [117.133.84.183])
        by gateway (Coremail) with SMTP id _____8CxZPDbiY1jmDUDAA--.7361S3;
        Mon, 05 Dec 2022 14:04:11 +0800 (CST)
Received: from [192.168.1.2] (unknown [117.133.84.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5VbZiY1jCcglAA--.8830S3;
        Mon, 05 Dec 2022 14:04:10 +0800 (CST)
Message-ID: <899d9d4c-36e8-6a4f-4243-dcf16f9ef29f@loongson.cn>
Date:   Mon, 5 Dec 2022 14:04:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
 <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
 <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn>
 <Y4tq4i2CJdnQWFZC@smile.fi.intel.com> <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
In-Reply-To: <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5VbZiY1jCcglAA--.8830S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF17Cw1xCF43ArW5GF1xKrg_yoW8JFyrpa
        4UXa18CF47Gr4fKw1vvw1UCa1avr13J34rX3WkGr48Cas8tr9rtF18Ja12kry7XFWak3y7
        JFWFqrW3Ca1rZaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnkucUUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/3 23:41, Andy Shevchenko 写道:
> On Sat, Dec 03, 2022 at 05:27:31PM +0200, Andy Shevchenko wrote:
>> On Sat, Dec 03, 2022 at 06:53:20PM +0800, Yinbo Zhu wrote:
>>> 在 2022/12/3 18:03, Linus Walleij 写道:
>>>> On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>>>> +config GPIO_LOONGSON_64BIT
>>>>> +       tristate "Loongson 64 bit GPIO support"
>>>>> +       depends on LOONGARCH || COMPILE_TEST
>>>>> +       select GPIO_GENERIC
>>>>> +       select GPIOLIB_IRQCHIP
>>>> If the kernelbots start complaining you might need to add a:
>>>>
>>>> select IRQ_DOMAIN_HIERARCHY
>>>>
>>>> here.
>>> Bartosz had merged my patch and I will add a change on top of the existing
>>> series.
>> I don;'t know why he had done that, the driver requires a lot of cleanups,
>> e.g. why it uses acpi.h, what that "nice" container of the platform device for.

I just compile it that it is still okay when remove acpi.h, so I will 
remove it in v11.

and, I'm afraid I didn't catch your meaning about "

what that "nice" container of the platform device for."


you said is for following code ?
144         struct platform_device *pdev =
145                 container_of(chip->parent, struct platform_device, dev);

> + we have macros for get_direction() returned values and so on.
okay, I will use that macros in v11.

