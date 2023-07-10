Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D374D5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGJMlr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGJMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:41:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092CAD8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:41:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R03ST4p06z6D8Y6;
        Mon, 10 Jul 2023 20:38:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 10 Jul
 2023 13:41:37 +0100
Date:   Mon, 10 Jul 2023 13:41:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/21] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
Message-ID: <20230710134135.00007ba7@Huawei.com>
In-Reply-To: <CAMuHMdXx7h47cOg8AJysbS_ohT=SfRsXW+vRUh+KiOPEsXNfnA@mail.gmail.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
        <CAMuHMdXx7h47cOg8AJysbS_ohT=SfRsXW+vRUh+KiOPEsXNfnA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 14:25:24 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Yangtao,
> 
> On Mon, Jul 10, 2023 at 12:05 PM Yangtao Li <frank.li@vivo.com> wrote:
> > There are more than 700 calls to devm_request_threaded_irq method and
> > more than 1000 calls to devm_request_irq method. Most drivers only
> > request one interrupt resource, and these error messages are basically
> > the same. If error messages are printed everywhere, more than 2000 lines
> > of code can be saved by removing the msg in the driver.
> >
> > And tglx point out that:
> >
> >   If we actually look at the call sites of
> >   devm_request_threaded_irq() then the vast majority of them print more or
> >   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> >
> >      519 messages total (there are probably more)
> >
> >      352 unique messages
> >
> >      323 unique messages after lower casing
> >
> >          Those 323 are mostly just variants of the same patterns with
> >          slight modifications in formatting and information provided.
> >
> >      186 of these messages do not deliver any useful information,
> >          e.g. "no irq", "
> >
> >      The most useful one of all is: "could request wakeup irq: %d"
> >
> >   So there is certainly an argument to be made that this particular
> >   function should print a well formatted and informative error message.
> >
> >   It's not a general allocator like kmalloc(). It's specialized and in the
> >   vast majority of cases failing to request the interrupt causes the
> >   device probe to fail. So having proper and consistent information why
> >   the device cannot be used _is_ useful.
> >
> > So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
> > which ensure that all error handling branches print error information.
> > In this way, when this function fails, the upper-layer functions can
> > directly return an error code without missing debugging information.
> > Otherwise, the error message will be printed redundantly or missing.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>  
> 
> Thanks for your patch!
> 
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -201,6 +201,21 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
> >
> >  struct device;
> >
> > +extern int __must_check
> > +devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> > +                             irq_handler_t handler, irq_handler_t thread_fn,
> > +                             unsigned long irqflags, const char *devname,
> > +                             void *dev_id, const char *info);
> > +
> > +static inline int __must_check
> > +devm_request_irq_probe(struct device *dev, unsigned int irq,
> > +                      irq_handler_t handler, unsigned long irqflags,
> > +                      const char *devname, void *dev_id, const char *info)
> > +{
> > +       return devm_request_threaded_irq_probe(dev, irq, handler, NULL, irqflags,
> > +                                        devname, dev_id, info);
> > +}
> > +
> >  extern int __must_check
> >  devm_request_threaded_irq(struct device *dev, unsigned int irq,
> >                           irq_handler_t handler, irq_handler_t thread_fn,
> > diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> > index f6e5515ee077..43a40d6e2e0b 100644
> > --- a/kernel/irq/devres.c
> > +++ b/kernel/irq/devres.c
> > @@ -79,6 +79,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> >  }
> >  EXPORT_SYMBOL(devm_request_threaded_irq);
> >
> > +/**
> > + *     devm_request_threaded_irq_probe - allocate an interrupt line for a managed device
It's awkward for the short description to be identical to devm_request_threaded_irq
but I can't think of a sensible and short way to differentiate it.

> > + *     @dev: device to request interrupt for
> > + *     @irq: Interrupt line to allocate
> > + *     @handler: Function to be called when the IRQ occurs
> > + *     @thread_fn: function to be called in a threaded interrupt context. NULL
> > + *                 for devices which handle everything in @handler
> > + *     @irqflags: Interrupt type flags
> > + *     @devname: An ascii name for the claiming device, dev_name(dev) if NULL
> > + *     @dev_id: A cookie passed back to the handler function
> > + *     @info: Optional additional error log
> > + *
> > + *     This is a variant of the devm_request_threaded_irq function.
> > + *     It will print an error message by default when the request fails,
> > + *     and the consumer can add a special error msg.
> > + *
> > + *     Except for the extra @dev argument, this function takes the  
> 
> ... extra @dev and @info arguments, ...
> 
> > + *     same arguments and performs the same function as
> > + *     request_threaded_irq().  IRQs requested with this function will be  
> 
> But probably you want to compare with devm_request_threaded_irq()
> instead of with request_threaded_irq()?
> I.e. "... extra @info argument..." above.
> 
> > + *     automatically freed on driver detach.
> > + *
> > + *     If an IRQ allocated with this function needs to be freed
> > + *     separately, devm_free_irq() must be used.
> > + */
> > +int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> > +                                   irq_handler_t handler, irq_handler_t thread_fn,
> > +                                   unsigned long irqflags, const char *devname,
> > +                                   void *dev_id, const char *info)
> > +{
> > +       int rc;
> > +
> > +       rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
> > +       if (rc)
> > +               return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
> > +                                    thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> > +                                    info ? : "");
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(devm_request_threaded_irq_probe);
> > +
> >  /**
> >   *     devm_request_any_context_irq - allocate an interrupt line for a managed device
> >   *     @dev: device to request interrupt for  
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Likewise, lgtm
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'd aim to get this upstream in one cycle with a few example drover changes
but if you plan to do mass changes, leave them for the following cycle to
make it really easy for maintainers to pick them up.

Jonathan


> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

