Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8319632362
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKUNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKUNYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:24:38 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF940446
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:24:36 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-398cff43344so63426587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMF5A9vgu2qUxvanROG2lGFbnRUFl67UAIh7zppvu2s=;
        b=TmbfJOUCs+9U3Y6bfub3PFtiGVGewEjVOdg9ibhoZFqFo0VQROsNDGOe232bTYcwno
         5nqd0DOxhqA6bA0YttR5LY+FLX4wteJz9Cc/1XcdHyytHpVctmPct40jtyyZ5MnojkF0
         2Pbk/FtOnBcUpU4R/kY8nq/RN0p94iVCGbvDrcx3ova8WgSm6aJyVE9lZ4r50ncSvzMZ
         VQ5zJAuCuSpRYXZ6/m0UYhLiV+7e9lklmlbR62aholORjxBsU59pGnY6HYG6Bx+X8MRe
         LDlysTbmjyRNg32elTiD8oJPYkGCZlIqL99vOcJA6wLqB6aBysFjeHe7iFTIfzn/GPJ/
         7iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMF5A9vgu2qUxvanROG2lGFbnRUFl67UAIh7zppvu2s=;
        b=AM1D3c54Bqywbz7EVHqLGcWFhIn+b6PS0EpKokW2EBkniCgjBff4O2VX2fUez3g7SX
         noZrfoyhqfv3m/QZy9Uwlm9u/YbvryOBJuT34qlA5+ocDzJXfp1IE2GfmcgYlAsIfEuS
         rmSTsXtPLO+U56vixb/F4otxnq1lZyuXNQYflnF3UzAPM+MABJe2gqMU8yTj21QVGjWm
         /KjM/WfIVB/dWbaErAixMOzE1mJNCqDaZQGYW59gluFrxF3n7jSc1wcoHoItbfTnxCNC
         aS0LLHdkqqLtbLqVA86SkXyH5TEz+OD2XydBmamen8yG/OmNFto6eq4baRJ+7o3l/UIx
         BLFg==
X-Gm-Message-State: ANoB5plS/5EiEVbutZlH6tM9N8FxyQdRrWMKGSjafZLaOKxcNPmzxMXw
        GBvmA91FWNeXgb/llK0A73fS9a2hwLWLcbVfMgm54Q==
X-Google-Smtp-Source: AA0mqf4uBiIhiP9oP8YwfTs/QwKMT4Vn2rtMltIF40cPCUml7Dfu19+TajxNWcCL4Q6Um3PxxssXpQKIQueyzLOF1E4=
X-Received: by 2002:a0d:fdc7:0:b0:37a:e8f:3cd3 with SMTP id
 n190-20020a0dfdc7000000b0037a0e8f3cd3mr17017274ywf.187.1669037075837; Mon, 21
 Nov 2022 05:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221121123803.3786-1-zhuyinbo@loongson.cn> <20221121123803.3786-2-zhuyinbo@loongson.cn>
In-Reply-To: <20221121123803.3786-2-zhuyinbo@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 14:24:23 +0100
Message-ID: <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 1:38 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> The Loongson platforms GPIO controller contains 60 GPIO pins in total,
> 4 of which are dedicated GPIO pins, and the remaining 56 are reused
> with other functions. Each GPIO can set input/output and has the
> interrupt capability.
>
> This driver added support for Loongson GPIO controller and support to
> use DTS or ACPI to descibe GPIO device resources.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v5:

This is starting to look really good! We are getting to the final polish.

> +config GPIO_LOONGSON
> +       tristate "Loongson GPIO support"
> +       depends on LOONGARCH || COMPILE_TEST

select GPIO_GENERIC

You should use this in the "bit mode".

>  obj-$(CONFIG_GPIO_LOONGSON1)           += gpio-loongson1.o
> +obj-$(CONFIG_GPIO_LOONGSON)            += gpio-loongson.o

Isn't this a bit confusing? What about naming it
gpio-loongson2.c?

> +enum loongson_gpio_mode {
> +       BIT_CTRL_MODE,
> +       BYTE_CTRL_MODE,
> +};

I don't think you will need to track this, jus assume BYTE_CTRL_MODE
in your callbacks because we will replace the bit mode with assigned
accessors from GPIO_GENERIC.

> +
> +struct loongson_gpio_platform_data {
> +       const char              *label;
> +       enum loongson_gpio_mode mode;

So drop this.

> +static int loongson_gpio_request(
> +                       struct gpio_chip *chip, unsigned int pin)
> +{
> +       if (pin >= chip->ngpio)
> +               return -EINVAL;

This is not needed, the gpiolib core already checks this. Drop it.

> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
> +                       unsigned int pin, int input)
> +{
> +       u64 qval;
> +       u8  bval;
> +
> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
> +               qval = readq(LOONGSON_GPIO_OEN(lgpio));
> +               if (input)
> +                       qval |= 1ULL << pin;
> +               else
> +                       qval &= ~(1ULL << pin);
> +               writeq(qval, LOONGSON_GPIO_OEN(lgpio));
> +       } else {
> +               bval = input ? 1 : 0;
> +               writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
> +       }

Drop bit mode keep only byte mode.

> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
> +                       int high)
> +{
> +       u64 qval;
> +       u8 bval;
> +
> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
> +               qval = readq(LOONGSON_GPIO_OUT(lgpio));
> +               if (high)
> +                       qval |= 1ULL << pin;
> +               else
> +                       qval &= ~(1ULL << pin);
> +               writeq(qval, LOONGSON_GPIO_OUT(lgpio));
> +       } else {
> +               bval = high ? 1 : 0;
> +               writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
> +       }

Dito.

> +static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
> +{
> +       u64 qval;
> +       u8  bval;
> +       int val;
> +
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
> +               qval = readq(LOONGSON_GPIO_IN(lgpio));
> +               val = (qval & (1ULL << pin)) != 0;
> +       } else {
> +               bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
> +               val = bval & 1;
> +       }

Dito.

> +static int loongson_gpio_to_irq(
> +                       struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct platform_device *pdev =
> +               container_of(chip->parent, struct platform_device, dev);
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       if (offset >= chip->ngpio)
> +               return -EINVAL;
> +
> +       if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
> +               offset = lgpio->gsi_idx_map[offset];
> +       else
> +               return -EINVAL;
> +
> +       return platform_get_irq(pdev, offset);
> +}

I'm a bit suspicious about this. See the following in
Documentation/driver-api/gpio/driver.rst:

------------------
It is legal for any IRQ consumer to request an IRQ from any irqchip even if it
is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
irq_chip are orthogonal, and offering their services independent of each
other.

gpiod_to_irq() is just a convenience function to figure out the IRQ for a
certain GPIO line and should not be relied upon to have been called before
the IRQ is used.

Always prepare the hardware and make it ready for action in respective
callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() having
been called first.
------------------

I am bit suspicious that your IRQchip implementation expects consumers
to call gpiod_to_irq() first and this is not legal.

> +static int loongson_gpio_init(
> +                       struct device *dev, struct loongson_gpio_chip *lgpio,
> +                       struct device_node *np, void __iomem *base)
> +{

Do something like this:

#define LOONGSON_GPIO_IN(x)            (x->base + x->p_data->in_offset)
+#define LOONGSON_GPIO_OUT(x)           (x->base + x->p_data->out_offset)
+#define LOONGSON_GPIO_OEN(x)           (x->base + x->p_data->conf_offset)

if (lgpio->p_data->mode == BIT_CTRL_MODE) {
       ret = bgpio_init(&g->gc, dev, 8,
                         lgpio->base + lgpio->p_data->in_offset,
                         lgpio->base + lgpio->p_data->out_offset,
                         0,
                         lgpio->base + lgpio->p_data->conf_offset,
                         NULL,
                         0);
        if (ret) {
                dev_err(dev, "unable to init generic GPIO\n");
                goto dis_clk;
        }

If you actually have a special purpose clear register in your hardware
which is not included here, then add it in the line with just 0 for that
function.

See the kerneldoc in bgpio_init() in drivers/gpio/gpio-mmio.c.

Then:

}  else {

> +       lgpio->chip.request = loongson_gpio_request;
> +       lgpio->chip.direction_input = loongson_gpio_direction_input;
> +       lgpio->chip.get = loongson_gpio_get;
> +       lgpio->chip.direction_output = loongson_gpio_direction_output;
> +       lgpio->chip.set = loongson_gpio_set;

Note also: implement loongson_gpio_get_direction(). To read the setting
of the conf register on startup. You now only need to implement it for
byte mode.

}

After this you should set ngpios, because bgpio_init() will overwrite it
with 64, so it cannot be done directly when parsing platform data,
cache it somewhere and write it here.

(...)

Yours,
Linus Walleij
