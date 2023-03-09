Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6B6B25FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCIN5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 08:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCINzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:55:15 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2D460A4;
        Thu,  9 Mar 2023 05:55:09 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1paGjS-003nVv-BY; Thu, 09 Mar 2023 14:54:58 +0100
Received: from dynamic-077-188-003-023.77.188.pool.telefonica.de ([77.188.3.23] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1paGjS-002ozW-3O; Thu, 09 Mar 2023 14:54:58 +0100
Message-ID: <a1f72b2bb25f8a06a10a436138e1032cc12b6506.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include
 <linux/gpio/driver.h>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-gpio@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Date:   Thu, 09 Mar 2023 14:54:56 +0100
In-Reply-To: <20230309135255.3861308-1-geert+renesas@glider.be>
References: <20230309135255.3861308-1-geert+renesas@glider.be>
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

Hi Geert!

On Thu, 2023-03-09 at 14:52 +0100, Geert Uytterhoeven wrote:
> shx3_defconfig:
> 
>     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
>     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
>       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> 	  |                                                              ^
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
> Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/boards/mach-x3proto/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3proto/setup.c
> index 95b85f2e13dda75b..7f39fca95e57a109 100644
> --- a/arch/sh/boards/mach-x3proto/setup.c
> +++ b/arch/sh/boards/mach-x3proto/setup.c
> @@ -17,6 +17,7 @@
>  #include <linux/usb/r8a66597.h>
>  #include <linux/usb/m66592.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/gpio_keys.h>
>  #include <mach/ilsel.h>
>  #include <mach/hardware.h>

Thanks. You were much faster than me. I didn't even have the time to have a look
at the problem yet ;-). Is it sufficient to pick this up for 6.4?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
