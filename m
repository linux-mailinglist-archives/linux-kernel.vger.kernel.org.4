Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C986BE9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCQNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:06:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F79E20E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:06:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679058394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFYw3YNz3tVwRv0R10t1U3whCIaB4UN17G5l6oAjGFE=;
        b=J0R0BrpRqZDyvlz2xlkTbYF9F9jhG+s8Vt6HQOJz0x4y5liEeHFcCXdNADyQUrA8+VzyoB
        Q6BeFzVAET+Uo91duakrNVU3Jve/5s2TkFcfm1HNDNMwKSVYScQrhOxjU44uP438LXgj1q
        hz+ZZ/sGh5yEqnHteKn4wvtb9ijAFZ61onTyzg3tAgtHU2lDvFS7M2v8iCDAqQop7qQNDf
        SB3thPC0mMA8CpenrJ08SGnC1e7tBSVrIzbpisldzY3vQn63Hkg9P7l12xX/C6oH/Dhzxq
        bsKHNu9Ih5vmSM6wxTyRlvDUoKi6KvVMfZ70PS4iSxn91I0LazX+Ck0g6BkzmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679058394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFYw3YNz3tVwRv0R10t1U3whCIaB4UN17G5l6oAjGFE=;
        b=2ITIKvMWw+xxsEv/FXXAuTHKv5xvaTRSkKcbsW9hWzBY6zx1CZwHwEUDUpj66xqQHg3YJH
        Rlyo0ItNYfw0K6Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 03/18] printk: Consolidate console deferred
 printing
In-Reply-To: <ZAiKhAA37/jehmD7@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-4-john.ogness@linutronix.de>
 <ZAiKhAA37/jehmD7@alley>
Date:   Fri, 17 Mar 2023 14:11:01 +0106
Message-ID: <871qln7cle.fsf@jogness.linutronix.de>
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
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2321,7 +2321,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  		preempt_enable();
>>  	}
>>  
>> -	wake_up_klogd();
>> +	if (in_sched)
>> +		defer_console_output();
>> +	else
>> +		wake_up_klogd();
>
> Nit: I would add an empty line here. Or I would move this up into the
>      previous if (in_sched()) condition.

Empty line is ok. I do not want to move it up because the above
condition gets more complicated later. IMHO a simple if/else for
specifying what the irq_work should do is the most straight forward
here.

>> @@ -3811,11 +3814,30 @@ static void __wake_up_klogd(int val)
>>  	preempt_enable();
>>  }
>>  
>> +/**
>> + * wake_up_klogd - Wake kernel logging daemon
>> + *
>> + * Use this function when new records have been added to the ringbuffer
>> + * and the console printing for those records is handled elsewhere. In
>
> "elsewhere" is ambiguous. I would write:
>
> "and the console printing for those records maybe handled in this context".

The reason for using the word "elsewhere" is because in later patches it
is also the printing threads that can handle it. I can change it to
"this context" for this patch, but then after adding threads I will need
to adjust the comment again. How about:

"and the console printing for those records should not be handled by the
irq_work context because another context will handle it."

> Anyway, I like this change.

Thanks.

John
