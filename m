Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C1640404
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLBKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiLBKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:04:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726112AA1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23E662240
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6FDC433D6;
        Fri,  2 Dec 2022 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669975444;
        bh=rjqoFQfT51QM7OSsPhsfBZCaCoI/Gtou7tN2REaATcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yd8QO8dca29gFjr8o0TcQQLD4EpMrueXx+HhKYqIC8k2L41lSK4rm8wCMoetISe5s
         0Iq1DzC0TuoDpfhRT1p7nnPQdjRyP6xSRPua+1DOxVtL6aoIwJGcAtA8DZL3LHU+V3
         TDamfp9WERl+1qtmx/wfbXSpqCgUHgY9NWrVZlssPpfESl8bkJET5ZWcYnh6njsBn7
         gkEKcc3y6lGb4jmAELp1xrDsxWK6pXTcmJ+k3mwHQJi21/WgTW15LRi3++c9C2k645
         yzNacAgy0NHS+UXGybFfnH4kz9uYxnpG7lIzeZfGCwBcuLj/8cWDWrvces2J0ojK7H
         pBSe1EM/Lbf6A==
Date:   Fri, 2 Dec 2022 10:03:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221202100357.GB29396@willie-the-truck>
References: <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
 <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> On 02.12.22 09:26, Amit Pundir wrote:
> > On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>
> >> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> >>> Has any progress been made to fix this regression? It afaics is not a
> >>> release critical issue, but well, it still would be nice to get this
> >>> fixed before 6.1 is released.
> >>
> >> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> >> that exposed the driver bug. It doesn't fix the actual bug, it only
> >> makes it less likely to happen.
> >>
> >> I like the original commit removing the cache invalidation as it shows
> >> drivers not behaving properly
> 
> Yeah, I understand that, but I guess it's my job to ask at this point:
> "is continuing to live with the old behavior for one or two more cycles"
> that much of a problem"?

That wouldn't be a problem. The problem is that I haven't see any efforts
from the Qualcomm side to actually fix the drivers so what makes you think
the issue will be addressed in one or two more cycles? On the other hand, if
there were patches out there trying to fix the drivers and we just needed to
revert this change to buy them some time, then that would obviously be the
right thing to do.

> >> but, as a workaround, we could add a
> >> command line option to force back the old behaviour (defaulting to the
> >> new one) until the driver is fixed.
> 
> Well, sometimes that approach is fine to fix a regression, but I'm not
> sure this is one of those situations, as this...
> 
> > We use DB845c extensively for mainline and android-mainline[1] testing
> > with AOSP, and it is broken for weeks now. So be it a temporary
> > workaround or a proper driver fix in place, we'd really appreciate a
> > quick fix here.
> 
> ...doesn't sound like we are not talking about some odd corner case
> here. But in the end that would be up to Linus to decide.

The issue is that these drivers are abusing the DMA API to manage buffers
which are being transferred to trustzone. Even with the revert, this is
broken (the CPU can speculate from the kernel's cacheable linear mapping
of memory), it just appears to be less likely with the CPUs on this SoC.
So we end up in a situation where the kernel is flakey on these devices
but with even less incentive for the drivers to be fixed.

As well as broken drivers, the patch has also identified broken device-tree
files where DMA-coherent devices weher incorrectly being treated as
non-coherent:

https://lore.kernel.org/linux-arm-kernel/20221124142501.29314-1-johan+linaro@kernel.org/

so I do think it's something that's worth having as the default behaviour.

> I'll point him to this thread once more in my weekly report anyway.
> Maybe I'll even suggest to revert this change, not sure yet.

As I said above, I think the revert makes sense if the drivers are actually
being fixed, but I'm not seeing any movement at all on that front.

Will
