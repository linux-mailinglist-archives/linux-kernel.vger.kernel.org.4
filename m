Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D0665A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjAKLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjAKLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 076B9C1C;
        Wed, 11 Jan 2023 03:39:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFDBBFEC;
        Wed, 11 Jan 2023 03:39:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C6A3F587;
        Wed, 11 Jan 2023 03:39:12 -0800 (PST)
Date:   Wed, 11 Jan 2023 11:39:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org
Subject: Re: [PATCH 3/8] arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
Message-ID: <Y76fxxGPWB2MW5NH@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-4-mark.rutland@arm.com>
 <Y73MBswL76Hi9cay@hirez.programming.kicks-ass.net>
 <20230110204320.GA9739@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110204320.GA9739@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:43:20PM +0000, Will Deacon wrote:
> On Tue, Jan 10, 2023 at 09:35:18PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 09, 2023 at 01:58:23PM +0000, Mark Rutland wrote:
> > 
> > > diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> > > index 1436fa1cde24d..df18a3446ce82 100644
> > > --- a/arch/arm64/include/asm/linkage.h
> > > +++ b/arch/arm64/include/asm/linkage.h
> > > @@ -5,8 +5,14 @@
> > >  #include <asm/assembler.h>
> > >  #endif
> > >  
> > > -#define __ALIGN		.align 2
> > > -#define __ALIGN_STR	".align 2"
> > > +#if CONFIG_FUNCTION_ALIGNMENT > 0
> > > +#define ARM64_FUNCTION_ALIGNMENT	CONFIG_FUNCTION_ALIGNMENT
> > > +#else
> > > +#define ARM64_FUNCTION_ALIGNMENT	4
> > > +#endif
> > > +
> > > +#define __ALIGN		.balign ARM64_FUNCTION_ALIGNMENT
> > > +#define __ALIGN_STR	".balign " #ARM64_FUNCTION_ALIGNMENT
> > 
> > Isn't that much the same as having ARM64 select FUNCTION_ALIGNMENT_4B
> > and simply removing all these lines and relying on the default
> > behaviour?
> 
> There's a proposal (with some rough performance claims) to select
> FUNCTION_ALIGNMENT_16B over at:
> 
> https://lore.kernel.org/r/20221208053649.540891-1-almasrymina@google.com
> 
> so we could just go with that?

I reckon it'd be worth having that as a separate patch atop, to split the
infrastructure from the actual change, but I'm happy to go with 16B immediately
if you'd prefer.

It'd be nice if we could get some numbers...

Thanks,
Mark.
