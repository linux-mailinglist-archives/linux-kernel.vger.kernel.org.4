Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD775BCC26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiISMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiISMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:49:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC770266B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:49:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2fk5UgooGqmYDFl5idROCKpAEIlHVlp9hl/WZSTLHI=;
        b=teD7/h7ErOV6ct5FPG9wslM1TEXZBhMAqGhoJXpu7Quzay3klIbRxR2IhjXceR1Y/fE4Wy
        O2U3jnSgiMwIR9kLdGuUQ9FQguASbLxO5a61hydTMaHqcPzmnKp3u7ULhMtHLYNjY0ehUM
        fuSrbF30Z+CMLYYOnHswrQSWR99N+K/HzBDqtSfp1elT2dU0Lwo2XYpZFU/pfWviEGGHkN
        N10c0jVTMTGVSlYUFove962aex78olT5jiGpu+abEMP2feOBtCU+TrzDJZ5brmYZNgQ5HH
        AXaT5BFEG+ePshAxdaVXLfinU9kzGAUKtvmwPJgP+1DhWxka1O3ByD96J7G31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2fk5UgooGqmYDFl5idROCKpAEIlHVlp9hl/WZSTLHI=;
        b=bAbspF65yuZdzkxSYZ8aKEx1jQgQUspXn+mi6iAwAA61OCqLyLBT7SbcbTx24eXGBYokr6
        0/U7pwQK3itFY2Cw==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 06/29] printk: Protect [un]register_console() with a
 mutex
In-Reply-To: <YyHJvdQbmd1wf0bZ@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.712668210@linutronix.de> <YyHJvdQbmd1wf0bZ@google.com>
Date:   Mon, 19 Sep 2022 14:55:50 +0206
Message-ID: <87pmfrlea9.fsf@jogness.linutronix.de>
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

On 2022-09-14, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (22/09/11 00:27), Thomas Gleixner wrote:
> [..]
>> + * console_sem protects the console_drivers list, and also provides
>> + * serialization for access to the entire console driver system.
>> + *
>> + * console_mutex serializes register/unregister. console_sem has to be
>> + * taken for any list manipulation inside the console_mutex locked
>> + * section to keep the console BKL machinery happy.
>>   */
>> +static DEFINE_MUTEX(console_mutex);
>>  static DEFINE_SEMAPHORE(console_sem);
> [..]
>>  /*
>>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>>   * macros instead of functions so that _RET_IP_ contains useful information.
>> @@ -2978,17 +3008,21 @@ struct tty_driver *console_device(int *i
>>  void console_stop(struct console *console)
>>  {
>>  	__pr_flush(console, 1000, true);
>> +	console_list_lock();
>>  	console_lock();
>>  	console->flags &= ~CON_ENABLED;
>>  	console_unlock();
>> +	console_list_unlock();
>>  }
>>  EXPORT_SYMBOL(console_stop);
>>  
>>  void console_start(struct console *console)
>>  {
>> +	console_list_lock();
>>  	console_lock();
>>  	console->flags |= CON_ENABLED;
>>  	console_unlock();
>> +	console_list_unlock();
>>  	__pr_flush(console, 1000, true);
>>  }
>>  EXPORT_SYMBOL(console_start);
>
> So the comment says that list lock (console_mutex) is to serialize
> register/unregister, but then we take it in stop/start as well. What
> does list lock protect us against in start/stop? console->flags reader
> (console_is_usable()) does not take list lock, it's called under console
> lock and console->flags writers (console_unregister() and console_stop())
> modify console->flags under console_lock.

Currently all writers to console->flags are holding the
console_lock. However, there are console->flags readers that do _not_
hold the console_lock (register_console, unregister_console,
printk_late_init).

Aside from adding list synchronization, the list lock also provides the
missing console->flags synchronization. Now all console->flags writers
hold the list lock _and_ console_lock. A console->flags reader can hold
either the list lock or the console_lock.

Since console_start and console_stop are console->flags writers, they
also need to take the list lock. I agree that this should be mentioned
in the commit message and code comments.

The follow-up patch in the series only deals with list/flags
readers. Therefore I think the change to console_stop/console_start
belongs in this patch, which focusses on fixing synchronization.

John
