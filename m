Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3C6EFB70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjDZUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjDZUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:00:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E360D2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:00:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682539234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlKUM3Ard0yvYVkNRouDQadczDOl0h3/V1tyd2kzQE4=;
        b=XQh5cZc+zBpM0TV56z1mOffywR5isafraX73BycznXr2NdYvMba65wjMtqXnoYcYdUCMYr
        dMtuSrVzQoU86y3fIbBfaCjhzlo6kbvGhS1Btxe3VZPv50venyz4wElCOfOFkSr9uljlwR
        PqpqGR91UUlq0sJoHRibFHQ4XFWJgOMUQEQ/Hi01uS+fXtuY/VLAi82Xa5iZOCZCl219D1
        fTjmMzus60PAgg9V4E1Q4nfevvzD+L4OBp7sAP9DMJvGjSQ+AiKwSsPLcNFFa2Bn/ZE7qp
        KdC6LJnVQe6g5BJXQGHTlf/mZ8m/i419Q+nPFvRc9mwfIhzLe/t6hOjAmwYt1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682539234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlKUM3Ard0yvYVkNRouDQadczDOl0h3/V1tyd2kzQE4=;
        b=OsK3BMW+c0X0idT26Fw8YUOSyWNhRVqCZEobdodKgMeAhmKaW1wqQAttlfvB9bp32ZiBxr
        SdnATjOa2X8jwPCg==
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
In-Reply-To: <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
 <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
Date:   Wed, 26 Apr 2023 22:00:33 +0200
Message-ID: <87sfcmxvku.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2023 at 12:51, Tom Lendacky wrote:
> On 4/26/23 12:37, Tony Battersby wrote:
>>> +	/*
>>> +	 * native_stop_other_cpus() will write to @stop_cpus_count after
>>> +	 * observing that it went down to zero, which will invalidate the
>>> +	 * cacheline on this CPU.
>>> +	 */
>>> +	atomic_dec(&stop_cpus_count);
>
> This is probably going to pull in a cache line and cause the problem the 
> native_wbinvd() is trying to avoid.

The comment above this atomic_dec() explains why this is _not_ a
problem. Here is the counterpart in native_stop_other_cpus():

>>> @@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
>>>   	disable_local_APIC();
>>>   	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>>>   	local_irq_restore(flags);
>>> +
>>> +	/*
>>> +	 * Ensure that the cache line is invalidated on the other CPUs. See
>>> +	 * comment vs. SME in stop_this_cpu().
>>> +	 */
>>> +	atomic_set(&stop_cpus_count, INT_MAX);

That happens _after_ all the other CPUs did the atomic_dec() as the
control CPU waits for it to become 0.

As this makes the cacheline exclusive on the control CPU the dirty
cacheline on the CPU which did the last atomic_dec() is invalidated.

As the atomic_dec() is obviously serialized via the lock prefix there
can be only one dirty copy on some other CPU at the time when the
control CPU writes to it.

After that the only dirty copy is on the control CPU, no?

Thanks,

        tglx
