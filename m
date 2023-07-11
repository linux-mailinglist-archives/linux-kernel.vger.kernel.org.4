Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B574E490
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGKC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGKC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:58:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AFDE3;
        Mon, 10 Jul 2023 19:58:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso6203162a12.3;
        Mon, 10 Jul 2023 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044316; x=1691636316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMufGZRURrHmH1jJKqkA3fgmQNlTbVYYmj3oN03vBtA=;
        b=kftUh53juqSHOlfZftt6k9IlBV9xj4ZYGBGhiddi7V5eEjsO6H2a7qRmIo759mr7II
         fUR2b6zP+q+zUz7iJyw69fve9tR0nBaYKTL4Sz4idJ5Ne5kYUBVdTxTV0suVJ8CtzLtk
         bXCNcsO4w5pjC5SCQAjMWXz7OJIlGBtpyn9q89QTzyWqtQ+1FhDyd9DbwpU78jiAFgkW
         iwaEVJOic+eoKcZKjpeh1gOkNpLRyPAIPX9bcHOMbKrSizKz/q0TDuWu7I6EOG2ZKsPJ
         f1dcXKlaqoeivTx9/FMhB3nPaghwVC75jYYo9OpUawvjR1E49UzXdT8hYBh/DbJnUwzd
         6SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044316; x=1691636316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMufGZRURrHmH1jJKqkA3fgmQNlTbVYYmj3oN03vBtA=;
        b=gLnQUAA7pFLp7e7IPxXRX9GKw/JFNIrokrKW47dCn1VxpgTitnEY5pRv4NWZwBhY8S
         ErRht71kMdr2mWF/9iBzT4/0AVLtKLZ+5KwXpV5ewEi36UkhzKwaRoG0IGg4uaYWRgVZ
         X5GPDw4CfefUnNvvdAnC3y8Pp2juGu65c5tm5Z1QETyyl1K1HDUT6SjlgtHYb2/FKBDY
         M7mHikpBGgRogM2g/fBpIObU1Ha2S6fD+ZSpDTloN77iC8y1Q527rDsi7j8nU1V9/r2B
         Nszk2iuZLJGr+6/Z/iwbqXRkJX16Vv/oJqVNVaBRQWBoWBJkN4+aCOXTp5se9WmmBWtU
         RB3g==
X-Gm-Message-State: ABy/qLZNM2ONCp0kOlq2QC8kugBnKhhNt0v+JU1Qm8rMrKzqQjuTmDZr
        aufMViiqCSvxiCSnV/oPI+z1AYE/DhIMSZ0/yP8=
X-Google-Smtp-Source: APBJJlFn0LTrUNNgfERWrZCo1wa9S5uvR0s9Hf0aCUTVLJN7y83WxF8AvQ37tk9B2sNYxZlm1O21zmKvT4+hUw8YXb0=
X-Received: by 2002:aa7:ccd1:0:b0:516:af22:bcc6 with SMTP id
 y17-20020aa7ccd1000000b00516af22bcc6mr11767994edt.21.1689044316425; Mon, 10
 Jul 2023 19:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230710080348.4137875-1-chunyan.zhang@unisoc.com> <fb86f01a-81b3-62c5-050f-f44e591bf272@linux.alibaba.com>
In-Reply-To: <fb86f01a-81b3-62c5-050f-f44e591bf272@linux.alibaba.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 11 Jul 2023 10:57:59 +0800
Message-ID: <CAAfSe-ttuTvOE-BbnNk5LiAqhZHcPEe9XSeunCxkpG4-95Tcjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sprd: Assign sprd_port after initialized to
 avoid wrong access
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 17:57, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 7/10/2023 4:03 PM, Chunyan Zhang wrote:
> > The global pointer 'sprd_port' maybe not zero when sprd_probe returns
> > fail, that is a risk for sprd_port to be accessed afterward, and will
> > lead unexpected errors.
> >
> > For example:
> >
> > There're two UART ports, UART1 is used for console and configured in kernel
> > command line, i.e. "console=";
> >
> > The UART1 probe fail and the memory allocated to sprd_port[1] was released,
> > but sprd_port[1] was not set to NULL;
>
> IMO, we should just set sprd_port[1] to be NULL, which seems simpler?

This patch just does like this indeed, in the label of 'clean_port'.
Adding a local variable instead of using global pointer (sprd_port[])
to store the virtual address allocated for sprd_port can avoid
overmany goto labels.

>
> >
> > In UART2 probe, the same virtual address was allocated to sprd_port[2],
> > and UART2 probe process finally will go into sprd_console_setup() to
> > register UART1 as console since it is configured as preferred console
> > (filled to console_cmdline[]), but the console parameters (sprd_port[1])
> > actually belongs to UART2.
>
> I'm confusing why the console parameters belongs to UART2? Since the
> console_cmdline[] will specify the serial index, that belongs to UART1.

The same virtual address stored in sprd_port[1] was reallocated to
sprd_port[2] after the UART1 probe returned failure.

Thanks for the review,
Chunyan


> Please correct me if I miss something.
>
> > So move the sprd_port[] assignment to where the port already initialized
> > can avoid the above issue.
> >
> > Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >   drivers/tty/serial/sprd_serial.c | 24 ++++++++++++++++--------
> >   1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > index b58f51296ace..942808517393 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1106,7 +1106,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
> >   static int sprd_clk_init(struct uart_port *uport)
> >   {
> >       struct clk *clk_uart, *clk_parent;
> > -     struct sprd_uart_port *u = sprd_port[uport->line];
> > +     struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
> >
> >       clk_uart = devm_clk_get(uport->dev, "uart");
> >       if (IS_ERR(clk_uart)) {
> > @@ -1149,22 +1149,22 @@ static int sprd_probe(struct platform_device *pdev)
> >   {
> >       struct resource *res;
> >       struct uart_port *up;
> > +     struct sprd_uart_port *sport;
> >       int irq;
> >       int index;
> >       int ret;
> >
> >       index = of_alias_get_id(pdev->dev.of_node, "serial");
> > -     if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
> > +     if (index < 0 || index >= UART_NR_MAX) {
> >               dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
> >               return -EINVAL;
> >       }
> >
> > -     sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
> > -                                     GFP_KERNEL);
> > -     if (!sprd_port[index])
> > +     sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> > +     if (!sport)
> >               return -ENOMEM;
> >
> > -     up = &sprd_port[index]->port;
> > +     up = &sport->port;
> >       up->dev = &pdev->dev;
> >       up->line = index;
> >       up->type = PORT_SPRD;
> > @@ -1195,7 +1195,7 @@ static int sprd_probe(struct platform_device *pdev)
> >        * Allocate one dma buffer to prepare for receive transfer, in case
> >        * memory allocation failure at runtime.
> >        */
> > -     ret = sprd_rx_alloc_buf(sprd_port[index]);
> > +     ret = sprd_rx_alloc_buf(sport);
> >       if (ret)
> >               return ret;
> >
> > @@ -1208,12 +1208,20 @@ static int sprd_probe(struct platform_device *pdev)
> >       }
> >       sprd_ports_num++;
> >
> > +     sprd_port[index] = sport;
> > +
> >       ret = uart_add_one_port(&sprd_uart_driver, up);
> >       if (ret)
> > -             sprd_remove(pdev);
> > +             goto clean_port;
> >
> >       platform_set_drvdata(pdev, up);
> >
> > +     return 0;
> > +
> > +clean_port:
> > +     sprd_port[index] = NULL;
> > +     sprd_ports_num--;
> > +     uart_unregister_driver(&sprd_uart_driver);
> >       return ret;
> >   }
> >
