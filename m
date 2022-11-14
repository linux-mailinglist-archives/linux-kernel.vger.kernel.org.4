Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E86289D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiKNTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiKNTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:51:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193AC16;
        Mon, 14 Nov 2022 11:51:20 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668455478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfwmN3gCUQ+9TAw/6+bki3KtgpMLZgBklmxHfTgDw4o=;
        b=iMGGVuDKNStmNor0UI3iTAYJ0AUO55XogBClFvM6B+tx0AU7fG2GCFY1lB/NC6Tb3UDkHT
        wjMXw+7S+KKxg6nci2jZINQSPEpVH8/S75n8xpxWvbZB9TxM/doLt1grp8dJYSQNe4gcu2
        DqQPQFAS80ZUU4gsK6dxxarHe2nXdRbTQa10ScIZY9lfZD459n/D+zboV2n4sGBx1lblni
        JnLYd56MPxPaQR/+Mg3f7wjXIhTMsGxmrmPTrYXYKM4AA9jm8M7zDoQPx6vcpAWYDQ7x6x
        bqOsfc0s5Ggddqj32cmnHa27cCEyV5ocQGudIreuupfSYr3csW2a8Zggd4jVgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668455478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfwmN3gCUQ+9TAw/6+bki3KtgpMLZgBklmxHfTgDw4o=;
        b=dncJ14jVrz1LFCtglE+whx9TPp6GS0vWhsUTBrHNZGXicNcXkFVwyCGWGQtJhi1XDLy5gW
        vPUxufgOngSBI2Bw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v4 31/39] printk, xen: fbfront: create/use safe
 function for forcing preferred
In-Reply-To: <20221114162932.141883-32-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-32-john.ogness@linutronix.de>
Date:   Mon, 14 Nov 2022 20:57:18 +0106
Message-ID: <87mt8tfh6x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After more detailed runtime testing I discovered that I didn't re-insert
the console to the correct place in the list. More below...

On 2022-11-14, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/include/linux/console.h b/include/linux/console.h
> index f716e1dd9eaf..9cea254b34b8 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -291,6 +291,7 @@ enum con_flush_mode {
>  };
>  
>  extern int add_preferred_console(char *name, int idx, char *options);
> +extern void console_force_preferred_locked(struct console *con);
>  extern void register_console(struct console *);
>  extern int unregister_console(struct console *);
>  extern void console_lock(void);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e770b1ede6c9..dff76c1cef80 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3461,6 +3462,48 @@ int unregister_console(struct console *console)
>  }
>  EXPORT_SYMBOL(unregister_console);
>  
> +/**
> + * console_force_preferred_locked - force a registered console preferred
> + * @con: The registered console to force preferred.
> + *
> + * Must be called under console_list_lock().
> + */
> +void console_force_preferred_locked(struct console *con)
> +{
> +	struct console *cur_pref_con;
> +
> +	if (!console_is_registered_locked(con))
> +		return;
> +
> +	cur_pref_con = console_first();
> +
> +	/* Already preferred? */
> +	if (cur_pref_con == con)
> +		return;
> +
> +	/*
> +	 * Delete, but do not re-initialize the entry. This allows the console
> +	 * to continue to appear registered (via any hlist_unhashed_lockless()
> +	 * checks), even though it was briefly removed from the console list.
> +	 */
> +	hlist_del_rcu(&con->node);
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed so that the console
> +	 * can be added to the beginning of the console list and its forward
> +	 * list pointer can be re-initialized.
> +	 */
> +	synchronize_srcu(&console_srcu);
> +
> +	con->flags |= CON_CONSDEV;
> +	WARN_ON(!con->device);
> +
> +	/* Only the new head can have CON_CONSDEV set. */
> +	console_srcu_write_flags(cur_pref_con, cur_pref_con->flags & ~CON_CONSDEV);
> +	hlist_add_behind_rcu(&con->node, console_list.first);

This is adding the console as the 2nd item. It should be the new
head. The patch below fixes it.

I have done careful runtime testing with this fixup. After the
force_preferred, the console is the new head and sending data to
/dev/console redirects to that console.

It would be nice if we could fold this in. Sorry.

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8d635467882f..4b77586cf4cb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3494,7 +3494,7 @@ void console_force_preferred_locked(struct console *con)
 
 	/* Only the new head can have CON_CONSDEV set. */
 	console_srcu_write_flags(cur_pref_con, cur_pref_con->flags & ~CON_CONSDEV);
-	hlist_add_behind_rcu(&con->node, console_list.first);
+	hlist_add_head_rcu(&con->node, &console_list);
 }
 EXPORT_SYMBOL(console_force_preferred_locked);
 
