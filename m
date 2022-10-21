Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAF607A21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJUPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJUPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:09:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5615A04;
        Fri, 21 Oct 2022 08:09:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44CB621AC3;
        Fri, 21 Oct 2022 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666364966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2cmZ6BvHBYBb6ewKQViyHi8KNoqJ4RJeLxFa1jRfPU=;
        b=Z64rxAKDBG/TanlPIBnuQFWm/LX0xgg8bMR9dvDfTuLSMLDAR3+SUqOUHGVFVCf/uVI24I
        kV9RAoggTaweiqxTo5EH8RKHNMsrJn3elumj0N3Vc8VtltOGywUpSyBPeNClBFEdkL5gW2
        myMpVZpXF60Gl0Vtf54IlRCCU57GDaA=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24A8A2C141;
        Fri, 21 Oct 2022 15:09:25 +0000 (UTC)
Date:   Fri, 21 Oct 2022 17:09:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 21/38] serial: kgdboc: use srcu console list
 iterator
Message-ID: <Y1K2JP6LIf8H2Ub5@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-22-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-22-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:43, John Ogness wrote:
> Use srcu console list iteration for safe console list traversal.
>
> Note that configure_kgdboc() still requires the console_lock in
> order to ensure that no console is in its write() callback when
> its direct() callback is called. Add comments to clarify this.

s/direct()/device()/

Do you know about such requirements or is it just
a conservative approach, please?

I ask because the comment in the code says "may assume".


Anyway, this would deserve a comment why the SRCU list iteration is
needed even when console_lock() is needed as well.

The reason is that further patches are going to synchronize
console_list manipulation with another lock and console_lock()
will be used only to serialize accessing con->write() callbacks.

Best Regards,
Petr

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b17aa7e49894..e9d3f8c6e3dc 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -171,6 +171,7 @@ static int configure_kgdboc(void)
>  	int err = -ENODEV;
>  	char *cptr = config;
>  	struct console *cons;
> +	int cookie;
>  
>  	if (!strlen(config) || isspace(config[0])) {
>  		err = 0;
> @@ -193,8 +194,14 @@ static int configure_kgdboc(void)
>  	if (!p)
>  		goto noconfig;
>  
> +	/*
> +	 * Stop console printing because the device() callback may
> +	 * assume the console is not within its write() callback.
> +	 */
>  	console_lock();
> -	for_each_console(cons) {
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(cons) {
>  		int idx;
>  		if (cons->device && cons->device(cons, &idx) == p &&
>  		    idx == tty_line) {
> @@ -202,6 +209,8 @@ static int configure_kgdboc(void)
>  			break;
>  		}
>  	}
> +	console_srcu_read_unlock(cookie);
> +
>  	console_unlock();
>  
>  	kgdb_tty_driver = p;
> @@ -451,6 +460,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  {
>  	struct console *con;
>  	static bool already_warned;
> +	int cookie;
>  
>  	if (already_warned)
>  		return;
> @@ -463,9 +473,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  	 * serial drivers might be OK with this, print a warning once per
>  	 * boot if we detect this case.
>  	 */
> -	for_each_console(con)
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
>  		if (con == kgdboc_earlycon_io_ops.cons)
> -			return;
> +			break;
> +	}
> +	console_srcu_read_unlock(cookie);
> +	if (con)
> +		return;
>  
>  	already_warned = true;
>  	pr_warn("kgdboc_earlycon is still using bootconsole\n");
> -- 
> 2.30.2
