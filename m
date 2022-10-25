Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FBF60CD84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiJYNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJYNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:31:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21C17A027
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:31:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19BEC21871;
        Tue, 25 Oct 2022 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666704694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B57ABKR0jXC+ghHbmHVsPkm6SapcSZbWhYEq3LRfTig=;
        b=F1JbMDDdn2x51NqO/zRfaIS0W6PmQIBz682XI16dRE59sW1mpaD80pCWhHBt/WWXCPjank
        poR+4tqQGD3cQnBKPf+gdBEgYtaaMZbvvqF3THJQoEQd4Q7IzLBgwH4ycCoPokZIvxt56/
        LLIZxWARhKyynKOK1uqvfZB2NeE8QQ8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D13FD2C141;
        Tue, 25 Oct 2022 13:31:33 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:31:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH printk v2 23/38] tty: tty_io: document console_lock usage
Message-ID: <Y1flNciDszdP7c/G@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-24-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-24-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:45, John Ogness wrote:
> show_cons_active() uses the console_lock to gather information
> on registered consoles. Since the console_lock is being used for
> multiple reasons, explicitly document these reasons. This will
> be useful when the console_lock is split into fine-grained
> locking.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/tty_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 2050e63963bb..333579bfa335 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3526,6 +3526,14 @@ static ssize_t show_cons_active(struct device *dev,
>  	struct console *c;
>  	ssize_t count = 0;
>  
> +	/*
> +	 * Hold the console_lock to guarantee that no consoles are
> +	 * unregistered until all console processing is complete.
> +	 * This also allows safe traversal of the console list.

This is more or less clear. show_cons_active() reads a lot of
information from the registered consoles.

> +	 *
> +	 * Stop console printing because the device() callback may
> +	 * assume the console is not within its write() callback.

I wonder if this is based on some real example or if you just want
to stay on the safe side.

It is perfectly fine to stay on the safe side. But we should make
it clear if the dependency really exists or if it has to be
investigated later during the clean up.

> +	 */
>  	console_lock();
>  	for_each_console(c) {
>  		if (!c->device)

Anyway, thanks for adding the comment.

Best Regards,
Petr
