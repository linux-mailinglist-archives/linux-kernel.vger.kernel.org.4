Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D8697EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBOO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBOO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:58:58 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B683A0B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:58:35 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id m1so20106005vst.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPkUSaLMzwpeCHMGA+UM75UbDw347VZfWrMPvnxSJi0=;
        b=ZJ39X5oTsZs/ynW8YRkYknySK+P7IIWYfkYcekUd4iKazKtn4cWD6BxY0OZUuv5RHS
         Me2RaZXQvE7GCB+I70HCtifJ3XaeOh2yEbMcihp1AdezuwAYpQUKKXnsqnc0G/J36jdT
         dK5TlDDHEpjBanUkThStkKzNR5bL9cX6/yOq1D2b7/OpUaxTL4soSepbODExn0ZgbhJb
         lKwiTjuFALIeMbKxnOcSF9mpl8eWG0Q3P/4A+TTLYx6u28q/JcFqv/Ga/FX4flWnwvxI
         CiTHib4YuDL2t2wCNp7VRPuxhhYaGxt9xVxm1Iy5Kp3FAWOx7jSM6yfHZU1h96fdw/Vl
         Pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPkUSaLMzwpeCHMGA+UM75UbDw347VZfWrMPvnxSJi0=;
        b=Oed105uspW51qoMqG/OJyK8MSMYmsjG60TcH40kUBs7sKX2hFImsjSdA9tw6UeEUqp
         2vji/DdyQeNsfCYceYMatu4gCV1q3xeFLZhSF8B5E+3OLvK+inXG8sC/rIUQT+Y2C0T0
         4EhYqdRumszGQpdq+7J02JwyKnmLbd/VxvTmXc8tm3YbzZHTSs09GRUW+9EsdYazULxi
         uddmEqH61llYPtCSOAm6tBlIOGA9DOBkpe/QdwfZ174GmxkBa7QIpWI0wrGvE3juGgsB
         gEIa8eIfzW6K/ygzmjW+gl9GqIQk7TuulpcVrhyEG07w+pkOYH/T/VHy/x1RHRlBpm7C
         wpYQ==
X-Gm-Message-State: AO0yUKXa2ROLDAkc+EkaxDZLtKqtV+GbpQXrlmgrHdbwa6rSIfCBlh6r
        lnWAIQOqFM+3pBuWZXfEFnl+vWJjXCgo+vRnaKNrJQ==
X-Google-Smtp-Source: AK7set+0YxuGri/V2foEwc0NiZxIp6uu5J4mgHu5oKT2oVA9rc8lPd74Rg8O7qhHyudpBwVuMuSQnCHtmC16lKeGmbc=
X-Received: by 2002:a05:6102:7db:b0:410:e23:4ba with SMTP id
 y27-20020a05610207db00b004100e2304bamr401863vsg.80.1676473110911; Wed, 15 Feb
 2023 06:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20230215095249.246911-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230215095249.246911-1-alexander.stein@ew.tq-group.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Feb 2023 15:58:20 +0100
Message-ID: <CAMRc=MciMZ5n9RZ7nzac46WKwmbxdjO_4VSL=GgApmOdj=wf4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gpio: vf610: make irq_chip immutable
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:52 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Since recently, the kernel is nagging about mutable irq_chips:
>
>     "not an immutable chip, please consider fixing it!"
>
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes in v3:
> * Use calculated gpio_num instead of accessing struct member
>
>  drivers/gpio/gpio-vf610.c | 41 ++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index a429176673e7..d3f3a69d4907 100644
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
> @@ -207,20 +206,24 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
>
>  static void vf610_gpio_irq_mask(struct irq_data *d)
>  {
> -       struct vf610_gpio_port *port =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(d));
> -       void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct vf610_gpio_port *port = gpiochip_get_data(gc);
> +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);
> +       void __iomem *pcr_base = port->base + PORT_PCR(gpio_num);
>
>         vf610_gpio_writel(0, pcr_base);
> +       gpiochip_disable_irq(gc, gpio_num);
>  }
>
>  static void vf610_gpio_irq_unmask(struct irq_data *d)
>  {
> -       struct vf610_gpio_port *port =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(d));
> -       void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct vf610_gpio_port *port = gpiochip_get_data(gc);
> +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);
> +       void __iomem *pcr_base = port->base + PORT_PCR(gpio_num);
>
> -       vf610_gpio_writel(port->irqc[d->hwirq] << PORT_PCR_IRQC_OFFSET,
> +       gpiochip_enable_irq(gc, gpio_num);
> +       vf610_gpio_writel(port->irqc[gpio_num] << PORT_PCR_IRQC_OFFSET,
>                           pcr_base);
>  }
>
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

Applied, thanks!

Bart
