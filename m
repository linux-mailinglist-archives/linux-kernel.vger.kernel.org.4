Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196E628344
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiKNOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiKNOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFA2669
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177A9611CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E2C433D6;
        Mon, 14 Nov 2022 14:54:31 +0000 (UTC)
Date:   Mon, 14 Nov 2022 14:54:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
Message-ID: <Y3JWpCV1LoScdJn1@arm.com>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com>
 <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
 <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
 <Y24uvyDJU3CL1jOi@arm.com>
 <20221111173952.GB5393@thinkpad>
 <20221111191820.GC5393@thinkpad>
 <20221114140903.GF30263@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114140903.GF30263@willie-the-truck>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:09:04PM +0000, Will Deacon wrote:
> On Sat, Nov 12, 2022 at 12:48:20AM +0530, Manivannan Sadhasivam wrote:
> > I digged a little further and found that the crash was due to the secure
> > processor (XPU) violation. It happens because, CPU tried acccessing the memory
> > after sharing it with the modem for firmware metadata validation.
[...]
> > Sibi tried fixing this problem earlier by using a hack in the remoteproc driver
> > [1], but I guess that got negated due to c44094eee32f?
> 
> Performing a clean rather than a clean+invalidate when the buffer is
> allocated (which is what is achieved by c44094eee32f) shouldn't affect
> this afaict.

I agree. The DMA_ATTR_NO_KERNEL_MAPPING used in the qcom_q6v5_mss fix
only ensures that there is no non-cacheable DMA mapping but we still
have the kernel linear map in place that may be accessed speculatively
by the CPU at any point. I can't tell why the clean+inval makes any
difference but I suspect it's a matter of time before you'd hit similar
conditions again (maybe not at boot).

-- 
Catalin
