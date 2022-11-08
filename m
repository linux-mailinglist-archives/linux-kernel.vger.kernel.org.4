Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56A621AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiKHRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiKHRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:40:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6D50F14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:40:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C017B1F88D;
        Tue,  8 Nov 2022 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667929230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E19JDYRMCtHVo52riv0xC8e/AOPdJZyCAR84AHrfs3g=;
        b=qRJI/Z9N8oaDhQAG9LC+m0VSM4vTRcZ8f3TUvFv5Eq9D2UFukL+yuJ62pE/5ukfiTnvj6U
        9yjRuPlXmyBOKuEm3U3O7JoPZJxmgo9GDDdEXtyRjUYuyhsBXKq39c4R97xULUJMdRig7Z
        Hmr+GoVnUFEcW2dLhbN7uVArU41USMg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 786412C141;
        Tue,  8 Nov 2022 17:40:30 +0000 (UTC)
Date:   Tue, 8 Nov 2022 18:40:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 08/40] printk: use console_is_enabled()
Message-ID: <Y2qUjiBStRbVRGZ9@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:06, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled()
> if it involves a data race. Otherwise add comments mentioning why the
> wrapper is not used.

The wrapper will be used/needed only on few locations. There are many
more locations where the console flags are modified without any
locking.

Note that it is not only about CON_ENABLE flag. If we started playing
the game with WRITE_ONCE()/READ_ONCE() then we would need to consider
all locations where the flags are modified.

In the end, it might be easier to use the proposed console_set_flag(),
console_clear_flag(), console_check_flag(), and
console_check_flag_unsafe(), instead of documenting all the locations.

Also it is more important to document why it is acceptable to use
the racy variant. The wrappers would make sure that all the other
accesses are safe.


> Note that this is a preparatory change for when console_lock no longer
> provides synchronization for console->flags.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 79811984da34..f243bb56a3ba 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2660,7 +2660,7 @@ static bool abandon_console_lock_in_panic(void)
>   */
>  static inline bool console_is_usable(struct console *con)
>  {
> -	if (!(con->flags & CON_ENABLED))
> +	if (!console_is_enabled(con))

I agree that it makes sense to do this now. console_is_usable() is
used in two cycles. They will get switched to the srcu walk one by one.

Just please document that this allows to use console_is_usable() under
console_srcu_read_lock. And that in this case, the value of the flag might
get cleared at any time but the console still might be used
as long as the console_srcu_read_lock is held.

We should actually add a check into console_is_enabled() that either
console_lock or console_srcu_read_lock is held. The console_lock
should later be changed to console_list_lock.


>  		return false;
>  
>  	if (!con->write)
> @@ -2946,7 +2946,7 @@ void console_unblank(void)
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	for_each_console(c)
> -		if ((c->flags & CON_ENABLED) && c->unblank)
> +		if (console_is_enabled(c) && c->unblank)

I would prefer to do this change together with switching to
for_each_console_srcu(). It would be more clear why this change
is needed.

>  			c->unblank();
>  	console_unlock();
>  
> @@ -3104,8 +3104,11 @@ static int try_enable_preferred_console(struct console *newcon,
>  	 * Some consoles, such as pstore and netconsole, can be enabled even
>  	 * without matching. Accept the pre-enabled consoles only when match()
>  	 * and setup() had a chance to be called.
> +	 *
> +	 * Note that reading @flags is race-free because the console is not
> +	 * yet added to the console list.

Nit: This is not completely true. We just know that it will not get
     modified by the printk/console framework because the console is not
     registered yet.

Well, I could live with it. The comment is good enough. I am still
more concerned about how to distinguish when READ_ONCE()/WRITE_ONCE()
is needed. And it would affect all accesses to the flags.

>  	 */
> -	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
> +	if ((newcon->flags & CON_ENABLED) && (c->user_specified == user_specified))
>  		return 0;
>  
>  	return -ENOENT;

Best Regards,
Petr
