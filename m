Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD54693268
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBKQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:26:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2E8285B91
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:26:11 -0800 (PST)
Received: (qmail 851788 invoked by uid 1000); 11 Feb 2023 11:26:10 -0500
Date:   Sat, 11 Feb 2023 11:26:10 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+fBopfbwwQMdBv+@rowland.harvard.edu>
References: <1676117858-32157-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676117858-32157-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 05:47:38PM +0530, Prashanth K wrote:
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
> v2: Added static spinlock and fixed Fixes tag.
> 
>  drivers/usb/gadget/function/u_serial.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 840626e..9ced0fa 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -82,6 +82,8 @@
>  #define WRITE_BUF_SIZE		8192		/* TX only */
>  #define GS_CONSOLE_BUF_SIZE	8192
>  
> +static DEFINE_SPINLOCK(serial_port_lock);
> +
>  /* console info */
>  struct gs_console {
>  	struct console		console;
> @@ -1370,11 +1372,13 @@ EXPORT_SYMBOL_GPL(gserial_connect);
>  void gserial_disconnect(struct gserial *gser)
>  {
>  	struct gs_port	*port = gser->ioport;
> -	unsigned long	flags;
> +	unsigned long flags, serial_flag;

You don't need two separate flags here.  The fact that you wrote this 
indicates you don't understand how spin_lock_irqsave() and 
spin_lock_irqrestore() work.

When spin_lock_irqsave(&lock, flag) is called, it saves the current INT 
(interrupt-enable) setting in flag, disables interrupts, and acquires 
the lock.  When spin_unlock_irqrestore(&lock, flag) is called, it 
releases the lock and writes the value in flag back to the INT setting.

The end result is that if interrupts were enabled before 
spin_lock_irqsave() then they will be enabled after 
spin_unlock_irqrestore().  If interrupts were disabled beforehand, they 
will remain disabled afterward.  And either way, interrupts will be 
disabled between the two calls.

>  
>  	if (!port)
>  		return;
>  
> +	spin_lock_irqsave(&serial_port_lock, serial_flag);

So now interrupts are disabled.

> +
>  	/* tell the TTY glue not to do I/O here any more */
>  	spin_lock_irqsave(&port->port_lock, flags);

Hence there's no need for flag here.  You don't need to save the current 
INT setting because you already know what it is: interrupts are 
disabled.  You can simply call spin_lock(), which will acquire the lock 
without doing anything to the INT setting.

>  
> @@ -1392,6 +1396,7 @@ void gserial_disconnect(struct gserial *gser)
>  	}
>  	port->suspended = false;
>  	spin_unlock_irqrestore(&port->port_lock, flags);

Likewise, here you can call spin_unlock().

> +	spin_unlock_irqrestore(&serial_port_lock, serial_flag);
>  
>  	/* disable endpoints, aborting down any active I/O */
>  	usb_ep_disable(gser->out);
> @@ -1426,9 +1431,16 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
>  void gserial_resume(struct gserial *gser)
>  {
>  	struct gs_port *port = gser->ioport;
> -	unsigned long	flags;
> +	unsigned long flags, serial_flag;
> +
> +	spin_lock_irqsave(&serial_port_lock, serial_flag);
> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, serial_flag);
> +		return;
> +	}

This is a little trickier, but the same principles apply.  Since 
spin_lock_irqsave() was called above, interrupts are now disabled.

>  
>  	spin_lock_irqsave(&port->port_lock, flags);

So there's no need for _irqsave here.

> +	spin_unlock_irqrestore(&serial_port_lock, serial_flag);

And here you must not use spin_unlock_irqrestore().  This will do the 
wrong thing, because it will enable interrupts if they were enabled at 
the start of the function.  Then you would be running with 
port->port_lock held and interrupts enabled, a bad combination.

>  	port->suspended = false;
>  	if (!port->start_delayed) {
>  		spin_unlock_irqrestore(&port->port_lock, flags);

Here, at the final unlock, is where you should restore the INT setting 
to the value it had at the start of the function.

Alan Stern
