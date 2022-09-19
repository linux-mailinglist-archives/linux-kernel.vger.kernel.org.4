Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1D5BCDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiISN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiISN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:56:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFD2A437;
        Mon, 19 Sep 2022 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595765; x=1695131765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=seKeYV0gOWzY7/c7QcQQFvW/59ue+xo+PLsduwkw7hE=;
  b=OJDVV2tfJnRuLrV2GasiNlWRwQlNJb2JduPllE2oCzZN2V0bDiRkB3WK
   GkB4nYDIWZQuixCfsQJO7YjmmEE1LtHhrcdIZ62MQq0AKPqdo+qZiEDNq
   HmM8kjEtCurNY4cnPPPGkiB+LPHzsSMxzf9qSO9zeLzvbPBF6PQFNZQqS
   l9uRerniy0M0Nf1TnYg7SBDcSU4CwO1Bl7vTwC0n/Mr+rIMdFFxKOOdlK
   4NKBCIbaakMS7jlLtZhPcsDEfXiJLVcR92prWIdzY3kiSi4edTljdYbWy
   Jv3Ge7E6hKX9H649W6sjnsMjLXJ4gzsHhKjbtA+6ehNbUyaw9TLVvz5L0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325696493"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="325696493"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="686982505"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2022 06:56:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaHFg-004ZxT-1T;
        Mon, 19 Sep 2022 16:56:00 +0300
Date:   Mon, 19 Sep 2022 16:56:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v2 1/1] serial: 8250: Turn IER bits on only after irq has
 been set up
Message-ID: <YySX8E3PjAvRr/ld@smile.fi.intel.com>
References: <20220916133804.15196-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916133804.15196-1-ilpo.jarvinen@linux.intel.com>
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>) id 1oZDO4-003IA7-1H;
 Fri, 16 Sep 2022 18:36:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:38:04PM +0300, Ilpo Järvinen wrote:
> Invoking TIOCVHANGUP on 8250_mid port and then reopening the port
> triggers these faults during serial8250_do_startup():
> 
>   DMAR: DRHD: handling fault status reg 3
>   DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> 
> The cause is a DMA write to the address in MSI address register that
> was zeroed during the hangup as the irq was freed. The writes are
> triggered due signalling an interrupt during the THRE test that
> temporarily toggles THRI in IER. The THRE test currently occurs before
> UART's irq (and MSI address) is properly set up.
> 
> Refactor serial8250_do_startup() such that irq is set up before the
> THRE test. The current irq setup code is intermixed with the timer
> setup code. As THRE test must be performed prior to the timer setup,
> extract it into own function and call it only after the THRE test.

Not sure if it was a formal v1, but anyway, the result is good, since
I was following the thread from the beginning.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Lennert Buytenhek <buytenh@arista.com>
> Tested-by: Lennert Buytenhek <buytenh@arista.com>
> Fixes: 40b36daad0ac ("[PATCH] 8250 UART backup timer")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> - Remove unnecessary changes to comments & newlines
> - Change Lennert's email & add Tested-by
> - Improve description of the problem (thank to Lennert's explanation)
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
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko


