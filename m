Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBF6051CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiJSVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:13:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB3188AB1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:13:33 -0700 (PDT)
Received: from sopl295.home ([109.220.248.156])
        by smtp.orange.fr with ESMTPA
        id lGNMo1N0Kg7y2lGNMocFLS; Wed, 19 Oct 2022 23:13:31 +0200
X-ME-Helo: sopl295.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 19 Oct 2022 23:13:31 +0200
X-ME-IP: 109.220.248.156
From:   Robert Jarzmik <jarzmik.robert@orange.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stern@rowland.harvard.edu, alexandre.belloni@bootlin.com,
        brgl@bgdev.pl, damien.lemoal@opensource.wdc.com,
        dmitry.torokhov@gmail.com, linux@dominikbrodowski.net,
        balbi@kernel.org, gregkh@linuxfoundation.org, deller@gmx.de,
        perex@perex.cz, jingoohan1@gmail.com, lee@kernel.org,
        kernel@wantstofly.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, marek.vasut@gmail.com,
        broonie@kernel.org, mkpetch@internode.on.net,
        miquel.raynal@bootlin.com, lost.distance@yahoo.com,
        philipp.zabel@gmail.com, linux@armlinux.org.uk, sre@kernel.org,
        slapin@ossfans.org, s.shtylyov@omp.ru, sudipm.mukherjee@gmail.com,
        tiwai@suse.com, ulf.hansson@linaro.org, vigneshr@ti.com,
        viresh.kumar@linaro.org, wsa+renesas@sang-engineering.com,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/30] ARM: pxa: remove all unused boards&drivers
References: <20221019161831.3864786-1-arnd@kernel.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 19 Oct 2022 23:13:20 +0200
In-Reply-To: <20221019161831.3864786-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 19 Oct 2022 18:17:53 +0200")
Message-ID: <m2sfjjh5zj.fsf@sopl295.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
...zip...

> A good number of drivers become impossible to select after this, so
> each of these also get dropped. I'm including the driver patches in the
> series here and can either merge them through the soc tree, or they
> can get picked up by the individual subsystem maintainers. Since both
> the platform and the drivers get removed, the order should not matter.
This part is a bit ... bothering.
I at least identified these :
>  delete mode 100644 drivers/input/touchscreen/wm9705.c
>  delete mode 100644 drivers/input/touchscreen/wm9712.c
>  delete mode 100644 drivers/input/touchscreen/wm9713.c
>  delete mode 100644 drivers/input/touchscreen/wm97xx-core.c
>  delete mode 100644 drivers/mfd/wm97xx-core.c
>  delete mode 100644 sound/ac97/bus.c
>  delete mode 100644 sound/ac97/codec.c
>  delete mode 100644 sound/ac97/snd_ac97_compat.c

For the existing platforms working with devicetree support (mioa701 for
example), the wm9713 was properly used, providing both sound support and input
touchscreen.
So was the a97 part, providing a framework to make the wm9713 work.

So I'm wondering how the choice to chop these drivers was done, and it is
necessary to remove them. If so, maybe pxa support in the kernel should be
removed all together, as people playing with it loose part of the working DT
platforms they had.

As for the removal of defconfigs and arch-pxa, sure, this was PXA's destiny.

Cheers.

--
Robert

PS: If this mail is sent twice, sorry in advance, my mailer is a bad mood
lately.
