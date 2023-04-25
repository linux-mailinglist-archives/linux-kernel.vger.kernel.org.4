Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F046EEA74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjDYXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDYXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:00:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED50AF22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:00:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682463632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xi1m4IlR6UmZMMi3ONfEx6qfukMjT8mnp8XWxnWtv0=;
        b=ww1058Sh6ajk58vJ3U/YypFjA5A6rdVE4snPFJ4Nhzir65J/UKYkUM/pBW+z6CLCIxI+3j
        nDeAL1CatekP6AMzsSkaeat3B8eit04wGTYBlyGihPQM6UCqM98LRq79AHHM5B4/TJTEyG
        /GY8MS6/xavEMKpwa/uWbVaniGN7y8Xx7s5NO7ljZ7faiB77nPmCmlXcoLfGUpv8yvYvde
        xraPh3PRJPWkJgnIWZkzVyMWin4nHHCVDB4DrddqdDYhxHJXO8RpQ7YvxIcDX1XEYo2+Dx
        NXUYPWUtNz8lmyoDhseA0hiOqYGxAcP5aShWunw/mgKt5F0DUS6jfQkTE7J7DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682463632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xi1m4IlR6UmZMMi3ONfEx6qfukMjT8mnp8XWxnWtv0=;
        b=NnybxPpRjgTFCeqNEvNDMDMNbioY+kg5jNz+tMC31aFbqH5jOCed65NRlFzRdazmo1XxlM
        NJlbxWx1LJYqR0DQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
In-Reply-To: <ecdea7a8-a748-6ecb-5fc1-93d7eda3c54d@intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <ecdea7a8-a748-6ecb-5fc1-93d7eda3c54d@intel.com>
Date:   Wed, 26 Apr 2023 01:00:31 +0200
Message-ID: <87leifzhww.ffs@tglx>
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

On Tue, Apr 25 2023 at 15:29, Dave Hansen wrote:
> On 4/25/23 14:05, Thomas Gleixner wrote:
>> The only consequence of looking at bit 0 of some random other leaf is
>> that all CPUs which run stop_this_cpu() issue WBINVD in parallel, which
>> is slow but should not be a fatal issue.
>> 
>> Tony observed this is a 50% chance to hang, which means this is a timing
>> issue.
>
> I _think_ the system in question is a dual-socket Westmere.  I don't see
> any obvious errata that we could pin this on:
>
>> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-5600-specification-update.pdf
>
> Andi Kleen had an interesting theory.  WBINVD is a pretty expensive
> operation.  It's possible that it has some degenerative behavior when
> it's called on a *bunch* of CPUs all at once (which this path can do).
> If the instruction takes too long, it could trigger one of the CPU's
> internal lockup detectors and trigger a machine check.  At that point,
> all hell breaks loose.
>
> I don't know the cache coherency protocol well enough to say for sure,
> but I wonder if there's a storm of cache coherency traffic as all those
> lines get written back.  One of the CPUs gets starved from making enough
> forward progress and trips a CPU-internal watchdog.
>
> Andi also says that it _should_ log something in the machine check banks
> when this happens so there should be at least some kind of breadcrumb.
>
> Either way, I'm hoping this hand waving satiates tglx's morbid curiosity
> about hardware that came out from before I even worked at Intel. ;)

No, it does not. :)

There is no reason to believe that this is just a problem of CPUs which
were released long time ago.

If there is an issue with concurrent WBINVD then this needs to be
addressed independently of Tony's observations.

Aside of that the allowance for the control CPU to make progress based
on the early clearing of the CPU online bit is still a possibility to
explain the wreckage just based on timing.

The reason why I insist on a proper analysis is definitely not morbid
curiosity. The real reason is that I fundamentally hate problems being
handwaved away.

It's a matter of fact that all problems which are not root caused keep
coming back and not necessarily in debuggable ways. Tony's 50% case is
golden compared to the once in a blue moon issues.

I outlined the debug options already. So just throw them at the problem
instead of indulging in handwaing theories.

Thanks,

        tglx
