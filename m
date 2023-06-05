Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7E722811
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjFEOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFEOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:02:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ACED;
        Mon,  5 Jun 2023 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685973721; x=1717509721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NGA9rIhc908BS62unw9O7z7MJCnWPsT9GleQVLM6vWc=;
  b=mWLms4Pg0qwkrFRUfPuGBhN0WWt54Kn36r6NChOhWW1a01pqysO1Bzov
   zmdd2/zh5CShYH/nCoYMiyjZUiVrdHH05Xz9vcbcydDP4gspAUYQMiIPv
   JdaYzbP9POdGU7Gk+GFXjboraL1YI3TYYrXzxg+0ls5c99KYuC/9j129Q
   OUYfdMf8wyCgemSHV0MAV0BUdrUAUZm9ZVWSi3I0nqE/sKiZ3Fgw1YwLK
   Ggr5/hGHaS8vXZZ00bbnEwe5guZZIv9LRCHvcSGZ+yB3igFoI5aI2z4C3
   /zpbexmrEFiGedPO2hge3a1QymrypupuRjuzuvGWCgmCsOD+P7bktZwrc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="358820538"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358820538"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773746578"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="773746578"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 07:01:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Alh-001O7Z-1L;
        Mon, 05 Jun 2023 17:01:09 +0300
Date:   Mon, 5 Jun 2023 17:01:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Liang He <windhl@126.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel@pengutronix.de, Michael Ellerman <mpe@ellerman.id.au>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
Message-ID: <ZH3qpAw9+dDzGVzf@smile.fi.intel.com>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de>
 <20230605130857.85543-3-u.kleine-koenig@pengutronix.de>
 <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com>
 <20230605133445.vi762odw2v7pkrog@pengutronix.de>
 <f01b13f5-34c9-62fc-52fd-33e923e2a2ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f01b13f5-34c9-62fc-52fd-33e923e2a2ba@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:44:08PM +0300, Ilpo Järvinen wrote:
> On Mon, 5 Jun 2023, Uwe Kleine-König wrote:
> > On Mon, Jun 05, 2023 at 04:22:55PM +0300, Ilpo Järvinen wrote:
> > > On Mon, 5 Jun 2023, Uwe Kleine-König wrote:
> > > > The need to handle the FSL variant of 8250 in a special way is also
> > > > present without console support. So soften the dependency for
> > > > SERIAL_8250_FSL accordingly. Note that with the 8250 driver compiled as
> > > > a module, some devices still might not make use of the needed
> > > > workarounds. That affects the ports instantiated in
> > > > arch/powerpc/kernel/legacy_serial.c.
> > > > 
> > > > This issue was identified by Dominik Andreas Schorpp.
> > > > 
> > > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > > must be put in the same compilation unit as 8250_port.o because the
> > > > latter defines some functions needed in the former and so 8250_fsl.o
> > > > must not be built-in if 8250_port.o is available in a module.
> > > > 
> > > > Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > Link: https://lore.kernel.org/r/20230531083230.2702181-1-u.kleine-koenig@pengutronix.de
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > > index 5313aa31930f..10c09b19c871 100644
> > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > >  
> > > >  config SERIAL_8250_FSL
> > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > > -	depends on SERIAL_8250_CONSOLE
> > > > +	depends on SERIAL_8250
> > > 
> > > Just one additional thought: After the adding the arch side 
> > > workaround/hack, SERIAL_8250_FSL could become a tristate?
> > 
> > I see no benefit for a module separate from 8250_base.ko. There are
> > dependencies in both directions between 8250_port.o and 8250_fsl.o[1].
> > So in my book a bool SERIAL_8250_FSL that modifies 8250_base.ko (with
> > SERIAL_8250=m) is fine.

> > [1] 8250_port.o uses fsl8250_handle_irq() from 8250_fsl.o
> 
> Is that after some fix which isn't in tty-next? I see only these:
> 
> $ git grep -l fsl8250_handle_irq
> arch/powerpc/kernel/legacy_serial.c
> drivers/tty/serial/8250/8250_fsl.c
> drivers/tty/serial/8250/8250_of.c
> include/linux/serial_8250.h
> 
> No users of fsl8250_handle_irq in 8250_port.c.

> >, and 8250_fsl.o uses serial8250_modem_status from 8250_port.o.

I don't like 8250_base to be fattened by some stuff that has no
generic meaning. Can we avoid putting every quirk there?

-- 
With Best Regards,
Andy Shevchenko


