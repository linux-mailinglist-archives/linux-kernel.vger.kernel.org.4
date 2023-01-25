Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00F67B5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjAYPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjAYP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE659E42;
        Wed, 25 Jan 2023 07:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674660587; x=1706196587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2tR3uGtswiBcJrUWftQvxqWPML3gAok8N/0LQbz+4A=;
  b=iQpTzKKxVkg2jVztYouRXUNRDbilSwRz8oyNKkOM0qoQjfFuOKOie28e
   6DnJOLgjATg8oc394sJNyPDJUt1UW9sHjTrOn52q7ZWPp9zuGKp3/5eMV
   6ZPaEM6yStOQGTxr6jH2duUquXzSk0V40DqG/2Bz8jkIB26C8rebE7gpk
   nwfkr655H+pCqy40ktNtBl07l1uYIdukzwqH1y565Ol909jcA4N/VdF00
   hu9zQL0ZuUTOjLPJSq3szZ/tfqd+n+/zlu2nKzdSNUjeUyBpF4dGrKnPW
   rx0x/XHaF4NePAPuwkJ6dFO4oilog1bBxK3C+HqB7j8+S2sXj/c+HqCgV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306242452"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306242452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:29:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="725896529"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="725896529"
Received: from zguo4-mobl1.amr.corp.intel.com (HELO [10.209.50.216]) ([10.209.50.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:29:39 -0800
Message-ID: <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
Date:   Wed, 25 Jan 2023 07:29:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230125012801.362496-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 17:28, Eric Biggers wrote:
> To mitigate this CPU vulnerability, it's possible to enable "Data
> Operand Independent Timing Mode" (DOITM) by setting a bit in a MSR.
> While Intel's documentation suggests that this bit should only be set
> where "necessary", that is highly impractical, given the fact that
> cryptography can happen nearly anywhere in the kernel and userspace, and
> the fact that the entire kernel likely needs to be protected anyway.

I think this misses a key point from the documentation:

	This functionality is intended for use by software which has
	already applied other techniques to mitigate software timing
	side channels, such as those documented in Intel's Guidelines
	for Mitigating Timing Side Channels Against Cryptographic
	Implementations.

Translating from Intel-speak: Intel thinks that DOITM purely a way to
make the CPU run slower if you haven't already written code specifically
to mitigate timing side channels.  All pain, no gain.

The kernel as a whole is not written that way.  I'm sure the crypto
folks that are cc'd can tell us specifically if the kernel crypto code
is written following those recommendations.

So, let's call this patch what it is: a potential global slowdown which
protects a very small amount of crypto code, probably just in userspace.
 That is probably the code that's generating your RSA keys, so it's
quite important, but it's also a _very_ small total amount of code.

There's another part here which I think was recently added to the
documentation:

	Intel expects the performance impact of this mode may be
	significantly higher on future processors. 

That's _meant_ to be really scary and keep folks from turning this on by
default, aka. what this patch does.  Your new CPU will be really slow if
you turn this on!  Boo!

All that said, and given the information that Intel has released, I
think this patch is generally the right thing to do.  I don't think
people are wrong for looking at "DODT" as being a new vulnerability.
Intel obviously doesn't see it that way, which is why "DODT" has (as far
as I can tell) not been treated with the same security pomp and
circumstance as other stuff.

Last, if you're going to propose that this be turned on, I expect to see
at least _some_ performance data.  DOITM=1 isn't free, even on Ice Lake.
