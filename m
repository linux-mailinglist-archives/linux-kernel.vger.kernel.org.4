Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C769E696A29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBNQqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjBNQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:46:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08002CFDD;
        Tue, 14 Feb 2023 08:46:22 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c2so18188845qtw.5;
        Tue, 14 Feb 2023 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EF3Fh18aPcGx0lZp0vgnipu7S3GtbM+fR6/6UdgsdNs=;
        b=CTF/qzvcYJAJLKXvKMWN/YwCABFO/JfSitBj6DO/vhRNHvMpG85slDJ1toSOPCNDnh
         wy86254A87Avvwy7jTAtH458QbqVSJerHCXlxlF5hSbg3k7s7QPRatVg/02DvVaxnrko
         /LWmwB3TJLGd+6WNTojelVikUPwCecSBMuuMP/0Bry5gpTKB3Ba2hmS/3jR/doM12lOB
         XLP40X4HP6l901qc217chSeJBlYwrlXiD0vU+FRn+MEEc7N/48HgLw5Aj/QOSZ7FaVv1
         ywEOa64WxY39zw3PR2f0iVzvsJIQHuLQEUV2JdYJDPAdR3IFwiOewRGzd0r7To0hijZM
         wHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF3Fh18aPcGx0lZp0vgnipu7S3GtbM+fR6/6UdgsdNs=;
        b=kDKwOPk9mFgKQgQgrWrM8n2HkPTnnQRgocC94fLTIElsPHhgcxVI2zvDip+yVoZFbI
         ywNhbmwsff0BET0PhC2eMq20Bud0C1B+wQeFvwv4hqIkfiULSbnvKfIHGbLl1eBBQUXh
         lxiXHPJ1Ak1bgUKoB0Mv2LChpNdUh8f65ZX4KCtJyYVdCH6grcA6iWeg/NKjLcRbxC13
         coMb2RTDW7AguDFQH2TueFveFawh2HJEmb3O1b7k2nwYPmTEoVR9sCjsUcrtWa4ji6U2
         uzMdNEQVoqjCMmpqXwqtZefXWveQ0MY2A/fsXWuXnsnHq8SZ+m3ijBY4j5wkiDoSYGv4
         hvSQ==
X-Gm-Message-State: AO0yUKXaE/YgPFd45Jbspz3kt8y93ICwIC7aZV3V5W7VXOHTIwSpwiSi
        BssTKnSH0M1wFQLAB6JzzBD2Yt6O3ivmjUOuzmc=
X-Google-Smtp-Source: AK7set/XOn2ZldcOYB2ieyAsOe3/lw+j3S2PAxYis4xfciqkF+F/Gmpvcc3VJrUrmfVUJnwfPGEdiu9QWZrUtBvBhOU=
X-Received: by 2002:ac8:5ac9:0:b0:3b6:82ef:2d6 with SMTP id
 d9-20020ac85ac9000000b003b682ef02d6mr458716qtd.24.1676393181530; Tue, 14 Feb
 2023 08:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20230214125949.3462396-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230214125949.3462396-1-alexander.stein@ew.tq-group.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Feb 2023 18:45:45 +0200
Message-ID: <CAHp75Vf0u_F4bFs-1hyckG7h-7r3XqxdZc_6EjuWxTxbfMPMjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: vf610: make irq_chip immutable
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 2:59 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Since recently, the kernel is nagging about mutable irq_chips:
>
>     "not an immutable chip, please consider fixing it!"
>
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.

Thanks for an update, something to amend below, otherwise
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Thanks Andy for the feedback!
>
> Changes in v2:
> * Add missing calls to gpiochip_disable_irq() and gpiochip_enable_irq()
>
>  drivers/gpio/gpio-vf610.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index a429176673e7..b657a07a9b56 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -30,7 +30,6 @@ struct fsl_gpio_soc_data {
>
>  struct vf610_gpio_port {
>         struct gpio_chip gc;
> -       struct irq_chip ic;
>         void __iomem *base;
>         void __iomem *gpio_base;
>         const struct fsl_gpio_soc_data *sdata;
> @@ -207,19 +206,23 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
>
>  static void vf610_gpio_irq_mask(struct irq_data *d)
>  {
> -       struct vf610_gpio_port *port =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(d));
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct vf610_gpio_port *port = gpiochip_get_data(gc);
>         void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);

Now you can use gpio_num here...

> +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);
>
>         vf610_gpio_writel(0, pcr_base);
> +       gpiochip_disable_irq(gc, gpio_num);
>  }
>
>  static void vf610_gpio_irq_unmask(struct irq_data *d)
>  {
> -       struct vf610_gpio_port *port =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(d));
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct vf610_gpio_port *port = gpiochip_get_data(gc);
>         void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
> +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);
>
> +       gpiochip_enable_irq(gc, gpio_num);
>         vf610_gpio_writel(port->irqc[d->hwirq] << PORT_PCR_IRQC_OFFSET,

...and here.


>                           pcr_base);
>  }
> @@ -237,6 +240,17 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
>         return 0;
>  }
>
> +static const struct irq_chip vf610_irqchip = {
> +       .name = "gpio-vf610",
> +       .irq_ack = vf610_gpio_irq_ack,
> +       .irq_mask = vf610_gpio_irq_mask,
> +       .irq_unmask = vf610_gpio_irq_unmask,
> +       .irq_set_type = vf610_gpio_irq_set_type,
> +       .irq_set_wake = vf610_gpio_irq_set_wake,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  static void vf610_gpio_disable_clk(void *data)
>  {
>         clk_disable_unprepare(data);
> @@ -249,7 +263,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
>         struct vf610_gpio_port *port;
>         struct gpio_chip *gc;
>         struct gpio_irq_chip *girq;
> -       struct irq_chip *ic;
>         int i;
>         int ret;
>
> @@ -315,14 +328,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
>         gc->direction_output = vf610_gpio_direction_output;
>         gc->set = vf610_gpio_set;
>
> -       ic = &port->ic;
> -       ic->name = "gpio-vf610";
> -       ic->irq_ack = vf610_gpio_irq_ack;
> -       ic->irq_mask = vf610_gpio_irq_mask;
> -       ic->irq_unmask = vf610_gpio_irq_unmask;
> -       ic->irq_set_type = vf610_gpio_irq_set_type;
> -       ic->irq_set_wake = vf610_gpio_irq_set_wake;
> -
>         /* Mask all GPIO interrupts */
>         for (i = 0; i < gc->ngpio; i++)
>                 vf610_gpio_writel(0, port->base + PORT_PCR(i));
> @@ -331,7 +336,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
>         vf610_gpio_writel(~0, port->base + PORT_ISFR);
>
>         girq = &gc->irq;
> -       girq->chip = ic;
> +       gpio_irq_chip_set_chip(girq, &vf610_irqchip);
>         girq->parent_handler = vf610_gpio_irq_handler;
>         girq->num_parents = 1;
>         girq->parents = devm_kcalloc(&pdev->dev, 1,
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
