Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00654625923
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiKKLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKKLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:15:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282E6711D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:15:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC551B825C4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C66C433C1;
        Fri, 11 Nov 2022 11:15:17 +0000 (UTC)
Date:   Fri, 11 Nov 2022 11:15:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
Message-ID: <Y24uvyDJU3CL1jOi@arm.com>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com>
 <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
 <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:58:16PM +0530, Amit Pundir wrote:
> On Tue, 25 Oct 2022 at 18:08, Amit Pundir <amit.pundir@linaro.org> wrote:
> > On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> > > > On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > Will Deacon (2):
> > > > >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> > > >
> > > > This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> > > > relevant crash in the attached log and device silently reboots into
> > > > USB crash dump mode. The crash is fairly reproducible on db845c. I
> > > > could trigger it twice in 5 reboots and it always crash at the same
> > > > point during the boot process. Reverting this patch fixes the crash.
> > > >
> > > > I'm happy to test run any debug patche(s), that would help narrow
> > > > down this breakage.
[...]
> > Further narrowed down the breakage to the userspace daemon rmtfs
> > https://github.com/andersson/rmtfs. Is there anything specific in the
> > userspace code that I should be paying attention to?

Since you don't see anything in the logs like a crash and the system
restarts, I suspect it's some deadlock and that's triggering the
watchdog. We have an erratum (826319) but that's for Cortex-A53. IIUC
SDM845 has Kryo 3xx series which based on some random google searches is
derived from A75/A55. Unfortunately the MIDR_EL1 register doesn't match
the Arm Ltd numbering, so I have no idea what CPUs these are by looking
at the boot log.

I wouldn't be surprised if you hit a similar bug, though I couldn't find
anything close in the A55 errata notice.

While we could revert commit c44094eee32f ("arm64: dma: Drop cache
invalidation from arch_dma_prep_coherent()"), if you hit a real hardware
issue it may trigger in other scenario where we only do cache cleaning
(without invalidate), like arch_sync_dma_for_device(). So I'd rather get
to the bottom of this and potentially enable the workaround for this
chipset.

You could give it a quick try to by adding the MIDR ranges for SDM845 to
struct midr_range workaround_clean_cache[].

After that I suggest you raise it with Qualcomm to investigate. Normally
we ask for an erratum number to enable a workaround and it's only
Qualcomm that can provide one here.

-- 
Catalin
