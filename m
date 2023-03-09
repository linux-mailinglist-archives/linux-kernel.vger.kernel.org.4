Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB86B262C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjCIOBw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjCIOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:24 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B9D5983B;
        Thu,  9 Mar 2023 05:58:21 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1paGmd-003ofv-0O; Thu, 09 Mar 2023 14:58:15 +0100
Received: from dynamic-077-188-003-023.77.188.pool.telefonica.de ([77.188.3.23] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1paGmc-002po9-Py; Thu, 09 Mar 2023 14:58:14 +0100
Message-ID: <77c0a979af8c46a52dac2af435c16744698d6e5c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include
 <linux/gpio/driver.h>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-gpio@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Date:   Thu, 09 Mar 2023 14:58:14 +0100
In-Reply-To: <CAMuHMdUbZ69hcUBUBHpH1P1ZJ59ejTF=9vOdUMO-cgOHtBgGCA@mail.gmail.com>
References: <20230309135255.3861308-1-geert+renesas@glider.be>
         <a1f72b2bb25f8a06a10a436138e1032cc12b6506.camel@physik.fu-berlin.de>
         <CAMuHMdUbZ69hcUBUBHpH1P1ZJ59ejTF=9vOdUMO-cgOHtBgGCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.188.3.23
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-09 at 14:56 +0100, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> > On Thu, 2023-03-09 at 14:52 +0100, Geert Uytterhoeven wrote:
> > > shx3_defconfig:
> > > 
> > >     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
> > >     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
> > >       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> > >         |                                                              ^
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
> > > Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/arch/sh/boards/mach-x3proto/setup.c
> > > +++ b/arch/sh/boards/mach-x3proto/setup.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/usb/r8a66597.h>
> > >  #include <linux/usb/m66592.h>
> > >  #include <linux/gpio.h>
> > > +#include <linux/gpio/driver.h>
> > >  #include <linux/gpio_keys.h>
> > >  #include <mach/ilsel.h>
> > >  #include <mach/hardware.h>
> > 
> > Thanks. You were much faster than me. I didn't even have the time to have a look
> > at the problem yet ;-). Is it sufficient to pick this up for 6.4?
> 
> As the problem is introduced in and only found in gpio/for-next,
> I expect Linus or Andy to pick it up.

OK, thanks! I'm planning to prepare my for-next changes this weekend.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
