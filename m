Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4906933AD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBKUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:32:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AAB001164A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 12:32:25 -0800 (PST)
Received: (qmail 856943 invoked by uid 1000); 11 Feb 2023 15:32:25 -0500
Date:   Sat, 11 Feb 2023 15:32:25 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+f7WaMmsNBHDIcZ@rowland.harvard.edu>
References: <1676146033-3948-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676146033-3948-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 01:37:13AM +0530, Prashanth K wrote:
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

This looks pretty good, except for a couple of small things...

> v3: Fixed the spin_lock_irqsave flags.
> 
>  drivers/usb/gadget/function/u_serial.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 840626e..471087f 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -82,6 +82,8 @@
>  #define WRITE_BUF_SIZE		8192		/* TX only */
>  #define GS_CONSOLE_BUF_SIZE	8192
>  
> +static DEFINE_SPINLOCK(serial_port_lock);

You might put a short comment before this line, explaining what the 
purpose of serial_port_lock is.  Otherwise people will wonder what it is 
for.

> +
>  /* console info */
>  struct gs_console {
>  	struct console		console;
> @@ -1370,13 +1372,15 @@ EXPORT_SYMBOL_GPL(gserial_connect);
>  void gserial_disconnect(struct gserial *gser)
>  {
>  	struct gs_port	*port = gser->ioport;
> -	unsigned long	flags;
> +	unsigned long flags;

Unnecessary whitespace change.  Leave the original code as it is.

>  
>  	if (!port)
>  		return;

Is it really possible for port to be NULL here?  If it is possible, 
where would gser->ioport be set to NULL?

And if it's not possible, this test should be removed.

>  
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +
>  	/* tell the TTY glue not to do I/O here any more */
> -	spin_lock_irqsave(&port->port_lock, flags);
> +	spin_lock(&port->port_lock);
>  
>  	gs_console_disconnect(port);
>  
> @@ -1391,7 +1395,8 @@ void gserial_disconnect(struct gserial *gser)
>  			tty_hangup(port->port.tty);
>  	}
>  	port->suspended = false;
> -	spin_unlock_irqrestore(&port->port_lock, flags);
> +	spin_unlock(&port->port_lock);
> +	spin_unlock_irqrestore(&serial_port_lock, flags);
>  
>  	/* disable endpoints, aborting down any active I/O */
>  	usb_ep_disable(gser->out);
> @@ -1426,9 +1431,16 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
>  void gserial_resume(struct gserial *gser)
>  {
>  	struct gs_port *port = gser->ioport;

You shouldn't read gser->ioport here; do it under the protection of the 
static spinlock.  If you do the read here then there will still be a 
data race, because gserial_disconnect() might change the value just as 
you are reading it.

> -	unsigned long	flags;
> +	unsigned long flags;

Again, unnecessary whitespace change.

>  
> -	spin_lock_irqsave(&port->port_lock, flags);
> +	spin_lock_irqsave(&serial_port_lock, flags);

Here is where you should read gser->ioport.

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

Alan Stern
