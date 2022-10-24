Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64460A010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJXLSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJXLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:18:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4E5C5FDD9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:18:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E23D6E;
        Mon, 24 Oct 2022 04:18:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D162B3F7B4;
        Mon, 24 Oct 2022 04:18:28 -0700 (PDT)
Date:   Mon, 24 Oct 2022 12:18:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: kCFI && patchable-function-entry=M,N
Message-ID: <Y1Z0gvscALn2br2q@FVFF77S0Q05N>
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
 <CABCJKuf=OB_3ZR_rwaG3H5kHKmTTDk+sihjJXYmyWgZjUX2yTQ@mail.gmail.com>
 <CAFP8O3JuC9HL1-G23vGJO=jjN7Tsgz7c8TB1_F6UQ-MqCyGNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3JuC9HL1-G23vGJO=jjN7Tsgz7c8TB1_F6UQ-MqCyGNLQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:14:41PM -0700, Fangrui Song wrote:
> On Fri, Oct 21, 2022 at 10:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 8:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > For arm64, I'd like to use -fatchable-function-entry=M,N (where N > 0), for our
> > > ftrace implementation, which instruments *some* but not all functions.
> > > Unfortuntately, this doesn't play nicely with -fsanitize=kcfi, as instrumented
> > > and non-instrumented functions don't agree on where the type hash should live
> > > relative to the function entry point, making them incompatible with one another.
> >
> > Yes, the current implementation assumes that if prefix nops are used,
> > all functions have the same number of them.
> >
> > > Is there any mechanism today that we could use to solve this, or could we
> > > extend clang to have some options to control this behaviour?
> >
> > I don't think there's a mechanism to work around the issue right now,
> > but we could just change where the hash is emitted on arm64.
> >
> > > It would also be helpful to have a symbol before both the hash and pre-function
> > > NOPs so that we can filter those out of probes patching (I see that x86 does
> > > this with the __cfi_function symbol).
> >
> > Adding a symbol before the hash isn't a problem, but if we move the
> > hash and want the symbol to be placed before the prefix nops as well,
> > we might need a flag to control this. Fangrui, what do you think?
> >
> > Sami
> 
> Since the kcfi code expects the hash to appear in a specific location
> so that an instrumented indirect jump can reliably obtain the hash.
> For a translation unit `-fpatchable-function-entry=N,M` may be
> specified or not, and we want both to work. Therefore, I agree that a
> consistent hash location will help. This argument favors placing M
> nops before the hash. The downside is a restriction on how the M nops
> can be used. Previously if M>0, the runtime code needs to check
> whether a BTI exists to locate the N-M after-function-entry NOPs. If
> the hash appears after the M nops, the runtime code needs to
> additionally knows whether the hash exists. My question is how to
> reliably detect this.

That's a fair point.

For detecting BTI we can scan the binary for BTI/NOP at M instructions into the
patch-site, but a similar approach won't be reliable for the type hash since
the type hash itself could have the same bit pattern as an instruction.

> If there is motivation using M>0, I'd like to know the concrete code
> sequence for `-fpatchable-function-entry=N,M` and how the runtime code
> detects the NOPs with optional hash and optional BTI.

For the BTI case alone, I have code at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/ftrace/per-callsite-ops&id=272a580fd5b7acc31747505d71530cee7cc2837d

... the gist being that it checks the instruction M insns after the start of
the patch site.

For the type hash, I think there are a few options, e.g.

* Restricting the type hash to a set of values that can be identified (e.g.
  encoding those as a permanently-undefined UDF with a 16-bit immediate).

* Adding options to record additional metadata along with the pointer to the
  patch-site in the __patchable_function_entries section.

* Adding an option to record patch-site variants to sub-sections of the
  __patchable_function_entries section, so that at link time these can be
  grouped separately, e.g.

  * __patchable_function_entries.???		// no BTI, no type hash
  * __patchable_function_entries.bti		// has BTI
  * __patchable_function_entries.bti_cfi	// has BTI and type hash
  * __patchable_function_entries.cfi		// has type hash

Do any of those approaches sound plausible to you?

Thanks,
Mark.
