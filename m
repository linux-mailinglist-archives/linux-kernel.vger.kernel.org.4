Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E145EC510
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiI0Nzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiI0Nzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:55:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F1A2206
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:55:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664286932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOFpg0ko4vp35XfzMuBi1tARe9gnDDUDXIsKhZ2NLKA=;
        b=muMJ/6awH4ktt7A82uE40UBKdacZKEvBE9/xIuJa1yMSR3l/aYjQPxrO8723zQljePWFko
        ABlMK/5uHlzSAtU2uFCpdyTYoXoS3Ehy5MKOhhF7ZJc7qVBlE3vbGj0COjwnhSiEfPeXDk
        wtLl/ZbSAUwuC2SRlW02qLvcMxy9hhhHiuNC9ERY430KX2lxnV+FMjdPLdp+47Jylz5sHk
        2ykvst7AJd8OYJymDwDp/ly3PjwYwWPPMFa1J/sEIqRAShlLY5LiXzQPydV/67Q1ctZM5Y
        qQ3zQu2pN+VFbaUHHNNOPj06hT+QCcrz4Ib8DLMQn95loABNYDbzeXXfZa9b3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664286932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOFpg0ko4vp35XfzMuBi1tARe9gnDDUDXIsKhZ2NLKA=;
        b=6OwSic1U2jmLfqe87z0QHrt2juaK9Qu7Ui7m+77zGsi8V2IAo7u2vOnnOuwdqcy/DuYX6L
        9QmWWcwc9m7yrDBg==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [patch RFC 28/29] printk: Provide functions for atomic write
 enforcement
In-Reply-To: <20220910222301.995758602@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.995758602@linutronix.de>
Date:   Tue, 27 Sep 2022 16:01:32 +0206
Message-ID: <87r0zwly5n.fsf@jogness.linutronix.de>
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

Below is a fix that was used for the LPC2022 demo so that atomic
printing occurs in NMI context.

On 2022-09-11, Thomas Gleixner <tglx@linutronix.de> wrote:
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1072,6 +1072,8 @@ static inline void log_buf_add_cpu(void)
>  #endif /* CONFIG_SMP */
>  
>  static void cons_alloc_percpu_data(struct console *con);
> +static void cons_atomic_flush(void);
> +static void cons_wake_threads(void);
>  
>  static void __init set_percpu_data_ready(void)
>  {
> @@ -2270,17 +2272,21 @@ asmlinkage int vprintk_emit(int facility
>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> +	/*
> +	 * The caller may be holding system-critical or
> +	 * timing-sensitive locks. Disable preemption during
> +	 * printing of all remaining records to all consoles so that
> +	 * this context can return as soon as possible. Hopefully
> +	 * another printk() caller will take over the printing.
> +	 */
> +	preempt_disable();
> +
> +	/* Flush the non-BKL consoles if required */
> +	cons_atomic_flush();
> +
>  	/* If called from the scheduler, we can not call up(). */
>  	if (!in_sched) {
>  		/*
> -		 * The caller may be holding system-critical or
> -		 * timing-sensitive locks. Disable preemption during
> -		 * printing of all remaining records to all consoles so that
> -		 * this context can return as soon as possible. Hopefully
> -		 * another printk() caller will take over the printing.
> -		 */
> -		preempt_disable();
> -		/*
>  		 * Try to acquire and then immediately release the console
>  		 * semaphore. The release will print out buffers. With the
>  		 * spinning variant, this context tries to take over the
> @@ -2288,9 +2294,11 @@ asmlinkage int vprintk_emit(int facility
>  		 */
>  		if (console_trylock_spinning())
>  			console_unlock();
> -		preempt_enable();
>  	}
>  
> +	preempt_enable();
> +
> +	cons_wake_threads();
>  	wake_up_klogd();
>  	return printed_len;
>  }

Atomic flushing also needs to occur for the cases where deferred
printing is used (NMI or explicit defer). The following hunk will take
care of that.

@@ -3648,6 +3658,8 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	cons_atomic_flush();
+
 	/*
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.

John Ogness
