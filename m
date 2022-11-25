Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E200F6390BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKYUd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKYUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:33:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC14046F;
        Fri, 25 Nov 2022 12:33:54 -0800 (PST)
Date:   Fri, 25 Nov 2022 21:33:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669408432;
        bh=vVPwweNm6Yg30BDNKJPQ9AahvzbXNoZx/FMS9AZieuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAuqxJ6uZVoigG97b8l8kakkNCrK4Z4guxeoB6DlGS8kkAYRGKDYvPtL9ApZ6Ga7L
         R1xE4CLpAkCVuXT7IMITCp+klXo8QYrz8WmwlLDVcrpMU7x/llRRXpcG2bjuFmY6Y5
         y/gfI9Pkyr606TgK53tLwUiuwXNRP3qk8E701IoI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <cf45b62e-6248-42f3-807f-5df0954437e0@t-8ch.de>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-2-linux@weissschuh.net>
 <1fb146231e1810b4c9923f384afa166e07e7f253.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fb146231e1810b4c9923f384afa166e07e7f253.camel@perches.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-25 12:18-0800, Joe Perches wrote:
> On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
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
> 
> Aren't this rather backwards?
> KERN_CONT KERN_<LEVEL> seems to make more sense to me.

If nobody else disagrees I'll do this for v3.

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
>> +
>>  extern const struct file_operations kmsg_fops;
>>  
>>  enum {
> 
