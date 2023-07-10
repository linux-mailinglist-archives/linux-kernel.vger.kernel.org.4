Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75774D553
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGJMZs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:25:45 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D1911B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:25:38 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso5188343276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991938; x=1691583938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM4VrnkOKahCQL3Z9io6VIWBmoWn4zfK2CwOjm+Fmgo=;
        b=Ru0GYbZLDwK5tdt1fSP3SNKWFIQuzaD80KTnwSBZ+IGmdfLb/IrFlXrDGmnjwioDCX
         MGbbhWPyEgJzIs/dHRPEdaR1G40Sv4oCynfMGWq1qZ9cIS7lmITT1YEVtNNNj9vQDpiX
         9Qe5atej8rQbYDCef5S/4bpkBgIr049V1NpOkWhY8cx7keOVCTz9Bn0f/N7a3vEtdwlM
         qlaPAwep5kXNLAigi6f20Nvxr+X9Gj6NeNP0onxXnLhXC97EdkM0Xi7e4NTZ4734sU4C
         GniqdNYbw8RYG9mvpRpV1q2NtXDLsVaBDnmG88ZGoxFUON0Rd7rLV/iZlljW4kTM0/6t
         gtwg==
X-Gm-Message-State: ABy/qLacwfusIddOWsc4WHoI9bZfAz7uezLZRZ5Ewp1dAQASjPELECXp
        /fNQMMZy1t8oHhTe8E1iNisTFWgEPhY6hg==
X-Google-Smtp-Source: APBJJlEuodjkOhdeJwiCeCKKMdS+yEnWxXZuL6l0IC3Zt2KeDY9r8UR5lk/9+OlQ6mRXPTucKz514g==
X-Received: by 2002:a25:6086:0:b0:ba8:60ab:a7d3 with SMTP id u128-20020a256086000000b00ba860aba7d3mr9411621ybb.48.1688991937775;
        Mon, 10 Jul 2023 05:25:37 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w17-20020a05690202d100b00bf44703efd3sm2528044ybh.6.2023.07.10.05.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:25:37 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso5180232276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:25:37 -0700 (PDT)
X-Received: by 2002:a25:4907:0:b0:c18:1300:633b with SMTP id
 w7-20020a254907000000b00c181300633bmr9694758yba.46.1688991937401; Mon, 10 Jul
 2023 05:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230710095926.15614-1-frank.li@vivo.com>
In-Reply-To: <20230710095926.15614-1-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:25:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx7h47cOg8AJysbS_ohT=SfRsXW+vRUh+KiOPEsXNfnA@mail.gmail.com>
Message-ID: <CAMuHMdXx7h47cOg8AJysbS_ohT=SfRsXW+vRUh+KiOPEsXNfnA@mail.gmail.com>
Subject: Re: [PATCH v4 01/21] genirq/devres: Add devm_request_threaded_irq_probe()
 and devm_request_irq_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Mon, Jul 10, 2023 at 12:05 PM Yangtao Li <frank.li@vivo.com> wrote:
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
>
> And tglx point out that:
>
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>
>      519 messages total (there are probably more)
>
>      352 unique messages
>
>      323 unique messages after lower casing
>
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>
>      The most useful one of all is: "could request wakeup irq: %d"
>
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>
> So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
> which ensure that all error handling branches print error information.
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for your patch!

> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -201,6 +201,21 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
>
>  struct device;
>
> +extern int __must_check
> +devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> +                             irq_handler_t handler, irq_handler_t thread_fn,
> +                             unsigned long irqflags, const char *devname,
> +                             void *dev_id, const char *info);
> +
> +static inline int __must_check
> +devm_request_irq_probe(struct device *dev, unsigned int irq,
> +                      irq_handler_t handler, unsigned long irqflags,
> +                      const char *devname, void *dev_id, const char *info)
> +{
> +       return devm_request_threaded_irq_probe(dev, irq, handler, NULL, irqflags,
> +                                        devname, dev_id, info);
> +}
> +
>  extern int __must_check
>  devm_request_threaded_irq(struct device *dev, unsigned int irq,
>                           irq_handler_t handler, irq_handler_t thread_fn,
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index f6e5515ee077..43a40d6e2e0b 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -79,6 +79,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  }
>  EXPORT_SYMBOL(devm_request_threaded_irq);
>
> +/**
> + *     devm_request_threaded_irq_probe - allocate an interrupt line for a managed device
> + *     @dev: device to request interrupt for
> + *     @irq: Interrupt line to allocate
> + *     @handler: Function to be called when the IRQ occurs
> + *     @thread_fn: function to be called in a threaded interrupt context. NULL
> + *                 for devices which handle everything in @handler
> + *     @irqflags: Interrupt type flags
> + *     @devname: An ascii name for the claiming device, dev_name(dev) if NULL
> + *     @dev_id: A cookie passed back to the handler function
> + *     @info: Optional additional error log
> + *
> + *     This is a variant of the devm_request_threaded_irq function.
> + *     It will print an error message by default when the request fails,
> + *     and the consumer can add a special error msg.
> + *
> + *     Except for the extra @dev argument, this function takes the

... extra @dev and @info arguments, ...

> + *     same arguments and performs the same function as
> + *     request_threaded_irq().  IRQs requested with this function will be

But probably you want to compare with devm_request_threaded_irq()
instead of with request_threaded_irq()?
I.e. "... extra @info argument..." above.

> + *     automatically freed on driver detach.
> + *
> + *     If an IRQ allocated with this function needs to be freed
> + *     separately, devm_free_irq() must be used.
> + */
> +int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> +                                   irq_handler_t handler, irq_handler_t thread_fn,
> +                                   unsigned long irqflags, const char *devname,
> +                                   void *dev_id, const char *info)
> +{
> +       int rc;
> +
> +       rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
> +       if (rc)
> +               return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
> +                                    thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> +                                    info ? : "");
> +       return 0;
> +}
> +EXPORT_SYMBOL(devm_request_threaded_irq_probe);
> +
>  /**
>   *     devm_request_any_context_irq - allocate an interrupt line for a managed device
>   *     @dev: device to request interrupt for

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
