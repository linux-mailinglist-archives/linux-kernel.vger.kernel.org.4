Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF8642A57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiLEOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiLEOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:24:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E2E2D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4822DB810D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D42C433C1;
        Mon,  5 Dec 2022 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670250249;
        bh=Ga1etePyywTh7KmP0kVhAXuTI89MxsurxbY+ShnzFMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBS5OGYjBDCqLhKn2ikLcA3iPA78DIFQIx1ERbXTm8VxByd90B77rdrQZYlsXDqyz
         fIhV0GHswf8xkdaneiwAyYows42xJfmAAC0/CWORW7kJRCfK2hEJn4XCmb0U9HXEXk
         YUIlwB12B7xzFjdLHlXtelUYw6XeIeZupZzLJGKymtPAwCjIZc9A65G7xcoXTsmhoK
         ff/RrGZ9d9ZHPpAkr4QbrgWtUIbIXEGVGEG8aglQJJYlAzk9+ttVOVGNqaolrUmf3j
         eAtFzbkJolHQ61YBYdtX8L06Nixc31ZnYUw/YDzlGilk7kfAVwqELccK/XRcOHh1hm
         Va4mFquebUqMw==
Date:   Mon, 5 Dec 2022 14:24:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221205142402.GA31783@willie-the-truck>
References: <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
 <Y4ojXyXMX2p+RVBR@kroah.com>
 <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
 <Y4oos/xXL+tLT7E7@kroah.com>
 <20221202171437.GH5356@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202171437.GH5356@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:44:37PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 02, 2022 at 05:32:51PM +0100, Greg KH wrote:
> > On Fri, Dec 02, 2022 at 05:27:24PM +0100, Thorsten Leemhuis wrote:
> > > On 02.12.22 17:10, Greg KH wrote:
> > > > On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
> > > >> On 02.12.22 11:03, Will Deacon wrote:
> > > >>> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> > > >>>> On 02.12.22 09:26, Amit Pundir wrote:
> > > >>>>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >>>>>>
> > > >>>>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> > > >>>>>>> Has any progress been made to fix this regression? It afaics is not a
> > > >>>>>>> release critical issue, but well, it still would be nice to get this
> > > >>>>>>> fixed before 6.1 is released.
> > > >>>>>>
> > > >>>>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> > > >>>>>> that exposed the driver bug. It doesn't fix the actual bug, it only
> > > >>>>>> makes it less likely to happen.
> > > >>>>>>
> > > >>>>>> I like the original commit removing the cache invalidation as it shows
> > > >>>>>> drivers not behaving properly
> > > >>>>
> > > >>>> Yeah, I understand that, but I guess it's my job to ask at this point:
> > > >>>> "is continuing to live with the old behavior for one or two more cycles"
> > > >>>> that much of a problem"?
> > > >>>
> > > >>> That wouldn't be a problem. The problem is that I haven't see any efforts
> > > >>> from the Qualcomm side to actually fix the drivers [...]
> > > >>
> > > >> Thx for sharing the details. I can fully understand your pain. But well,
> > > >> in the end it looks to me like this commit it intentionally breaking
> > > >> something that used to work -- which to my understanding of the "no
> > > >> regression rule" is not okay, even if things only worked by chance and
> > > >> not flawless.
> > > > 
> > > > "no regressions" for userspace code, this is broken, out-of-tree driver
> > > > code, right?
> > > 
> > > If so: apologies. But that's not the impression I got, as Amit wrote "I
> > > can reproduce this crash on vanilla v6.1-rc1 as well with no out-of-tree
> > > drivers." here:
> > > https://lore.kernel.org/linux-arm-kernel/CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com/
> > 
> > Ah, I missed that.
> > 
> > Ok, what in-tree drivers are having problems being buggy?  I can't seem
> > to figure that out from that report at all.  Does anyone know?
> > 
> 
> It is the Qualcomm Q6V5_MSS remoteproc driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_mss.c
> 
> Qualcomm is working on the fix but the patches are not ready yet. So if we can
> get this patch reverted in the meantime, that would be helpful.

It's good to hear that you're working to fix this, even if it's happening
behind closed doors. Do you have a rough idea how soon you'll be able to
post the remoteproc driver fixes? That would help us to figure out when
to bring back the change if we were to revert it.

Cheers,

Will
