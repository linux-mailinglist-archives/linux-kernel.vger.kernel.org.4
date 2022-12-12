Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDF649A15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiLLIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiLLIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:34:57 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E0F06151;
        Mon, 12 Dec 2022 00:34:54 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxB_Gu55Zj4fkEAA--.11267S3;
        Mon, 12 Dec 2022 16:34:54 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuCs55ZjGUEsAA--.41531S2;
        Mon, 12 Dec 2022 16:34:53 +0800 (CST)
Subject: Re: [PATCH v5 2/3] gpio: loongson: add gpio driver support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20221121123803.3786-1-zhuyinbo@loongson.cn>
 <20221121123803.3786-2-zhuyinbo@loongson.cn>
 <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
 <8a7abd77-9540-efa8-6f67-908530e85399@loongson.cn>
 <CACRpkdb=wdydOYCcrpjLSyvfVO--_ezXsFQ46qwfVCiiTd5fNw@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <b78f02f4-4329-602e-ca8d-adbe911c2a54@loongson.cn>
Date:   Mon, 12 Dec 2022 16:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb=wdydOYCcrpjLSyvfVO--_ezXsFQ46qwfVCiiTd5fNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuCs55ZjGUEsAA--.41531S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxurWkGw4DCF1kCrWDGF4UArb_yoW5Xw4xpF
        W5Gayqkr4DJryIyw4vqw18ZF1fKa93uFy3Jr1Fk3s8Aryqqr93ZrWaqrWavF9ru3yUJr42
        vF1Yk3yxu3WDAFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
        0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8k-BtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/24 上午6:05, Linus Walleij 写道:
> On Wed, Nov 23, 2022 at 9:02 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>> 在 2022/11/21 下午9:24, Linus Walleij 写道:
> 
>>>> +static int loongson_gpio_request(
>>>> +                       struct gpio_chip *chip, unsigned int pin)
>>>> +{
>>>> +       if (pin >= chip->ngpio)
>>>> +               return -EINVAL;
>>>
>>> This is not needed, the gpiolib core already checks this. Drop it.
>> I check gpio_request in gpilib, I notice gpio_is_valid is not equal to
>> this condition, so I still kept it for byte mode.
> 
> This is because descriptors can only be obtained from gpiod_get() and
> similar and gpiod_get() falls to gpiod_get_index() which will not
> return a valid descriptor from either HW backend. gpiod_get()
> will call gpiod_request() for if and only if the descriptor is valid.
> 
> The only reason to implement something like this is because of
> using the legacy GPIO numberspace which we are getting rid
> of so it is irrelevant, the consumers of your driver will only be
> using gpio descriptors, will only come in through gpiod_get_index()
> and will have desc validity check done before calling gpiod_request().
> 
> So drop this.
> 
>>> I am bit suspicious that your IRQchip implementation expects consumers
>>> to call gpiod_to_irq() first and this is not legal.
>>
>> okay, I got it, and other driver use gpio interrupt doesn't rely on
>> gpiod_to_irq, but can use gpiod_to_irq.
> 
> Yes it can be used to look up the irq corresponding to a GPIO
> but it is not mandatory to do that.
> 
>> The reason is that gpio interrupt wasn't an independent module,  The
>> loongson interrupt controller liointc include lots of interrupt was
>> route to perpherial, such as i2c/spi .. gpio, so gpio interrupt as
>> normal perpherial interrupt, It is unnecessary and redundant to
>> implement a gpio irq chip. The liointc controller driver had cover all
>> interrupt.
> 
> This is fine, and it is common for GPIO drivers to implement
> their own IRQchips.
> 
> But these drivers can not rely on the .gpio_to_irq() callback
> to be called before an IRQ is requested and used.
> 
>> in addition,  I don't like to use the dynamically allocated gpio base,
>> so I set the gpio base after call bgpio_init.
> 
> Don't do that because the GPIO maintainers love the
> dynamic base and hate hardcoded bases. Set the base to -1
> If you wonder why, read drivers/gpio/TODO.
Hi Linus,

I recenly verfied other peripheral on upstream, some peripheral driver
need use gpio number, but if use dynamic base that gpio number will be
meaningless.  in additon I notice that many gpio driver don't use
dynamic base, although bgpio_int was called.

so I think the gpio number should be keep consistent with datasheet for
some platform that need use gpio number.

Yinbo.

> 
> Yours,
> Linus Walleij
> 

