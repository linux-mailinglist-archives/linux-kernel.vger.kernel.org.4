Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A188640ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiLBQdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiLBQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7674508C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166246233A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF39AC433D6;
        Fri,  2 Dec 2022 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669998774;
        bh=pQ7g0nDMOMcY6daJmycAqY67TFIHNGmsVxECzKIRMaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1s3wulxVdXIVq63bb87WUMUUL+XldGTyL7zWeuy5CHBc6+Xspp0QWBY2C5xcWatCl
         88nRgRjSA9XlLB0ROROfY4ObT2oVdXFa2PfqLdv2SaUZj7ufAVg7d0eiVPBw9d7gB9
         45ZkQaeX5l/ZydAUSGRq8i0AvssFWLnFfapK05P4=
Date:   Fri, 2 Dec 2022 17:32:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Will Deacon <will@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <Y4oos/xXL+tLT7E7@kroah.com>
References: <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
 <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
 <Y4ojXyXMX2p+RVBR@kroah.com>
 <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:27:24PM +0100, Thorsten Leemhuis wrote:
> 
> 
> On 02.12.22 17:10, Greg KH wrote:
> > On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
> >> On 02.12.22 11:03, Will Deacon wrote:
> >>> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> >>>> On 02.12.22 09:26, Amit Pundir wrote:
> >>>>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>>>>>
> >>>>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> >>>>>>> Has any progress been made to fix this regression? It afaics is not a
> >>>>>>> release critical issue, but well, it still would be nice to get this
> >>>>>>> fixed before 6.1 is released.
> >>>>>>
> >>>>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> >>>>>> that exposed the driver bug. It doesn't fix the actual bug, it only
> >>>>>> makes it less likely to happen.
> >>>>>>
> >>>>>> I like the original commit removing the cache invalidation as it shows
> >>>>>> drivers not behaving properly
> >>>>
> >>>> Yeah, I understand that, but I guess it's my job to ask at this point:
> >>>> "is continuing to live with the old behavior for one or two more cycles"
> >>>> that much of a problem"?
> >>>
> >>> That wouldn't be a problem. The problem is that I haven't see any efforts
> >>> from the Qualcomm side to actually fix the drivers [...]
> >>
> >> Thx for sharing the details. I can fully understand your pain. But well,
> >> in the end it looks to me like this commit it intentionally breaking
> >> something that used to work -- which to my understanding of the "no
> >> regression rule" is not okay, even if things only worked by chance and
> >> not flawless.
> > 
> > "no regressions" for userspace code, this is broken, out-of-tree driver
> > code, right?
> 
> If so: apologies. But that's not the impression I got, as Amit wrote "I
> can reproduce this crash on vanilla v6.1-rc1 as well with no out-of-tree
> drivers." here:
> https://lore.kernel.org/linux-arm-kernel/CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com/

Ah, I missed that.

Ok, what in-tree drivers are having problems being buggy?  I can't seem
to figure that out from that report at all.  Does anyone know?

thanks,

greg k-h
