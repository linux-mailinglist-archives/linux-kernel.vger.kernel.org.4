Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E662450F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKJPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKJPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:05:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750F657B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:05:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668092744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUv5oWr627GyhN9qZmZPgShdj6dU+Hjacn/+CGmdi7o=;
        b=XTW90QxKsDYXYe6doKgVnxi0GGGjYNbt1hVaabG+Ke2aRdW+gI/X1dLZE9AsuAfKOX/1MR
        8HoFSFjAPbY0NDWYcWTKhV/sMCyp/6XVQMmvDDzK1E30YD0l9OZ5qJALkrL0Add/lcPTyL
        j7xLpGsWh48hydwZ0hV5lGL5XK0SDxTHLpKwElbocaiNAjIk1t7kOLSVjW4441DF+az+O/
        Dwi4bSpzKXbRlKmX/NFfgmTqlStqbiVWQctFil4Vy1j1fm3zbOKPC0u3+olIRLx33HmAb3
        yttwhosiP3YhK0BTnnDSGHp0rynbPQECzjMUfvbQCtVDPk8fw2NcS+HulneQkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668092744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUv5oWr627GyhN9qZmZPgShdj6dU+Hjacn/+CGmdi7o=;
        b=aK6O7+C53BYg5UVtHbqgB+OFyLWpDKzgrrVMYSfj3QcIK7xAECi7SLv4IXBvFZjS6pPLRL
        CM8eOMyDBfqx/yCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 07/40] console: introduce console_is_enabled()
 wrapper
In-Reply-To: <Y2qBVZQDYnxv1af0@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-8-john.ogness@linutronix.de>
 <Y2qBVZQDYnxv1af0@alley>
Date:   Thu, 10 Nov 2022 16:11:43 +0106
Message-ID: <87a64y6e9k.fsf@jogness.linutronix.de>
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

On 2022-11-08, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3021,7 +3021,7 @@ void console_stop(struct console *console)
>>  {
>>  	__pr_flush(console, 1000, true);
>>  	console_lock();
>> -	console->flags &= ~CON_ENABLED;
>> +	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
>
> My first reaction is that using the atomic operation only for the
> store side is suspicious. It is correct because the read is serialized
> by console_lock(). But it is far from obvious why we need and can do
> it this way.

The READ_ONCE()/WRITE_ONCE() usage is really about documenting data-race
reads and the writes that they are racing with.

For WRITE_ONCE() the rule is:

- If console->flags is modified for a registered console, it is done
  under the console_list_lock and using WRITE_ONCE().

If we use a wrapper for this rule, then we can also add the lockdep
assertion that console_list_lock is held.


For READ_ONCE() the rule is:

- If console->flags is read for a registered console, then either
  console_list_lock must be held _or_ it must be read via READ_ONCE().

If we use wrappers here, then we can use lockdep assertion on
console_list_lock for the non-READ_ONCE wrapper, and scru_read_lock
assertion for the READ_ONCE wrapper.

> It would deserve a comment. But there are several other writes.
> Also it is not obvious why many other con->flags modifications
> do not need this.
>
> I think about hiding this into an API. We could also add some
> checks that it is used the right way. Also it might make sense
> to avoid using the READ_ONCE()/WRITE_ONCE by using
> set_bit()/test_bit().

I do not see any advantage of set_bit()/test_bit(). They have the
disadvantage that they only work with 1 bit at a time. And there are
multiple sites where more than 1 bit is set/tested. It is important that
the multi-bit tests are simultaneous.

READ_ONCE()/WRITE_ONCE() are perfectly fine for what we are doing. The
writes (for registered consoles) are synchronized by the
console_list_lock. There is no need to use atomic operations.

> I would prefer to use the proposed API because it should make all
> accesses more clear and safe. And most importantly, it would help use
> to catch bugs.
>
> But I do not resist on it. The patch looks correct and we could do
> this later. I could live with it if we add some comments above the
> WRITE_ONCE() calls.

I do not want to do a full API replacement for all console->flags access
in this series or at this time. I am concerned that it is taking us too
far away from our current goal. Also, with the upcoming atomic/threaded
model, all consoles need to be modified that want to use it anyway. So
that would be a more appropriate time to require the use of new API's.

For console_is_enabled() I will add the srcu_read_lock check. I suppose
I should also name the function console_srcu_is_enabled().

For the WRITE_ONCE() calls, I will add a static inline wrapper in
printk.c that includes the lockdep console_list_lock assertion. Perhaps
called console_srcu_write_flags(struct console *con, short flags).

In console_srcu_write_flags() and console_srcu_is_enabled() I can
document their relationship and when they are to be used. Both these
functions are used rarely and should be considered the exception, not
the rule.

For code that is reading registered console->flags under the
console_list_lock, I will leave the "normal access" as is. Just as I am
leaving the "normal access" for non-registered console-flags as is. We
can convert those to a new generic API later if we think it is really
necessary.

John
