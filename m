Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFA5613A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiJaPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJaPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:39:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9CBA0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:39:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667230740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIPJ91nyWm33HO4GBNncrIzLvJk3C6XXN8kbJVT6Als=;
        b=kB0l6adN1LX8PDBUlXlrjidw1Q1RbCi4wPf1JQSFrQeQPd0uIJkfAEL9D7c5tMgkAs/36z
        job5Ow7WH+O0TUZ+uxnEVsjIis3KVeJkA/Q1IcC/XR65cGnNtuNFIPWrrkjeftc+nI83xl
        NAYWFzitkeZENUTgQI1PHaicyvHrxssfcFG0KQ5R6j22TPESblmieeqKAb2jayMK+Xfeiz
        njghTgA2P54+0jnh4wHdJFBWzZCWwlBVwtzQl/KEKaoPzHVmCurLYZ5UBnf5IAcLypIFVY
        tHWLmTTflh+WgonNbOISTsa8ry07x1UBki/YLaq+RjcvNNc3SjXkAayeneScTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667230740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIPJ91nyWm33HO4GBNncrIzLvJk3C6XXN8kbJVT6Als=;
        b=oNuuyuAUxFHbKSQ87M/jZjiv41v/VqtmL43Qr6YyI875wpMWQ9O7ZoQ8DJPXKzw4UZ4N/F
        gIQQvd+IzyELeQCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/38] printk: use console_is_enabled()
In-Reply-To: <Y1JlerStRZ85D4Zo@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-6-john.ogness@linutronix.de>
 <Y1JlerStRZ85D4Zo@alley>
Date:   Mon, 31 Oct 2022 16:45:00 +0106
Message-ID: <87ilk09f57.fsf@jogness.linutronix.de>
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

On 2022-10-21, Petr Mladek <pmladek@suse.com> wrote:
>>  static inline bool console_is_usable(struct console *con)
>>  {
>> -	if (!(con->flags & CON_ENABLED))
>> +	if (!console_is_enabled(con))
>>  		return false;
>
> This allows to use console_is_usable() without synchronization against
> modification of the state. I guess that it will be needed for the
> printk kthreads. But it is not needed at the moment.

It will be needed once console_lock is no longer providing the
synchronization for console->flags (later in _this_ series).

I will add to the commit message that this is a preparatory change for
when console_lock no longer provides this synchronization.

>> @@ -2944,7 +2944,7 @@ void console_unblank(void)
>>  	console_locked = 1;
>>  	console_may_schedule = 0;
>>  	for_each_console(c)
>> -		if ((c->flags & CON_ENABLED) && c->unblank)
>> +		if (console_is_enabled(c) && c->unblank)
>>  			c->unblank();
>>  	console_unlock();
>
> The reading of the flag is actually synchronized against modifications
> here. I guess that we need this because c->unblank() probably is not safe
> against other operations with the console, e.g. c->write().

Again, we will need it later in this series when holding console_lock
does not provide the necessary synchronization.

>> @@ -3098,7 +3098,7 @@ static int try_enable_preferred_console(struct console *newcon,
>>  	 * without matching. Accept the pre-enabled consoles only when match()
>>  	 * and setup() had a chance to be called.
>>  	 */
>> -	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
>> +	if (console_is_enabled(newcon) && (c->user_specified == user_specified))
>
> This is not racy because newcon is not in console_list at this
> point. So that the state can't be modified by another callers.
>
> Anyway, it is not explicitly synchronized, so we need to use
> console_is_enabled with data_race() annotation.

For this case, it makes sense to _not_ use console_is_enabled(). This
code will be synchronized against writes even after console_lock has
been relieved of this responsibility.

Originally I wanted to replace _all_ checks with console_is_enabled(),
but since synchronization is rare, I'll keep the manual checks for those
(and add a comment that it is not a data race).

John
