Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44D63A125
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiK1GZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK1GZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:25:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A43BF72;
        Sun, 27 Nov 2022 22:25:28 -0800 (PST)
Received: from loongson.cn (unknown [117.133.84.114])
        by gateway (Coremail) with SMTP id _____8CxrutXVIRjZpcBAA--.3934S3;
        Mon, 28 Nov 2022 14:25:27 +0800 (CST)
Received: from [192.168.1.7] (unknown [117.133.84.114])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5VZVVIRjbQcdAA--.54968S3;
        Mon, 28 Nov 2022 14:25:26 +0800 (CST)
Message-ID: <a749cb75-eea8-c1af-5a07-5d85c7fc17ff@loongson.cn>
Date:   Mon, 28 Nov 2022 14:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/2] gpio: loongson: add gpio driver support
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
References: <20221123080414.14005-1-zhuyinbo@loongson.cn>
 <CACRpkdZ5OJpMFH1Wi31TKQZskQtCmNGyySdkOpouiNW2t_jV6Q@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
In-Reply-To: <CACRpkdZ5OJpMFH1Wi31TKQZskQtCmNGyySdkOpouiNW2t_jV6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5VZVVIRjbQcdAA--.54968S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxurWDuF4kGr4xKFW5Wry8Xwb_yoW5KFyxpF
        WxWayakF45JrWUCr1DXrW5ZFyakrZ0yrsrJFsFk3yv93s8Awn7XrWUWF15Zr97ur95uF17
        ZFW8CFWv9a1DAFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1SoXUUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/24 6:14, Linus Walleij 写道:
> On Wed, Nov 23, 2022 at 9:04 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
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
>> Change in v6:
> This is way better :)
>
> I guess you notice how the driver gets smaller and smaller.
> This is a good sign!
It's thanks to your advice！
>> +static int loongson_gpio_request(
>> +                       struct gpio_chip *chip, unsigned int pin)
>> +{
>> +       if (pin >= chip->ngpio)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
> Drop this altogether as discussed in my other reply.
okay , I got it.
>
>> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
>> +                       unsigned int pin, int input)
>> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
>> +                       int high)
> I missed this before. Also the use of __underscore for inner functions
> is a bad habit IMO (because __underscore is also used for compiler
> primitives such as __init which is confusing) The signature of these
> functions is too generic. Name them loongson_commit_direction() or
> loongson_commit_level() or something.
okay , I got it.
>
>> +static int loongson_gpio_get_direction(
>> +                               struct gpio_chip *chip, unsigned int pin)
> thanks for implementing this!
>
>> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
>> +               ret = bgpio_init(&lgpio->chip, dev, 8,
>> +                               LOONGSON_GPIO_IN(lgpio),
>> +                               LOONGSON_GPIO_OUT(lgpio), 0,
>> +                               LOONGSON_GPIO_OEN(lgpio), NULL, 0);
>> +               if (ret) {
>> +                       dev_err(dev, "unable to init generic GPIO\n");
>> +                       return ret;
>> +               }
>> +               lgpio->chip.ngpio = ngpios;
> Neat!
>
>> +               lgpio->chip.base = 0;
> Drop this. It is good that the base is unpredictable so
> people don't start to rely on it. (drivers/gpio/TODO)
okay, I got it.
>
>> +       rval = device_property_read_u16_array(dev, "gsi_idx_map", NULL, 0);
> But this gsi_idx_map is missing from your device tree bindings,
> is it not?
>
> Or what am I missing here? Sorry I might overlook something...

gsi_idx_map is for acpi, the dts doesn't use it, and acpi should be 
follow dts,

so remove it.

>
>> +static int loongson_gpio_probe(struct platform_device *pdev)
>> +{
>> +       void __iomem *reg_base;
>> +       struct loongson_gpio_chip *lgpio;
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct device *dev = &pdev->dev;
>> +
>> +       lgpio = devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
>> +       if (!lgpio)
>> +               return -ENOMEM;
>> +
>> +       loongson_gpio_get_props(pdev, lgpio);
>> +
>> +       lgpio->p_data = device_get_match_data(&pdev->dev);
> lgpio->p_data = device_get_match_data(dev);
>
>
>> +static int __init loongson_gpio_setup(void)
>> +{
>> +       return platform_driver_register(&loongson_gpio_driver);
>> +}
>> +postcore_initcall(loongson_gpio_setup);
> Why does this have to be postcore_initcall()?

it was refer other gpio driver. other perpherial driver will use gpio, 
the gpio driver

  should be loaded as early as possible,so use postcore_initcall();

>
> Yours,
> Linus Walleij

