Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE976EF2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjDZKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbjDZKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:53 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75034EC3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:53:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 7de87a15-e420-11ed-abf4-005056bdd08f;
        Wed, 26 Apr 2023 13:52:53 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 26 Apr 2023 13:52:51 +0300
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <ZEkCg-WqwBHVZwHC@surfacebook>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
 <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux>
 <20230426071910.GE14287@atomide.com>
 <20230426093920.3e9b5c61@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426093920.3e9b5c61@aktux>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Apr 26, 2023 at 09:39:20AM +0200, Andreas Kemnade kirjoitti:
> On Wed, 26 Apr 2023 10:19:10 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [230425 19:58]:
> > > On Tue, 25 Apr 2023 22:36:37 +0300
> > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > > > On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:  
> > > > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:    

...

> > > > > > Which commit introduced that regression? Also, the changelog mentions
> > > > > > it happens only with "unusual" probe order. Now, all the ordinary cases
> > > > > > for OMAP1 are broken.
> > > > > >     
> > > > > did not bisect that to an exact commit.
> > > > > Unusual probe order: on the device where I tested it,
> > > > > I did not see a completely successful probe.    
> > > > 
> > > > If you cannot point out a working past commit, there was no regression. If
> > > > you fix something that hasn't worked before or has been long time broken,
> > > > it must not cause breakage to other current users.
> > > >   
> > > Well, I did not take the time for a bisect. As we need a less aggressive
> > > fix, it seems to be worth doing it. 
> > >   
> > > > > > And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> > > > > > and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> > > > > > well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> > > > > > stopped now working.
> > > > > >     
> > > > > so we break every non-devicetree user of omap-gpio?     
> > > > 
> > > > It seems so.
> > > >   
> > > or maybe an if (not_using_devicetree())  
> > 
> > Not sure what the best way to fix this might be, adding Linus W to Cc too.
> > Maybe using gpio line names in the legacy platform data instead of numbers?
> > 
> > Seems that we should just revert this patch for now and try again after
> > the issues have been fixed.
> >
> I think the reason for the patch (besides of cleaning up warnings) is that
> dynamic allocation seems to start at 512, static at zero.
> If both are there, like registering twl_gpio between omap gpiochip 4 and 5,
> dynamic allocation seems just to start after the last static number,
> calling for trouble.
> 
> If dynamic alloc would just start at 512 in that case too, no problem would appear.
> As said I have not bisected it to an exact commit yet.
> So if we need to move backward, we should IMHO first fix that allocation thing.

I agree.

As PoC can the reported add the following lines

	if (gdev->base < GPIO_DYNAMIC_BASE)
		continue;

after https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L190
and test your idea?


-- 
With Best Regards,
Andy Shevchenko


