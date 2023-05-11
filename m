Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D756FF1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbjEKMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEKMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:47:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397B95BA5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:47:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683809228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wTzQu0YX5Gtk6CXkcoP5eA8yZZ7HmVRR0JdGtJ+b7Q=;
        b=qccYScfLX/ZIg8Z0fMoeAQqcS5GFQTGJRfUywt/XLbRRJk6jft/qCZf8Wz962AdZJQ56fI
        GXDy9omQd4196C6ii5XT71ge5q9k3fb4OMiGPXdxo71bzxPRQgiV0/Z356KabMpyQy6NuZ
        1pnQK/nuV2hIEv5se+0eKBzxz/yoMog0MjIrZUeHwnFHL85phfqf4IlScyUoiG1MbLdsrG
        sEDMnMHpIE1u7huWu7RYUYkIeDG+Ql9jKEwjggauLXVAx5JBO6JtWtyS8FjP03zt1a+1bJ
        FI8mBmJVf3AQLx9PMBLCNSFL327W+VPYzn58+bHi93WGSWs7t+ovqTqGyFDKoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683809228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wTzQu0YX5Gtk6CXkcoP5eA8yZZ7HmVRR0JdGtJ+b7Q=;
        b=9Sz+YsKXl9nQdMQci1sF7zmRpECbyas0zVZWWjcRK9bKQTeCNmLwcY1ByY0cVGMkifPlA6
        cw5gZkmqpMLueLAA==
To:     Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] threads: Update PID limit comment according to futex
 UAPI change
In-Reply-To: <8736apede7.fsf@nanos.tec.linutronix.de>
References: <20200302112939.8068-1-jannh@google.com>
 <20200303102540.GC2579@hirez.programming.kicks-ass.net>
 <8736apede7.fsf@nanos.tec.linutronix.de>
Date:   Thu, 11 May 2023 14:47:08 +0200
Message-ID: <87mt2bc9wz.ffs@tglx>
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


Reviving this old thread.

On Tue, Mar 03 2020 at 15:12, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Mon, Mar 02, 2020 at 12:29:39PM +0100, Jann Horn wrote:
>>>  /*
>>>   * A maximum of 4 million PIDs should be enough for a while.
>>> - * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
>>> + * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
>>>   */
>>>  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>>>  	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
>>
>> I just noticed another mention of this in Documentation/robust-futex-ABI.txt
>> There it states that bit-29 is reserved for future use.
>>
>> Thomas, do we want to release that bit and update all this?
>
> In fact we've released it long ago:
>
> include/uapi/linux/futex.h:
>
> #define FUTEX_TID_MASK          0x3fffffff

That futex mask is irrelevant because there is another limitiation for
the PID space namely posix CPU timers:

static inline clockid_t make_process_cpuclock(const unsigned int pid,
		                              const clockid_t clock)
{
	return ((~pid) << 3) | clock;
}

That existed even before we fiddled with robust futexes and puts a hard
limit of 29 bits on the PID space.

So we want something like the below.

Thanks,

        tglx
---       
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -29,7 +29,9 @@
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
- * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
+ *
+ * PID/TIDs are limited to 2^29 due to POSIX CPU timers. See
+ * make_process_cpuclock().
  */
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
