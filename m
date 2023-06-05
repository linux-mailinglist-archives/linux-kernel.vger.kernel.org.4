Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C537228F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjFEOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjFEOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:38:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3099;
        Mon,  5 Jun 2023 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685975892; x=1717511892;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ii0wAsvvPcH2RH0dwkgNRbrd5Rz5fLTuzH3e9FVwJYw=;
  b=gDLZkunr+Oe3K2eJ3U7xTt7knm5beCmPa4jgfy0Pro742/zs60qLsYOg
   dQ7UdFWF3Fran9JRsPcAbleT6J7A8egkxHfEXXsZU/FeBudxK0GPcIl1G
   xmKFQG16Db+WQ3mkI3Tt6W5eKz2eJXbB791wkqlia1xcKG9iGDLe7fpIE
   b1A8PHqXGPo++3S7L2DQN3QA8kkx+I60LjgLAiTViUMlU3WNUMt+yCLRU
   byN/f2nuxtuM6lG8hI3TRuletyZdmLIT8zoDOYbsDg3NqouhVrzAEyU+9
   2vkhEe1DFKLwJ+51UgXP1Vu/fGXcdck0UZZS0SWhrlB+eEKU3/o4FqScl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359695812"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359695812"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="741750834"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741750834"
Received: from gfittedx-mobl.ger.corp.intel.com ([10.252.47.115])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:38:07 -0700
Date:   Mon, 5 Jun 2023 17:38:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        kernel@pengutronix.de,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-serial <linux-serial@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liang He <windhl@126.com>
Subject: Re: [PATCH v3 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230605142225.75l6px3ep5ythkl6@pengutronix.de>
Message-ID: <9fa2b513-24a5-2e37-9a63-1fd5f53fa92@linux.intel.com>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de> <20230605130857.85543-3-u.kleine-koenig@pengutronix.de> <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com> <20230605133445.vi762odw2v7pkrog@pengutronix.de> <f01b13f5-34c9-62fc-52fd-33e923e2a2ba@linux.intel.com>
 <20230605142225.75l6px3ep5ythkl6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1799272671-1685975891=:2703"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1799272671-1685975891=:2703
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, Uwe Kleine-König wrote:

> Hello Ilpo,
> 
> On Mon, Jun 05, 2023 at 04:44:08PM +0300, Ilpo Järvinen wrote:
> > On Mon, 5 Jun 2023, Uwe Kleine-König wrote:
> > > On Mon, Jun 05, 2023 at 04:22:55PM +0300, Ilpo Järvinen wrote:
> > > > On Mon, 5 Jun 2023, Uwe Kleine-König wrote:
> > > > 
> > > > > The need to handle the FSL variant of 8250 in a special way is also
> > > > > present without console support. So soften the dependency for
> > > > > SERIAL_8250_FSL accordingly. Note that with the 8250 driver compiled as
> > > > > a module, some devices still might not make use of the needed
> > > > > workarounds. That affects the ports instantiated in
> > > > > arch/powerpc/kernel/legacy_serial.c.
> > > > > 
> > > > > This issue was identified by Dominik Andreas Schorpp.
> > > > > 
> > > > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > > > must be put in the same compilation unit as 8250_port.o because the
> > > > > latter defines some functions needed in the former and so 8250_fsl.o
> > > > > must not be built-in if 8250_port.o is available in a module.
> > > > > 
> > > > > Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > Link: https://lore.kernel.org/r/20230531083230.2702181-1-u.kleine-koenig@pengutronix.de
> > > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > > > index 5313aa31930f..10c09b19c871 100644
> > > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > > >  
> > > > >  config SERIAL_8250_FSL
> > > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > > > -	depends on SERIAL_8250_CONSOLE
> > > > > +	depends on SERIAL_8250
> > > > 
> > > > Just one additional thought: After the adding the arch side 
> > > > workaround/hack, SERIAL_8250_FSL could become a tristate?
> > > 
> > > I see no benefit for a module separate from 8250_base.ko. There are
> > > dependencies in both directions between 8250_port.o and 8250_fsl.o[1].
> > > So in my book a bool SERIAL_8250_FSL that modifies 8250_base.ko (with
> > > SERIAL_8250=m) is fine.
> > > 
> > > Best regards
> > > Uwe
> > > 
> > > [1] 8250_port.o uses fsl8250_handle_irq() from 8250_fsl.o
> > 
> > Is that after some fix which isn't in tty-next? I see only these:
> > 
> > $ git grep -l fsl8250_handle_irq
> > arch/powerpc/kernel/legacy_serial.c
> > drivers/tty/serial/8250/8250_fsl.c
> > drivers/tty/serial/8250/8250_of.c
> > include/linux/serial_8250.h
> > 
> > No users of fsl8250_handle_irq in 8250_port.c.
> 
> Ah right, I was too quick:
> 
> 	8250_of.o uses fsl8250_handle_irq() from 8250_fsl.o
> 	8250_fsl.o uses serial8250_modem_status() from 8250_port.o (which is in 8250_base.o)
> 
> 
> However linking 8250_fsl.o in 8250_of.o isn't a good solution either as
> 8250_fsl.o should also be available with CONFIG_SERIAL_OF_PLATFORM
> disabled to provide the ACPI driver. And as 8250_of.o already depends on
> 8250_port.o (e.g. via serial8250_em485_config()) adding 8250_fsl.o
> together with 8250_port.o into 8250_base.ko is fine and doesn't add new
> dependencies.

So we have dependencies one-way only:

8250_port

/\    |\
        \
8250_fsl \
         /
/\      /

8250_of

There's no loop here, both they be indepedent modules and configured 
independently (with a correct IS_*() in 8250_of.c).

-- 
 i.

--8323329-1799272671-1685975891=:2703--
