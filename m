Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03262689F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBCQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9EA6B9F;
        Fri,  3 Feb 2023 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675441547; x=1706977547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vIRC4xnaApbPW8RCCJgEQXnu08a0bMVna8tyTv2MRHQ=;
  b=Py+NP4thkZbXh0tNJQ//Ow9qleoK0j/YxWbpW8j2xGpVgbopq7rM2rAK
   +FNSk9Skj6EoxB9McbT+zPr/QFKbZ7gU5Au8ILGM6CWILsyeMOjyo1VYx
   DCl/A+N70aqmihKHc0x8FRglx23+6nxKGRE2LLUJQtE8ON8nd2e6G3hqy
   UGRBj1OvITlNz9h9Xn2TCSS0PbM69V8kA3fx5Dudp/paQvCPJBq3MxMO9
   qnJwhPF9udfnkhrbvESp532Eze/IDWcgf1JTDa251U+RFMC9hnJW83jdQ
   a+RbOTsBirFH5kQOaOX1scYrQzCHehyEaWlRb7VGHep3T6lZIi/29Qiyy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="316783306"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="316783306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 08:25:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="911208619"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="911208619"
Received: from hheck-mobl.amr.corp.intel.com (HELO [10.212.230.180]) ([10.212.230.180])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 08:25:45 -0800
Message-ID: <851920c5-31c9-ddd9-3e2d-57d379aa0671@intel.com>
Date:   Fri, 3 Feb 2023 08:25:44 -0800
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
 <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
 <16e3217b-1561-51ea-7514-014e27240402@intel.com>
 <Y9oMmYWzy7mlk3D9@sol.localdomain>
 <c5809098-9066-d90d-1bcc-108a11525cac@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c5809098-9066-d90d-1bcc-108a11525cac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 10:09, Dave Hansen wrote:
> Good questions.  I want to make sure what I'm saying here is accurate,
> and I don't have good answers to those right now.  We're working on it,
> and should have something useful to say in the next couple of days.

This is an attempt to make sure that everyone that is concerned about
DOITM behavior has all the same information as Intel folks before we
make a decision about a kernel implementation.

Here we go...

The execution latency of the DOIT instructions[1] does not depend on the
value of data operands on all currently-supported Intel processors. This
includes all processors that enumerate DOITM support.  There are no
plans for any processors where this behavior would change, despite the
DOITM architecture theoretically allowing it.

So, what's the point of DOITM in the first place?  Fixed execution
latency does not mean that programs as a whole will have constant
overall latency.  DOITM currently affects features which do not affect
execution latency but may, for instance, affect overall program latency
due to side-effects of prefetching on the cache.  Even with fixed
instruction execution latency, these side-effects can matter especially
to the paranoid.

Today, those affected features are:
 * Data Dependent Prefetchers (DDP)[2]
 * Some Fast Store Forwarding Predictors (FSFP)[3].

There are existing controls for those features, including
spec_store_bypass_disable=[4].  Some paranoid software may already have
mitigations in place that are a superset of DOITM.  In addition, both
DDP and FSFP were also designed to limit nastiness when crossing
privilege boundaries.  Please see the linked docs for more details.

That's basically the Intel side of things.  Everyone else should have
all the background that I have.  Now back to maintainer mode...

So, in short, I don't think everyone's crypto libraries are busted today
when DOITM=0.  I don't think they're going to _become_ busted any time soon.

Where do we go from here?  There are a few choices:

1. Apply the patch in this thread, set DOITM=1 always.  Today, this
   reduces exposure to DDP and FSFP, but probably only for userspace.
   It reduces exposure to any future predictors under the DOITM umbrella
   and also from Intel changing its mind.
2. Ignore DOITM, leave it to the hardware default of DOITM=0.  Today,
   this probably just steers folks to using relatively heavyweight
   mitigations (like SSBD) if they want DDP/FSFP disabled.  It also
   leaves Linux exposed to Intel changing its mind on its future plans.
3. Apply the patch in this thread, but leave DOITM=0 as the default.
   This lets folks enable DOITM on a moment's notice if the need arises.

There are some other crazier choices like adding ABI to toggle DOITM for
userspace, but I'm not sure they're even worth discussing.

#1 is obviously the only way to go if the DOITM architecture remains
as-is.  There is talk of making changes, like completely removing the
idea of variable execution latency.  But that's a slow process and would
be a non-starter if *anyone* (like other OSes) is depending on the
existing DOITM definition.

My inclination is to wait a couple of weeks to see which way DOITM is
headed and if the definition is likely to get changed.  Does anyone feel
any greater sense of urgency?


1.
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
2.
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/data-dependent-prefetcher.html
3.
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/fast-store-forwarding-predictor.html
4. https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html



