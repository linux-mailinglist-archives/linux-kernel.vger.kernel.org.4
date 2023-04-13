Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C836E0D53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDMMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDMMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:15:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F072A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:15:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681388106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8+nVKITZkaZhX5qchviUfDT0l6q7J7IjVYSeriSWWc=;
        b=MyKYLr2XbSRKxtTEtLuQUkdmgKnD5AMrgY7jJTpbo9QzkQ1909ga/hQSzXP7bxY1gMNcl/
        O9zwRy2ltwTn6uuImxUrdrtrQW2BXD4LZ2b3UykAP7j6E26A5YYi/WRrWKgF5TwKFBfefZ
        vlmTfPurVJWuJh7nXcrCL6HOJ6wsc0rDRPYZ/wKe58Y0deQTDtKOO6972BlELV/Cgs7Oxu
        H1cgIkLhH5e9WzcYgoDu7eul7lthsw+G59ptr4KSyaSI1Bhu8VS220zLi3Ij/uHVofw3eJ
        Hi9vrOASZTZNS4NecD4NTnb77vZqcvJ9UsEf9PBV+Du200rbzQsEiRlg+be9GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681388106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8+nVKITZkaZhX5qchviUfDT0l6q7J7IjVYSeriSWWc=;
        b=1PrtC0cyfYTClBUFVLuQoUrdmL2kQfcddFGeh3Zf8vjzYqbPRseemYhEPoSJRr33tHzTRr
        m5vBhvtB8iUMhuBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH printk v1 16/18] kernel/panic: Add atomic write
 enforcement to warn/panic
In-Reply-To: <ZDfUiB55jE25kmv5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-17-john.ogness@linutronix.de>
 <ZDfUiB55jE25kmv5@alley>
Date:   Thu, 13 Apr 2023 14:19:13 +0206
Message-ID: <87h6tk3rqe.fsf@jogness.linutronix.de>
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

On 2023-04-13, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -329,6 +332,8 @@ void panic(const char *fmt, ...)
>>  	if (_crash_kexec_post_notifiers)
>>  		__crash_kexec(NULL);
>>  
>> +	cons_atomic_flush(NULL, true);
>
> Do we need to explicitly flush the messages here?

This is where the atomic printing actually starts (after the full dump
has been inserted into the ringbuffer).

> cons_atomic_flush() is called also from vprintk_emit(). And there are
> many messages printed with the PANIC priority above.

vprintk_emit() does not print in this case. From cons_atomic_flush():

        /*
         * When in an elevated priority, the printk() calls are not
         * individually flushed. This is to allow the full output to
         * be dumped to the ringbuffer before starting with printing
         * the backlog.
         */
        if (cpu_state->prio > NBCON_PRIO_NORMAL && printk_caller_wctxt)
                return;

> This makes an assumption that either printk() in PANIC context
> does not try to show the messages immediately or that this
> explicit console_atomic_flush() tries harder. I think
> that both assumptions are wrong.

Both assumptions are correct, because until this point there has been no
effort to print.

>> @@ -353,6 +358,7 @@ void panic(const char *fmt, ...)
>>  		 * We can't use the "normal" timers since we just panicked.
>>  		 */
>>  		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
>> +		cons_atomic_flush(NULL, true);
>
> Same here.

This flush is just to make sure the rebooting message is
output. For nbcon consoles printk() calls are never synchronous except
for during early boot (before kthreads are ready).

The same goes for the other cons_atomic_flush() calls in this function.

>>  	disabled_wait();
>>  #endif
>>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
>>  
>>  	/* Do not scroll important messages printed above */
>>  	suppress_printk = 1;
>> +
>> +	cons_atomic_exit(CONS_PRIO_PANIC, prev_prio);
>
> On the contrary, I would explicitly call cons_atomic_flush(NULL, false)
> here instead of hiding it in cons_atomic_exit().

It is not hiding there. That is the semantic. After entering an atomic
block all printk's are only writing to the ringbuffer. On exiting the
atomic block the ringbuffer is flushed via atomic printing.

Exiting CONS_PRIO_PANIC has a special condition that it first tries to
safely flush all consoles, then will try the unsafe variant for consoles
that were not flushed.

> Also I think that we want to set the EMERGENCY prio also in
> oops_enter()?

Agreed.

John
