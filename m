Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986D46F06DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbjD0Nt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Ntw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:49:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3464483
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:49:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F40011FE35;
        Thu, 27 Apr 2023 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682603386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Swbzinvf8av35N+IqEK3U3mJZ+XeWnl5lcS/gZxCyog=;
        b=MhB0mmVjv5JSdajiw417Tn82gW1klD0frORBl+b+PjD4nM6s2aJ/HPyyIO9yHIiLGU9sR6
        7Y05xdfEzkGM18NevcvuNkSM0zew1ZOW2s4HxX84HkeSd6d0KCr23SztjlvEnK/sEkBCM4
        Z38WVCC7Izav+H/r9w+MEqK4sKuiEJ4=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A24D2C141;
        Thu, 27 Apr 2023 13:49:45 +0000 (UTC)
Date:   Thu, 27 Apr 2023 15:49:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <ZEp9dXwHCYNPidjC@alley>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-25 14:06:26, Chris Down wrote:
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the order
> of tens of milliseconds to get the UART to successfully write a message.
> While this might be fine for a single, one-off message, this can cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
> 
> This means that while you might want to send at least INFO level
> messages to (for example) netconsole, which is relatively fast, you may
> only want to send at least WARN level messages to the serial console.
> Such an implementation would permit debugging using the serial console
> in cases that netconsole doesn't receive messages during particularly
> bad system issues, while still keeping the noise low enough to avoid
> inducing latency in userspace applications. This patch adds such an
> interface, extending the existing console loglevel controls to allow
> each console to have its own loglevel.

I like the approach. I have many comments but there is nothing
serious. Mostly only cosmetic issues.

> --- /dev/null
> +++ b/Documentation/admin-guide/per-console-loglevel.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _per_console_loglevel:
> +
> +Per-console loglevel support
> +============================
> +
> +Motivation
> +----------
> +
> +Consoles can have vastly different latencies and throughputs. For example,
> +writing a message to the serial console can take on the order of tens of
> +milliseconds to get the UART to successfully write a message. While this might
> +be fine for a single, one-off message, this can cause significant
> +application-level stalls in situations where the kernel writes large amounts of
> +information to the console.
> +
> +This means that while you might want to send at least INFO level messages to
> +(for example) netconsole, which is relatively fast, you may only want to send
> +at least WARN level messages to the serial console. This permits debugging
> +using the serial console in cases that netconsole doesn't receive messages
> +during particularly bad system issues, while still keeping the noise low enough
> +to avoid inducing latency in userspace applications.
> +

It would make sense to list the available loglevel somewhere in this
file:

Loglevel
--------

The loglevels are defined the followind way:

+---+--------------+-----------------------------------+
| 0 | KERN_EMERG   | system is unusable                |
+---+--------------+-----------------------------------+
| 1 | KERN_ALERT   | action must be taken immediately  |
+---+--------------+-----------------------------------+
| 2 | KERN_CRIT	   | critical conditions               |
+---+--------------+-----------------------------------+
| 3 | KERN_ERR     | error conditions                  |
+---+--------------+-----------------------------------+
| 4 | KERN_WARNING | warning conditions                |
+---+--------------+-----------------------------------+
| 5 | KERN_NOTICE  | normal but significant condition  |
+---+--------------+-----------------------------------+
| 6 | KERN_INFO    | informational                     |
+---+--------------+-----------------------------------+
| 7 | KERN_DEBUG   | debug-level messages              |
+---+--------------+-----------------------------------+

> +Tunables
> +--------
> +
> +In order to allow tuning this, the following controls exist:
> +
> +Global
> +~~~~~~
> +
> +The global loglevel is set by the ``kernel.console_loglevel`` sysctl, which can
> +also be set as ``loglevel=`` on the kernel command line.
> +
> +The printk module also takes two parameters which modify this behaviour
> +further:
> +
> +* ``ignore_loglevel`` on the kernel command line or set in printk parameters:
> +  Emit all messages. All other controls are ignored if this is present.

Please add empty lines between "* item with a long descripion".
It would make the text better readable in the plain text form.

> +* ``ignore_per_console_loglevel`` on the kernel command line or set in printk
> +  parameters: Ignore all per-console loglevels and use the global loglevel.
> +
> +The default value for ``kernel.console_loglevel`` comes from
> +``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
> +``quiet`` is passed on the kernel command line.
> +
> +Console attributes
> +~~~~~~~~~~~~~~~~~~
> +
> +Registered consoles are exposed at ``/sys/class/console``. For example, if you
> +are using ``ttyS0``, the console backing it can be viewed at
> +``/sys/class/console/ttyS0/``. The following files are available:
> +
> +* ``effective_loglevel`` (r): The effective loglevel after considering all
> +  loglevel authorities. For example, if the console-specific loglevel is 3, but
> +  the global minimum console loglevel [*]_ is 5, then the value will be 5.

I would rather avoid this example. It confused me ;-)

I thought that it was talking about the "global console loglevel"
instead of "global minimum console loglevel". I was surprised
that the global value was used when a console-specific one
was defined.

</more details about my confusion>
The console loglevel defines a maximal message loglevel.
The important thing is that it defines a "limit". Most people,
including me, do not remember if the numbers go up or down.
So I ignored the word "minimum". I though that it described
the effect of the value and not a limit for the value.

Also the global minimum loglevel is a really weird setting.
I do not see much practical use for it. I guess that most
people are not aware of this limit. I think that it creates
more harm than good.
</more details about my confusion>

My proposal. I would replace the "confusing" paragraph with
something like:

  * ``effective_loglevel`` (r): The effective loglevel after considering all
    loglevel authorities. For example, it would show the value of
    the console-specific loglevel when it is defined or the global
    console loglevel value when the console-specific one is not defined.


> +* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
> +  the effective loglevel being set. The following values can be present:
> +
> +    * ``local``: The console-specific loglevel is in effect.

> +    * ``global``: The global loglevel (``kernel.console_loglevel``) is in
> +      effect. Set a console-specific loglevel to override it.

> +    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
> +      command line or at ``/sys/module/printk/parameters/ignore_loglevel``.
> +      Disable it to use level controls.

> +    * ``ignore_per_console_loglevel``: ``ignore_per_console_loglevel`` was
> +      specified on the kernel command line or at
> +      ``/sys/module/printk/parameters/ignore_per_console_loglevel``. Disable it
> +      to use per-console level controls.

The code does not show this value. And I would not show it either.

> +* ``enabled`` (r): Whether the console is enabled.

> +* ``loglevel`` (rw): The local, console-specific loglevel for this console.
> +  This will be in effect if no other global control overrides it. Look at
> +  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
> +
> +.. [*] The existence of a minimum console loglevel is generally considered to
> +   be a confusing and rarely used interface, and as such is not exposed through
> +   the modern printk sysctl APIs that obsoleted ``kernel.printk``. Use the
> +   legacy ``kernel.printk`` sysctl to control it if you have a rare use case
> +   that requires changing it. The default value is ``CONSOLE_LOGLEVEL_MIN``.
> +
> +Deprecated
> +~~~~~~~~~~
> +
> +* ``kernel.printk`` sysctl: this takes four values, setting
> +  ``kernel.console_loglevel``, ``kernel.default_message_loglevel``, the minimum
> +  console loglevel, and a fourth unused value. The interface is generally
> +  considered to quite confusing, doesn't perform checks on the values given,
> +  and is unaware of per-console loglevel semantics.
> +
> +Chris Down <chris@chrisdown.name>, 27-April-2023
> diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
> index 58b32832e50a..4e204115fe4a 100644
> --- a/Documentation/admin-guide/serial-console.rst
> +++ b/Documentation/admin-guide/serial-console.rst
> @@ -32,15 +32,25 @@ The format of this option is::
>  			and F is flow control ('r' for RTS). Default is
>  			9600n8. The maximum baudrate is 115200.
>  
> +			One can also specify the per-console loglevel for this
> +			console by providing a loglevel parameter, for example
> +			"loglevel:4" to set this console's loglevel to 4. The
> +			value provided can be from 0 (LOGLEVEL_EMERG) to 8
> +			(LOGLEVEL_DEBUG + 1), and messages below that will be
> +			emitted onto the console as they become available.

It would be handy to add the table with the available log levels
into this file as well.

> +
>  You can specify multiple console= options on the kernel command line.
>  Output will appear on all of them. The last device will be used when
>  you open ``/dev/console``. So, for example::
>  
> -	console=ttyS1,9600 console=tty0
> +	console=ttyS1,9600,loglevel:5 console=tty0
>  
>  defines that opening ``/dev/console`` will get you the current foreground
> -virtual console, and kernel messages will appear on both the VGA
> -console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
> +virtual console, and kernel messages will appear on both the VGA console and
> +the 2nd serial port (ttyS1 or COM2) at 9600 baud. The optional loglevel "5"
> +indicates that this console will emit messages more serious than
> +LOGLEVEL_NOTICE (that is, LOGLEVEL_WARNING and below, since more serious
> +messages have lower ordering).
>  
>  Note that you can only define one console per device type (serial, video).
>  
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -101,12 +102,26 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
>  static void sysrq_handle_loglevel(int key)
>  {
>  	int i;
> +	int cookie;
> +	int warned = 0;
> +	struct console *con;
>  
>  	i = key - '0';
>  	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>  	pr_info("Loglevel set to %d\n", i);
>  	console_loglevel = i;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		if (!warned && per_console_loglevel_is_set(con)) {
> +			warned = 1;
> +			pr_warn("Overriding per-console loglevel from sysrq\n");
> +		}
> +		con->level = -1;

Please, use WRITE_ONCE(con->level, -1) to make sure that it will be
atomic.

READ_ONCE()/WRITE_ONCE() should always be used when the values
are read/written using RCU synchronization. Otherwise the compiler
might do some optimizations and read/write bytes separately.

> +	}
> +	console_srcu_read_unlock(cookie);
>  }

Also we should safe/set/restore "ignore_per_console_loglevel"
in __handle_sysrq(). It already does the same with
"console_loglevel".

__handle_sysrq() increases the loglevel to show all
messages printed by the sysrq handler on all consoles.
Many handlers print some information that might be useful
for debugging.

>  static const struct sysrq_key_op sysrq_loglevel_op = {
>  	.handler	= sysrq_handle_loglevel,
>  	.help_msg	= "loglevel(0-9)",
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -203,6 +204,8 @@ struct console {
>  	unsigned long		dropped;
>  	void			*data;
>  	struct hlist_node	node;
> +	int			level;
> +	struct device		*classdev;

Please, update also the comment above the structure.

>  };
>  
>  #ifdef CONFIG_LOCKDEP
> --- a/kernel/printk/console_cmdline.h
> +++ b/kernel/printk/console_cmdline.h
> @@ -6,6 +6,8 @@ struct console_cmdline
>  {
>  	char	name[16];			/* Name of the driver	    */
>  	int	index;				/* Minor dev. to use	    */
> +	int	level;				/* Log level to use */
> +	short	flags;				/* Initial flags */

Are the initial flags actually set anywhere?

>  	bool	user_specified;			/* Specified by command line vs. platform */
>  	char	*options;			/* Options for the driver   */
>  #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 041c7bd56005..f006960ce18b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1261,9 +1278,119 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(ignore_loglevel,
>  		 "ignore loglevel setting (prints all kernel messages to the console)");
>  
> -static bool suppress_message_printing(int level)
> +static bool __read_mostly ignore_per_console_loglevel;
> +
> +static int __init ignore_per_console_loglevel_setup(char *str)
> +{
> +	ignore_per_console_loglevel = true;
> +	return 0;
> +}
> +
> +early_param("ignore_per_console_loglevel", ignore_per_console_loglevel_setup);
> +module_param(ignore_per_console_loglevel, bool, 0644);
> +MODULE_PARM_DESC(
> +	ignore_per_console_loglevel,
> +	"ignore per-console loglevel setting (only respect global console loglevel)");
> +
> +bool per_console_loglevel_is_set(const struct console *con)
> +{
> +	return !ignore_per_console_loglevel && con && (con->level > 0);

It should use READ_ONCE(con->level).

> +}
> +
> +/*
> + * Hierarchy of loglevel authority:
> + *
> + * 1. con->level. The locally set, console-specific loglevel. Optional, only
> + *    valid if >0.
> + * 2. console_loglevel. The default global console loglevel, always present.
> + *
> + * The behaviour can be further changed by the following printk module
> + * parameters:
> + *
> + * 1. ignore_loglevel. Can be set at boot or at runtime with
> + *    /sys/module/printk/parameters/ignore_loglevel. Overrides absolutely
> + *    everything since it's used to debug.
> + * 2. ignore_per_console_loglevel. Existing per-console loglevel values are left
> + *    intact, but are ignored in favour of console_loglevel as long as this is
> + *    true. Also manipulated through syslog(SYSLOG_ACTION_CONSOLE_{ON,OFF}).
> + */
> +static enum loglevel_source
> +console_effective_loglevel_source(const struct console *con)
> +{
> +	if (WARN_ON_ONCE(!con))
> +		return LLS_GLOBAL;
> +
> +	if (ignore_loglevel)
> +		return LLS_IGNORE_LOGLEVEL;
> +
> +	if (per_console_loglevel_is_set(con))
> +		return LLS_LOCAL;
> +
> +	return LLS_GLOBAL;
> +}
> +
> +static int console_effective_loglevel(const struct console *con)
>  {
> -	return (level >= console_loglevel && !ignore_loglevel);
> +	enum loglevel_source source;
> +	int level;
> +
> +	if (WARN_ON_ONCE(!con))
> +		return default_console_loglevel;

This looks superfluous. The check in
console_effective_loglevel_source(con) should be enough.

I know that it would change the behavior of this function.
It would return the value of "console_loglevel" instead of
"default_console_loglevel" when there is a bug. But it
does not matter. There is no good value. It just
should never happen.

> +	source = console_effective_loglevel_source(con);
> +
> +	switch (source) {
> +	case LLS_IGNORE_LOGLEVEL:
> +		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
> +		break;
> +	case LLS_LOCAL:
> +		level = con->level;
> +		break;
> +	case LLS_GLOBAL:
> +		level = console_loglevel;
> +		break;
> +	default:
> +		pr_warn("Unhandled console loglevel source: %d", source);
> +		level = default_console_loglevel;
> +		break;
> +	}
> +
> +	return level;
> +}
> +
> +static const char *
> +console_effective_loglevel_source_str(const struct console *con)
> +{
> +	enum loglevel_source source;
> +	const char *str;
> +
> +	if (WARN_ON_ONCE(!con))
> +		return "unknown";

Same here. I would remove this check.

> +	source = console_effective_loglevel_source(con);
> +
> +	switch (source) {
> +	case LLS_IGNORE_LOGLEVEL:
> +		str = "ignore_loglevel";
> +		break;
> +	case LLS_LOCAL:
> +		str = "local";
> +		break;
> +	case LLS_GLOBAL:
> +		str = "global";
> +		break;
> +	default:
> +		pr_warn("Unhandled console loglevel source: %d", source);
> +		str = "unknown";
> +		break;
> +	}
> +
> +	return str;
> +}
> +
> +static bool suppress_message_printing(int level, struct console *con)
> +{
> +	return level >= console_effective_loglevel(con);
>  }
>  
>  #ifdef CONFIG_BOOT_PRINTK_DELAY
> @@ -2293,7 +2429,14 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		in_sched = true;
>  	}
>  
> -	printk_delay(level);
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		if (!suppress_message_printing(level, con)) {
> +			printk_delay();

This would repeat the delay for each registered and non-supressed console.
But it should be called only once when there is at least one
non-suppressed console.

> +			break;
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);

I would prefer to keep the @level parameter and do this in
printk_delay(). vprintk_emit() historically grew into a monster
function. It took a long time to clean it. I am happy that
it contains only the top level logic now ;-)

>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> @@ -2410,11 +2556,78 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
>  	console_set_on_cmdline = 1;
>  }
>  
> +static bool find_and_remove_console_option(char *options, const char *key,
> +					   char *val_buf, size_t val_buf_size)
> +{
> +	bool found = false, first = true;
> +	char *option, *next = options;
> +
> +	while ((option = strsep(&next, ","))) {
> +		char *value;
> +
> +		value = strchr(option, ':');
> +		if (value)
> +			*(value++) = '\0';
> +
> +		if (strcmp(option, key) == 0) {
> +			found = true;
> +			if (value) {
> +				if (strlen(value) > val_buf_size - 1)
> {

It might undeflow when val_buf_size == 0. I would use:

				if (strlen(value) >= val_buf_size)

> +					pr_warn("Can't copy console option value for %s:%s: not enough space (%zu)\n",
> +						option, value, val_buf_size);
> +					found = false;
> +				} else {
> +					strscpy(val_buf, value, val_buf_size);
> +				}
> +			} else
> +				*val_buf = '\0';
> +		}
> +
> +		if (found)
> +			break;
> +
> +		if (next)
> +			*(next - 1) = ',';
> +		if (value)
> +			*(value - 1) = ':';
> +
> +		first = false;
> +	}
> +
> +	if (found) {
> +		if (next)
> +			memmove(option, next, strlen(next) + 1);
> +		else if (first)
> +			*option = '\0';
> +		else
> +			*--option = '\0';
> +	}
> +
> +	return found;
> +}
> +
> +static int find_and_remove_loglevel_option(char *options)
> +{
> +	char val[3];
> +
> +	int loglevel;
> +
> +	if (!find_and_remove_console_option(options, "loglevel", val,
> +					    sizeof(val)))
> +		return -ENOENT;
> +
> +	if (kstrtoint(val, 10, &loglevel)) {
> +		pr_warn("Invalid console loglevel, ignoring: %s\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return clamp_loglevel(loglevel);

I would use the same logic as in loglevel_store():

	if (clamp_loglevel(loglevel) != loglevel) {
		pr_warn("Per-console loglevel out of range, ignoring: %d\n", loglevel);
		return -ERANGE;
	}

	return loglevel;

Nit: Also I would use a bigger buffer, e.g. val[12]. It would allow to
     read a bigger range of invalid values. The message about that
     a value is out of range is more clear than the generic one about
     that the buffer is too small ;-)

> +}
> +
>  static int __add_preferred_console(char *name, int idx, char *options,
>  				   char *brl_options, bool user_specified)
>  {
>  	struct console_cmdline *c;
> -	int i;
> +	int i, ret;
>  
>  	/*
>  	 *	See if this tty is not yet registered, and
> @@ -2435,6 +2648,11 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	if (!brl_options)
>  		preferred_console = i;
>  	strscpy(c->name, name, sizeof(c->name));
> +
> +	ret = find_and_remove_loglevel_option(options);
> +	if (ret >= 0)
> +		c->level = ret;

c->level == 0 is also the initial value. We should do:

	if (ret >= 0)
		c->level = ret;
	else
		c->level = -1;

I know that it was not a real problem because the level never could be 0
because of clamping by the minimal console loglevel. But it is not obvious.
Let's have the logic obvious and clear.

> +
>  	c->options = options;
>  	set_user_specified(c, user_specified);
>  	braille_set_options(c, brl_options);
> @@ -2764,7 +2982,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
>   * of @pmsg are valid. (See the documentation of struct printk_message
>   * for information about the @pmsg fields.)
>   */
> -static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> +static bool printk_get_next_message(struct printk_message *pmsg,
> +				    struct console *con, u64 seq,
>  				    bool is_extended, bool may_suppress)

@is_extended has to match @con->flags & CON_EXTENDED. It would be
ugly if the API is not used correctly and they do not match.

Also the "may_suppress" value might be guessed from @con.

I see two solutions:

1. If we pass @con then @is_extended and @may_suppress parameters
   are not needed. The values might be guessed. The logic is
   the following:

	if (con) {
		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
		may_suppress = true;
	} else {
		/* Used only by devkmsg_read(). */
		is_extended = true;
		may_suppress = false;
	}

   If we go this way then we should do the parameter switch in a
   separate patch. The commit message should explain that
   the upcoming changes will need to read even more information
   from struct console.

   The drawback is that @con->seq and @seq values might still
   be inconsistent. But the @seq value must be passed explicitly
   when called from dev_kmsg() and @con is NULL. Also the explicit
   @seq parameter will most likely useful also for the
   con->atomic_write() callback added by John's patchset.
   The atomic consoles will not use con->seq at all.


2. We could pass @con_loglevel instead of @con. And pass it to
   suppress_message_printing() instead of @con as well.

   It is probably cleaner solution but the many parameters suck.


I would personally use the 1st proposal and live with the fact
that the function would ignore con->seq and use the passed
@seq instead. The many parameters suck, and especially
bool parameters suck.

>  {
>  	static int panic_console_dropped;
> @@ -2808,7 +3027,7 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	}
>  
>  	/* Skip record that has level above the console loglevel. */
> -	if (may_suppress && suppress_message_printing(r.info->level))
> +	if (may_suppress && suppress_message_printing(r.info->level, con))

This would be:

	/* Never suppress when used in devkmsg_read() */
	if (con && suppress_message_printing(r.info->level, con))

>  		goto out;
>  
>  	if (is_extended) {
> @@ -2851,7 +3070,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  
>  	*handover = false;
>  
> -	if (!printk_get_next_message(&pmsg, con->seq, is_extended, true))
> +	if (!printk_get_next_message(&pmsg, con, con->seq, is_extended, true))

The "con, con->seq" parameters look a bit ugly.
But I could live with it as explained above.

>  		return false;
>  
>  	con->dropped += pmsg.dropped;
> @@ -3199,6 +3418,144 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +#ifdef CONFIG_PRINTK

It might be better to put this into separate source file, e.g.
kernel/printk/sysfs.c, like the existing kernel/printk/sysctl.c.

printk.c is already huge. And any longer #ifdef section is always
hard to follow in such long files. This would actually be
3rd #ifdef CONFIG_PRINTK section there.

> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", con->level);

It should use READ_ONCE(con->loglevel).

> +}
> +
> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +	ssize_t ret;
> +	int level;
> +
> +	ret = kstrtoint(buf, 10, &level);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (level == -1) {
> +		con->level = level;
> +		return size;
> +	}

Nit: This might be:

	if (level == -1)
		goto out:

> +	if (clamp_loglevel(level) != level)
> +		return -ERANGE;

out:
> +	con->level = level;
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(loglevel);
[...]
> +
> +static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", !!(con->flags & CON_ENABLED));

This should use console_srcu_read_flags(con) & CON_ENABLED);

> +}
> +
[...]
> +static void console_register_device(struct console *con)
> +{

Please add:

	lockdep_assert_console_list_lock_held();

, see below.


> +	/*
> +	 * We might be called from register_console() before the class is
> +	 * registered. If that happens, we'll take care of it in
> +	 * printk_late_init.
> +	 */
> +	if (IS_ERR_OR_NULL(console_class))
> +		return;
> +
> +	if (WARN_ON(con->classdev))
> +		return;
> +
> +	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);

Better would be sizeof(*con->classdev)

> +	if (!con->classdev)
> +		return;
> +
> +	device_initialize(con->classdev);
> +	dev_set_name(con->classdev, "%s%d", con->name, con->index);
> +	dev_set_drvdata(con->classdev, con);
> +	con->classdev->release = console_classdev_release;
> +	con->classdev->class = console_class;
> +	if (device_add(con->classdev))
> +		put_device(con->classdev);
> +}
> +
> +static void console_setup_class(void)

Please. rename it to console_sysfs_init() to match the name of
printk_sysctl_init(). They are called after each other in
printk_late_init()...

> +{
> +	struct console *con;
> +	int cookie;
> +
> +	/*
> +	 * printk exists for the lifetime of the kernel, it cannot be unloaded,
> +	 * so we should never end up back in here.
> +	 */
> +	if (WARN_ON(console_class))
> +		return;
> +
> +	console_class = class_create(THIS_MODULE, "console");
> +	if (!IS_ERR(console_class))
> +		console_class->dev_groups = console_sysfs_groups;
> +

I would add a comment here:

	/*
	 * Create sysfs interface for consoles that were registered
	 * before the console class was created.
	 */

> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con)

This does not loop properly serialized against register_console() and
unregister_console(). I am not 100% sure. The race is not much
realistic, definitely. But better be on the safe side and do:

	console_list_lock();
	for_each_console(con) {

> +		console_register_device(con);
> +	console_srcu_read_unlock(cookie);
> +}
> +#else /* CONFIG_PRINTK */
> +static void console_register_device(struct console *new)
> +{
> +}
> +static void console_setup_class(void)
> +{
> +}
> +#endif
> +
>  /*
>   * This is called by register_console() to try to match
>   * the newly registered console with any of the ones selected
> @@ -3231,6 +3588,14 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (newcon->index < 0)
>  				newcon->index = c->index;
>  
> +			if (c->level > 0)
> +				newcon->level = c->level;
> +			else
> +				newcon->level = -1;

Better would be:

			if (c->level >= minimum_console_loglevel)
				newcon->level = c->level;
			else
				newcon->level = -1;


> +
> +			newcon->flags |= c->flags;

Is newcon->flags actually set anywhere, please?

> +			newcon->classdev = NULL;
> +
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> @@ -3627,6 +3996,10 @@ void __init console_init(void)
>   * To mitigate this problem somewhat, only unregister consoles whose memory
>   * intersects with the init section. Note that all other boot consoles will
>   * get unregistered when the real preferred console is registered.
> + *
> + * Early consoles will also have been registered before we had the
> + * infrastructure to put them into /sys/class/console, so make sure they get
> + * set up now that we're ready.

Actually, it is not only about early consoles. Even normal consoles
are usually registered before late init calls.

Anyway, we do not need to add a comment here. It is too lost and
unrelated to the above comments. The comment in console_setup_class()
above the for-cycle would be enough.

>   */
>  static int __init printk_late_init(void)
>  {
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -7,10 +7,14 @@
>  #include <linux/printk.h>
>  #include <linux/capability.h>
>  #include <linux/ratelimit.h>
> +#include <linux/console.h>
>  #include "internal.h"
>  
>  static const int ten_thousand = 10000;
>  
> +static int min_loglevel = LOGLEVEL_EMERG;
> +static int max_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;

The default message loglevel should be meaningful. I would use
LOGLEVEL_DEBUG at max.

Also, please, call the variable min_msg_... to make it clear
that these limits are for message loglevels:

static int min_msg_loglevel = LOGLEVEL_EMERG;
static int max_msg_loglevel = LOGLEVEL_DEBUG;

> +
>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  				void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -20,13 +24,48 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> +static int printk_sysctl_deprecated(struct ctl_table *table, int write,
> +				    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	if (write)
> +		pr_warn_once(
> +			"printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n");

Nit: Please, put it on the same line as pr_warn_once("printk: The kernel....
     The small shift left did not help much ;-)

> +
> +	return res;
> +}
> +
> +static int printk_console_loglevel(struct ctl_table *table, int write,
> +				   void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ctl_table ltable = *table;
> +	int ret, level;
> +
> +	if (!write)
> +		return proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	ltable.data = &level;
> +
> +	ret = proc_dointvec(&ltable, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +
> +	if (level != -1 && level != clamp_loglevel(level))
> +		return -ERANGE;
> +
> +	console_loglevel = level;
> +
> +	return 0;
> +}
> +
>  static struct ctl_table printk_sysctls[] = {
>  	{
>  		.procname	= "printk",
>  		.data		= &console_loglevel,
>  		.maxlen		= 4*sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= printk_sysctl_deprecated,
>  	},
>  	{
>  		.procname	= "printk_ratelimit",
> @@ -76,6 +115,22 @@ static struct ctl_table printk_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> +	{
> +		.procname	= "console_loglevel",
> +		.data		= &console_loglevel,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= printk_console_loglevel,
> +	},
> +	{
> +		.procname	= "default_message_loglevel",
> +		.data		= &default_message_loglevel,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &min_loglevel,
> +		.extra2		= &max_loglevel,
> +	},
>  	{}
>  };

Finally, the patch is really huge. It might cause problems
when dealing with regressions. It would be nice to split it.
It would help with review, bisection, and make the life
easier for future archaeologists.

The following separate patches comes to my mind:

1. Fix printk_delay() call (already done, current 1st patch)

2. Pass @con instead of @is_extended/@may_schedule in
   in printk_get_next_message().

3. Add con->level and the logic that will use it in printk(),
   including console_effective_loglevel(). It will be
   temporary initialized to -1 in register_console().

4. Add ignore_per_console_loglevel parameter, use it
   in per_console_loglevel_is_set(), do_syslog(),
   and __handle_sysrq().

5. Add sysfs interface that would allow to set per-console
   log level at runtime.

6. Add the command line interface that would allow to define
   the console loglevel via console= parameter.

7. Update the sysctl interface.

I know that it might be painful to do so but I believe that
it would pay off in the long term.

How does this sounds, please?

Best Regards,
Petr
