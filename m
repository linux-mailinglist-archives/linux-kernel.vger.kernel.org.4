Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B500C613761
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiJaNGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJaNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:06:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16B264F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:06:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667221597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtFebNpUqbj6L0uvPA+EmJHxYKyZugqghpwUDGxGgkk=;
        b=kbOC4Jc5l6Ft/03sDcrZOxGvXrxlMDytpMTS+2XFB6T+RQxH1PcpSYiZQXZaDC29W8yJh2
        ScjtBdAnfZj5GtYE/zeewLI/nP+/J4JbsskFLfD+2v4maBSzU7n67KEv5DYmKhX3depP0K
        CsE/WwpbSUlpJB1nbSEXneVCMsIDd50sJ+DtHk8bUkcmAjCsq19/PIZTKg/C3BLTLdoXgj
        leHZMkwCGfpjtar8fYe0Q/IDxIpxPy8ZdQcHzKKDYZPLcuyD9HRisKRQNOkCRrW/OFAXvq
        k8MiXmO+LasBIjjmIHnfxdZJ0kGoKnGRLXFgi+sVaM8hNbfYoC4QMCjHDwafXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667221597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtFebNpUqbj6L0uvPA+EmJHxYKyZugqghpwUDGxGgkk=;
        b=bLWByKGq8XCmVDOGCxPp57b1XgbMBL2A64+mbGe1WkV4yRyBO9ft78C59/H+GsFHlONKHU
        53ei1R1nI4gzW7Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 03/38] printk: Prepare for SRCU console list
 protection
In-Reply-To: <Y1JZqyIF5rf4sal2@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-4-john.ogness@linutronix.de>
 <Y1JZqyIF5rf4sal2@alley>
Date:   Mon, 31 Oct 2022 14:12:36 +0106
Message-ID: <87leow9m77.fsf@jogness.linutronix.de>
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
>> +#ifdef CONFIG_LOCKDEP
>> +bool console_srcu_read_lock_is_held(void)

>> +#ifdef CONFIG_LOCKDEP
>> +extern bool console_srcu_read_lock_is_held(void);
>> +#else
>> +static inline bool console_srcu_read_lock_is_held(void)
>> +{
>> +	return 1;
>> +}
>> +#endif
>
> srcu_read_lock_held() actually depends on CONFIG_DEBUG_LOCK_ALLOC.

I really want to keep @console_srcu private. For v3 I am changing it to
depend on ifdef CONFIG_DEBUG_LOCK_ALLOC.

>> @@ -2989,6 +3021,9 @@ void console_stop(struct console *console)
>>  	console_lock();
>>  	console->flags &= ~CON_ENABLED;
>>  	console_unlock();
>> +
>> +	/* Ensure that all SRCU list walks have completed */
>> +	synchronize_srcu(&console_srcu);
>
> What is the motivation for this synchronization, please?

For v3 I change it to:

    /*
     * Ensure that all SRCU list walks have completed. All contexts must
     * be able to see that this console is disabled so that (for example)
     * the caller can suspend the port without risk of another context
     * using the port.
     */

>> @@ -3179,6 +3214,17 @@ void register_console(struct console *newcon)
>>  		newcon->flags &= ~CON_PRINTBUFFER;
>>  	}
>>  
>> +	newcon->dropped = 0;
>> +	if (newcon->flags & CON_PRINTBUFFER) {
>> +		/* Get a consistent copy of @syslog_seq. */
>> +		mutex_lock(&syslog_lock);
>> +		newcon->seq = syslog_seq;
>> +		mutex_unlock(&syslog_lock);
>> +	} else {
>> +		/* Begin with next message. */
>> +		newcon->seq = prb_next_seq(prb);
>
> Hmm, prb_next_seq() is the next-to-be written message. It does not
> guarantee that all the existing messages already reached the boot
> console.
>
> Ideally, we should set it to con->seq from the related boot
> consoles. But we do not know which one it is.

Yes. It is really sad that we do not know this. We need to fix this boot
console handover at some point in the future.

> A good enough solution would be to set it to the minimal con->seq
> of all registered boot consoles. They would most likely be on
> the same sequence number. Anyway, con->seq has to be read under
> console_lock() at least at this stage of the patchset.

Well, for v3 I would do the following:

- explicitly have boot consoles also behave like CON_PRINTBUFFER

- use the oldest boot+enabled message

The code would include the additional changes:

-	if (newcon->flags & CON_PRINTBUFFER) {
+	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
 		newcon->seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
-		/* Begin with next message. */
+		/* Begin with next message added to the ringbuffer. */
 		newcon->seq = prb_next_seq(prb);
+
+		/*
+		 * If an enabled boot console is not caught up, start with
+		 * that message instead. That boot console will be
+		 * unregistered shortly and may be the same device.
+		 */
+		for_each_console(con) {
+			if ((con->flags & (CON_BOOT | CON_ENABLED)) == (CON_BOOT | CON_ENABLED) &&
+			    con->seq < newcon->seq) {
+				newcon->seq = con->seq;
+			}
+		}
 	}
>> +		hlist_add_behind_rcu(&newcon->node, console_list.first);
>>  	}
>>  	console_unlock();
>> +
>> +	/* No need to synchronize SRCU here! */
>
> This would deserve explanation why it is not needed. At least some
> hint.

For v3 I change it to:

    /*
     * No need to synchronize SRCU here! The caller does not rely
     * on all contexts being able to see the new console before
     * register_console() completes.
     */

>> @@ -3269,6 +3307,10 @@ int unregister_console(struct console *console)
>>  		console_first()->flags |= CON_CONSDEV;
>>  
>>  	console_unlock();
>> +
>> +	/* Ensure that all SRCU list walks have completed */
>> +	synchronize_srcu(&console_srcu);
>
> Again, we should explain why.

For v3 I change it to:

    /*
     * Ensure that all SRCU list walks have completed. All contexts
     * must not be able to see this console in the list so that any
     * exit/cleanup routines can be performed safely.
     */

John
