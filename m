Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345B6757DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjATO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjATO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168241B72;
        Fri, 20 Jan 2023 06:57:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD89B61F8A;
        Fri, 20 Jan 2023 14:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F21C4339C;
        Fri, 20 Jan 2023 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674226661;
        bh=ypygvQlwer+ORu/AoOXl2IUKxeVMlTrXW7cTfAT/NPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kfuc9syxLlHjxTwsJQxy9OoIhPdIi9HVa4jlS2icIgmGaPJxmQpFvq5O6+fTtb1Va
         NYuovIg8XRnCiGae0XkS9LZzGYJx5iMow/LcEJIlyEvkxn2X2T+ZJynOahAseob7Fg
         nf3J5nSmPTVKmNP8zUElL7zK6Z/CZQ2HNFAl6ufkp5ZAHgTgAZ5P4RAmja11TlzZ5M
         sPE7+E+FYZj/kY0vzReTLDyEf4gjKXciMrT2yngmsg0UJGYFYGZHEInhhJjlFksKIe
         qA+R7Ct0uNhDOX8PX5JbMjIOVKXiiBC2BeRHygMUT6xuftYVBbryCWakrVPLhgsV08
         HJQhkGzCx8vEg==
Date:   Fri, 20 Jan 2023 14:57:33 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Marek Vasut <marex@denx.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 19/27] mfd: remove ucb1400 support
Message-ID: <Y8qr3U/AJK4jcKm5@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-20-arnd@kernel.org>
 <Y8qio/hwsP6+EG29@google.com>
 <9f0ddd93-a7b6-4b21-86ed-8604fb8a44e1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f0ddd93-a7b6-4b21-86ed-8604fb8a44e1@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Arnd Bergmann wrote:

> On Fri, Jan 20, 2023, at 15:18, Lee Jones wrote:
> > On Thu, 05 Jan 2023, Arnd Bergmann wrote:
> >
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The ucb1400 MFD driver and its gpio and touchscreen child
> >> drivers were only used on a few PXA machines that were unused
> >> for a while and are now removed.
> >> 
> >> Removing these leaves the AC97 support as ALSA specific,
> >> no other drivers are now connected through this interface.
> >> 
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> >> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Cc: Lee Jones <lee@kernel.org>
> >> Cc: Jaroslav Kysela <perex@perex.cz>
> >> Cc: Takashi Iwai <tiwai@suse.com>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-gpio@vger.kernel.org
> >> Cc: linux-input@vger.kernel.org
> >> Cc: alsa-devel@alsa-project.org
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/gpio/Kconfig                   |   7 -
> >>  drivers/gpio/Makefile                  |   1 -
> >>  drivers/gpio/gpio-ucb1400.c            |  85 -----
> >>  drivers/input/touchscreen/Kconfig      |  16 -
> >>  drivers/input/touchscreen/Makefile     |   1 -
> >>  drivers/input/touchscreen/ucb1400_ts.c | 458 -------------------------
> >>  drivers/mfd/Kconfig                    |  11 -
> >>  drivers/mfd/Makefile                   |   1 -
> >>  drivers/mfd/ucb1400_core.c             | 158 ---------
> >>  include/linux/ucb1400.h                | 160 ---------
> >>  sound/Kconfig                          |   1 -
> >>  sound/pci/ac97/ac97_codec.c            |   1 -
> >>  sound/pci/ac97/ac97_patch.c            |  40 ---
> >
> > Happy to take this with the relevant Acks.
> >
> > I assume an immutable branch is necessary.
> 
> I actually have this and the other bits from the series
> in my the soc tree already, aside from one bufix patch
> that Mark Brown picked up in the ASoC tree. If it's ok
> with you, I'd just leave it like this and submit
> everything together.

For this one, it's fine.

Acked-by: Lee Jones <lee@kernel.org>

I already applied the others.

-- 
Lee Jones [李琼斯]
