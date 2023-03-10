Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FD6B4B49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCJPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjCJPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:38:18 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB25134AFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:25:48 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n4so3751787ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678461947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdQamsC4vi5DdWnwK5HVEMpNIaeepKJtcchj23r+Ns8=;
        b=xRgf8zpxpRcJiHDvwUeCgbDOhtkP0Co5sv+gAy33WegXPv7/8fF4TChaKaOtJk7Zib
         p9248LVUG2Op1wOvSOlIN3/odHqRfA5uyWhQ+RCL/D4KcgIdvEK7nTGgRWvrJu7DwF68
         sG9v09jiWmvcWoAMA4OCSI8OUiY6S1+HZGGVvsKUEhzElhGVBwNBQ+A+mX6wTv8S8gzJ
         hMO8c8uEn1awYHv22BiJGlHel8L4nMzk7d8nnDK4iOpmrUHA4WqQN1E/ncqGT+JXGAxf
         1MgZ/5aFZSZ+zMeSbZ4OgVDyVDApZSpdwrT/vE+wCvVqciX5oRp7fbLAcCZvvo6aOWTX
         UDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdQamsC4vi5DdWnwK5HVEMpNIaeepKJtcchj23r+Ns8=;
        b=VxnwnyOcgIHodV/6uJQ12jIuk7J9jGc4s71pwpDk3KkxKi23ojsVJRugqLa6dVoZ+S
         ZXziX9xXNPG5qe/rAXG4HGCxf9iQC13ob7BwxXwfs29c5aBiF7cYJKyUNx2kFDU+2HJX
         Zzk6RlkRh/w2vO/GiXMEYN9ro+5dP9xdFsvmgJZW55JFSSGxUAXixg/MryUczXqy0mYE
         sP77XrtMDMZEhz37kAz9l25Nz1NiMkp1wJosfn0EDdOeKteoNr//WfqjEvH7g2hIQbQm
         Ap7Lf19zqBW/HR80Yn+K1DaFNRufiv2hWS8MejKmCKZpHje+S6JN9nPQ4i2gOXJ9GuYS
         IafQ==
X-Gm-Message-State: AO0yUKU4pPGIortAfFHCpC2h/iFkHir/yV+DOXJIkhg3aGksbu6IDF40
        60iatxzBYHxpQLp0G0o4pI6DxtPBFOl6i3YHeJ23nw==
X-Google-Smtp-Source: AK7set8JKIa0SDKefJ5/5r0bsBT4FjcaTDkUOLiUSu4UpVWrx/n+FeDaLWhaBvyJsXFMK706ylGuz6gzvS1T6/qS6zA=
X-Received: by 2002:a05:6122:588:b0:42f:6cba:201f with SMTP id
 i8-20020a056122058800b0042f6cba201fmr3007297vko.1.1678461947541; Fri, 10 Mar
 2023 07:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Mar 2023 16:25:36 +0100
Message-ID: <CAMRc=MdyjQDEMNxGYOKwWHry7MnEFMHYZSg=-FPohNwn6dxjaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Mass convert GPIO IRQ chips to be immutable
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 8:45=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> We are getting tired of these irq_chips not getting converted
> to be immutable, so I just take out the big hammer and fix
> some that I deem not too complex as best I can.
>
> I stopped after doing some, I will take another sweep at some
> point I guess.
>
> This is v6.4 material.
>
> The last two patches to pci-idio-* (patch 15 and 16) can be
> omitted if William's patches to convert this driver to
> regmap GPIO are merged first.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Deleted the irq_chip->name assignment in the Aspeed driver
> - Fold in a patch from Joel to make aspeed IRQs compulsory
> - Link to v2: https://lore.kernel.org/r/20230215-immutable-chips-v2-0-d6b=
0e3f2d991@linaro.org
>
> Changes in v2:
> - Rebased on v6.3-rc1
> - Collected some test and ACK tags
> - Link to v1: https://lore.kernel.org/r/20230215-immutable-chips-v1-0-51a=
8f224a5d0@linaro.org
>
> ---
> Joel Stanley (1):
>       gpio: aspeed: Always register the irqchip
>
> Linus Walleij (16):
>       gpio: altera: Convert to immutable irq_chip
>       gpio: adnp: Convert to immutable irq_chip
>       gpio: aspeed: Convert to immutable irq_chip
>       gpio: aspeed-sgpio: Convert to immutable irq_chip
>       gpio: ath79: Convert to immutable irq_chip
>       gpio: cadence: Convert to immutable irq_chip
>       gpio: hisi: Convert to immutable irq_chip
>       gpio: hlwd: Convert to immutable irq_chip
>       gpio: idt3243x: Convert to immutable irq_chip
>       gpio: msc313: Convert to immutable irq_chip
>       gpio: mlxbf2: Convert to immutable irq_chip
>       gpio: max732x: Convert to immutable irq_chip
>       gpio: omap: Drop irq_base
>       gpio: omap: Convert to immutable irq_chip
>       gpio: pci-idio-16: Convert to immutable irq_chip
>       gpio: pcie-idio-24: Convert to immutable irq_chip
>
>  drivers/gpio/gpio-adnp.c         |  9 ++++-
>  drivers/gpio/gpio-altera.c       | 25 +++++++-----
>  drivers/gpio/gpio-aspeed-sgpio.c | 44 +++++++++++++++++----
>  drivers/gpio/gpio-aspeed.c       | 82 ++++++++++++++++++++++++++--------=
-----
>  drivers/gpio/gpio-ath79.c        |  8 +++-
>  drivers/gpio/gpio-cadence.c      | 10 +++--
>  drivers/gpio/gpio-hisi.c         | 25 +++++++-----
>  drivers/gpio/gpio-hlwd.c         | 33 ++++++++++++----
>  drivers/gpio/gpio-idt3243x.c     | 11 ++++--
>  drivers/gpio/gpio-max732x.c      |  8 +++-
>  drivers/gpio/gpio-mlxbf2.c       | 32 ++++++++++++----
>  drivers/gpio/gpio-msc313.c       | 26 +++++++++++--
>  drivers/gpio/gpio-omap.c         | 83 ++++++++++++++++++++++------------=
------
>  drivers/gpio/gpio-pci-idio-16.c  | 12 ++++--
>  drivers/gpio/gpio-pcie-idio-24.c | 12 ++++--
>  15 files changed, 290 insertions(+), 130 deletions(-)
> ---
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> change-id: 20230215-immutable-chips-762922277f1e
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

Normally these irq_chip conversions would go upstream as fixes but
this time there are too many at once. I applied them to my
gpio/for-next branch. Let's give them some time in next and later we
can backport them if necessary.

Bartosz
