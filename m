Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEF640A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiLBQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:10:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92AACA5C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E2FDB821E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2FCC433D6;
        Fri,  2 Dec 2022 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669997410;
        bh=pY7GxkPoYDDAU3TZ6koKkSzCTbxeST3lXEvYEd5lxqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2iz181rBBRvc23kA2L1olkpMyRP2SNz+tVYU+5vXH9vDD1q5YMzFYv+wAlPxdaqfM
         umrK2KdRvxPxb9mZf65PwgfIG1gkRsud0Y93/MeYQA1ZaZ7aIOWlUEyxCCEY1+pAk6
         dEecQvwg8Qc1zo9nKRfVkna20J+Obh+1wURMz5Qk=
Date:   Fri, 2 Dec 2022 17:10:07 +0100
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
Message-ID: <Y4ojXyXMX2p+RVBR@kroah.com>
References: <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
 <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
> On 02.12.22 11:03, Will Deacon wrote:
> > On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> >> On 02.12.22 09:26, Amit Pundir wrote:
> >>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>>>
> >>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> >>>>> Has any progress been made to fix this regression? It afaics is not a
> >>>>> release critical issue, but well, it still would be nice to get this
> >>>>> fixed before 6.1 is released.
> >>>>
> >>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> >>>> that exposed the driver bug. It doesn't fix the actual bug, it only
> >>>> makes it less likely to happen.
> >>>>
> >>>> I like the original commit removing the cache invalidation as it shows
> >>>> drivers not behaving properly
> >>
> >> Yeah, I understand that, but I guess it's my job to ask at this point:
> >> "is continuing to live with the old behavior for one or two more cycles"
> >> that much of a problem"?
> > 
> > That wouldn't be a problem. The problem is that I haven't see any efforts
> > from the Qualcomm side to actually fix the drivers [...]
> 
> Thx for sharing the details. I can fully understand your pain. But well,
> in the end it looks to me like this commit it intentionally breaking
> something that used to work -- which to my understanding of the "no
> regression rule" is not okay, even if things only worked by chance and
> not flawless.

"no regressions" for userspace code, this is broken, out-of-tree driver
code, right?  I do not think any in-kernel drivers have this issue today
from what I can tell, but if I am wrong here, please let me know.

We don't keep stable apis, or even functionality, for out-of-tree kernel
code as that would be impossible for us to do for obvious reasons.

thanks,

greg kh
