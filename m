Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4A664DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAJUsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjAJUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:43:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7F4D72E;
        Tue, 10 Jan 2023 12:43:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD6DB819AA;
        Tue, 10 Jan 2023 20:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A5BC433D2;
        Tue, 10 Jan 2023 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673383406;
        bh=W4MoENF/ZOiCtEvF2sFd7AEBeWJSmcxY8vS9xvYYyAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0l+GfmccPc59TMwfpjWMzXm46RrWGT66OgnGrYEF1zsssiS20y8X1VXaXzfn2/t/
         Fyj9pcyU3crMJbdwuTJOyQsdIYaT+GJPlPufw4AKNfdgG5o+ZErWBrEDsJ05He2epL
         6VOw34eBe+4QCrvucf3Gl6tYmebkoWDycRgntnZXRiDiaRhbFrXsDaOgFMJv974Q54
         J66tAbM0lb38UVPoCI/XNozRfBGEziaiBuaP4ei4YD0Mmu2bVn2HPlth28tvijc5a7
         dJsQtLMBtfOWv/VibgLhTowXA1hcU52p/Irg7bCEwDpdxdNFtI1A/hFfAmvMr6NMpY
         9ZMEJeaCnAJJQ==
Date:   Tue, 10 Jan 2023 20:43:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org
Subject: Re: [PATCH 3/8] arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
Message-ID: <20230110204320.GA9739@willie-the-truck>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-4-mark.rutland@arm.com>
 <Y73MBswL76Hi9cay@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73MBswL76Hi9cay@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:35:18PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 09, 2023 at 01:58:23PM +0000, Mark Rutland wrote:
> 
> > diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> > index 1436fa1cde24d..df18a3446ce82 100644
> > --- a/arch/arm64/include/asm/linkage.h
> > +++ b/arch/arm64/include/asm/linkage.h
> > @@ -5,8 +5,14 @@
> >  #include <asm/assembler.h>
> >  #endif
> >  
> > -#define __ALIGN		.align 2
> > -#define __ALIGN_STR	".align 2"
> > +#if CONFIG_FUNCTION_ALIGNMENT > 0
> > +#define ARM64_FUNCTION_ALIGNMENT	CONFIG_FUNCTION_ALIGNMENT
> > +#else
> > +#define ARM64_FUNCTION_ALIGNMENT	4
> > +#endif
> > +
> > +#define __ALIGN		.balign ARM64_FUNCTION_ALIGNMENT
> > +#define __ALIGN_STR	".balign " #ARM64_FUNCTION_ALIGNMENT
> 
> Isn't that much the same as having ARM64 select FUNCTION_ALIGNMENT_4B
> and simply removing all these lines and relying on the default
> behaviour?

There's a proposal (with some rough performance claims) to select
FUNCTION_ALIGNMENT_16B over at:

https://lore.kernel.org/r/20221208053649.540891-1-almasrymina@google.com

so we could just go with that?

Will
