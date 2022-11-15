Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CA62A038
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKORY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiKORPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:15:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB971EC66
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:15:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668532505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yybjy0PIYNskaP5faHqnthg9WIcdfrQS9ZzYuDsOR40=;
        b=RcR7/OCp+pX+2ZBjJuvEpAejLUopOa3GAS6CXfhXrOwNyPFY9qRko+iEaCHw7SyJmNEuIU
        cOOcaHx9j8LODvYIGJKpdwEKVLodgHsSBQ+/qpolBasgI8YHenioADiRSeSJyFneQ6dWQE
        I8EFErSedz93x4HJFI6XpzBFU8DiDU/P4acdmGcRkVvkmoLIVjO2VVY2uwQ2GyYB7Ov1DJ
        B7g+5ylUW8vWnznUuIQ4ZO0BGxa+kB0ivxyr7kxi9TZRu4IBVEigbX9xYVdZoCruMzsWoC
        x807E0O6ElX5baV/QomA30FgR4YNnkzZNWm6CxwlgYQAA43TfcO1br3wOMSLrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668532505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yybjy0PIYNskaP5faHqnthg9WIcdfrQS9ZzYuDsOR40=;
        b=grtvYJEi+TN+aVj2Y1xGMCHSC39yTXgDLSnZ49pqIKQnNBNS+PlrtEPQJBBA3XNVCEWxhs
        5PfC6JkUvArjAHBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
In-Reply-To: <Y3PBNJRvE6tU8ct+@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley> <Y3PBNJRvE6tU8ct+@alley>
Date:   Tue, 15 Nov 2022 18:21:34 +0106
Message-ID: <87r0y4m955.fsf@jogness.linutronix.de>
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

On 2022-11-15, Petr Mladek <pmladek@suse.com> wrote:
>>> --- a/kernel/printk/printk.c
>>> +++ b/kernel/printk/printk.c
>>> @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
>>>  		 * boot console that is the furthest behind.
>>>  		 */
>>>  		if (bootcon_registered && !keep_bootcon) {
>>> +			/*
>>> +			 * Hold the console_lock to guarantee safe access to
>>> +			 * console->seq.
>>> +			 */
>>> +			console_lock();
>>>  			for_each_console(con) {
>>>  				if ((con->flags & CON_BOOT) &&
>>>  				    (con->flags & CON_ENABLED) &&
>>> @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
>>>  					newcon->seq = con->seq;
>>>  				}
>>>  			}
>>> +			console_unlock();
>
> So, without the above two hunks:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Note that we actually need those hunks to guarantee a consistent @seq
value. The console_lock is the only synchronization mechanism available
to read console->seq.

John
