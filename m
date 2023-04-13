Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F56E11AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDMQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDMQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:06:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93383EA;
        Thu, 13 Apr 2023 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681402000; x=1712938000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rOehdBIrreHkMjOxugsVNu2ybTTdqeAOr5KilNtz1OA=;
  b=Ak1fzE/z0NYUWwyrwx5KhjEgUwCa0MKMf+/q3lV+R9NdM9s6ZnfEdb4v
   s2kbg6iNqyj8OVt4LrMqeS53s4t2so4GXfp8DOCZzSXq0bo6TMo2PWkTq
   5Bs+9SOVy2tHa8PpXzgB2K8a5DHq6EeuwVJctX1OdmvXiW0zF3ps7Wo3D
   wLxQQHl844g/j+rDGI6GaA2DMEQoqbxQ5krsuwl9o/U5nxmEJDrZY75PC
   cbdhgJ2TFl2NabQ1dQv9Zx+JknH0A5c5JTRtzZeibF+31OpQVifl4I7rF
   //JAV3/uM8z2OuINv+qELQV6vKCkMAJZfvq4336dt8AySqCtupXNVT3Kv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341722722"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="341722722"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 09:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="754062124"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="754062124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2023 09:06:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmzT1-00GcXx-1e;
        Thu, 13 Apr 2023 19:06:35 +0300
Date:   Thu, 13 Apr 2023 19:06:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Clear port->pm on port specific driver
 unbind
Message-ID: <ZDgoi2mFYYqswAhu@smile.fi.intel.com>
References: <20230413070342.36155-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413070342.36155-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:03:41AM +0300, Tony Lindgren wrote:
> When we unbind a serial port hardware specific 8250 driver, the generic
> serial8250 driver takes over the port. After that we see an oops about 10
> seconds later. This can produce the following at least on some TI SoCs:
> 
> Unhandled fault: imprecise external abort (0x1406)
> Internal error: : 1406 [#1] SMP ARM
> 
> Turns out that we may still have the serial port hardware specific driver
> port->pm in use, and serial8250_pm() tries to call it after the port
> specific driver is gone:
> 
> serial8250_pm [8250_base] from uart_change_pm+0x54/0x8c [serial_base]
> uart_change_pm [serial_base] from uart_hangup+0x154/0x198 [serial_base]
> uart_hangup [serial_base] from __tty_hangup.part.0+0x328/0x37c
> __tty_hangup.part.0 from disassociate_ctty+0x154/0x20c
> disassociate_ctty from do_exit+0x744/0xaac
> do_exit from do_group_exit+0x40/0x8c
> do_group_exit from __wake_up_parent+0x0/0x1c
> 
> Let's fix the issue by clearing port->pm in serial8250_unregister_port().

Sounds to me like a fix that needs a Fixes tag.
Code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1157,6 +1157,7 @@ void serial8250_unregister_port(int line)
>  		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
>  		uart->port.type = PORT_UNKNOWN;
>  		uart->port.dev = &serial8250_isa_devs->dev;
> +		uart->port.pm = NULL;
>  		uart->capabilities = 0;
>  		serial8250_apply_quirks(uart);
>  		uart_add_one_port(&serial8250_reg, &uart->port);
> -- 
> 2.40.0

-- 
With Best Regards,
Andy Shevchenko


