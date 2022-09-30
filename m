Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C55F0C75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiI3NbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3NbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:31:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2298B105030
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:31:00 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664544659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUhzV2Svkhwq52cmzDJhgFyCAH4JV5SY42HOZF74N5k=;
        b=utZw0st1lAib4F3fd0fK5TrmAQGy0gmnGHow4SvvuLKoUEjBTnwcb7OklUs0AOUaUs6Vb1
        Kz+UxKkw079GA8Eo3cn04AxnEF9tjUE2LYpqwUK7LzaAwDxEd9etMQafUNE+RqmyKk+MMd
        KewG0kXxuZjzDx+H5ZPHoAdA/JCd5Fb0xwnR7Fn41uCHUlC/2JKAXnmD4f0z5KV48tc9XO
        YzqJrGcLSp9TAXvJ15wGjqA/rdjtUOiQumhkpyOTRZtqil84WhXmo8rVvd5NgGevGT8rM2
        nDKuRCyaV6B4JKRhOQLNi6XQLQLlrZFfCsrgfYUvJDwgJFAa9kFid0Wdh6ALNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664544659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUhzV2Svkhwq52cmzDJhgFyCAH4JV5SY42HOZF74N5k=;
        b=CskbAgL+Q2KfkauDxefiUbfguCfHLdawen6wgyQBmBRk9qeyIUctH54LINK9lqlI/hJjcR
        TqWwVCwjcTOhvnDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console()
 with a mutex
In-Reply-To: <YzW9ExRVjv6PzvWR@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley> <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
Date:   Fri, 30 Sep 2022 15:36:58 +0206
Message-ID: <87r0ztugz1.fsf@jogness.linutronix.de>
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

On 2022-09-29, Petr Mladek <pmladek@suse.com> wrote:
> It is the legacy mode that tries to print to the consoles immediately.
> I am not sure if we could _ever_ remove this mode.

We are not trying to remove this mode. We are trying to introduce a new
mode. Once all the console drivers have moved over to the new mode, the
old mode can disappear. If some console drivers never move over, the old
mode can hang around.

It is important to understand that we are not trying to change the old
mode. This was our big mistake leading to the 5.19-revert.

> And it is most likely the main reason why semaphore is used instead
> of a mutex:
>
>     + printk() can be called in atomic context
>
>     + also there is the console_trylock_spinning() trick that allows
>       to transfer the semaphore to another owner without locking.
>
> Do you see any RT-friendly solution for the legacy mode, please?

No. Legacy mode will never work for RT because the console drivers are
using spinlocks, which for RT requires that preemption is enabled.

> Anyway, some lock will still be needed to synchronize the list.
> But could it be mutex? What about the legacy mode of printk_emit()?

For list updates a mutex is fine. All list updates already require
may_sleep contexts. For just iterating the list, SRCU is fine.

But we really need an atomic variable (or separate data-race bools) for
the properties that are not immutable. AFAIK this is only CON_ENABLED
and CON_CONSDEV (and I seriously question the usefulness/correctness of
CON_CONSDEV). If console_is_enabled() could be safely called without a
lock, neither console_lock nor console_list_lock would be needed to
safely iterate and act on the console list.

The NOBKL consoles (not included in this series) use a separate atomic
state variable to handle this. Perhaps the legacy consoles could
(mis)use that variable so that CON_ENABLED is atomic for them as well.

>> Yes! One of the main points of this final phase of the rework is to
>> remove console_sem usage (for NOBKL consoles). If a system is running
>> with only NOBKL consoles registered, ideally that system should never
>> call console_lock()/console_trylock(). Once all drivers have
>> converted over to the NOBKL interface, console_sem will serve no
>> purpose for the printk and console frameworks, so it can be removed.
>
> And even if we convert all console drivers then people still might
> want the legacy mode.

For converted drivers there is no use for the pseudo-synchronous legacy
mode. Converted drivers can run in true synchronous mode if the user
wants.

> My understanding is that some atomic consoles would be real hacks.

Well, it is up to the maintainers to make sure they are not real
hacks. We are not mandating that all drivers are converted. But I think
when devs start seeing the benefits of the converted drivers (and will
have many working examples to be inspired by) there will be honest
efforts to correctly convert the driver.

> They might be good enough for panic(). But what about running system.
> It seems that people might want the legacy more even on running
> system. Will it be doable with mutex?

I'm not sure what you mean here, but I think you are referencing
situations that are not valid. Either drivers are legacy (and continue
using the BKL) or they are correctly converted to the new atomic/thread
model (and have nothing to do with the BKL).

There will be some exceptions (such as fbdev), which is why we are also
considering special alternatives for this class of drivers (such as BSoD
splash on panic, rather than an atomic console).

> I would really like to avoid state where we have two locks (semaphore
> and mutex) serializing the same thing (console list).

I understand. I will look into this more closely. But it may just mean
adding comments above each console_lock() to say:

1. that it is being using to stop all console printing

2. why all console printing needs to stop

Notice that the above list does not include "provide synchronization for
the console list".

John
