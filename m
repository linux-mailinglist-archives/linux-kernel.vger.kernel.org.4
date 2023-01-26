Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67167D89B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjAZWiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:38:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E359EC2;
        Thu, 26 Jan 2023 14:37:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDCED6198A;
        Thu, 26 Jan 2023 22:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFDCC433D2;
        Thu, 26 Jan 2023 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674772672;
        bh=7AYFhb4koS9pJTdWI4SB1Hdg+HY7ss67hczEY93WEp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqohPkmrzcf+GeWXrSxRwkqs0k3Xlkoj3CqzVFnli+3LGo2FeksZWSp8oiMS/0mpe
         wyTWlXFSB8V3a+A9ccMGpCoh3t9TiDFMgSjz4z59Yi/nT81dkJjAyz88fixXoi8sr7
         +9fFSF7B7qwRNBluZ5Pb+caWOmWqKCRtUUYxfN2R+LMeA7CQJJg7j2HRoRlyXz7OwW
         9NG5dOkCIS/ocf4Wru/IR9jfED5dfasZHMKZXqRzaf+D+HMJtprrAxx7oHC/KpvICE
         ueBsvTuibj18Vf5H+A0m2Zfz35wRxNRprgmPBCucrgg+yIU+dgzgyTi/uwe++hmtUt
         mdNVbSKrG3s5g==
Date:   Thu, 26 Jan 2023 22:37:50 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Message-ID: <Y9MAvhQYlOe4l2BM@gmail.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
 <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
 <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
 <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:12:36AM -0800, Dave Hansen wrote:
> On 1/26/23 09:52, Jann Horn wrote:
> >> Maybe I'm totally missing something, but I thought the scope here was
> >> the "non-data operand independent timing behavior for the listed
> >> instructions" referenced here:
> >>
> >>> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
> >> where the "listed instructions" is this list:
> >>
> >>> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
> >> For example, that includes XOR with the 0x31 and 0x81 opcodes which
> >> there are plenty of in the kernel.
> > That list says at the top: "The table below lists instructions that
> > have data-independent timing."
> 
> So, first of all, apologies for the documentation.  It needs some work,
> and I see where the confusion is coming from.
> 
> But, I did just confirm with the folks that wrote it. The "listed
> instructions" *ARE* within the scope of being affected by the DOITM=0/1
> setting.
> 
> Instead of saying:
> 
> 	The table below lists instructions that have data-independent
> 	timing.
> 
> I think it should probably say something like:
> 
> 	The table below lists instructions that have data-independent
> 	timing when DOITM is enabled.
> 
> 	(Modulo the MXCSR interactions for now)
> 
> Somebody from Intel please thwack me over the head if I'm managing to
> get this wrong (wouldn't be the first time).

That's my understanding too, based on the part of
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
that describes DOITM.  The page
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
is actively misleading, so yes please get that fixed.

I think the following is also extremely important:

	For Intel® Core™ family processors based on microarchitectures before
	Ice Lake and Intel Atom® family processors based on microarchitectures
	before Gracemont that do not enumerate IA32_UARCH_MISC_CTL, developers
	may assume that the instructions listed here operate as if DOITM is
	enabled.

The end result is that on older CPUs, Intel explicitly guarantees that the
instructions in
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
have data operand independent timing.  But on newer CPUs, Intel has explicitly
removed that guarantee, and enabling DOITM is needed to get it back.

By the way, surely the importance of using DOITM on a particular CPU correlates
strongly with its performance overhead?  So I'm not sure that benchmarks of
DOITM would even be very interesting, as we couldn't necessarily decide on
something like "don't use DOITM if the overhead is more than X percent", since
that would exclude exactly the CPUs where it's the most important to use...

I think the real takeaway here is that the optimizations that Intel is
apparently trying to introduce are a bad idea and not safe at all.  To the
extent that they exist at all, they should be an opt-in thing, not out-opt.  The
CPU gets that wrong, but Linux can flip that and do it right.

- Eric
