Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4C6E906E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjDTKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjDTKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:38:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F14C08
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:35:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681986931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1WwqJbjdqbVTI8TYWB0whF/15cU3RjutF8ccNUpsmg=;
        b=pSxQZAqnSvsSgu+wbVW0ZoGHxgE0aUCza+aRw+bvqvk9oHwn4mqoDwGVj1LZAB7dpzMTHz
        bB52ANyQ8VvRmUvaQs36/tUg7lKToAX3qbxvxICNiSB77tZIJEqMg1lGHSXspTqhZdW5nN
        90pApwix/qUupUwDxa3WYbqNwhFwjqZFfdceUjqC5Pi7ZskWtP9cdBEkCp4dhDdcTxN0/r
        P88DcdYRxyBqd9yri977YNFONa/4iOMk47cyawXGdU+ht3N8EWF0Kw2nVrvT4DHZrYPSHq
        /3nlJDP+9F8xGTvBO8y67EzMgvcuqEAbVLZ06uNZycPcrD4PyjR5JwPClulahg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681986931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1WwqJbjdqbVTI8TYWB0whF/15cU3RjutF8ccNUpsmg=;
        b=r/Xalzos+G1Ip59iGysXHnsyWVtkesjJFsFVC7yUbtZAl9aOwRLm3QvrY58tq3pcB6i324
        IX3JqTqmbSusjbAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: port lock: was: Re: [PATCH printk v1 11/18] printk: nobkl:
 Introduce printer threads
In-Reply-To: <ZEEMJxobFe_UZ8gV@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
 <ZC6U/CZCNmgnTpI4@alley> <ZEEMJxobFe_UZ8gV@alley>
Date:   Thu, 20 Apr 2023 12:39:31 +0206
Message-ID: <87zg72vo5g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20, Petr Mladek <pmladek@suse.com> wrote:
>> OK, let's first define what the two locks are supposed to synchronize.
>> My understanding is that this patchset uses them the following way:
>> 
>>     + The new lock (atomic_state) is used to serialize emiting
>>       messages between different write contexts. It replaces
>>       the functionality of console_lock.

It replaces the functionality of console_lock, but operates at a finer
level. It is serializing all access to the hardware registers involved
in outputting. For the 8250 driver, this is the IER register.

>>       It is a per-console sleeping lock, allows voluntary and has
>>       hand-over using priorities and spinning with a timeout.

It is not a sleeping lock. It is used as a trylock or spinning with
timeout. It has the special feature that it can be handed over to or
stolen by another context with a higher ownership priority.

>>     + The port_lock is used to synchronize various operations
>>       of the console driver/device, like probe, init, exit,
>>       configuration update.
>> 
>>       It is typically a per-console driver/device spin lock.
>> 
>> 
>> I guess that we would want to keep both locks:

I agree because the port_lock has a much larger scope and is fully
preemptible under PREEMPT_RT.

> I forgot to check how these two locks are supposed to be used
> in write_atomic().
>
> It seems that cons_atomic_flush_con() takes only the new lock
> (atomic_state) and ignores the port_lock(). It should be safe
> against write_kthread(). But it is not safe against other
> operations with the console device that are synchronized
> only by the port_lock().

Yes, it is because the console drivers will also take the atomic_state
lock when needed. You can see this in the POC patch I posted [0].

For example, a new function serial8250_enter_unsafe() is used by the
serial drivers to mark the beginning of an unsafe section. To use this
function, the port_lock must be held. This function additionally takes
the atomic_state lock. Then the driver is allowed to touch hardware
registers related to outputting (IER).

But typically the driver will use a new higher level function, for
example serial8250_in_IER(), which will enter unsafe, read the register,
and exit unsafe. This provides the necessary synchronization against
write_atomic() (for the 8250 driver).

Please also remember that hostile takeovers of drivers in unsafe
sections are done as a last resort in panic, after all other nbcon
consoles have safely flushed their buffers. So we should not spend too
many brain cycles on "what if the atomic_state lock is stolen while in
an unsafe section" questions. The answer is: then you are in "hope and
pray" mode.

John

[0] https://lore.kernel.org/lkml/877cv1geo4.fsf@jogness.linutronix.de
