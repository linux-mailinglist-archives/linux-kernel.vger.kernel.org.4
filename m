Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE1712771
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbjEZNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243675AbjEZNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D41B0;
        Fri, 26 May 2023 06:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEAE64FE8;
        Fri, 26 May 2023 13:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836ADC433D2;
        Fri, 26 May 2023 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685107400;
        bh=xJ6v8XRzEkgtwI83ON+sz5/7McQNk8B4qGX0hdyjKqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qjr3H3fqi+SVS47haXuIZ7fkCKrAkom5cWvlWv8FraMeNxfr5JcmD7Iry0U5j73bP
         lxcUDpPzwhzX++4rOV0D+HPh/sLUxLVd8Bmpn5/PnxAymKtyb2+e0c9kDwsLnDDxrN
         9jKiF0XmmCCeZBjnDkwQ3pZFNIkfKQabZ16K+bYgwPz4z/zM47mm/1/rr0iiEk7Paq
         GYDOny4fNArHrjgAIZGLbZwZpJNeS8LwZQanT0GXFK0nUNENYJYg2jJT1MnvMKGL3a
         xz4k1bsCQg9za28FOK1nkvq5KZtNfI7wZ1lF+UJmek2E9cCQAWWftLbsY/WG136C/S
         B7GopS+SZfPpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2XPo-0007Lg-Jj; Fri, 26 May 2023 15:23:32 +0200
Date:   Fri, 26 May 2023 15:23:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, maz@kernel.org, warthog618@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZHCy1PhyNAOCsalJ@hovoldconsulting.com>
References: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vcd8Q+-XMyfg3Y_hv_AL00PGgqg0jo7Yd7TTC4GrxPOuQ@mail.gmail.com>
 <CAMRc=MdHMiqhcpd2rFwjfKvwMWtTeTxG4fK+7zbzgSq9MHmGew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdHMiqhcpd2rFwjfKvwMWtTeTxG4fK+7zbzgSq9MHmGew@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:01:01PM +0200, Bartosz Golaszewski wrote:
> On Fri, May 19, 2023 at 12:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, May 19, 2023 at 8:07 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > On a system with pca9555 GPIOs that have been exported via sysfs the
> > > following warning could be triggered on kexec().
> > >
> > >   WARNING: CPU: 0 PID: 265 at drivers/gpio/gpiolib.c:3411 gpiochip_disable_irq
> > >   Call trace:
> > >    gpiochip_disable_irq
> > >    machine_crash_shutdown
> > >    __crash_kexec
> > >    panic
> > >    sysrq_reset_seq_param_set
> > >    __handle_sysrq
> > >    write_sysrq_trigger
> > >
> > > The warning is triggered because there is an irq_desc for the GPIO but
> > > it does not have the FLAG_USED_AS_IRQ set. This is because when the GPIO
> > > is exported via gpiod_export(), gpio_is_visible() is used to determine
> > > if the "edge" attribute should be provided but in doing so it ends up
> > > calling gpiochip_to_irq() which creates the irq_desc.
> > >
> > > Remove the call to gpiod_to_irq() from gpio_is_visible(). The actual
> > > intended creation of the irq_desc comes via edge_store() when requested
> > > by the user.
> >
> > To me it still sounds like a hack and the real solution should be done
> > differently/elsewhere.
> >
> > Also I'm worrying that not having this file visible or not may affect
> > existing user space custom scripts we will never hear about.
> >
> > P.S. TBH, I don't care much about sysfs, so if this patch finds its
> > way upstream, I won't be unhappy.
> >
> 
> Same. Which is why - if there'll be no more objections, I will apply it.

I don't think this should be applied.

It's still not clear from the commit message why gpiochip_disable_irq()
is called for a line which has not been requested. That seems like what
should be fixed, not changing some behaviour in the gpio sysfs interface
which has been there since forever (e.g. do not create the edge
attributes for gpios that cannot be used as interrupts).

There are other ways that mappings can be created (e.g. a gpio that
requested as as interrupt and then released) which would trigger the
same warning it seems.

Fix the root cause, don't just paper over the symptom.

Johan
