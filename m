Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317EF6C52F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCVRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCVRqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:46:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97195FD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:46:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679507190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97eqeia7EUPqw1nOEWGR/88IL7l8R8MGkhvjBLeoSyI=;
        b=lYGXadwTrIRAZ+s21sjkC1j1AyICI1gnwSLdcPU6uNFVqXK1MQ0LPn2Zccy7BkGmLPoL09
        GOecUe8YJ+3yqodYKnAtWiRh6oywTkhmPk0b3bpI+04KeMgXwwwyVC7k0meCYQs76TE0Mj
        RqUQ8BZzewANIuaM1ZGKCZHdDvNVHXv2/4pz5fJJdF41IoC2wFIda3XVk56IGJUjnX/prg
        TFSzczsz9pKpna9To8g2VPJl8BBjYNx8ZflxXeEs6G3Hurgc2vSzqO9QgWTCDffgfg1EhK
        mekLlZpNN0N5QkdC3abokOVdzIY0c7p4R6tUa9xtWUOIvxjeAu1evgFA33m2qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679507190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97eqeia7EUPqw1nOEWGR/88IL7l8R8MGkhvjBLeoSyI=;
        b=CuRrSNCFoJ93GD0Y/MBG7j/nsVa0Z8FCLmZJsswGf+RhuN7IaXyQc/JiNY5nVOnAgr5VWA
        HVzjbS9QR3bnQuCg==
To:     Schspa Shi <schspa@gmail.com>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
In-Reply-To: <m2ttycd8kx.fsf@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com>
Date:   Wed, 22 Mar 2023 18:46:29 +0100
Message-ID: <87sfdw8yru.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22 2023 at 23:40, Schspa Shi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>>> +	} else {
>>> +		/*
>>> +		 * The debug object is inited, and we should check this again
>>> +		 */
>>> +		if (obj->is_static) {
>>> +			raw_spin_unlock_irqrestore(&db->lock, flags);
>>> +			return;
>>
>> This is broken. If the object is static and already hashed and in active
>> state then this returns and fails to detect the re-initialization of an
>> active object.
>>
>
> Yes, it's right, this can be fixed by pass a skip_ifstatic parameters
> from debug_object_activate. then re-initialization of an active object
> can be detected.

>>> -static __initdata struct self_test obj = { .static_init = 0 };
>>> +static struct self_test obj __initdata = { .static_init = 0 };
>>> +static struct self_test sobj __initdata = { .static_init = 1 };
>>
>> ...
>>
>>> -	obj.static_init = 1;
>>
>> Plus the s/obj/sobj/ which should be equivalent, unless I'm missing
>> something here.
>>
>
> We have saved the is_static state when it is used at the first time, so
> the is_static_object function won't be called in this environment.

There is zero requirement for saving that state.

>>  lib/debugobjects.c |  127 +++++++++++++++++++++++++++--------------------------
>>  1 file changed, 67 insertions(+), 60 deletions(-)
>>
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(
>>  	return obj;
>>  }
>>  
>> -/*
>> - * Allocate a new object. If the pool is empty, switch off the debugger.
>> - * Must be called with interrupts disabled.
>> - */
>>  static struct debug_obj *
>>  alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>>  {
>> @@ -273,7 +269,7 @@ alloc_object(void *addr, struct debug_bu
>>  	if (obj) {
>>  		obj->object = addr;
>>  		obj->descr  = descr;
>> -		obj->state  = ODEBUG_STATE_NONE;
>> +		obj->state  = ODEBUG_STATE_INIT;
>
> This actually droped the ODEBUG_STATE_NONE state. If we active a
> uninitialized object, there will be no error report.

Indeed.

> This should be
>
> if (descr->is_static_object && descr->is_static_object(addr))
> 	obj->state  = ODEBUG_STATE_INIT;
> else
> 	obj->state  = ODEBUG_STATE_NONE;

Kinda.

> But this can't resolve the initial state requirement from the
> is_static_object() call.

Which requirement? The is_static_object() call takes the address of the
actual object and has nothing to do with the tracking object at all.

> I think we can report an error when calling debug_object_free() from a
> static object. If don't do so, there is no way to determine it's a
> static object.

The memory allocator will tell you loudly when you try to free a static
object. So no point in having another check.

> When its initialization state changes, the is_static_object() call
> will return the wrong value.

That call is only relevant on the first invocation when there is no
tracking object yet. So what's the problem you are trying to solve?

> Please see the fellowing test case:
>
> 	obj.static_init = 1;

This is pointless, really. Once the object is tracked it does not matter
at all whether it was statically or dynamically allocated.

>
> I test this patch, with my above change, and it seems to work well, but
> we still need to add extra flags to store its static state. And
> debug_object_free() should report an error for the static object.

No, we don't.

> I think we should introduce lookup_object_or_alloc and is_static at the
> same time.

What for?

Thanks,

        tglx
