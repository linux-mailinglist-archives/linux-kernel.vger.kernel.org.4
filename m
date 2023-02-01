Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271366862C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBAJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:26:34 -0500
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01C53B12;
        Wed,  1 Feb 2023 01:26:33 -0800 (PST)
Received: from iva6-ada8eb386f2b.qloud-c.yandex.net (iva6-ada8eb386f2b.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:9a88:0:640:ada8:eb38])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id C98D85F3F9;
        Wed,  1 Feb 2023 12:26:30 +0300 (MSK)
Received: by iva6-ada8eb386f2b.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id TQSsijNZh0U1-qcp8fDCf;
        Wed, 01 Feb 2023 12:26:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1675243590;
        bh=cfD4NJTaGFoBJDNfN0cYFw0uTWIpXwHYbgy0wqpZOiY=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=M4BDk4vjtfQ75ADWUuABQBt5f/qaXq2kRqssOIXVnw4WMqqhtKdVsfG9G+6oCR79g
         oZgF09mn5JC3wEZQOaff+T1i36w/SjK4V0YdZFhSCu6CX5jKBqD3rz2Go8djoBlIs4
         9DmFrCYHk6+azMaafXilVpqnsGv5vcB62rOzAg00=
Authentication-Results: iva6-ada8eb386f2b.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Wed, 1 Feb 2023 12:26:28 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] gpio: ep93xx: split device in multiple
Message-ID: <20230201122628.2e4e1788@redslave.neermore.group>
In-Reply-To: <15f7dcbcdaf6fdb05bfc1d5bee1bb2e1bf3c43fc.camel@gmail.com>
References: <CAMRc=MciMOfCo_fS_Um0xaQT2H=QSRgEUA5iTwxmpXqo2k2NJg@mail.gmail.com>
        <20230201091021.7090-1-nikita.shubin@maquefel.me>
        <15f7dcbcdaf6fdb05bfc1d5bee1bb2e1bf3c43fc.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2023 10:18:47 +0100
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Hello Nikita,
> 
> On Wed, 2023-02-01 at 12:10 +0300, Nikita Shubin wrote:
> > This prepares ep93xx SOC gpio to convert into device tree driver:
> > - dropped banks and legacy defines
> > - split AB IRQ and make it shared
> > 
> > We are relying on IRQ number information A, B ports have single
> > shared IRQ, while F port have dedicated IRQ for each line.
> > 
> > Also we had to split single ep93xx platform_device into multiple,
> > one for each port, without this we can't do a full working
> > transition from legacy platform code into device tree capable. All
> > GPIO_LOOKUP were change to match new chip namings.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Bart, i've rebased on the top of gpio/for-next (there were issues
> > indeed), but this patch still won't apply. That's becouse it's
> > dependant on Linus patch:
> > https://lore.kernel.org/linux-arm-kernel/20230111132210.134478-1-linus.walleij@linaro.org/T/
> > 
> > Alexander can we have Linus patch somehow applied to ep93xx ?   
> 
> in contrast to me Linus and Bartosz do maintain their GPIO tree,
> from my side I've performed a quick test, so it's OK from my PoV to
> apply, but I cannot really assist here more.
> 

Oh sorry about that, i thought if it refers to
"arch/arm/mach-ep93xx/core.c" - you or Hartley should apply them.

> Linus and Bartosz do maintain their GPIO tree

Then it should already exist in gpio/for-next ;).

```
echo heartbeat > /sys/class/leds/platform\:grled/trigger
echo heartbeat > /sys/class/leds/platform\:rdled/trigger
```

Both working on my ts7250.
