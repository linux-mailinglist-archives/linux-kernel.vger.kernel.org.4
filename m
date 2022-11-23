Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD93D6351C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiKWICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiKWICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:02:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD8F92183C;
        Wed, 23 Nov 2022 00:02:13 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxM_CE031jGTEAAA--.576S3;
        Wed, 23 Nov 2022 16:02:12 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VaB031j750YAA--.45728S2;
        Wed, 23 Nov 2022 16:02:09 +0800 (CST)
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
        Liu Peibao <liupeibao@loongson.cn>
References: <20221121123803.3786-1-zhuyinbo@loongson.cn>
 <20221121123803.3786-2-zhuyinbo@loongson.cn>
 <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <8a7abd77-9540-efa8-6f67-908530e85399@loongson.cn>
Date:   Wed, 23 Nov 2022 16:02:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VaB031j750YAA--.45728S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF43Kr1ktFy3Gw4kXFWDJwb_yoW3GF47pF
        W5ua13Kr4DJr4jkr1DXrs8uF13Jr98KrsrtFs7C348AFyqvr97XFWj9F1ru3srurZ5Zr13
        ZFWrCFy8u3Z8CaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/21 下午9:24, Linus Walleij 写道:
> On Mon, Nov 21, 2022 at 1:38 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>> The Loongson platforms GPIO controller contains 60 GPIO pins in total,
>> 4 of which are dedicated GPIO pins, and the remaining 56 are reused
>> with other functions. Each GPIO can set input/output and has the
>> interrupt capability.
>>
>> This driver added support for Loongson GPIO controller and support to
>> use DTS or ACPI to descibe GPIO device resources.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v5:
> 
> This is starting to look really good! We are getting to the final polish.
> 
>> +config GPIO_LOONGSON
>> +       tristate "Loongson GPIO support"
>> +       depends on LOONGARCH || COMPILE_TEST
> 
> select GPIO_GENERIC
> 
> You should use this in the "bit mode".
> 
>>   obj-$(CONFIG_GPIO_LOONGSON1)           += gpio-loongson1.o
>> +obj-$(CONFIG_GPIO_LOONGSON)            += gpio-loongson.o
> 
> Isn't this a bit confusing? What about naming it
> gpio-loongson2.c?
This driver was plan to cover all loongson platform, not only Loongson-2
SoC but also other loongson platform. and I adop your advice in another
mail. I named this driver was gpio-loongson-64bit.c.
> 
>> +enum loongson_gpio_mode {
>> +       BIT_CTRL_MODE,
>> +       BYTE_CTRL_MODE,
>> +};
> 
> I don't think you will need to track this, jus assume BYTE_CTRL_MODE
> in your callbacks because we will replace the bit mode with assigned
> accessors from GPIO_GENERIC.
  yes, but in loongson_gpio_init need a distinction, so I kept this.
> 
>> +
>> +struct loongson_gpio_platform_data {
>> +       const char              *label;
>> +       enum loongson_gpio_mode mode;
> 
> So drop this.

> 
>> +static int loongson_gpio_request(
>> +                       struct gpio_chip *chip, unsigned int pin)
>> +{
>> +       if (pin >= chip->ngpio)
>> +               return -EINVAL;
> 
> This is not needed, the gpiolib core already checks this. Drop it.
I check gpio_request in gpilib, I notice gpio_is_valid is not equal to
this condition, so I still kept it for byte mode.
> 
>> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
>> +                       unsigned int pin, int input)
>> +{
>> +       u64 qval;
>> +       u8  bval;
>> +
>> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
>> +               qval = readq(LOONGSON_GPIO_OEN(lgpio));
>> +               if (input)
>> +                       qval |= 1ULL << pin;
>> +               else
>> +                       qval &= ~(1ULL << pin);
>> +               writeq(qval, LOONGSON_GPIO_OEN(lgpio));
>> +       } else {
>> +               bval = input ? 1 : 0;
>> +               writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
>> +       }
> 
> Drop bit mode keep only byte mode.
okay, I will drop it.
> 
>> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
>> +                       int high)
>> +{
>> +       u64 qval;
>> +       u8 bval;
>> +
>> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
>> +               qval = readq(LOONGSON_GPIO_OUT(lgpio));
>> +               if (high)
>> +                       qval |= 1ULL << pin;
>> +               else
>> +                       qval &= ~(1ULL << pin);
>> +               writeq(qval, LOONGSON_GPIO_OUT(lgpio));
>> +       } else {
>> +               bval = high ? 1 : 0;
>> +               writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
>> +       }
> 
> Dito.
okay, I will drop bit mode.
> 
>> +static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
>> +{
>> +       u64 qval;
>> +       u8  bval;
>> +       int val;
>> +
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
>> +               qval = readq(LOONGSON_GPIO_IN(lgpio));
>> +               val = (qval & (1ULL << pin)) != 0;
>> +       } else {
>> +               bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
>> +               val = bval & 1;
>> +       }
> 
> Dito.
okay, I will drop bit mode.
> 
>> +static int loongson_gpio_to_irq(
>> +                       struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct platform_device *pdev =
>> +               container_of(chip->parent, struct platform_device, dev);
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +       if (offset >= chip->ngpio)
>> +               return -EINVAL;
>> +
>> +       if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
>> +               offset = lgpio->gsi_idx_map[offset];
>> +       else
>> +               return -EINVAL;
>> +
>> +       return platform_get_irq(pdev, offset);
>> +}
> 
> I'm a bit suspicious about this. See the following in
> Documentation/driver-api/gpio/driver.rst:
> 
> ------------------
> It is legal for any IRQ consumer to request an IRQ from any irqchip even if it
> is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
> irq_chip are orthogonal, and offering their services independent of each
> other.
> 
> gpiod_to_irq() is just a convenience function to figure out the IRQ for a
> certain GPIO line and should not be relied upon to have been called before
> the IRQ is used.
> 
> Always prepare the hardware and make it ready for action in respective
> callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() having
> been called first.
> ------------------
> 
> I am bit suspicious that your IRQchip implementation expects consumers
> to call gpiod_to_irq() first and this is not legal.
okay, I got it, and other driver use gpio interrupt doesn't rely on 
gpiod_to_irq, but can use gpiod_to_irq.

The reason is that gpio interrupt wasn't an independent module,  The
loongson interrupt controller liointc include lots of interrupt was
route to perpherial, such as i2c/spi .. gpio, so gpio interrupt as
normal perpherial interrupt, It is unnecessary and redundant to
implement a gpio irq chip. The liointc controller driver had cover all
interrupt.
> 
>> +static int loongson_gpio_init(
>> +                       struct device *dev, struct loongson_gpio_chip *lgpio,
>> +                       struct device_node *np, void __iomem *base)
>> +{
> 
> Do something like this:
> 
> #define LOONGSON_GPIO_IN(x)            (x->base + x->p_data->in_offset)
> +#define LOONGSON_GPIO_OUT(x)           (x->base + x->p_data->out_offset)
> +#define LOONGSON_GPIO_OEN(x)           (x->base + x->p_data->conf_offset)
> 
> if (lgpio->p_data->mode == BIT_CTRL_MODE) {
>         ret = bgpio_init(&g->gc, dev, 8,
>                           lgpio->base + lgpio->p_data->in_offset,
>                           lgpio->base + lgpio->p_data->out_offset,
>                           0,
>                           lgpio->base + lgpio->p_data->conf_offset,
>                           NULL,
>                           0);
>          if (ret) {
>                  dev_err(dev, "unable to init generic GPIO\n");
>                  goto dis_clk;
>          }
> 
> If you actually have a special purpose clear register in your hardware
> which is not included here, then add it in the line with just 0 for that
> function.
okay, I had do it.
in addition,  I don't like to use the dynamically allocated gpio base, 
so I set the gpio base after call bgpio_init.

> 
> See the kerneldoc in bgpio_init() in drivers/gpio/gpio-mmio.c.
> 
> Then:
> 
> }  else {
> 
>> +       lgpio->chip.request = loongson_gpio_request;
>> +       lgpio->chip.direction_input = loongson_gpio_direction_input;
>> +       lgpio->chip.get = loongson_gpio_get;
>> +       lgpio->chip.direction_output = loongson_gpio_direction_output;
>> +       lgpio->chip.set = loongson_gpio_set;
> 
> Note also: implement loongson_gpio_get_direction(). To read the setting
> of the conf register on startup. You now only need to implement it for
> byte mode.
okay, I had implement it.
> 
> }
> 
> After this you should set ngpios, because bgpio_init() will overwrite it
> with 64, so it cannot be done directly when parsing platform data,
> cache it somewhere and write it here.
okay, I will do it.
> 
> (...)
> 
> Yours,
> Linus Walleij
> 

