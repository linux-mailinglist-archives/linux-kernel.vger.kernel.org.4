Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042A69DCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjBUJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjBUJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:14:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257013DC0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:14:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676970894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQRPfdgwcRjmMWw+0c3Jqrn1sLC4pxLEI/ts5BFfWNs=;
        b=4lf3ncTbyGCsTdGUMTqu/8+wSbuNleK+TbpU3r1IdUq+q0A8dPmqfuMqgFUrgK+BVYs6jF
        GqyO2ZGmz7OeDLnw8JALhMHC3a0xUJOrh2Rq246Ucifk2KKegpYE662PTjWVdcXZrXhqj7
        buf/aXZSZCks/cuLzH0p74hDqrEWtnrmgs0/dtxVUzrqSCE1npxYSP2PV8oK7Um2VJkh16
        +xqbGFVrSNALd6q1fvQlYTKNae+b3TvpxnhIg1p0tY7+N75t/DRF5UeGtyXOC3tuW9b5BH
        oLGfKsgVpo5CsMbqxuk9B8gL6TuyVkCPUiQkwgH2k/UbjqU0AQL94Vtr3F+9Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676970894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQRPfdgwcRjmMWw+0c3Jqrn1sLC4pxLEI/ts5BFfWNs=;
        b=EznI/8jSHUDF8pTcrVH0UpZYp+I9czzXdCCXp84xzi5hwNqJ6pSl8TemI6OPnMvmLMPuR6
        9AI94MLXooTH4xCQ==
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
In-Reply-To: <20230221055117.GA1934@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx> <20230221041440.GA1934@templeofstupid.com>
 <20230221055117.GA1934@templeofstupid.com>
Date:   Tue, 21 Feb 2023 10:14:54 +0100
Message-ID: <871qmjpegh.ffs@tglx>
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

On Mon, Feb 20 2023 at 21:51, Krister Johansen wrote:
> On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
>> > static bool __init xen_tsc_safe_clocksource(void)
>> > {
>> > 	u32 eax, ebx. ecx, edx;
>> >  
>> > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
>> > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
>> > 
>> > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
>> > }
>> 
>> I'm all for simplifying.  I'm happy to clean up that return to be more
>> idiomatic.  I was under the impression, perhaps mistaken, though, that
>> the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
>> check_tsc_unstable() checks were actually serving a purpose: to ensure
>> that we don't rely on the tsc in environments where it's being emulated
>> and the OS would be better served by using a PV clock.  Specifically,
>> kvmclock_init() makes a very similar set of checks that I also thought
>> were load-bearing.
>
> Bah, what I meant to say was emulated, unstable, or otherwise unsuitable
> for use as a clocksource.  IOW, even if TSC_MODE_NEVER_EMULATE is
> set, it's possible that a user is attempting a migration from a cpu
> that's not invariant, and we'd still want to check for that case and
> fall back to a PV clocksource, correct?

Sure. But a life migration from a NEVER_EMULATE to a non-invariant host
is a patently bad idea and has nothing to do with the __init function,
which is gone at that point already.

What I wanted to say:

static bool __init xen_tsc_safe_clocksource(void)
{
        ......        

	/* Leaf 4, sub-leaf 0 (0x40000x03) */
	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);

	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
}

I didn't have the full context and was just looking at the condition.
Now I checked the full context and I think that except for the

	if (check_tsc_unstable())

check everything else can go away unless you do not trust the hypervisor
that it only sets the NEVER_EMULATE bit when CONSTANT and NONSTOP are
set as well. But yeah, you might prefer to be paranoid. It's virt after
all.

Thanks,

        tglx
