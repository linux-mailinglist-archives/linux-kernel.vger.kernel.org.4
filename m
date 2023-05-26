Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF887122DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbjEZJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242874AbjEZJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:01:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53FF799;
        Fri, 26 May 2023 02:01:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A4AA7812F;
        Fri, 26 May 2023 09:01:29 +0000 (UTC)
Date:   Fri, 26 May 2023 12:01:28 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v1 7/8] serial: 8250: lock port for UART_IER access
 in omap8250_irq()
Message-ID: <20230526090128.GE14287@atomide.com>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
 <20230525093159.223817-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525093159.223817-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Ogness <john.ogness@linutronix.de> [230525 09:34]:
> omap8250_irq() accesses UART_IER. This register is modified twice
> by each console write (serial8250_console_write()) under the port
> lock. omap8250_irq() must also take the port lock to guanentee
> synchronized access to UART_IER.
> 
> Since the port lock is already being taken for the stop_rx() callback
> and since it is safe to call cancel_delayed_work() while holding the
> port lock, simply extend the port lock region to include UART_IER
> access.
> 
> Fixes: 1fe0e1fa3209 ("serial: 8250_omap: Handle optional overrun-throttle-ms property")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/tty/serial/8250/8250_omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 34939462fd69..3225c95fde1d 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -659,17 +659,18 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
>  	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
>  		unsigned long delay;
>  
> +		/* Synchronize UART_IER access against the console. */
> +		spin_lock(&port->lock);
>  		up->ier = port->serial_in(port, UART_IER);
>  		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
> -			spin_lock(&port->lock);
>  			port->ops->stop_rx(port);
> -			spin_unlock(&port->lock);
>  		} else {
>  			/* Keep restarting the timer until
>  			 * the input overrun subsides.
>  			 */
>  			cancel_delayed_work(&up->overrun_backoff);
>  		}
> +		spin_unlock(&port->lock);
>  
>  		delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
>  		schedule_delayed_work(&up->overrun_backoff, delay);
> -- 
> 2.30.2
> 
