Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4D5F2E83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJCJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJCJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:51:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932225A;
        Mon,  3 Oct 2022 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664790687; x=1696326687;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0eSz7DO9mySO5jeTWFNlmR0B7bVjcdWTwf4B5JeJd14=;
  b=H9D9cK+NErNt5WNrJXG5/Kqp+VrSKsmBW4wY+WIlxhDiE/xrsSYm61z6
   NKu+VfmWAqpAd4hCsngVYJgczfxQBaNbbYUL6QnGYntdCHXJwdpcSAKUu
   oLumA7mrfmzhnyikruat6zGOUzeFs9uMjc0+feUWFVDT5nEQzBst4vQxd
   DJTGg53IeHgB96Q/f8N2BT8+5zFg3+y8kz0R+/3jb6W5Mcqoe+o6E7Pot
   CTDx4lSl7Ish6Jndt5rHCZJX1ZpgsaFwsanu8bZwdohPINbl9IB1+neR5
   2ud6KyUNP3Jvm+xMNgRunPgZuYWX+eg9x+Tl2km4NnkHdwLJgjl2NW6fE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="366636289"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="366636289"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:51:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="623472682"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="623472682"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.38.50])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:51:22 -0700
Date:   Mon, 3 Oct 2022 12:51:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
In-Reply-To: <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
Message-ID: <7892467b-c2de-c62-e977-62761dc5cbb@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx's quad-uart function has the capability to wake up the host from
> suspend state. Enable wakeup before entering into suspend and disable
> wakeup on resume.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v2:
> - Use DEFINE_SIMPLE_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS.
> - Use pm_sleep_ptr instead of CONFIG_PM_SLEEP.
> - Change the return data type of pci1xxxx_port_suspend to bool from int.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 112 ++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 999e5a284266..0a0459f66177 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -352,6 +352,112 @@ static void pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
>  	}
>  }
>  
> +static bool pci1xxxx_port_suspend(int line)
> +{
> +	struct uart_8250_port *up = serial8250_get_port(line);
> +	struct uart_port *port = &up->port;
> +	unsigned long flags;
> +	u8 wakeup_mask;
> +	bool ret = false;
> +
> +	if (port->suspended == 0 && port->dev) {
> +		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
> +
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl &= ~TIOCM_OUT2;
> +		port->ops->set_mctrl(port, port->mctrl);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +
> +		if ((wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS)
> +			ret = true;
> +	}
> +
> +	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> +
> +	return ret;
> +}
> +
> +static void pci1xxxx_port_resume(int line)
> +{
> +	struct uart_8250_port *up = serial8250_get_port(line);
> +	struct uart_port *port = &up->port;
> +	unsigned long flags;
> +
> +	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> +
> +	if (port->suspended == 0) {

Is this check the right way around?

> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl |= TIOCM_OUT2;
> +		port->ops->set_mctrl(port, port->mctrl);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +	}
> +}
> +
> +static int pci1xxxx_suspend(struct device *dev)
> +{
> +	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
> +	struct pci_dev *pcidev = to_pci_dev(dev);
> +	unsigned int data;
> +	void __iomem *p;
> +	bool wakeup = false;
> +	int i;
> +
> +	for (i = 0; i < priv->nr; i++) {
> +		if (priv->line[i] >= 0) {
> +			serial8250_suspend_port(priv->line[i]);
> +			wakeup |= pci1xxxx_port_suspend(priv->line[i]);

So first serial8250_suspend_port() calls into uart_suspend_port() that
sets port->suspended to 1, then pci1xxxx_port_suspend() checks if it's 0.
Is this intentional?


-- 
 i.

