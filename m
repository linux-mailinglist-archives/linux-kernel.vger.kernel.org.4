Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF17227CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjFENrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjFENrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:47:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E612100;
        Mon,  5 Jun 2023 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685972865; x=1717508865;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f/8Mm8l+bfLukgYZAlOu4RyviiusST+xkKpUSL7pBwk=;
  b=d9kE/1XRJ2ctJwSyRj69uSBL4VT6O3iJ7i9jeNwJ/z/mnvC3W5odSfKj
   dCbkWFrDGTTajJgcpjSjN4so7rkuEoLZVkvhpVg3zyxqPh0OXQPR+XP1i
   oV8+dCVM4flwJXRFeQSeRj8Fm29zBlIaQoYWdzN1ydaqTGEdlnQ1t3loM
   OrxYuv08UB9KUu0EcOM2elKvMAxgWmqFQu84QbJ1auEEPGFAE5ixkbzp1
   dP2iHV3C+0oKYYwY8LtYJwaAJlu7W7HPERiR3ECYHWVagoluMcZD/9SJJ
   uPVEf1db+90IvgGGsyqdEVyYEg3QW8mJyb6/LwcY7ZgbwnbYHqbv/WjyX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="353861634"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353861634"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 06:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955335772"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955335772"
Received: from gfittedx-mobl.ger.corp.intel.com ([10.252.47.115])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 06:44:10 -0700
Date:   Mon, 5 Jun 2023 16:44:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230605133445.vi762odw2v7pkrog@pengutronix.de>
Message-ID: <f01b13f5-34c9-62fc-52fd-33e923e2a2ba@linux.intel.com>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de> <20230605130857.85543-3-u.kleine-koenig@pengutronix.de> <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com> <20230605133445.vi762odw2v7pkrog@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1257931489-1685972655=:2703"
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

--8323329-1257931489-1685972655=:2703
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, Uwe Kleine-König wrote:

> On Mon, Jun 05, 2023 at 04:22:55PM +0300, Ilpo Järvinen wrote:
> > On Mon, 5 Jun 2023, Uwe Kleine-König wrote:
> > 
> > > The need to handle the FSL variant of 8250 in a special way is also
> > > present without console support. So soften the dependency for
> > > SERIAL_8250_FSL accordingly. Note that with the 8250 driver compiled as
> > > a module, some devices still might not make use of the needed
> > > workarounds. That affects the ports instantiated in
> > > arch/powerpc/kernel/legacy_serial.c.
> > > 
> > > This issue was identified by Dominik Andreas Schorpp.
> > > 
> > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > must be put in the same compilation unit as 8250_port.o because the
> > > latter defines some functions needed in the former and so 8250_fsl.o
> > > must not be built-in if 8250_port.o is available in a module.
> > > 
> > > Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Link: https://lore.kernel.org/r/20230531083230.2702181-1-u.kleine-koenig@pengutronix.de
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > >  drivers/tty/serial/8250/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > index 5313aa31930f..10c09b19c871 100644
> > > --- a/drivers/tty/serial/8250/Kconfig
> > > +++ b/drivers/tty/serial/8250/Kconfig
> > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > >  
> > >  config SERIAL_8250_FSL
> > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > -	depends on SERIAL_8250_CONSOLE
> > > +	depends on SERIAL_8250
> > 
> > Just one additional thought: After the adding the arch side 
> > workaround/hack, SERIAL_8250_FSL could become a tristate?
> 
> I see no benefit for a module separate from 8250_base.ko. There are
> dependencies in both directions between 8250_port.o and 8250_fsl.o[1].
> So in my book a bool SERIAL_8250_FSL that modifies 8250_base.ko (with
> SERIAL_8250=m) is fine.
> 
> Best regards
> Uwe
> 
> [1] 8250_port.o uses fsl8250_handle_irq() from 8250_fsl.o

Is that after some fix which isn't in tty-next? I see only these:

$ git grep -l fsl8250_handle_irq
arch/powerpc/kernel/legacy_serial.c
drivers/tty/serial/8250/8250_fsl.c
drivers/tty/serial/8250/8250_of.c
include/linux/serial_8250.h

No users of fsl8250_handle_irq in 8250_port.c.

-- 
 i.

>, and 8250_fsl.o uses serial8250_modem_status from 8250_port.o.

--8323329-1257931489-1685972655=:2703--
