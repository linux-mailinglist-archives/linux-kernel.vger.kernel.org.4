Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C72A6203EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiKGXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiKGXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:46:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AE1BE8A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:45:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667864756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJpXilJJ1kzzx00V2iygh4nhzFSutURlpOx4SGA14uA=;
        b=FWE7BDlqYAMHTT1SJ30pNL+SqokfR9h/m12iACtZZ43WKYeZbFyAdHTpns7swUJbuo+dbn
        AsEHL0Z9vLiq0djNF9pW2NlygDy2u+U7VxYdGpRf4eq5YtjN2qFI5VWk5ZEk0DexMBrB9j
        0nvJk2f3207hdD+pzdCuX2+2ZQF9UQ49pOt0Xa8nuWcN/jFthS3OAocC8JwI+3Fy8ZkioS
        9uZeLWpgmtjnwBn4ImTof9QeDBH8L6wCZXWwTm/On1NqF72vKdC3sGE8pbh8NS1vZ9pJOn
        zTHpFejSt1dsyJSmV9I5otGD9PkGwnhgMxHTfnegsBxhJNVdWa1DBfsDaYrtvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667864756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJpXilJJ1kzzx00V2iygh4nhzFSutURlpOx4SGA14uA=;
        b=Y0sYVhLypXw8UFv8HGsnFO6bAIWZK47+WF2PUXNF1fhAvFfHUpnyWavFPb7dqMdQkdt4Au
        lrQuJGm9ERJWKoBQ==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [for-linus][PATCH 4/5] timers: Add timer_shutdown_sync() and
 timer_shutdown() to be called before freeing timers
In-Reply-To: <F93A06C1-6188-4787-9563-8F5676A5A098@goodmis.org>
References: <20221106233037.815236769@goodmis.org>
 <20221106233434.425162916@goodmis.org> <87sfivvy91.ffs@tglx>
 <87mt93vwv4.ffs@tglx> <F93A06C1-6188-4787-9563-8F5676A5A098@goodmis.org>
Date:   Tue, 08 Nov 2022 00:45:55 +0100
Message-ID: <87y1sm8h1o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07 2022 at 05:43, Steven Rostedt wrote:
> On November 7, 2022 3:15:43 AM PST, Thomas Gleixner <tglx@linutronix.de> wrote:
>>On Mon, Nov 07 2022 at 11:45, Thomas Gleixner wrote:
>>> On Sun, Nov 06 2022 at 18:30, Steven Rostedt wrote:
>>>>
>>>> Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/
>>>> Link: https://lkml.kernel.org/r/20221106212702.363575800@goodmis.org
>>>> Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/
>>>>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>>> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Julia Lawall <Julia.Lawall@inria.fr>
>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> And please follow the guidelines of the tip tree for changelogs and tags.
>>>
>>> I'll just grab it from the list and let my scripts run over it.
>>
>>Duh. This thing is unreviewable.
>>
>>Can you please split it up into pieces which are digestable?
>
> Sure, but I'm traveling this week and may not get to it until Friday.

That's fine as I think this whole approach is wrong to begin with.

We are not doing a tree wide change at rc4 just to scratch an itch which
is there for ages and has been debated for months.

Q: Did you try a merge of the result against -next?
A: Definitely not.

The proper approach is to provide all the infrastructure, i.e. the new
interfaces and merge them during the next merge window. Right before rc1
provide a script or a script converted tree to Linus which switches the
tree over to the new world order.

How long have you been around doing kernel development and how much fuzz
do you make about even trivial changes to ftrace?

Thanks,

        tglx




