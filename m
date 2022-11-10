Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3AC62409F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKJLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiKJLCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:02:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979D6C738;
        Thu, 10 Nov 2022 03:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668078127; x=1699614127;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QFjjTyVO5gR6M9K8VpkC4XupdFEpATBo6gUQINjNEoI=;
  b=gg7BlStfY4Ndf88sYs4iGNtkf83UjOj+SoD+KxMH2COfyjbKYZQG/Kjz
   pbkJB+8BjpcV9fyllmLwHJKzH0677yb8pNBAWYiydeat1kVaj4u8Ldl5V
   izi625qctBuPeUI9VgYN06YEY8MMvr2LNh0QSN6YCcUpPiMEDbS1HoHHJ
   8RG4sjX1Q4djQ3cAVHup2ljUez+dgNLSrqascAGOkJA1GsQWYTd7gg2s5
   f2XpG8Jqgs0lN51z6/u0jQ4TaRWurx/JntAkJP5pcH/oWKWv4glOjeGrI
   1ObwAIsdou1bfFL2HcZle746l811iHvm1kTcpjDdCAT+YIqxk8oOs6N3g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311281208"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="311281208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:01:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700755125"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="700755125"
Received: from albertmo-mobl2.ger.corp.intel.com ([10.249.43.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:01:49 -0800
Date:   Thu, 10 Nov 2022 13:01:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 6/7] serial: liteuart: separate RX loop from poll
 timer
In-Reply-To: <20221110004450.772768-7-gsomlo@gmail.com>
Message-ID: <1c902ee8-d33d-c2d0-7eef-719f59f3a64@linux.intel.com>
References: <20221110004450.772768-1-gsomlo@gmail.com> <20221110004450.772768-7-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Gabriel Somlo wrote:

> Move the character-receive (RX) loop to its own dedicated function,
> and (for now) call that from the poll timer, liteuart_timer().
> 
> This is in preparation for adding IRQ support to the receive path.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 047d5ad32e13..aa7052280197 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -67,29 +67,34 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>  
> -static void liteuart_timer(struct timer_list *t)
> +static void liteuart_rx_chars(struct uart_port *port)
>  {
> -	struct liteuart_port *uart = from_timer(uart, t, timer);
> -	struct uart_port *port = &uart->port;
>  	unsigned char __iomem *membase = port->membase;
> -	unsigned int flg = TTY_NORMAL;
> -	int ch;
> -	unsigned long status;
> +	unsigned int status;
> +	unsigned char ch;
>  
>  	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
>  		ch = litex_read8(membase + OFF_RXTX);
>  		port->icount.rx++;
>  
>  		/* necessary for RXEMPTY to refresh its value */
> -		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
> +		litex_write8(membase + OFF_EV_PENDING, EV_RX);
>  
>  		/* no overflow bits in status */
>  		if (!(uart_handle_sysrq_char(port, ch)))
> -			uart_insert_char(port, status, 0, ch, flg);
> -
> -		tty_flip_buffer_push(&port->state->port);
> +			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
>  	}
>  
> +	tty_flip_buffer_push(&port->state->port);

This change is doing extra stuff besides moving rx to a dedicated 
function.

I see no reason why those other changes couldn't be put into an entirely 
separate patch. Also, please described those changes properly in the 
commit message (answer the why? question).

-- 
 i.

> +}
> +
> +static void liteuart_timer(struct timer_list *t)
> +{
> +	struct liteuart_port *uart = from_timer(uart, t, timer);
> +	struct uart_port *port = &uart->port;
> +
> +	liteuart_rx_chars(port);
> +
>  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }
>  
> 


