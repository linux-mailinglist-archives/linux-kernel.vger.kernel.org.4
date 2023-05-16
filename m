Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C37058FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEPUkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjEPUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:39:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B21BF4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:39:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684269590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCVRViIkSyo2p0AVmD2VBFU7NXG7CdGaJTUHpk53BrU=;
        b=36WTLNP0b8Tfd7PpIDZh6Yf9Q+udTKydU73GAA2jPeqm0kG+CZ6rJvcGRL51MySh3KDp5y
        UUD7zygPFkj57C3Mw2R1LUYKys3Gmab5bf5s3q5tvMHfRLTfCZSup1wsTvp+fFkf8fGU03
        W0CBWDGpBxTO2cp7P50b0IGNC6va1M1l2A6krtyQpXhoT0fAaDAJ0tgdqyi68YFnnT3mOT
        S0LRL7mGBdXy1MEFW4XzvcFnDbqSfM6woZ68U4dDUlTPyM2pZe4/Y1L6UvL0s2xg6HfWfh
        fHIwE4hPhsaL62IweXc+4Qj8c7a++U/t6wZmI5JLaSdcPsmQy8pOwbi8uiAWMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684269590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCVRViIkSyo2p0AVmD2VBFU7NXG7CdGaJTUHpk53BrU=;
        b=wkjjAvff5MwqI1LdgSgL20aU/GxPcU+j0081LoiGfDaVBR7zcdEf+dwFw2DoYBoeh8IXhZ
        /R5WA8Yq+B36P6Bg==
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
In-Reply-To: <4959DDEE-58DC-45E7-BE00-019A45A97D2B@zytor.com>
References: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
 <56ea846e-bce8-2508-e485-1dada8c39643@intel.com>
 <4959DDEE-58DC-45E7-BE00-019A45A97D2B@zytor.com>
Date:   Tue, 16 May 2023 22:39:49 +0200
Message-ID: <878rdo6mei.ffs@tglx>
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

On Tue, May 16 2023 at 10:57, H. Peter Anvin wrote:
> On May 16, 2023 7:12:34 AM PDT, Dave Hansen <dave.hansen@intel.com> wrote:
>>On 5/15/23 23:52, Rong Tao wrote:
>>> Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instruction
>>> rdtsc can achieve a 40% performance improvement with only a small loss of
>>> precision.
>>
>>I think the minimum that can be done in a changelog like this is to
>>figure out _why_ a RDTSCP was in use.  There are a ton of things that
>>can make the kernel go faster, but not all of them are a good idea.
>>
>>I assume that the folks that wrote this had good reason for not using
>>plain RSTSC.  What were those reasons?
>
> I believe the motivation is that it is atomic with reading the CPU number.

Believe belongs in the realm of religion and does not help much to
explain technical issues. :)

rdtsc_ordered() has actually useful comments and also see:
  https://lore.kernel.org/lkml/87ttwc73za.ffs@tglx

The Intel SDM and the AMD APM are both blury about RDTSC speculation and
we've observed (quite some time ago) situations where the RDTSC value
was clearly from the past solely due to speculation. So we had to bite
the bullet to add the fencing. Preferrably RDTSCP or if not available
LFENCE; RDTSC. IIRC the original variant was even CPUID; RDTSC, which is
daft.

The time readout does (simplified):

    do {
           // Wait for the sequence count to become even
           while ((seq = READ_ONCE(vd->seq)) & 1);

           tsc = rdtsc_ordered();
           now = convert(vd, tsc);
    } while (seq != READ_ONCE(vd->seq));

It's obviously more complex than that, but you get the idea.

Now replace RDTSCP with RDTSC and explain what guarantees that
the TSC read isn't speculated ahead of the sequence check.

If it's architecturally guaranteed that this can't happen, I'm more than
happy to use plain RDTSC.

But as I've observed that myself in the past, I'm pretty sure that it is
not guaranteed, at least not on older microarchitectures. If newer ones
make that guarantee then they should have exposed that as a feature bit
in CPUID and clearly documented it in the SDM.

As long as that does not happen, I'm sticking to the correctness first
principle.

Thanks,

        tglx
