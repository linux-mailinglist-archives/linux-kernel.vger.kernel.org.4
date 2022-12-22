Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16804654529
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLVQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:28:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B633A46D;
        Thu, 22 Dec 2022 08:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07FAE60C17;
        Thu, 22 Dec 2022 16:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4530C433D2;
        Thu, 22 Dec 2022 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671726532;
        bh=quQ2OOb8SYWeKmOuvUZAVXbbPsSJZ2ipg0z5ydmhLNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+behxXYqfS5N7QM8iPekCkNaFdT/IsqRvsyEDTEEbtpgv1A+iBHwxjCH5Png/qfn
         r+gDGvBk7+Xvpvv6tQsqrr4E0OQQN4FIEfsoNOixyOliGIDPhSgE7y0YsFG1poAcR2
         XBhnHHDmkBP/BxVmWoaTXGWAIYDC5Pobcn85Iys8=
Date:   Thu, 22 Dec 2022 17:28:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 3/5] usb: gadget: udc: add Renesas RZ/N1 USBF
 controller support
Message-ID: <Y6SFwVqXXmobljwW@kroah.com>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
 <20221213133302.218955-4-herve.codina@bootlin.com>
 <CAMuHMdV7QNZ8Rv6iFLhj_MmBHL-vGWuWZdKB=REWba1UAWgkHw@mail.gmail.com>
 <Y6MFKdOU4IUQo70L@kroah.com>
 <20221222162438.4d06bd77@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222162438.4d06bd77@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:24:38PM +0100, Herve Codina wrote:
> Hi Geert, Greg,
> 
> On Wed, 21 Dec 2022 14:07:53 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Dec 21, 2022 at 02:03:43PM +0100, Geert Uytterhoeven wrote:
> > > Hi Hervé,
> > > 
> > > On Tue, Dec 13, 2022 at 2:33 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > Add support for the Renesas USBF controller.
> > > > This controller is an USB2.0 UDC controller available in the
> > > > Renesas r9a06g032 SoC (RZ/N1 family).
> > > >
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> > > 
> > > Thanks for your patch!
> > >   
> > > > --- /dev/null
> > > > +++ b/drivers/usb/gadget/udc/renesas_usbf.c  
> > >   
> > > > +#ifdef DEBUG
> > > > +#define TRACE(_fmt, ...) trace_printk("%s: " _fmt, __func__, ##__VA_ARGS__)
> > > > +#define USBF_TRACE_EP_MASK 0x0ffff /* All the 16 endpoints */
> > > > +#define TRACEEP(_ep, _fmt, ...)                                             \
> > > > +       do {                                                                \
> > > > +               if ((1 << (_ep)->id) & USBF_TRACE_EP_MASK)                  \
> > > > +                       trace_printk("%s: " _fmt, __func__, ##__VA_ARGS__); \
> > > > +       } while (0)
> > > > +#else
> > > > +#define TRACE(_fmt, ...) do { } while (0)
> > > > +#define TRACEEP(_ep, _fmt, ...) do { } while (0)  
> > > 
> > > Please use "no_printk(fmt, ##__VA_ARGS__)" instead of dummy loops,
> > > to avoid bad callers going unnoticed if DEBUG is not defined.  
> > 
> > Even better, do NOT define custom debug/trace macros for a single
> > driver, just use the ones that the rest of the kernel uses instead
> > please.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I would like to keep some granularity in debug messages and
> also keep the function name automatically added.
> I propose 3 kinds of messages:
> - general ones,
> - specific Endpoint0 ones,
> - other Endpoints ones.

All of those can work just fine using dev_dbg() today, no need to make
anything special for the driver.  You can turn those messages on/off
with no need to ever rebuild your driver, which is the key point.

> So before doing any modification in the source code, what do you
> think about:
>     /*
>      * Suggested tracers:
>      * - no_printk:    Disable tracing
>      * - trace_printk: Print to trace buffer
>      */
>     #define usbf_dbg(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA_ARGS__)
>     #define usbf_dbg_ep0(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA_ARGS__)
>     #define usbf_dbg_epn(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA_ARGS__)

Nope, just use dev_dbg() only please.  It provides MUCH more
funcationality and a unified interface with the rest of the kernel.
Please do not attempt to "roll your own" version of debugging macros for
just a single driver.

thanks,

greg k-h
