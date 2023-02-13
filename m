Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FF694D88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBMQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBMQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:57:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F1DFAF75E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:57:03 -0800 (PST)
Received: (qmail 913739 invoked by uid 1000); 13 Feb 2023 11:57:03 -0500
Date:   Mon, 13 Feb 2023 11:57:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+pr3yIbnl8M1e2e@rowland.harvard.edu>
References: <1676288170-5493-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676288170-5493-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:06:10PM +0530, Prashanth K wrote:
> Consider a case where gserial_disconnect has already cleared
> gser->ioport. And if a wakeup interrupt triggers afterwards,
> gserial_resume gets called, which will lead to accessing of
> gser->ioport and thus causing null pointer dereference.Add
> a null pointer check to prevent this.
> 
> Added a static spinlock to prevent gser->ioport from becoming
> null after the newly added check.
> 
> Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
> v4: Added short comment about serial_port_lock.
> 
>  drivers/usb/gadget/function/u_serial.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 840626e..3a6adf2 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -82,6 +82,13 @@
>  #define WRITE_BUF_SIZE		8192		/* TX only */
>  #define GS_CONSOLE_BUF_SIZE	8192
>  
> +/*
> + * Since all the spinlocks used in this driver is part of struct gs_port (port_lock).
> + * Added a new static spinlock to prevent race conditions where gs_port is dereferenced
> + * after marking as null.
> + */

This comment could be a little shorter and more direct.  Something like:

/* Prevents race conditions when accessing gser->ioport */

or

/* Prevents races between disconnect and resume for gser->ioport */

or even just

/* Protects gser->ioport */

Everything else looks okay.

Alan Stern

> +static DEFINE_SPINLOCK(serial_port_lock);
> +
>  /* console info */
>  struct gs_console {
>  	struct console		console;
> @@ -1375,8 +1382,10 @@ void gserial_disconnect(struct gserial *gser)
>  	if (!port)
>  		return;
>  
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +
>  	/* tell the TTY glue not to do I/O here any more */
> -	spin_lock_irqsave(&port->port_lock, flags);
> +	spin_lock(&port->port_lock);
>  
>  	gs_console_disconnect(port);
>  
> @@ -1391,7 +1400,8 @@ void gserial_disconnect(struct gserial *gser)
>  			tty_hangup(port->port.tty);
>  	}
>  	port->suspended = false;
> -	spin_unlock_irqrestore(&port->port_lock, flags);
> +	spin_unlock(&port->port_lock);
> +	spin_unlock_irqrestore(&serial_port_lock, flags);
>  
>  	/* disable endpoints, aborting down any active I/O */
>  	usb_ep_disable(gser->out);
> @@ -1425,10 +1435,19 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
>  
>  void gserial_resume(struct gserial *gser)
>  {
> -	struct gs_port *port = gser->ioport;
> +	struct gs_port *port;
>  	unsigned long	flags;
>  
> -	spin_lock_irqsave(&port->port_lock, flags);
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = gser->ioport;
> +
> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, flags);
> +		return;
> +	}
> +
> +	spin_lock(&port->port_lock);
> +	spin_unlock(&serial_port_lock);
>  	port->suspended = false;
>  	if (!port->start_delayed) {
>  		spin_unlock_irqrestore(&port->port_lock, flags);
> -- 
> 2.7.4
> 
