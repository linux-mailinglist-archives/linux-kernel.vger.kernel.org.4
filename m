Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D546079FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJUO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJUO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:56:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37791BF23B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:56:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBCD421ABC;
        Fri, 21 Oct 2022 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666364164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1SvQMXi10r+rqaqtdwYHyeOxYLEtVGhID9W890ELfQ=;
        b=rWuQYy5ekQHJwfeXZGz4uX4PxDIIgxv0+pb4rsYn/WNu8BYJ4dwxshLkJph917IL6rEVfC
        pGSjFdhqLOqOZeyHJMkLW3Yc+CVyaOn9cqbhS/iYyoFtGJ2InyQqVwOrPs7Nd0hzob1N8L
        4m0PnAefcnJ0HdHHsFZDE62o8+6qP18=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55FCB2C141;
        Fri, 21 Oct 2022 14:56:04 +0000 (UTC)
Date:   Fri, 21 Oct 2022 16:56:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org
Subject: Re: [PATCH printk v2 20/38] um: kmsg_dumper: use srcu console list
 iterator
Message-ID: <Y1KzA0Avz08iW6l5@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-21-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-21-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:42, John Ogness wrote:
> Rather than using the console_lock to guarantee safe console list
> traversal, use srcu console list iteration.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/um/kernel/kmsg_dump.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 3a3bbbb22090..44a418dec919 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -16,20 +16,17 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  	struct console *con;
>  	unsigned long flags;
>  	size_t len = 0;
> +	int cookie;
>  
>  	/* only dump kmsg when no console is available */

I agree that it is perfectly fine to use RCU here. The previous
code was just a best effort. The kdump was done without console_lock()
so that the console might get available in the meantime.

I guess that it is not a big deal. The dumper is called typically only
during panic() where new consoles are not added.

> -	if (!console_trylock())
> -		return;
> -
> -	for_each_console(con) {
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
>  		if (strcmp(con->name, "tty") == 0 &&
>  		    (console_is_enabled(con) || (con->flags & CON_CONSDEV))) {

This is slightly more racy than the previous code. Only one console
could have CON_CONSDEV. It might be moved to another console when the
list is manipulated. As a result, rcu walk might see zero, one, or two
consoles with this flag unless the flag is moved carefully.

Anyway, this check does not match the comment and does not make much
sense to me. It is true that CON_CONSDEV flag is used only for
registered consoles. But messages are printed on the console only
when CON_ENABLED flag is set.

IMHO, we should check only console_is_enabled() here.

Adding Thomas Meyer and Richard Weinberger <richard@nod.at> into Cc.
Thomas added this check in the commit e23fe90dec286cd77e90
("um: kmsg_dumper: always dump when not tty console") and
Richard pushed it.

>  			break;
>  		}
>  	}
> -
> -	console_unlock();
> -
> +	console_srcu_read_unlock(cookie);
>
>  	if (con)
>  		return;

Best Regards,
Petr
