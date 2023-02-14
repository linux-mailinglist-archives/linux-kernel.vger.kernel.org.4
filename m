Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A58696A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBNQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjBNQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86A93FE;
        Tue, 14 Feb 2023 08:48:48 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id bl15so6365512qkb.4;
        Tue, 14 Feb 2023 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nau7lgiudKbh01gy/XQ5sRV2ogzSHbVMQQVqpfepIyY=;
        b=H0M5c0e2xuyV72DLSzHYxC41sV3A2EJB351Bi8GUtZuUnnl3fUPXtfVqpLpqAaTD1t
         veM07BgNlys43ZAVAcxg/selzbWZir79lwsUi0c+FuOlDiQvZn4wIlbwXpzVJJfjkhy7
         OQmpY3/o+MaacAOe3Uw67yY9fsokcUeRJ6DJxTUfMh/IxeB4PLnuCcc4BSMmYshnmkf6
         +BNCwCxwdDZSbxo86tZ1E2gF1ylHX9m2esqrQ1W/hHHA6dX51vbk3EZoocI7MST1JBXC
         vxLKAeknEOBOCfLnQFb9KMY22v7it9IjdzLV7PdDPCrwum3oRvTenIuyootEEhEWZPud
         e60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nau7lgiudKbh01gy/XQ5sRV2ogzSHbVMQQVqpfepIyY=;
        b=4MsezhOVPiD+yPRQ0uGBXkoKcxSHq6v1ehBuCoRSPGPyRwT7608GV2snV1SYyY7Sv2
         OyesTyY75JOM/M/En/QhPKy2tBuxmrd0URrbCp8akomsS5pAYehArQ0l3iflbkBme99T
         CoFKo58qN9DWiE/9Hmk2baCKCs9RDacbyRL3G0Ble9NfyVhdoJntcPwTf0VKCsXAuNdB
         OZ7+OLYxsiL93M/btZZjD8w6myCGqL5zei5TwwOiiKqR2tNTvPEHo2PsDY0gWwiFGkGt
         /QAV8BniWpB7K7/ld+FWG3ZgD3dxzj1U0ogWxOFoqdd/lkgkAJGeC4P3i4DzEl7GXgDx
         SKag==
X-Gm-Message-State: AO0yUKUDRWFZMifu8fICu7T1lUVmgDRK60/xben5mEL0h/lBxUDouE/2
        G+I46wcOYo+TBUb8W0eem93yNKNmoUJUYhiWnHvy8yN7eV8kww==
X-Google-Smtp-Source: AK7set+O41SkSlASBYPRgAtQ1mhirkdG7vKW0SAlOOQXg7ZYHnMbY+fyzZCR9s5UUcjsk+MzQ39LQjExm97fcWjs71U=
X-Received: by 2002:a37:9a85:0:b0:725:ff53:b58e with SMTP id
 c127-20020a379a85000000b00725ff53b58emr229775qke.331.1676393327818; Tue, 14
 Feb 2023 08:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20230214125949.3462396-1-alexander.stein@ew.tq-group.com> <CAHp75Vf0u_F4bFs-1hyckG7h-7r3XqxdZc_6EjuWxTxbfMPMjQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf0u_F4bFs-1hyckG7h-7r3XqxdZc_6EjuWxTxbfMPMjQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Feb 2023 18:48:11 +0200
Message-ID: <CAHp75VdLuDmaBRr0X_==zKxAN5mkxDZV4MMywo7bETaFCvmASg@mail.gmail.com>
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

On Tue, Feb 14, 2023 at 6:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 14, 2023 at 2:59 PM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:

...

> >         void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
>
> Now you can use gpio_num here...
>
> > +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);

...

> >  static void vf610_gpio_irq_unmask(struct irq_data *d)
> >  {
> > -       struct vf610_gpio_port *port =
> > -               gpiochip_get_data(irq_data_get_irq_chip_data(d));
> > +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +       struct vf610_gpio_port *port = gpiochip_get_data(gc);
> >         void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);

And here.

> > +       irq_hw_number_t gpio_num = irqd_to_hwirq(d);
> >
> > +       gpiochip_enable_irq(gc, gpio_num);
> >         vf610_gpio_writel(port->irqc[d->hwirq] << PORT_PCR_IRQC_OFFSET,
>
> ...and here.
>
> >                           pcr_base);
> >  }

-- 
With Best Regards,
Andy Shevchenko
