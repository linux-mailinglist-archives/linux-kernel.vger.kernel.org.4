Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAF689CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjBCPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjBCPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:06:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB647EFE9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9FD9B82AE4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 15:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64892C433D2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436791;
        bh=g7ucNJwx7l3G44S624zXuPhBPXVNsrOuucXlLkdMUBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IyuCKowejciYTxL7rIw7nwxqKEDohzs6Z8l31x8unE8AOzArIGKnuXHqCDTFnFfJa
         xzX3ZfyNITeTYVC0Tfteo2x6RKfq/PgBcWfRRbSrYZIqIOJc6kKKqjVEJEtK/NawA2
         4X6m046TmIXl7M0jWKrTaDOzY1j8kKWb1wD9GYy02Tfpdhk6FvnZ0sB+0Gw1kG4cyJ
         EvdPsJ/vCYZ15H8OHFDjwf4mzyYJ6cBgfvqJiskZNIdj/8ZfKm/8kdoN8dOUDuQ9rk
         gnhOqUAGZzhNHRK5Aryxupz80oEpNsLkPs5vc9qLf0S6hnNA2lBKZ069HdNu7mwpP+
         BR/b26RtqcYsg==
Received: by mail-vs1-f51.google.com with SMTP id i185so5644043vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:06:31 -0800 (PST)
X-Gm-Message-State: AO0yUKWRmlPA/lcgIkhLMl9x0LFkTZX5USIrfETaZLr2cq5o4lmh6JkZ
        W1JGi4inWQj4Ltb4evnwFMxQiBmIXwpDORhLCw==
X-Google-Smtp-Source: AK7set8Nhnn7wPSzRx1stDc4WyoPHokzsjm4Jbuqhwu/Fvwbp8JHZeU2bh2zPRMbFHGHETFoXimql9IuzxUQaVxotB0=
X-Received: by 2002:a67:d507:0:b0:3e9:107e:cc55 with SMTP id
 l7-20020a67d507000000b003e9107ecc55mr1407707vsj.6.1675436790281; Fri, 03 Feb
 2023 07:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20230201220011.247100-1-robh@kernel.org> <bb307806-fa02-d147-2c25-6b3b3bbd411b@socionext.com>
In-Reply-To: <bb307806-fa02-d147-2c25-6b3b3bbd411b@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Feb 2023 09:06:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfq6U3OORsKE962f2RZ7kQXLNEb2ShzrWqGY+=oVsf=g@mail.gmail.com>
Message-ID: <CAL_JsqLfq6U3OORsKE962f2RZ7kQXLNEb2ShzrWqGY+=oVsf=g@mail.gmail.com>
Subject: Re: [PATCH] bus: unifier-system-bus: Remove open coded "ranges" parsing
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 11:50 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> On 2023/02/02 7:00, Rob Herring wrote:
> > "ranges" is a standard property and we have common helper functions for
> > parsing it, so let's use them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Compile tested only!
>
> Please fix the driver's name.
>
> s/unifier-system-bus/uniphier-system-bus/

doh!

>
> > ---
> >   drivers/bus/uniphier-system-bus.c | 54 +++++++------------------------
> >   1 file changed, 11 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/bus/uniphier-system-bus.c
> > b/drivers/bus/uniphier-system-bus.c
> > index f70dedace20b..cb5c89ce7b86 100644
> > --- a/drivers/bus/uniphier-system-bus.c
> > +++ b/drivers/bus/uniphier-system-bus.c
> > @@ -176,10 +176,9 @@ static int uniphier_system_bus_probe(struct
> > platform_device *pdev)
> >   {
> >       struct device *dev = &pdev->dev;
> >       struct uniphier_system_bus_priv *priv;
> > -     const __be32 *ranges;
> > -     u32 cells, addr, size;
> > -     u64 paddr;
> > -     int pna, bank, rlen, rone, ret;
> > +     struct of_range_parser parser;
> > +     struct of_range range;
> > +     int ret;
> >
> >       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> > @@ -191,48 +190,17 @@ static int uniphier_system_bus_probe(struct
> > platform_device *pdev)
> >
> >       priv->dev = dev;
> >
> > -     pna = of_n_addr_cells(dev->of_node);
> > -
> > -     ret = of_property_read_u32(dev->of_node, "#address-cells",
> > &cells);
> > -     if (ret) {
> > -             dev_err(dev, "failed to get #address-cells\n");
> > -             return ret;
> > -     }
> > -     if (cells != 2) {
> > -             dev_err(dev, "#address-cells must be 2\n");
> > -             return -EINVAL;
> > -     }
>
> Don't you need to check the value of "#address-cells"?

Doesn't your schema do that?

It's not the kernel's job to validate the DT. If it is, then it does a
terrible job.

> > -
> > -     ret = of_property_read_u32(dev->of_node, "#size-cells", &cells);
> > -     if (ret) {
> > -             dev_err(dev, "failed to get #size-cells\n");
> > +     ret = of_range_parser_init(&parser, dev->of_node);
> > +     if (ret)
> >               return ret;
> > -     }
> > -     if (cells != 1) {
> > -             dev_err(dev, "#size-cells must be 1\n");
> > -             return -EINVAL;
> > -     }
>
> Same as "#size-cells"

While the address clearly needs cells to hold the chip select, there's
no reason to restrict the size cells.

>
> I confirmed the value of all the arguments of uniphier_system_bus_add_bank()
> match the previous ones.
>
> Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thanks.

Rob
