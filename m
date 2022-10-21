Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4C607846
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJUNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJUNWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:22:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD342475DA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:22:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B17C219C9;
        Fri, 21 Oct 2022 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666358538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VumRopmkMGi42CeTbKazupolMyzZhURL00ZfaW4xkE=;
        b=gdVZ4fSvrckrlGvFlTSb40MpTj1ZsqvTB7WK7LgbNOk+VtT8zH0CiWHKKRfqD+Tclsv4xI
        0mEmRZ+ChIZ5Pf66NbeD2oaws4fTZkCO4EnKliGVzXJrofHQZ2xuUYdxuikY3XaH2JhyLq
        GrpRfBiRz1oFHrjEoTuYOhMVYh3Jd+o=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEB062C141;
        Fri, 21 Oct 2022 13:22:17 +0000 (UTC)
Date:   Fri, 21 Oct 2022 15:22:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH printk v2 10/38] tty: hvc: use console_is_enabled()
Message-ID: <Y1KdCes7Ag6wJ3DE@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:32, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/hvc/hvc_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 4802cfaa107f..6d1d7b72488c 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -265,7 +265,7 @@ static void hvc_port_destruct(struct tty_port *port)
>  static void hvc_check_console(int index)
>  {
>  	/* Already enabled, bail out */
> -	if (hvc_console.flags & CON_ENABLED)
> +	if (console_is_enabled(&hvc_console))
>  		return;

The check is not reliable. The console might be disabled even when
it is already registered.

I would be nice to fix this. But it might be done later.
Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

>  
>   	/* If this index is what the user requested, then register

Best Regards,
Petr
