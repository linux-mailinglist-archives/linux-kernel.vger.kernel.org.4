Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB46406D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiLBM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiLBM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:27:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999844E6AD;
        Fri,  2 Dec 2022 04:27:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 438812188A;
        Fri,  2 Dec 2022 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669984077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gqeCZM5OYJ+JIW5Pild9FTDbugF31mKRKD6SyEG6wA=;
        b=oco5GF9PtWap+DR+4x4hnFUWZSasnV6H+asW7NISvNIAkDmHbDLkaZgswwhSVctsJKQFw7
        VpS0/C7MS+Iz2n/w/8Iy32Z2HYtND7P46JLowFpyeAm9ZmnVIVK54JfwGlEHtmJ/kBzKEa
        o1FgrzK7cyZbhTMIP3TGUNz/GxDrNi4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0C8C22C141;
        Fri,  2 Dec 2022 12:27:57 +0000 (UTC)
Date:   Fri, 2 Dec 2022 13:27:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <Y4nvSTTPdSEIZ+zl@alley>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-2-linux@weissschuh.net>
 <Y4dndyIiosT7l4RG@alley>
 <6bc60e00-30b8-40ff-81f4-e7973c701ad4@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bc60e00-30b8-40ff-81f4-e7973c701ad4@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-30 15:56:33, Thomas Weiﬂschuh wrote:
> On 2022-11-30 15:23+0100, Petr Mladek wrote:
> > On Fri 2022-11-25 20:09:46, Thomas Weiﬂschuh wrote:
> >> These macros emit continuation messages with explicit levels.
> >> In case the continuation is logged separately from the original message
> >> it will retain its level instead of falling back to KERN_DEFAULT.
> >> 
> >> This remedies the issue that logs filtered by level contain stray
> >> continuation messages without context.
> >> 
> >> Suggested-by: Petr Mladek <pmladek@suse.com>
> >> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> >> ---
> >>  include/linux/printk.h | 23 +++++++++++++++++++++++
> >>  1 file changed, 23 insertions(+)
> >> 
> >> diff --git a/include/linux/printk.h b/include/linux/printk.h
> >> index 8c81806c2e99..8f564c38f121 100644
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -537,6 +537,8 @@ struct pi_entry {
> >>   * This macro expands to a printk with KERN_CONT loglevel. It should only be
> >>   * used when continuing a log message with no newline ('\n') enclosed. Otherwise
> >>   * it defaults back to KERN_DEFAULT loglevel.
> >> + *
> >> + * Use the dedicated pr_<level>_cont() macros instead.
> >>   */
> >>  #define pr_cont(fmt, ...) \
> >>  	printk(KERN_CONT fmt, ##__VA_ARGS__)
> >> @@ -701,6 +703,27 @@ do {									\
> >>  	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> >>  #endif
> >>  
> >> +/*
> >> + * Print a continuation message with level. In case the continuation is split
> >> + * from the main message it preserves the level.
> >> + */
> >> +
> >> +#define pr_emerg_cont(fmt, ...)					\
> >> +	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_alert_cont(fmt, ...)					\
> >> +	printk(KERN_ALERT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_crit_cont(fmt, ...)					\
> >> +	printk(KERN_CRIT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_err_cont(fmt, ...)					\
> >> +	printk(KERN_ERR KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_warn_cont(fmt, ...)					\
> >> +	printk(KERN_WARN KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_notice_cont(fmt, ...)					\
> >> +	printk(KERN_NOTICE KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_info_cont(fmt, ...)					\
> >> +	printk(KERN_INFO KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> >> +/* no pr_debug_ratelimited, it doesn't make sense with CONFIG_DYNAMIC_DEBUG. */
> > 
> > I guess that you wanted to write "pr_debug_cont".
> 
> Indeed.
> 
> > Also I am not sure what you mean with "doesn't make sense". IMHO, it
> > might  make sense. But it would be hard to use and error prone
> > with CONFIG_DYNAMIC_DEBUG.
> > 
> > And more importantly, it probably would not work properly. If I get
> > it corretly the dynamic debug messages are printed by the wrapper:
> > 
> > void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
> > {
> > [...]
> > 	vaf.fmt = fmt;
> > 	vaf.va = &args;
> > 
> > 	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
> > [...]
> > 
> > This clearly does not support KERN_CONT in "fmt".
> 
> Good point.
> 
> My doubt was more that it would force users to know which message
> continuations belong together and always enable all of them together with
> dynamic debug.
> Which would be very errorprone and annoying to use.

Yes. This is what I meant with "hard to use" but I was not clear
enough :-)

> 
> But if it doesn't work at all that's an even stronger point.
> 
> > I suggest to either remove the comment completely. Or write something
> > like:
> > 
> > /* no pr_debug_cont(), can't be supported easily with CONFIG_DYNAMIC_DEBUG */
> 
> What about:
> 
> /* no pr_debug_cont(), it's errorprone to use
>  * and can't be supported easily with CONFIG_DYNAMIC_DEBUG */

Sounds good to me.

Best Regards,
Petr

PS: Heh, I just realized that we actually abandoned these changes because
    the continuous lines in kernel/power/process.c are going to be
    removed. (/me doing too many things in parallel).

    Anyway, it is possible that someone would take this patches to fix
    another continuous lines in the future.
