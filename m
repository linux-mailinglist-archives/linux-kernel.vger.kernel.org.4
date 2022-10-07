Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B925F77BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJGL6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:58:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE04CF866
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 04:57:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52B391F88D;
        Fri,  7 Oct 2022 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665143878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPDABE6V9DnT9VHFEqqqdfPppCdSWtIZjchCcrjiRHs=;
        b=NfgDeJHO27KqfMmMEX4q2nFT9N16Uu+xBV1RydBhQ+kM5bFgCFLQQ8KgMLeUqZ7ZK9EWsS
        C+tfBiGAhO8DlTATSrdHc4XlfcfHQv1q3U4uT5GEv4w1XWNpXwIukJi4mIk6CUxcDE3QAH
        3CdU3lZMNKUNusjOer+ODwuexzqbU3w=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 456CD2C142;
        Fri,  7 Oct 2022 11:57:57 +0000 (UTC)
Date:   Fri, 7 Oct 2022 13:57:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 14/18] printk: Document struct console
Message-ID: <Y0AUQSvug9V0miXU@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-15-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10:50, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add docbook comments to struct console.

Great!

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_CONSOLE_H_ 1
>  
>  #include <linux/atomic.h>
> +#include <linux/bits.h>

This probably should have been in another patch?

>  #include <linux/rculist.h>
>  #include <linux/types.h>
>  
> @@ -139,37 +140,77 @@ static inline int con_debug_leave(void)
>  /*
>   * The interface for a console, or any other device that wants to capture
>   * console messages (printer driver?)
> - *
> - * If a console driver is marked CON_BOOT then it will be auto-unregistered
> - * when the first real console is registered.  This is for early-printk drivers.
>   */
>  
> -#define CON_PRINTBUFFER	(1)
> -#define CON_CONSDEV	(2) /* Preferred console, /dev/console */
> -#define CON_ENABLED	(4)
> -#define CON_BOOT	(8)
> -#define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
> -#define CON_BRL		(32) /* Used for a braille device */
> -#define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
> +/**
> + * cons_flags - General console flags
> + * @CON_PRINTBUFFER:	On register, start from the oldest dmesg record

This a bit misleading. It starts from the oldest record that has not
been read via syslog yet. dmesg has been using /dev/kmsg by default
since a long time and it does not touch syslog_seq.

IMHO, in practice, it starts from the oldest record available in the ring
buffer. I think that nobody is using syslog syscall any longer. Also
console drivers are registered quite early. I am not sure if userspace
has any chance to read the log.

Finally, the flag is cleared when a boot consoles are replaced by
the preferred console.

I would write something like:

+ * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			console or read by userspace via syslog() syscall.


> + * @CON_CONSDEV:	Questionable historical leftover to denote which console
> + *			driver is the preferred console which is defining what
> + *			backs up /dev/console

It is true. But it sounds like it can be removed. But it can't be done
easily because it can be checked by userspace. For example, it is checked by
https://github.com/bitstreamout/showconsole/blob/master/showconsole.c

Another problem is that it is just the best effort. It might happen
that it is set for a wrong driver. But I would consider this a bug.

I would write something like:

 * @CON_CONSDEV:	Indicates that the console driver is backing
 *			/dev/console.

> + * @CON_ENABLED:	Indicates if a console is allowed to print records. If false,
> + *			the console also will not advance to later records.
> + * @CON_BOOT:		Marks the console driver as early console driver which
> + *			is used during boot before the real driver becomes available.
> + *			It will be automatically unregistered unless the early console
> + *			command line parameter for this console has the 'keep' option set.

This is more complicated. And it is a real mess, huh, huh, huh.

There are earlyprintk= and earlycon= parameters. They both register
boot consoles but earlyprintk= is supported only on some architectures.

I did not check it. My guess is that earlyprintk= was the first attempt
to show kernel messages as early as possible. There is also
early_printk() function that calls early_console->write()
directly. I think that it is used by Peter Zijlstra who
wants to avoid console_lock().

earlycon= does just the bare minimum to initialize driver
(no sysfs stuff, ...). Otherwise, the console works the same
way as a normal console driver defied by console=. It is called
from console_unlock().

Now, only earlyprintk= handle the "keep" parameter, see
setup_early_printk(). The CON_BOOT flag is not set when
"keep" parameter is used, see early_console_register().

earlycon= does not support the "keep" parameter. There is
the "keep_bootcon" option instead.

Lovely, isn't it?

OK, I suggest to write something like:

 * @CON_BOOT:		Marks the console driver as early console driver which
 *			is used during boot before the real driver becomes
 *			available. It will be automatically unregistered
 *			when the real console driver is registered unless
 *			"keep_bootcon" parameter is used.

> + * @CON_ANYTIME:	A misnomed historical flag which tells the core code that the

s/misnomed/misnamed/ ?

> + *			legacy @console::write callback can be invoked on a CPU which
> + *			is marked OFFLINE. That's misleading as it suggests that there
> + *			is no contextual limit for invoking the callback.

When I was digging the history, the motivation for this flag was
whether the per-CPU areas were initialized. Maybe, we should mention it here:

 * @CON_ANYTIME:	A misnamed historical flag which tells the core code
 *			that the legacy @console::write callback can be invoked
 *			on a CPU which is marked OFFLINE. That's misleading as
 *			it suggests that there is no contextual limit for
 *			invoking the callback. The original motivation was
 *			readiness of the per-CPU areas.

> + * @CON_BRL:		Indicates a braille device which is exempt from receiving the
> + *			printk spam for obvious reasons
> + * @CON_EXTENDED:	The console supports the extended output format of /dev/kmesg
> + *			which requires a larger output record buffer
> + */
> +enum cons_flags {
> +	CON_PRINTBUFFER		= BIT(0),
> +	CON_CONSDEV		= BIT(1),
> +	CON_ENABLED		= BIT(2),
> +	CON_BOOT		= BIT(3),
> +	CON_ANYTIME		= BIT(4),
> +	CON_BRL			= BIT(5),
> +	CON_EXTENDED		= BIT(6),
> +};
>  
> +/**
> + * struct console - The console descriptor structure
> + * @name:		The name of the console driver
> + * @write:		Write callback to output messages (Optional)

I am surprised that write() callback is optional. But it seems
that, for example, ttynull_console does not have it defined.

> + * @read:		Read callback for console input (Optional)
> + * @device:		The underlying TTY device driver (Optional)
> + * @unblank:		Callback to unblank the console (Optional)
> + * @setup:		Callback for initializing the console (Optional)

Thanks a lot for this effort.

Best Regards,
Petr
