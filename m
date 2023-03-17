Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D56BEA08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCQNXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCQNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:23:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3EEBBB35
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:23:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679059417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hjxw4YXpa9CYAEMmuD3Rpy1EqI53zWBIa8N76+228Tw=;
        b=krfcHFxRhypmLhAd3Vwu3A13A3YHkFcCJuxk3RoT4PItx8BEzHO4R1J1fQvygB6ScF54Mn
        yyQT5tFD9MDvSUHtX6FKkDGC2eukHINZNQpMUGNIGepYlB5jGT83fETX60kCXQTIVTsDb0
        PNTf6S9R/FCxErnL+96Nguipu4E1hcrcVyu77006vDkFaJMVh/KroWF4fYG44ROFkncc1F
        Q7Ae2gpci6L2QPVHmGdnb2axI9ZShnxKjA3kHMHFJb0VlvXX1fTiAxQ8RPU++peI9zu4ex
        5Bn7z2PZrSipIL5q9FJZvLE4VD0C284rLppIP15BqKuG7dIGRS3F1kS9mpRJNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679059417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hjxw4YXpa9CYAEMmuD3Rpy1EqI53zWBIa8N76+228Tw=;
        b=oyIWQPOi5hj0hHOvwDagE5xaCvP0BRV2pa7lJaqsj0BgQZS4Cc5F5VQCRcGyJivEIKQYMX
        IJ883CjHUT24NMBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 04/18] printk: Add per-console suspended state
In-Reply-To: <ZAieQtcs7YEuCCDa@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-5-john.ogness@linutronix.de>
 <ZAieQtcs7YEuCCDa@alley>
Date:   Fri, 17 Mar 2023 14:28:04 +0106
Message-ID: <87y1nv5x8j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-08, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -153,6 +153,8 @@ static inline int con_debug_leave(void)
>>   *			receiving the printk spam for obvious reasons.
>>   * @CON_EXTENDED:	The console supports the extended output format of
>>   *			/dev/kmesg which requires a larger output buffer.
>> + * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
>> + *			printing callbacks must not be called.
>>   */
>>  enum cons_flags {
>>  	CON_PRINTBUFFER		= BIT(0),
>> @@ -162,6 +164,7 @@ enum cons_flags {
>>  	CON_ANYTIME		= BIT(4),
>>  	CON_BRL			= BIT(5),
>>  	CON_EXTENDED		= BIT(6),
>> +	CON_SUSPENDED		= BIT(7),
>
> We have to show it in /proc/consoles, see fs/proc/consoles.c.

Are we supposed to show all flags in /proc/consoles? Currently
CON_EXTENDED is not shown either.

>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2574,11 +2590,26 @@ void suspend_console(void)
>>  
>>  void resume_console(void)
>>  {
>> +	struct console *con;
>> +
>>  	if (!console_suspend_enabled)
>>  		return;
>>  	down_console_sem();
>>  	console_suspended = 0;
>>  	console_unlock();
>> +
>> +	console_list_lock();
>> +	for_each_console(con)
>> +		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
>> +	console_list_unlock();
>> +
>> +	/*
>> +	 * Ensure that all SRCU list walks have completed. All printing
>> +	 * contexts must be able to see they are no longer suspended so
>> +	 * that they are guaranteed to wake up and resume printing.
>> +	 */
>> +	synchronize_srcu(&console_srcu);
>> +
>
> The setting of the global "console_suspended" and per-console
> CON_SUSPENDED flag is not synchronized. As a result, they might
> become inconsistent:

They do not need to be synchronized and it doesn't matter if they become
inconsistent. With this patch they are no longer related. One is for
tracking the state of the console (CON_SUSPENDED), the other is for
tracking the suspend trick for the console_lock.

> I think that we could just remove the global "console_suspended" flag.
>
> IMHO, it used to be needed to avoid moving the global "console_seq" forward
> when the consoles were suspended. But it is not needed now with the
> per-console con->seq. console_flush_all() skips consoles when
> console_is_usable() fails and it bails out when there is no progress.

The @console_suspended flag is used to allow console_lock/console_unlock
to be called without triggering printing. This is probably so that vt
code can make use of the console_lock for its own internal locking, even
when in a state where ->write() should not be called. I would expect we
still need it, even if the consoles do not.

The only valid criteria for allowing to call ->write() is CON_SUSPENDED.

>> @@ -3712,14 +3745,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>>  		}
>>  		console_srcu_read_unlock(cookie);
>>  
>> -		/*
>> -		 * If consoles are suspended, it cannot be expected that they
>> -		 * make forward progress, so timeout immediately. @diff is
>> -		 * still used to return a valid flush status.
>> -		 */
>> -		if (console_suspended)
>> -			remaining = 0;
>
> I wonder if it would make sense to add a comment somewhere,
> e.g. above the later check:
>
> +		/* diff is zero also when there is no usable console. */
> 		if (diff == 0 || remaining == 0)
> 			break;

I think that is obvious, but I can add a similar comment to remind the
reader that only usable consoles are counted.

> Anyway, we should update the comment above pr_flush():
>
> -  * Return: true if all enabled printers are caught up.
> +  * Return: true if all usable printers are caught up.

Nice catch.

John
