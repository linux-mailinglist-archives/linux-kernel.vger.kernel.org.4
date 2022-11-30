Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5763E574
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiK3X3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiK3X30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:29:26 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D9AD985;
        Wed, 30 Nov 2022 15:19:46 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:56:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669850360;
        bh=lMd/Ab2MOUBi5t1VUZde5XMv406zWEvfnprZnZ23DB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KK36kGVJJsHbA+RE+PK9eplFpMUZn84XFvP0AWuGpZMiaLLFM8PVqHOEclWBeXttd
         iSjdOeh2tvQc4VerOM0mv7ZqcHkjvryo4tUfbvGNuCKrzIrTmxa6zM6nCl7hTMDjrc
         0PICaw9/tMrR4pbEtxIUoeIfHLgG/+I3COMhpTLA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <6bc60e00-30b8-40ff-81f4-e7973c701ad4@t-8ch.de>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-2-linux@weissschuh.net>
 <Y4dndyIiosT7l4RG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4dndyIiosT7l4RG@alley>
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

On 2022-11-30 15:23+0100, Petr Mladek wrote:
> On Fri 2022-11-25 20:09:46, Thomas Weißschuh wrote:
>> These macros emit continuation messages with explicit levels.
>> In case the continuation is logged separately from the original message
>> it will retain its level instead of falling back to KERN_DEFAULT.
>> 
>> This remedies the issue that logs filtered by level contain stray
>> continuation messages without context.
>> 
>> Suggested-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  include/linux/printk.h | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>> 
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index 8c81806c2e99..8f564c38f121 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -537,6 +537,8 @@ struct pi_entry {
>>   * This macro expands to a printk with KERN_CONT loglevel. It should only be
>>   * used when continuing a log message with no newline ('\n') enclosed. Otherwise
>>   * it defaults back to KERN_DEFAULT loglevel.
>> + *
>> + * Use the dedicated pr_<level>_cont() macros instead.
>>   */
>>  #define pr_cont(fmt, ...) \
>>  	printk(KERN_CONT fmt, ##__VA_ARGS__)
>> @@ -701,6 +703,27 @@ do {									\
>>  	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>  #endif
>>  
>> +/*
>> + * Print a continuation message with level. In case the continuation is split
>> + * from the main message it preserves the level.
>> + */
>> +
>> +#define pr_emerg_cont(fmt, ...)					\
>> +	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_alert_cont(fmt, ...)					\
>> +	printk(KERN_ALERT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_crit_cont(fmt, ...)					\
>> +	printk(KERN_CRIT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_err_cont(fmt, ...)					\
>> +	printk(KERN_ERR KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_warn_cont(fmt, ...)					\
>> +	printk(KERN_WARN KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_notice_cont(fmt, ...)					\
>> +	printk(KERN_NOTICE KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_info_cont(fmt, ...)					\
>> +	printk(KERN_INFO KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
>> +/* no pr_debug_ratelimited, it doesn't make sense with CONFIG_DYNAMIC_DEBUG. */
> 
> I guess that you wanted to write "pr_debug_cont".

Indeed.

> Also I am not sure what you mean with "doesn't make sense". IMHO, it
> might  make sense. But it would be hard to use and error prone
> with CONFIG_DYNAMIC_DEBUG.
> 
> And more importantly, it probably would not work properly. If I get
> it corretly the dynamic debug messages are printed by the wrapper:
> 
> void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
> {
> [...]
> 	vaf.fmt = fmt;
> 	vaf.va = &args;
> 
> 	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
> [...]
> 
> This clearly does not support KERN_CONT in "fmt".

Good point.

My doubt was more that it would force users to know which message
continuations belong together and always enable all of them together with
dynamic debug.
Which would be very errorprone and annoying to use.

But if it doesn't work at all that's an even stronger point.

> I suggest to either remove the comment completely. Or write something
> like:
> 
> /* no pr_debug_cont(), can't be supported easily with CONFIG_DYNAMIC_DEBUG */

What about:

/* no pr_debug_cont(), it's errorprone to use
 * and can't be supported easily with CONFIG_DYNAMIC_DEBUG */

Thomas
