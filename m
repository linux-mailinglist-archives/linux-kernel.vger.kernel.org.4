Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0AF607975
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJUOXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:23:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1327C95D;
        Fri, 21 Oct 2022 07:23:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 07D6121C3C;
        Fri, 21 Oct 2022 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666362225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+r+MUYg4L0jiEOtXgDxphdKLvrOHZIrBRHvnZMBKsV8=;
        b=dA2qrfhIRkyi5E40MTeWY0jF2NdAhbF5yi2wyOMOtqv8DbGbnqIh6OomAAkIeL1nGBbM/9
        TF2KsRVuOQad+2VxK06MNqoU+GlN4zx2EPzfzkxnooF0fJTX1QoYgAa93qN2IADaKjh0s9
        T2M97KHe03rUv/R5UXIoAigmwYJBbQw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A94BA2C141;
        Fri, 21 Oct 2022 14:23:44 +0000 (UTC)
Date:   Fri, 21 Oct 2022 16:23:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH printk v2 16/38] tty: serial: xilinx_uartps: use
 console_is_enabled()
Message-ID: <Y1KrcPBmC0ZNlxKc@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-17-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-17-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:38, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 2eff7cff57c4..e1fe95bd55c1 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1631,7 +1631,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
>  	/* This is not port which is used for console that's why clean it up */
>  	if (console_port == port &&
> -	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED)) {
> +	    !console_is_enabled(cdns_uart_uart_driver.cons)) {
>  		console_port = NULL;
>  		cdns_uart_console.index = -1;

Again, IMHO, we should check here if the console is in console_list.
We should not clean the port and index when the console is already
registered.

Again, this is old problem that might be fixed later.

The change is straightforward. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
