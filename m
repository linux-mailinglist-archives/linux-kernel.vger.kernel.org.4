Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9863E576
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiK3XaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3X3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:29:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C82BD5;
        Wed, 30 Nov 2022 15:20:05 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:50:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669850360;
        bh=AOooFKU7NIxLs7yLATARLHPgA86wAoxNAcbcgPZM9II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZ7g80E1uS2FjZUXZepWD0GWT2LswMhWGPDrY6iItcUht2OhtmIjdSMLA3N8pxqVI
         Jp2ozhHPa4vOeklRuAX4zU13ndJldrhTeeCQg0vls8qIhNC4W5X8/y94LXJNZcBS/U
         vnO0viZBlBj8/Td4MeF4UtHKFBIWWcIWK6Zik19g=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <42950773-aac6-4ec6-8cbe-543489afe316@t-8ch.de>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-2-linux@weissschuh.net>
 <1fb146231e1810b4c9923f384afa166e07e7f253.camel@perches.com>
 <cf45b62e-6248-42f3-807f-5df0954437e0@t-8ch.de>
 <Y4dhs1G3mcX/YraJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4dhs1G3mcX/YraJ@alley>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-30 14:59+0100, Petr Mladek wrote:
> On Fri 2022-11-25 21:33:40, Thomas Weißschuh wrote:
>> On 2022-11-25 12:18-0800, Joe Perches wrote:
>>> On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
>>>> These macros emit continuation messages with explicit levels.
>>>> In case the continuation is logged separately from the original message
>>>> it will retain its level instead of falling back to KERN_DEFAULT.
>>>> 
>>>> This remedies the issue that logs filtered by level contain stray
>>>> continuation messages without context.
>>>> 
>>>> --- a/include/linux/printk.h
>>>> +++ b/include/linux/printk.h
>>>> @@ -701,6 +703,27 @@ do {									\
>>>>  	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>>  #endif
>>>>  
>>>> +/*
>>>> + * Print a continuation message with level. In case the continuation is split
>>>> + * from the main message it preserves the level.
>>>> + */
>>>> +
>>>> +#define pr_emerg_cont(fmt, ...)					\
>>>> +	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>>> 
>>> Aren't this rather backwards?
>>> KERN_CONT KERN_<LEVEL> seems to make more sense to me.
>> 
>> If nobody else disagrees I'll do this for v3.
> 
> I slightly prefer the way how it is now. IMHO, it makes it easier
> to check the related levels in /sys/kernel/debug/printk/index/vmlinux [*]:
> 
> <6> kernel/power/process.c:227 thaw_kernel_threads "Restarting kernel threads ... "
> <6,c> kernel/power/process.c:218 thaw_processes "done.\n"
> <6> kernel/power/process.c:197 thaw_processes "Restarting tasks ... "
> <6,c> kernel/power/process.c:176 freeze_kernel_threads "\n"
> <6,c> kernel/power/process.c:174 freeze_kernel_threads "done."
> <6> kernel/power/process.c:169 freeze_kernel_threads "Freezing remaining freezable tasks ... "
> <6,c> kernel/power/process.c:140 freeze_processes "\n"
> <6,c> kernel/power/process.c:138 freeze_processes "done."
> <6> kernel/power/process.c:133 freeze_processes "Freezing user space processes ... "
> <6,c> kernel/power/process.c:105 try_to_freeze_tasks "(elapsed %d.%03d seconds) "

I did not test it (will do so later) but it seems to me that the code in
kernel/printk/index.c should do this correctly in either case. At least it
tries to:

if (flags & LOG_CONT) {
	/*
	 * LOGLEVEL_DEFAULT here means "use the same level as the
	 * message we're continuing from", not the default message
	 * loglevel, so don't display it as such.
	 */
	if (level == LOGLEVEL_DEFAULT)
		seq_puts(s, "<c>");
		else
		seq_printf(s, "<%d,c>", level);
	} else
		seq_printf(s, "<%d>", level);
	}
}

I'll try to validate it.

If it doesn't work it may make more sense to fix the index file generation.
What do you think

> That said, I do not want to fight over it. It is hidden behind the
> API. The only really visible place is the printk index.
> 
> [*] The index is available only when CONFIG_PRINTK_INDEX is enabled.
> 
> Best Regards,
> Petr

Thomas
