Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843686FDD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjEJLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:43:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F4FE;
        Wed, 10 May 2023 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683719010; x=1715255010;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MSj618sbErzIYmOGI7vjCs5DAq9sbq+ULbuXkoSQgsk=;
  b=YyB6LTBjw4bBiuRjmDfZ2TFDUuB/yY2ARv7ER7dA0CtB/Hu4WezOq671
   fW5dU0GJQnTGB9F1lS4pJk97JJSJ6xUzQQxL6VMkmR2RU12GuIXLNGWoM
   ZCYXKwdy+EOTJS4ONJc7bvec4z714b2dPQ9+TSaRDkGFOeoeGi+Fd/aAl
   m24j0U3ZUw6rtf0s4oZ8Q0ssRbHfU3rlw7nGYKoAuCYPkTeLP41fa/oUf
   ldlJ7Yl3pIgEUcUpkwaNQY1n+SudWjuJncd1R9er29vIvCm9fjjMAPjo+
   7TkYUVaJxKKINjwvPvMB8nDtPgJf4aIJNGXmuOHFvoaEeMBoWqBzvtdGF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="329812487"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="329812487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 04:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1029188655"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="1029188655"
Received: from sschutze-mobl.ger.corp.intel.com ([10.251.218.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 04:43:28 -0700
Date:   Wed, 10 May 2023 14:43:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukasz Majczak <lma@semihalf.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, upstream@semihalf.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: core: enable FIFO after resume
In-Reply-To: <20230405111559.110220-3-lma@semihalf.com>
Message-ID: <2b3f5b4e-c75e-5c20-bb86-c5628e7e91a7@linux.intel.com>
References: <20230405111559.110220-1-lma@semihalf.com> <20230405111559.110220-3-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, Lukasz Majczak wrote:

> The "serial/8250: Use fifo in 8250 console driver" commit

Use canonical formatting when referring to commit:

commit 12char_SHA1 ("shortlog")

> has revealed an issue of not re-enabling FIFO after resume.
> The problematic path is inside uart_resume_port() function.
> First, when the console device is re-enabled,
> a call to uport->ops->set_termios() internally initializes FIFO
> (in serial8250_do_set_termios()), although further code

I'd drop "First," and start with "When" and change "although" to "then"

> disables it by issuing ops->startup() (pointer to serial8250_do_startup,
> internally calling serial8250_clear_fifos()).
> There is even a comment saying "Clear the FIFO buffers and disable them.
> (they will be reenabled in set_termios())", but in this scenario,
> set_termios() has been called already and FIFO remains disabled.

Also, you should reflow the text to 72 chars per line.

> This patch address the issue by reversing the order - first checks
> if tty port is suspended and performs actions accordingly
> (e.g. call to ops->startup()), then tries to re-enable
> the console device after suspend (and call to uport->ops->set_termios()).
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> Cc: <stable@vger.kernel.org> # 6.1+
> ---
>  drivers/tty/serial/serial_core.c | 54 ++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 394a05c09d87..57a153adba3a 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2406,33 +2406,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  	put_device(tty_dev);
>  	uport->suspended = 0;
>  
> -	/*
> -	 * Re-enable the console device after suspending.
> -	 */
> -	if (uart_console(uport)) {
> -		/*
> -		 * First try to use the console cflag setting.
> -		 */
> -		memset(&termios, 0, sizeof(struct ktermios));
> -		termios.c_cflag = uport->cons->cflag;
> -		termios.c_ispeed = uport->cons->ispeed;
> -		termios.c_ospeed = uport->cons->ospeed;
> -
> -		/*
> -		 * If that's unset, use the tty termios setting.
> -		 */
> -		if (port->tty && termios.c_cflag == 0)
> -			termios = port->tty->termios;
> -
> -		if (console_suspend_enabled)
> -			uart_change_pm(state, UART_PM_STATE_ON);
> -		uport->ops->set_termios(uport, &termios, NULL);
> -		if (!console_suspend_enabled && uport->ops->start_rx)
> -			uport->ops->start_rx(uport);
> -		if (console_suspend_enabled)
> -			console_start(uport->cons);
> -	}
> -
>  	if (tty_port_suspended(port)) {
>  		const struct uart_ops *ops = uport->ops;
>  		int ret;
> @@ -2471,6 +2444,33 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  		tty_port_set_suspended(port, false);
>  	}
>  
> +	/*
> +	 * Re-enable the console device after suspending.
> +	 */
> +	if (uart_console(uport)) {
> +		/*
> +		 * First try to use the console cflag setting.
> +		 */
> +		memset(&termios, 0, sizeof(struct ktermios));
> +		termios.c_cflag = uport->cons->cflag;
> +		termios.c_ispeed = uport->cons->ispeed;
> +		termios.c_ospeed = uport->cons->ospeed;
> +
> +		/*
> +		 * If that's unset, use the tty termios setting.
> +		 */
> +		if (port->tty && termios.c_cflag == 0)
> +			termios = port->tty->termios;
> +
> +		if (console_suspend_enabled)
> +			uart_change_pm(state, UART_PM_STATE_ON);
> +		uport->ops->set_termios(uport, &termios, NULL);
> +		if (!console_suspend_enabled && uport->ops->start_rx)
> +			uport->ops->start_rx(uport);
> +		if (console_suspend_enabled)
> +			console_start(uport->cons);
> +	}
> +
>  	mutex_unlock(&port->mutex);
>  
>  	return 0;
> 

To me it looks the whole function is too messed up to fix anything this 
easily. I'd start with splitting the two large ifs block so that the 
ordering makes sense:

- set_termios / uart_change_line_settings is called only once
- rx and tx is started only after set_termios
- failure path (the one doing uart_shutdown) logic is reverse + gotoed


-- 
 i.

