Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B880C6F8C95
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEEW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjEEW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:59:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B1618B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:59:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683327536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sxb0Huk9DeXydwe6cpIDkL7SV2wlpTgDqHSYs1vaAs=;
        b=wXfT696KaUYaGEuot+1Gy+WTVD+vu5j5EFC2LDzX+0ILhP/GjZeAhRSNqHPhj7V735MCNF
        TNSaKjBop7cinpFB+Lq8P90+v37I/HD8LBqz0U0ehJouMf2x2FLx5L/mmZd1oW3Ub1okkr
        J1yeIfb+uZautH79EEFukMh6jn1nSo6hXX7utU+HM0T+/+hIGp1es/KnnTYbmYCdhpTuwu
        s6+OtQdXemng/eqJw7gIHF7JqM3pBZhtc5bOUFzejmc4FjnOP9oAG8kJOi3nukiceoHL9A
        FK4y/JSajK37lhsSQFxYJDtIwQuElg3V4kIKEJ4ZdpnTE04aarNabweHtfuetw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683327536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sxb0Huk9DeXydwe6cpIDkL7SV2wlpTgDqHSYs1vaAs=;
        b=47+4+aKd4VWzrC4aVBxdK1WldAEyyCODSxsUrh5aqMLO9HvHrV2tgM9Vy+XeoGmBGbCi7a
        4XQvR+P3vBB4MADg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <ZFUXrCZtWyNG3Esi@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
Date:   Sat, 06 May 2023 00:58:56 +0200
Message-ID: <87zg6i2xn3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05 2023 at 16:50, Frederic Weisbecker wrote:
> On Tue, Apr 25, 2023 at 08:48:58PM +0200, Thomas Gleixner wrote:
>>  
>> -	do {
>> +	/* Can be written by a different task concurrently in the loop below */
>> +	start = READ_ONCE(sig->next_posix_timer_id);
>> +
>> +	for (id = ~start; start != id; id++) {
>>  		spin_lock(&hash_lock);
>> -		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
>> -		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
>> +		id = sig->next_posix_timer_id;
>> +
>> +		/* Write the next ID back. Clamp it to the positive space */
>> +		WRITE_ONCE(sig->next_posix_timer_id, (id + 1) & INT_MAX);
>
> Isn't that looping forever?

No. The loop breaks when @id reaches the locklessly read out @start
value again.

I admit that the 'id = ~start' part in the for() expression is confusing
without a comment. That initial @id value is in the invalid space to
make sure that the termination condition 'start != id' does not trigger
right away. But that value gets immediately overwritten after acquiring
hash_lock by the real sig->next_posix_timer_id value.

The clamp to the positive space has nothing to do with that. That's
required because the ID must be positive as a negative value would be an
error when returned, right?

So the whole thing works like this:

   start = READ_LOCKLESS(sig->next_id);

   // Enfore that id and start are different to not terminate right away
   id = ~start;

loop:
   if (id == start)
   	goto fail;
   lock()
        id = sig->next_id;                      <-- stable readout
        sig->next_id = (id + 1) & INT_MAX;      <-- prevent going negative

        if (unused_id(id)) {
           add_timer_to_hash(timer, id);
           unlock();
           return id;
        }
   id++;
   unlock();
   goto loop;

As the initial lockless readout is guaranteed to be in the positive
space, how is that supposed to be looping forever?

Admittedly this can be written less obscure, but not tonight :)

Thanks,

        tglx


