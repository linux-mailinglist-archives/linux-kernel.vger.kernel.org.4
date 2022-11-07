Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E361F889
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiKGQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiKGQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:11:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53C1C93D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:11:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A11A1F383;
        Mon,  7 Nov 2022 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667837478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0DskdtjDHY2pvABZnHBZOTRokFpVmSX8d11g6UxtqQ=;
        b=end9PIz63/KLNxeJwN6LOKQS5l4an+ti4FGYJoVZZozusCdHWw9Uz314cbadcMRSbv1EQd
        7BJKtrNJegT2eLStDzAEBlgW1mm+Gy3z/HLGfcvsmjTMQead3Ggs7nwfHqyZgVeOSgdsDg
        ToPQjXCMMbMa1YfkFQwzh1x5wf+h+uQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3ED852C141;
        Mon,  7 Nov 2022 16:11:18 +0000 (UTC)
Date:   Mon, 7 Nov 2022 17:10:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: cosmetic: was: Re: [patch RFC 19/29] printk: Add basic
 infrastructure for non-BKL consoles
Message-ID: <Y2kt4Wf22SKeH9XI@alley>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.479172669@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222301.479172669@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-09-11 00:28:01, Thomas Gleixner wrote:
> The current console/printk subsystem is protected by a Big Kernel Lock,
> aka. console_lock which has has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and makes
> forced takeover and output in emergency and panic situations a fragile
> endavour which is based on try and pray.
> 
> The goal of non-BKL consoles is to break out of the console lock jail and
> to provide a new infrastructure which avoids the pitfalls and allows
> console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Lockless (SCRU protected) console list walk
>   - Per console locking instead of global locking
>   - Per console state which allows to make informed decisions
>   - Stateful handover and takeover
> 
> As a first step this adds state to struct console. The per console state is
> a atomic_long_t with a 32bit bit field and on 64bit a 32bit sequence for
> tracking the last printed ringbuffer sequence number. On 32bit the sequence
> is seperate from state for obvious reasons which requires to handle a few
> extra race conditions.
> 
> Add the initial state with the most basic 'alive' and 'enabled' bits and
> wire it up into the console register/unregister functionality and exclude
> such consoles from being handled in the console BKL mechanisms.
> 
> The decision to use a bitfield was made as using a plain u32 and mask/shift
> operations turned out to result in uncomprehensible code.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -237,6 +272,9 @@ struct console {
>  	unsigned long		dropped;
>  	void			*data;
>  	struct hlist_node	node;
> +
> +	/* NOBKL console specific members */
> +	atomic_long_t __private	atomic_state[2];

Just to be sure about the meaning. "real" state means the current
state and "handover" means a requested state.

>  };
>  
>  #ifdef CONFIG_LOCKDEP
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2339,7 +2339,9 @@ static bool suppress_message_printing(in
>  static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
>  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
>  
> -#endif /* CONFIG_PRINTK */
> +#endif /* !CONFIG_PRINTK */
> +
> +#include "printk_nobkl.c"

Is there any chance to get rid of this?

If we need to use some of this API in printk.c then please declare
it either in "internal.h" or in a new "printk_noblk.h".

Honestly, I do not have any real arguments why it is bad. But there
are probably reasons why it is not a common pattern. IMHO, split
sources might help to:

    + speed up compilation
    + separate public and internal API
    + keep #ifdef/#else/#endif close each other in .h files
    + keep the sources somehow usable even without cscope
    + ???


>  #ifdef CONFIG_EARLY_PRINTK
>  struct console *early_console;
> @@ -2635,6 +2637,13 @@ static bool abandon_console_lock_in_pani
>   */
>  static inline bool console_is_usable(struct console *con)
>  {
> +	/*
> +	 * Exclude the NOBKL consoles. They are handled seperately
> +	 * as they do not require the console BKL
> +	 */
> +	if ((con->flags & CON_NO_BKL))
> +		return false;

This is confusing. Nobody would expect that a function called
"console_is_usable()" would return false just because the console
has CON_NO_BLK flag set.

Either we need a better name, for example, console_is_blk_and_usable().
Or please put the test into a separate function, e.g. console_is_blk()
and check it separately where needed.

IMHO, the original console_is_usable() would be useful even for
CON_NO_BLK consoles.


> +
>  	if (!(con->flags & CON_ENABLED))
>  		return false;
>  
> --- /dev/null
> +++ b/kernel/printk/printk_nobkl.c
> @@ -0,0 +1,176 @@
> +
> +enum state_selector {
> +	STATE_REAL,
> +	STATE_HANDOVER,
> +};

It might be problem that I am not a native speaker. But the names
are a bit ambiguous to me. I would personally use:

enum state_selector {
	CON_STATE_CURRENT,
	CON_STATE_REQUESTED,
};

or if it is too long: CON_STATE_CUR and CON_STATE_REQ.

Well, I do not resist on the change. I am not sure how the proposed names
would play with the followup patches. The original names might
be good after all. They are not that bad. I primary wanted
to document my first reaction ;-)

> +/**
> + * cons_nobkl_init - Initialize the NOBKL console state
> + * @con:	Console to initialize
> + */
> +static void cons_nobkl_init(struct console *con)
> +{
> +	struct cons_state state = {
> +		.alive = 1,
> +		.enabled = !!(con->flags & CON_ENABLED),
> +	};
> +
> +	cons_state_set(con, STATE_REAL, &state);
> +}

IMHO. we need to update the function description, e.g.

/**
 * cons_nobkl_init - Initialize the NOBKL console specific data
 * @con:	Console to initialize
 */


Background:

The function name does not match the rest:

  + The function name suggests that it initializes NOBLK console.

  + The function description and the implementation suggests that
    it initializes struct cons_state.

I see that the followup patches update this function. It initializes
all the members needed by noblk consoles in struct console. It
allocates per-CPU data and creates the kthread. It means
that the function name is reasonable after all.


> +
> +/**
> + * cons_nobkl_cleanup - Cleanup the NOBKL console state
> + * @con:	Console to cleanup
> + */
> +static void cons_nobkl_cleanup(struct console *con)
> +{
> +	struct cons_state state = { };
> +
> +	cons_state_set(con, STATE_REAL, &state);
> +}

Same as with cons_noblk_init(). The function does a lot
more in the later patches. The description should be

/**
 * cons_nobkl_cleanup - Cleanup the NOBKL console specific data
 * @con:	Console to cleanup
 */

Best Regards,
Petr
