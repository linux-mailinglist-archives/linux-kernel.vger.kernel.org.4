Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878E6B9853
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCNOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCNOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA05A56A5;
        Tue, 14 Mar 2023 07:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB83617D6;
        Tue, 14 Mar 2023 14:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9898BC4339B;
        Tue, 14 Mar 2023 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678805501;
        bh=HjYwDLvn5xq8HcnewhUzuZI6AHtUqffuITl4OpzsUJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfGjjKJjxHq0erIiGeuKqrDUiysOREmw2zI31nyW/8PZ2WrjhQSW9MJUzGqPIkObL
         +jq3uBOiat3vuoxFWieX2DcF41nC2yjzbnQV9n1X5PWAomaWA6QmNDJks8BC/Qi9gY
         niOd5o/JctKHXVQ0PzULjyc7SKHdlZB4rE6PR19PlVytbdlBlWXuFUUIphkf9kISTO
         5g0ZVP3feKnVTc/e8EUzubAGjIylfFIqXLLUGskruKavhehuZ+xx44v7b6z/WGiVMK
         tWh/Z+rCcx119HZ9aiXIZRTYcCQ4+EXp0PG64zdMBN8n8xg/laWP2K0MGbz8ui+r3N
         G1C9zdJsc/HYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pc616-00081K-Tt; Tue, 14 Mar 2023 15:52:45 +0100
Date:   Tue, 14 Mar 2023 15:52:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH 1/1] gpiolib: allow device numbering using OF alias
Message-ID: <ZBCKPMll1yt5gMf0@hovoldconsulting.com>
References: <20230215092421.143199-1-alexander.stein@ew.tq-group.com>
 <CACRpkdZbcs4zgGtuF5U4_JghHJ=A31T8jp2NTcN68P2Eh2azxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZbcs4zgGtuF5U4_JghHJ=A31T8jp2NTcN68P2Eh2azxg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

and sorry about the late reply on this.

On Wed, Feb 15, 2023 at 03:43:41PM +0100, Linus Walleij wrote:
> Top-posting because important people are missing from the to:line.
> 
> It seems you are trying to enforce topology here,
> i.e. hammering down what should come first, second etc, despite the
> probe order.
> 
> First the DT people need to acknowledge that this is a valid way to use
> device tree aliases. I'm not so sure about that. Remember that DT
> is mostly OS neutral, but we do have aliases for some use cases that
> can be the same tricky in any OS.

Yeah, I believe the idea is that aliases should generally be avoided
expect possibly for the console (or named) serial ports and first
ethernet interface.

> Second I want Johan Hovolds input on this from the Linux sysfs side, as
> he keeps reminding me that sysfs already has topology and should be
> discovered from there (loosely paraphrased from memory). It might
> be that you are fixing something that should not be fixed.

If user space needs to access some gpios directly then you can name
those resources and that should not rely on having stable gpiochip
ids.

> On Wed, Feb 15, 2023 at 10:24 AM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> 
> > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> >
> > This is useful e.g. for the following cases
> >
> > - GPIO IP name order is not aligned with SOC addresses
> >   (i.MX93 from NXP)
> > - reproducible naming for GPIO expander chips
> >
> > The implementation is a mix of the one found for MMC and RTC.
> >
> > Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > imx93 specifies alias for 4 on-chip GPIO controllers. But they are
> > ignored:
> > $ ls -o -g /sys/bus/gpio/devices/
> > total 0
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip0 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0071/gpiochip0
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip1 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0072/gpiochip1
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip2 -> ../../../devices/platform/soc@0/43810080.gpio/gpiochip2
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip3 -> ../../../devices/platform/soc@0/43820080.gpio/gpiochip3
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip4 -> ../../../devices/platform/soc@0/43830080.gpio/gpiochip4
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip5 -> ../../../devices/platform/soc@0/47400080.gpio/gpiochip5
> > lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip6 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0070/gpiochip6

Johan
