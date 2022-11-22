Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA2633976
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKVKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKVKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:12:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB865C6;
        Tue, 22 Nov 2022 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669111972; x=1700647972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkfiL1SWiTBuzefA52pcy+2yr5O15Ewlk9gdi/xHclw=;
  b=vmuYf9PJqvW58k7xcXP/Lkx92KNjScO4C6Zi6AroS/0lIb+T8ocXov+R
   LvwuPwbY3YIXsmF1tP3mTIc7jIgper50aansntIPc/D6Bkwiz+1XwJXzE
   Ngg0OaF118dOpTaQ98GFD2uw0NX1CX9c+J+Hc7o8yZRsBEsd8qJENN5vw
   y14EWxckaLSdS/rMeDurNnjbHnOEwTCGbbakUJomP7N22TVOcatpXDXKb
   bkpcDvvgG6kkfF4HSLg7o3fRSvdB3wujiiyyvRgau1+65BsDhvHyAPcR4
   fp7gXHlRwzaVhoEYIbk3iZOT4jRKUJHxeXSF1RfbbJ9XmaQVEyVziGLC3
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="124566194"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 03:12:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 03:12:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 03:12:48 -0700
Date:   Tue, 22 Nov 2022 10:12:30 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>
CC:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] soc: sifive: ccache: Add StarFive JH7110 support
Message-ID: <Y3ygjlEhu41dvT9k@wendy>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-6-hal.feng@starfivetech.com>
 <Y3dwdXExRRltyp8A@spud>
 <b4afb821-f899-a2b6-46e1-a31b5e3f974e@starfivetech.com>
 <CAJM55Z_LqTNEoo7CF-zfwqbKPTXEjji7aeLLeEgcLnacZ0z1Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_LqTNEoo7CF-zfwqbKPTXEjji7aeLLeEgcLnacZ0z1Og@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:54:34AM +0100, Emil Renner Berthing wrote:
> On Tue, 22 Nov 2022 at 10:03, Hal Feng <hal.feng@starfivetech.com> wrote:
> > On Fri, 18 Nov 2022 19:45:57 +0800, Conor Dooley wrote:
> > > Hey Emil/Hal,
> > > On Fri, Nov 18, 2022 at 09:17:11AM +0800, Hal Feng wrote:
> > > > From: Emil Renner Berthing <kernel@esmil.dk>

> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index 69774bb362d6..5a40e05f8cab 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -22,6 +22,7 @@ config SOC_STARFIVE
> > > >     bool "StarFive SoCs"
> > > >     select PINCTRL
> > > >     select RESET_CONTROLLER
> > > > +   select SIFIVE_CCACHE
> > >
> > > Please no. I am trying to get rid of these selects + I cannot figure out
> > > why this driver is so important that you *need* to select it. Surely the
> > > SoC is useable without it>
> > > Is this a hang over from your vendor tree that uses the driver to do
> > > non-coherent stuff for the jh7100?
> >
> > I have tested that the board can successfully boot up without the cache
> > driver. The `select` can be removed for JH7110. @Emil, what do you think
> > of this?
> 
> Yes, for the JH7110 this is not strictly needed, just like the
> Unmatched board. For the StarFive JH7100 it is though.
> So if you're only adding support for the JH7110 then it's not needed.

Even for the JH7100 there are other ways to do this than selects in
arch/riscv - for example
config SIFIVE_CCACHE
	default SOC_STARFIVE

But you don't need that either if you're not adding the JH7100 :)

> > > >  config SIFIVE_CCACHE
> > > >     bool "Sifive Composable Cache controller"
> > > > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> > > > index 1c171150e878..9489d1a90fbc 100644
> > > > --- a/drivers/soc/sifive/sifive_ccache.c
> > > > +++ b/drivers/soc/sifive/sifive_ccache.c
> > > > @@ -107,6 +107,7 @@ static const struct of_device_id sifive_ccache_ids[] = {
> > > >     { .compatible = "sifive,fu540-c000-ccache" },
> > > >     { .compatible = "sifive,fu740-c000-ccache" },
> > > >     { .compatible = "sifive,ccache0" },
> > > > +   { .compatible = "starfive,jh7110-ccache" },
> > >
> > > Per my second reply to the previous patch, I am not sure why you do not
> > > just have a fallback compatible in the binding/dt for the fu740 ccache
> > > since you appear to have identical configuration?
> >
> > Yeah, I will use the compatible of fu740 and modify this patch.
> 
> No, the JH7110 should not pretend to be a fu740, but if you add
> 
> compatible = "starfive,jh7110-ccache", "sifive,ccache0";
> 
> then this driver should still match "sifive,ccache0" without adding
> the "starfive,jh7110-ccache" entry.

Either works for me :) If you go for "sifive,ccache0", just make sure to
add the correct property enforcement - you can just copy the fu740 by
the looks of things (although that'd imply that it is compatible and can
fall back to it...)

Thanks,
Conor.

