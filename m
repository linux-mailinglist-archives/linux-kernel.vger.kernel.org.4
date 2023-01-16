Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11F66CDA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjAPRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjAPRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:37:14 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 491A349019;
        Mon, 16 Jan 2023 09:14:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8CCDC8108;
        Mon, 16 Jan 2023 17:14:03 +0000 (UTC)
Date:   Mon, 16 Jan 2023 19:14:02 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andreas Kemnade <andreas@kemnade.info>, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: use dynamic allocation of base
Message-ID: <Y8WF2gXbrGnDLQ+S@atomide.com>
References: <20230113205922.2312951-1-andreas@kemnade.info>
 <CAMRc=Mf4-8AfTHLrvaF14tc2TJatxZJWnMOF-1G8HmDhPKSFAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf4-8AfTHLrvaF14tc2TJatxZJWnMOF-1G8HmDhPKSFAw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bartosz Golaszewski <brgl@bgdev.pl> [230116 08:38]:
> On Fri, Jan 13, 2023 at 9:59 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 80ddc43fd875..f5f3d4b22452 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1020,7 +1020,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
> >                 if (!label)
> >                         return -ENOMEM;
> >                 bank->chip.label = label;
> > -               bank->chip.base = gpio;
> > +               bank->chip.base = -1;
> >         }
> >         bank->chip.ngpio = bank->width;
> >
> > --
> > 2.30.2
> >
> 
> This could potentially break some legacy user-space programs using
> sysfs but whatever, let's apply it and see if anyone complains.

Worth a try for sure, fingers crossed. I guess /sys/class/gpio will
break at least.

Regards,

Tony
