Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3B66A88D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjANCKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjANCKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:10:50 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062948B769
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 18:10:49 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30E2AEij2810940
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 13 Jan 2023 18:10:15 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30E2AEij2810940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673662217;
        bh=GqQouhlORIoyM6JNxn/mN7mkG20++JcJpilzWzqGmow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S43FZltOLHSxFBy5O44fVMS2oNCKSGKsbGYnaN+U3str1tOvDcStm0HwpiEAK4OTd
         sMwvReeJDRR7/8fTKraPZy5KGOeX9ayYp8RDObRvyAfLd0lHKlozC5ijdjflJByYIL
         aWuY1ksgv+TvEuJs9tUKszRzYUgvmRhLnLSQXSErkGFpcOE6QA/GtA5CbBFOupjokX
         azI1+wm7hHyl8h87Rdt2MiB2uNULKcjrXBKevbq4U2SrHghbAlct3FdE5Ft6mvulN/
         FljJgEZGZ74YoZEXDN93I1ktGEZ8Bf4bJbcqRa2m6t4hjIWLemSMtoYD3gqIoG4ifD
         p3kDNr1YS/HGw==
Message-ID: <9fc36447-5534-b93a-98d2-0999820c0def@zytor.com>
Date:   Fri, 13 Jan 2023 18:10:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 3/3] x86 mm, x86 architecture (32-bit and 64-bit):
 arch/x86/mm/kaslr.c: Adds 64bits version of prandom_seed_state
Content-Language: en-US
To:     david.keisarschm@mail.huji.ac.il, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Jason@zx2c4.com, keescook@chromium.org, aksecurity@gmail.com,
        ilay.bahat1@gmail.com
References: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
 <295dceed7bef2391f86e751b9bfc9a34347062e4.1673470326.git.david.keisarschm@mail.huji.ac.il>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <295dceed7bef2391f86e751b9bfc9a34347062e4.1673470326.git.david.keisarschm@mail.huji.ac.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 13:39, david.keisarschm@mail.huji.ac.il wrote:
> +{
> +	u32 i = ((seed >> 32) ^ (seed << 10) ^ seed) & 0xffffffffUL;
> +	// To take advantage of all 64 bits of the seed
> +	u32 j = ((seed>>32) ^ (seed<<10)) & 0xffffffffUL;

The and operation here is pointless. You are implicitly casting to u32. 
Even if you had to mask explicitly, (u32) would be a lot more clear than 
a hard-to-read constant.


> +	state->s1 = __seed(i,   2U);
> +	state->s2 = __seed(j,   8U);
> +	/* Ensure no obvious linear relation with the previous states */
> +	state->s3 = __seed(next_pseudo_random32(i+j),  16U);
> +	state->s4 = __seed(next_pseudo_random32(j-((i>>16)^(i<<16))), 128U);
> +
> +	/* Calling RNG ten times to satisfy recurrence condition */
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +	prandom_u32_state(state);
> +}

What recurrence relation is that? This looks like you are just trying to 
re-invoke prandom_warmup(), but for heaven's sake, don't open-code it!

In fact, it seems you are just hacking an alternate version of 
prandom_seed_full_state(). Why not just change prandom_seed_full_state() 
if that is motivated? (You may need to factor out the iteration over all 
CPUs.)

Honestly, I'm not a super expert in PRNGs, but this seems both slow (the 
*only* motivation for prandom_u32() is to be fast) and pointless. If we 
are relying on this for security, we should be using something that is 
actually cryptographic; especially since this is only invoked on boot, 
which is where entropy is maximally scarce and PRNGs maximally 
vulnerable due to being close to their seed state.


Additionally, in terms of creating performant mixing functions, one 
thing that comes to mind is the circular multiply:

static inline u32 circular_multiply(u32 a, u32 b)
{
	u64 m = (u64)a * b;
	return m + (m >> 32);
}

On x86, this is two instructions, even on 32 bits.

One can use ^ instead of + to make it a bit less algebraic, but I don't 
know for sure that that is a net improvement.

	-hpa
