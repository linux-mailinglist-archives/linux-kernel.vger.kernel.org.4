Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F030625FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKKQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:45:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4FF012;
        Fri, 11 Nov 2022 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668185121; x=1699721121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8e9e7nUGMQKTjT/UB23G+Vl6wm0WUKF3M0J9ZTBV5A=;
  b=VU7H6SgmkrWzhBo4aoeP8HpgPyVqEMDbxKqkTp203WVtdXHSDrAbDJIy
   78igevk8o8z+lsk4z43kVE+s/MXWeAqVNZ0fHeeIlHuNPu7T8RfO2io2m
   vRbi3Bv0nli7MlFmSSJ28pDwUbewPUH9FkcZw4xm2QAq8Ye6SdfqpOLT8
   wRJmreaA6iQmb/X0eaPg4syNtl+w0IkcCIBavpxdk0CHPk3AeKzkHH1+m
   lYYoWWymQ7ktffRnSqWdBgKHXRMi6v64BooqlclED8i7/xuKsm1AyEj3l
   /iggxm8yH+Tfh/XsrB+2D2Jffqilv/u4S1VVixAgHyk1rfLh+Nt8QSrQP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="397923900"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397923900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 08:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668859256"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668859256"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 08:45:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otX9V-00Ankg-1L;
        Fri, 11 Nov 2022 18:45:13 +0200
Date:   Fri, 11 Nov 2022 18:45:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver
Message-ID: <Y258GVGTxyt5zZnW@smile.fi.intel.com>
References: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
 <20221111161130.2043882-4-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111161130.2043882-4-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:41:30PM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx's quad-uart function has the capability to wake up the host

UART

> from suspend state. Enable wakeup before entering into suspend and
> disable wakeup on resume.

> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

No Co-developed-by?

> +static bool pci1xxxx_port_suspend(int line)
> +{
> +	struct uart_8250_port *up = serial8250_get_port(line);
> +	struct uart_port *port = &up->port;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned long flags;
> +	bool ret = false;
> +	u8 wakeup_mask;
> +
> +	mutex_lock(&tport->mutex);
> +	if (port->suspended == 0 && port->dev) {
> +		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
> +
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl &= ~TIOCM_OUT2;
> +		port->ops->set_mctrl(port, port->mctrl);
> +		spin_unlock_irqrestore(&port->lock, flags);

> +		if ((wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS)
> +			ret = true;

Can be
		ret = (wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS;

> +	}
> +
> +	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> +	mutex_unlock(&tport->mutex);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


