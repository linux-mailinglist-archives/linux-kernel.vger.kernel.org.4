Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01967D1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjAZQke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAZQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:40:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8BDA;
        Thu, 26 Jan 2023 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674751231; x=1706287231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjE1KkJgMovuMdFd70jXi/i73o89qDzcwabqBZl3my8=;
  b=YL6gcJGhZqvQYHMzM3OCXMcNagRQ1rFTBONC4cCpeH4nAyKH96eAIUMQ
   8hIQRi2oAnEl2SnvPBteR1ENOXBtr09MRxtyNJPGjNo0jU1mfpYByZROr
   vgGMbH37myJNoT4TI7IXE3jxI8pgYx845E7my7klAI5IpQx7qEya2y6CM
   Ca6r9bUUFG445+qQrxkazkiJRK8LKv6Ix0K1zlzB/JlDhZJVwuY9qSPqf
   +u32BOl7cq+N3rkNPXTixqosT2hEt4x428l3qi0rvwePpKRE92EFTLHhI
   bbY5IDgOtyEEiZ5wC9MCvpbJqE4QZ9u87FWU+0pM/0qMUqHe8QzEPhhhm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328966559"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="328966559"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:40:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693374746"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="693374746"
Received: from ernestom-mobl.amr.corp.intel.com (HELO [10.212.255.13]) ([10.212.255.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:40:29 -0800
Message-ID: <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
Date:   Thu, 26 Jan 2023 08:40:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
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
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
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

On 1/26/23 05:52, Jann Horn wrote:
> On Wed, Jan 25, 2023 at 4:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> Translating from Intel-speak: Intel thinks that DOITM purely a way to
>> make the CPU run slower if you haven't already written code specifically
>> to mitigate timing side channels.  All pain, no gain.
>>
>> The kernel as a whole is not written that way.
> 
> The kernel as a whole also doesn't really use the FPU registers for
> anything other than checksumming and cryptography and stuff like that
> (it's disabled in the compiler flags because the FPU registers
> normally contain userspace state that must not be clobbered). The
> instructions listed on that Intel help page are all weird PM* and VP*
> arithmetic instructions that can't be generated from C code in the
> kernel (except for weird subsystems in which every function is only
> callable in kernel-FPU-enabled mode and the compiler is set to enable
> FPU instruction generation, by which I mean amdgpu).

Maybe I'm totally missing something, but I thought the scope here was
the "non-data operand independent timing behavior for the listed
instructions" referenced here:

> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html

where the "listed instructions" is this list:

> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html

For example, that includes XOR with the 0x31 and 0x81 opcodes which
there are plenty of in the kernel.

That's a bit wider scope than the crazy instructions like VPLZCNTD.  The
crazy instructions list that I _think_ you were grepping for is the
"Instructions That May Exhibit MCDT Behavior".  That's also a fun one,
but it is more narrow than the DOITM list.

