Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A06F92D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjEFPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEFPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:45:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1D30E191D3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:45:32 -0700 (PDT)
Received: (qmail 481467 invoked by uid 1000); 6 May 2023 11:45:31 -0400
Date:   Sat, 6 May 2023 11:45:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_suspend
Message-ID: <d05be5e3-a994-4924-a86f-d8f19d800193@rowland.harvard.edu>
References: <1683278317-11774-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683278317-11774-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 02:48:37PM +0530, Prashanth K wrote:
> Consider a case where gserial_disconnect has already cleared
> gser->ioport. And if gserial_suspend gets called afterwards,
> it will lead to accessing of gser->ioport and thus causing
> null pointer dereference.
> 
> Avoid this by adding a null pointer check. Added a static
> spinlock to prevent gser->ioport from becoming null after
> the newly added null pointer check.
> 
> Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/gadget/function/u_serial.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index a0ca47f..e5d522d 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1420,10 +1420,19 @@ EXPORT_SYMBOL_GPL(gserial_disconnect);
>  
>  void gserial_suspend(struct gserial *gser)
>  {
> -	struct gs_port	*port = gser->ioport;
> +	struct gs_port	*port;
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
>  	port->suspended = true;
>  	spin_unlock_irqrestore(&port->port_lock, flags);
>  }

This looks fine to me, but I'm not a serial-gadget maintainer.  
In fact, it looks like we don't have a serial-gadget maintainer.

Alan Stern
