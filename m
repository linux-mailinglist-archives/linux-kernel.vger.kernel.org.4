Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC65BFEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIUNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIUNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:20:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB38293532;
        Wed, 21 Sep 2022 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663766456; x=1695302456;
  h=date:from:cc:subject:in-reply-to:message-id:references:
   mime-version;
  bh=vYgIHBqQT1LOSTdLXHjE2GGwmevR+anrYC3oXAZSnJk=;
  b=m91KiL9EZBDNnPeO1yVHjcRDB20rUWU5T65pw2VHoXqtkehKzATSHejm
   UrDD8dQWsi29FQ1qDdnXJyXzPU1+AetHWp4e4jB12Bsn05NMspcxerA3J
   pPu99Ez9wp356DMkAtfAo3icXcnIpSb7bspKKOMO1iq8GfQv1pHDaC21t
   NfDPXBvMflgiEVB57iTraW8n/qYEny5VJmw4IqQyCHqjRG1nMLS50x5Y/
   T3ak3XqSMkundQanGycngiTxsXE9gqA/2+FovvVLKEXrFYCjT5Z7CsX3P
   fSVecyAXlMaxb3uylLozxcCVY9soez+ABD3QMc/7MZuTmDK7rMndoFcBs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="298715561"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="298715561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 06:20:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="794668445"
Received: from dgonsal1-mobl1.ger.corp.intel.com ([10.252.58.151])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 06:20:52 -0700
Date:   Wed, 21 Sep 2022 16:20:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v3 1/1] serial: 8250: Toggle IER bits on only after irq
 has been set up
In-Reply-To: <20220919144057.12241-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <24ec3f1f-b39c-eeb1-d53-ed97e2ccdb4f@linux.intel.com>
References: <20220919144057.12241-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1816087576-1663766455=:1741"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MISSING_HEADERS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1816087576-1663766455=:1741
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 19 Sep 2022, Ilpo Järvinen wrote:

> Invoking TIOCVHANGUP on 8250_mid port on Ice Lake-D and then reopening
> the port triggers these faults during serial8250_do_startup():
> 
>   DMAR: DRHD: handling fault status reg 3
>   DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> 
> If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> address/data registers. Disabling the IRQ at the interrupt controller
> won't stop the UART from performing a DMA write to the address programmed
> in its MSI address register (zero) when it wants to signal an interrupt.
> 
> The UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> capability, so there is no way to mask the interrupt at the source PCI
> function level, except disabling the MSI capability entirely, but that
> would cause it to fall back to INTx# assertion, and the PCI specification
> prohibits disabling the MSI capability as a way to mask a function's
> interrupt service request.
> 
> The MSI address register is zeroed during by the hangup as the irq is
> freed. The interrupt is signalled during serial8250_do_startup()
> performing a THRE test that temporarily toggles THRI in IER. The THRE
> test currently occurs before UART's irq (and MSI address) is properly
> set up.
> 
> Refactor serial8250_do_startup() such that irq is set up before the
> THRE test. The current irq setup code is intermixed with the timer
> setup code. As THRE test must be performed prior to the timer setup,
> extract it into own function and call it only after the THRE test.
> 
> Reported-by: Lennert Buytenhek <buytenh@arista.com>
> Tested-by: Lennert Buytenhek <buytenh@arista.com>
> Fixes: 40b36daad0ac ("[PATCH] 8250 UART backup timer")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v3:
> - Improved the commit with Lennert's superior descriptions.
> - Added Andy's Rev-by
> 
>  drivers/tty/serial/8250/8250.h      |  2 ++
>  drivers/tty/serial/8250/8250_core.c | 16 +++++++++++-----
>  drivers/tty/serial/8250/8250_port.c |  8 +++++---
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 287153d32536..dbf4c1204bf3 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -403,3 +403,5 @@ static inline int serial_index(struct uart_port *port)
>  {
>  	return port->minor - 64;
>  }
> +
> +void univ8250_setup_timer(struct uart_8250_port *up);
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 2e83e7367441..10d535640434 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -298,10 +298,9 @@ static void serial8250_backup_timeout(struct timer_list *t)
>  		jiffies + uart_poll_timeout(&up->port) + HZ / 5);
>  }
>  
> -static int univ8250_setup_irq(struct uart_8250_port *up)
> +void univ8250_setup_timer(struct uart_8250_port *up)
>  {
>  	struct uart_port *port = &up->port;
> -	int retval = 0;
>  
>  	/*
>  	 * The above check will only give an accurate result the first time
> @@ -322,10 +321,17 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
>  	 */
>  	if (!port->irq)
>  		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
> -	else
> -		retval = serial_link_irq_chain(up);
> +}
> +EXPORT_SYMBOL_GPL(univ8250_setup_timer);
>  
> -	return retval;
> +static int univ8250_setup_irq(struct uart_8250_port *up)
> +{
> +	struct uart_port *port = &up->port;
> +
> +	if (port->irq)
> +		return serial_link_irq_chain(up);
> +
> +	return 0;
>  }
>  
>  static void univ8250_release_irq(struct uart_8250_port *up)
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 39b35a61958c..6e8e16227a3a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2294,6 +2294,10 @@ int serial8250_do_startup(struct uart_port *port)
>  	if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
>  		up->port.irqflags |= IRQF_SHARED;
>  
> +	retval = up->ops->setup_irq(up);
> +	if (retval)
> +		goto out;
> +
>  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>  		unsigned char iir1;
>  
> @@ -2336,9 +2340,7 @@ int serial8250_do_startup(struct uart_port *port)
>  		}
>  	}
>  
> -	retval = up->ops->setup_irq(up);
> -	if (retval)
> -		goto out;
> +	univ8250_setup_timer(up);
>  
>  	/*
>  	 * Now, initialize the UART

Hi Greg,

Please scratch this patch. It seems to create a circular dependency issue 
with allmodconfig. I'll send v4 once the problem is sorted out.

-- 
 i.

--8323329-1816087576-1663766455=:1741--
