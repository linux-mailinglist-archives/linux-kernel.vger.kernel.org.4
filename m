Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C767DA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjAZX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjAZX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:59:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0B29433;
        Thu, 26 Jan 2023 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674777541; x=1706313541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i4cO6WKOwLUL0B6TizQ55O2+z+ArENpzZgj7B6EXcBs=;
  b=THr6/IoMQZz78U3zCFwIuw2iqHoNZ3l5UeKLyOo24JTJmuFwec43NdUK
   UVydJW999DFuTAWnZnPALzHzZXe4h95nu50c6PE1rEYAcbfX1etUGrXpZ
   be+6a0eOGdAY5wkYHiMl0OmKHZ0Sdn/USBwuFUfETTCCovbM7Dd6bfJVu
   ZbFhzzdD2f+WligVl9sxpPcjR+G7tu/lrcA3uNKUQh67AGiVTMW501pmc
   pSfs8K5L0BNt2aXW2UgxK3ff0OwASoHOWbJs3YTe5JJamZQBu9qiKRHwd
   kT1t9M1cWg3Ts8v3slt1arTknmEyIL4cv76vpI6ClTg0dlU9I5F/Ya2jP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306642202"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="306642202"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:58:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="613019003"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="613019003"
Received: from ernestom-mobl.amr.corp.intel.com (HELO [10.212.255.13]) ([10.212.255.13])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:58:58 -0800
Message-ID: <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
Date:   Thu, 26 Jan 2023 15:58:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
 <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
 <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
 <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com> <Y9MAvhQYlOe4l2BM@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y9MAvhQYlOe4l2BM@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 14:37, Eric Biggers wrote:
> The end result is that on older CPUs, Intel explicitly guarantees that the
> instructions in
> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
> have data operand independent timing.  But on newer CPUs, Intel has explicitly
> removed that guarantee, and enabling DOITM is needed to get it back.

Yep.

> By the way, surely the importance of using DOITM on a particular CPU correlates
> strongly with its performance overhead?  So I'm not sure that benchmarks of
> DOITM would even be very interesting, as we couldn't necessarily decide on
> something like "don't use DOITM if the overhead is more than X percent", since
> that would exclude exactly the CPUs where it's the most important to use...

We've looked at how bad the cure is compared to the disease for *every*
one of these issues.  As far as I know, either the disease has always
gotten better over time or the cure gets cheaper (think IBRS/retpoline
-> EIBRS or RDCL_NO for Meltdown).

DOITM doesn't follow that pattern.  It appears that it's fairly cheap
now, but Intel is reserving the right to make it worse over time.  I
don't know how we can come up with a kernel policy which will be sane
going forward when things get worse over time.

> I think the real takeaway here is that the optimizations that Intel is
> apparently trying to introduce are a bad idea and not safe at all.  To the
> extent that they exist at all, they should be an opt-in thing, not out-opt.  The
> CPU gets that wrong, but Linux can flip that and do it right.

Let's try to break this down a _bit_.

The code most sensitive to the DOITM behavior is code written to be
resistant to timing side-channels today.  DOITM=0 behavior is obviously
unsafe there.  This code is, unfortunately, out in the wild and
completely unannotated and completely unaware of DOITM.  The only way to
mitigate it is to set DOITM=1 whenever it _might_ be running, which is
when userspace runs.  If the kernel can't be bothered to switch DOITM on
kernel entry/exit, then it's game over and DOITM=1 is the only choice.
For this code, it's arguable that even mitigations=off shouldn't set
DOITM=0.

The other extreme is code that's known to be vulnerable to timing
side-channels no matter the value of DOITM.  KSM is an example here.
Setting DOITM=1 isn't going to make KSM's side channels go away.

Then, there's the middle ground.  There is surely some code that does
not have timing side-channels with DOITM=0, but some appear with
DOITM=1.  I _think_ my colleagues at Intel consider this code to be in
the same bucket as "known vulnerable".  Basically, "if it's not designed
to be timing side-channel resistant then it surely is vulnerable to one,
regardless of DOITM."

That middle ground matters a *lot* because it's probably 99.9% of all
software, including essentially the whole kernel.

I think what I'm hearing from folks in this thread is that if going from
DOITM=1->0 _makes_ any code vulnerable in practice, then they view that
as a bug -- a real-world security bug.  It doesn't matter whether the
code was designed to be side-channel resistant or not.  A regression is
a regression.

I'm also hearing that the old (pre-Ice Lake), universal, DOITM=1
behavior is basically architecture because software depends on it.  It
can't be changed except with an explicit software opt-in.  Even if DOITM
were the right basic interface for this opt-in, the default polarity is
wrong for an opt-in.


