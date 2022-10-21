Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0556073FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJUJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJUJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:25:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F422250E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:25:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 504421F8CA;
        Fri, 21 Oct 2022 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666344315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rP4nnQX47thfgyRolOvKfKaLG4h6OdFE4hnFaQyj1q8=;
        b=nAvhlh8EZFSSEeFHBgj4tKZsJ5Mr2eb4h2CF9OY0FW1lt6aDcuG25kUIZXYsackXVNdni7
        TT3mYYA0LXNcrmHRULkAIL+rtfHRzEhf9G+UhjtLzMPoYh3R/vqa0NLC9c+LJDGbnctCpY
        X2jJZrOeynuarXTpRCp0ud00OxIYqXg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24F432C141;
        Fri, 21 Oct 2022 09:25:15 +0000 (UTC)
Date:   Fri, 21 Oct 2022 11:25:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/38] printk: use console_is_enabled()
Message-ID: <Y1JlerStRZ85D4Zo@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:27, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e8a56056cd50..7ff2fc75fc3b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2658,7 +2658,7 @@ static bool abandon_console_lock_in_panic(void)
>   */
>  static inline bool console_is_usable(struct console *con)
>  {
> -	if (!(con->flags & CON_ENABLED))
> +	if (!console_is_enabled(con))
>  		return false;

This allows to use console_is_usable() without synchronization against
modification of the state. I guess that it will be needed for the
printk kthreads. But it is not needed at the moment.

We should document why it is needed and why it is safe.


>  
>  	if (!con->write)
> @@ -2944,7 +2944,7 @@ void console_unblank(void)
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	for_each_console(c)
> -		if ((c->flags & CON_ENABLED) && c->unblank)
> +		if (console_is_enabled(c) && c->unblank)
>  			c->unblank();
>  	console_unlock();

The reading of the flag is actually synchronized against modifications
here. I guess that we need this because c->unblank() probably is not safe
against other operations with the console, e.g. c->write().

Well, it probably does not matter if reading of CON_ENABLED flag is
serialized against modifications. So, it is perfectly fine to use
the "racy" function.


> @@ -3098,7 +3098,7 @@ static int try_enable_preferred_console(struct console *newcon,
>  	 * without matching. Accept the pre-enabled consoles only when match()
>  	 * and setup() had a chance to be called.
>  	 */
> -	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
> +	if (console_is_enabled(newcon) && (c->user_specified == user_specified))

This is not racy because newcon is not in console_list at this
point. So that the state can't be modified by another callers.

Anyway, it is not explicitly synchronized, so we need to use
console_is_enabled with data_race() annotation.


>  		return 0;
>  
>  	return -ENOENT;

Best Regards,
Petr
