Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3A67B71D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjAYQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAYQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:46:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A588A5618B;
        Wed, 25 Jan 2023 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674665158; x=1706201158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XdmD7UQAGzmd7MjF/AVg3Q2yN7Wg4zxBx49JM/0ghV4=;
  b=J0tP8zkTbdhnjmn0BWCBr/E6DAXRrISl0R5nosb1iJbc8Nh5I6Xz6hEF
   zD61jRppX7YD7vL5o81bSs+mhEjBOK0KffvniAUun2WC+cBiKAdCHcscN
   SaQmkk20EnoyCAndEiFT3lBw2zfAcTeTnc0X/SVFvrcMPyjNo6ne3hpBS
   n1ajmIHZ990rYYUd2m1Asj3yL+EvsXXOpXDkCaPxgGE9j2pXMX7Oj2ELT
   5eVGwPgTc87gXwYbgWFHLrXt4ZGVEieMay2VVs7zUM+4vmzDAgS12DHlN
   io6k2iHGGR7euWxyqmGyqc9LWk8jTFTj4hZuf8Z6REo+uaUysP/Y3KGYx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="324305906"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="324305906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:45:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="751266882"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="751266882"
Received: from zguo4-mobl1.amr.corp.intel.com (HELO [10.209.50.216]) ([10.209.50.216])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:45:57 -0800
Message-ID: <1000ec59-c8b7-e546-5baa-bdd0e878bf76@intel.com>
Date:   Wed, 25 Jan 2023 08:45:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAMj1kXEZi1ewVdqXHTi7kWX9aT+j1=rFOVE55LdJYb9LkV9Dkw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXEZi1ewVdqXHTi7kWX9aT+j1=rFOVE55LdJYb9LkV9Dkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 08:22, Ard Biesheuvel wrote:
...
> All the nospec stuff we added for Spectre v1 serves the same purpose,
> essentially, although the timing variances due to cache misses are
> likely easier to measure. IOW, some of the kernel is now written that
> way in fact, although the author of that doc may have had something
> else in mind.
> 
> So IMHO, the scope is really not as narrow as you think.

I've spoken with the folks who wrote that doc.  They've told me
repeatedly that the scope is super narrow.  Seriously, look at just
*one* thing in the other Intel doc about mitigating timing side-channels[1]:

	be wary of code generated from high-level language source code
	that appears to adhere to all of these recommendations.

The kernel has a fair amount of code written in high-level languages.

The authors of the DOIT doc truly intend the real-world benefits of
DOITM to be exceedingly narrow.  I think it would be fair to say that
they think:

	DOITM is basically useless for most code written in C, including
	basically the entire kernel.

I'll go forward this on to them and make sure I'm not overstating this
_too_ much.

>> That's _meant_ to be really scary and keep folks from turning this on by
>> default, aka. what this patch does.  Your new CPU will be really slow if
>> you turn this on!  Boo!
> 
> What is the penalty for switching it on and off? On arm64, it is now
> on by default in the kernel, and off by default in user space, and
> user space can opt into it using an unprivileged instruction.

Right now, DOITM is controlled by a bit in an MSR and it applies
everywhere.  It is (thankfully) one of the cheap MSRs and is not
architecturally serializing.

That's still not ideal and there is a desire to expose the bit to
userspace *somehow* to make it much, much cheaper to toggle.  But, it'll
still be an extra bit that needs to get managed and context switched.

When I looked, the arm64 bit seemed to be in some flags register that
got naturally saved and restored already on user<->kernel transitions.
Was I reading it right?  It seemed like a really nice, simple mechanism
to me.


1.
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/secure-coding/mitigate-timing-side-channel-crypto-implementation.html
