Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A472274B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjFENX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjFENXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:23:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9FD2;
        Mon,  5 Jun 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685971404; x=1717507404;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GaPBRwh/p3/q9XjwiMmF7kgvfkl5/deErODgA22dN94=;
  b=HcJzc8w8HjEWQXGr+ZQ9voecZm2+XgGaJwQiHFGeNUYp5bTDVWYcuvYJ
   52Ou8PZGIFUINtZJ+4wNNDL8M+YW1e6XJu1NdppE91GJaHOdbBM1qvO7Z
   eNMl8SVWJVk8xon9RmMEjThMiNA9hTV10LQO7kK4ERx7VegcGBTvjsnRg
   nP4AUgs7yUg2c4HKAW9hI7rmgV5srnG6y0Ujhk7KXmIF7Ie9k3DFb8gYl
   LDe70Oiixjt1EJmoM14G1wX0gbFEjjHGDv2MXsu37dvJGluiQTnSgA2ar
   QD2bavWVhi79f2+5huu/esSkerePdvj3k2g65J3HrYEbX62UgB1WVl94V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359676136"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359676136"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 06:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="882905242"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="882905242"
Received: from gfittedx-mobl.ger.corp.intel.com ([10.252.47.115])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 06:22:58 -0700
Date:   Mon, 5 Jun 2023 16:22:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kernel@pengutronix.de,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Rob Herring <robh@kernel.org>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Liang He <windhl@126.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230605130857.85543-3-u.kleine-koenig@pengutronix.de>
Message-ID: <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de> <20230605130857.85543-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-830021027-1685971383=:2703"
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

--8323329-830021027-1685971383=:2703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, Uwe Kleine-König wrote:

> The need to handle the FSL variant of 8250 in a special way is also
> present without console support. So soften the dependency for
> SERIAL_8250_FSL accordingly. Note that with the 8250 driver compiled as
> a module, some devices still might not make use of the needed
> workarounds. That affects the ports instantiated in
> arch/powerpc/kernel/legacy_serial.c.
> 
> This issue was identified by Dominik Andreas Schorpp.
> 
> To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> must be put in the same compilation unit as 8250_port.o because the
> latter defines some functions needed in the former and so 8250_fsl.o
> must not be built-in if 8250_port.o is available in a module.
> 
> Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/20230531083230.2702181-1-u.kleine-koenig@pengutronix.de
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/Kconfig  | 2 +-
>  drivers/tty/serial/8250/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 5313aa31930f..10c09b19c871 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
>  
>  config SERIAL_8250_FSL
>  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> -	depends on SERIAL_8250_CONSOLE
> +	depends on SERIAL_8250

Just one additional thought: After the adding the arch side 
workaround/hack, SERIAL_8250_FSL could become a tristate?

(1/2 might need a small change to take into account that it can now be a 
module).

>  	default PPC || ARM || ARM64
>  	help
>  	  Selecting this option enables a workaround for a break-detection
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 4fc2fc1f41b6..8824ba5295b6 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
>  8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
>  8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
> +8250_base-$(CONFIG_SERIAL_8250_FSL)	+= 8250_fsl.o
>  8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
>  obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
>  obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
> @@ -28,7 +29,6 @@ obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
> -obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
>  obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o

-- 
 i.

--8323329-830021027-1685971383=:2703--
