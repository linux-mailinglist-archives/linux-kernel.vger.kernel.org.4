Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBB635AED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiKWLFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbiKWLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:04:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64E26101E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:01:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A274C1FB;
        Wed, 23 Nov 2022 03:01:38 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.7.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7063F587;
        Wed, 23 Nov 2022 03:01:30 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:01:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, yusongping@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: armv8_deprecated: fix unused-function error
Message-ID: <Y339iLo9KQslAWht@FVFF77S0Q05N>
References: <20221122032010.202956-1-renzhijie2@huawei.com>
 <Y3z9dEkMdCeWAWq0@FVFF77S0Q05N.cambridge.arm.com>
 <28a90ac0-dc8f-f0dd-74d8-d2884e2cbd30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28a90ac0-dc8f-f0dd-74d8-d2884e2cbd30@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:06:03AM +0800, Ren Zhijie wrote:
> 
> 在 2022/11/23 0:48, Mark Rutland 写道:
> > On Tue, Nov 22, 2022 at 03:20:10AM +0000, Ren Zhijie wrote:
> > > If CONFIG_SWP_EMULATION is not set and
> > > CONFIG_CP15_BARRIER_EMULATION is not set,
> > > aarch64-linux-gnu complained about unused-function :
> > > 
> > > arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
> > >   static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
> > >                       ^~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > 
> > > To fix this error, warp the definition of
> > > aarch32_check_condition() by defined(CONFIG_SWP_EMULATION) ||
> > > defined(CONFIG_CP15_BARRIER_EMULATION)
> > > 
> > > Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
> > This also depends on building with additional options to turn warnings into
> > errors, no?
> 
> No，i just run the normal command as follow:
> 
> make ARCH="arm64" CROSS_COMPILE="aarch64-linux-gnu-"

I think you must also have CONFIG_WERROR enabled?

Just building defconfig + CONFIG_ARMV8_DEPRECATED=y gives me a warning, but not
an error, and the kernel builds just fine.

So this is a problem to fix, and I appreciate that in test configs this might
be broken, but it's not a full build-time failure for most users.

Thanks,
Mark.

> > > Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> > > ---
> > >   arch/arm64/kernel/armv8_deprecated.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> > > index ed0788cf6bbb..3f29ceb6653a 100644
> > > --- a/arch/arm64/kernel/armv8_deprecated.c
> > > +++ b/arch/arm64/kernel/armv8_deprecated.c
> > > @@ -64,6 +64,7 @@ struct insn_emulation {
> > >   #define	ARM_OPCODE_CONDITION_UNCOND	0xf
> > > +#if defined(CONFIG_SWP_EMULATION) || defined(CONFIG_CP15_BARRIER_EMULATION)
> > >   static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
> > >   {
> > >   	u32 cc_bits  = opcode >> 28;
> > > @@ -76,6 +77,7 @@ static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
> > >   	}
> > >   	return ARM_OPCODE_CONDTEST_UNCOND;
> > >   }
> > > +#endif
> > Could we mark this as '__maybe_unused' or 'inline' instead? I think that's
> > preferable to the ifdeferry.
> 
> sure, i will use __maybe_unused in v2.
> 
> Thanks,
> 
> Ren.
> 
> > Thanks,
> > Mark.
> > 
> > >   #ifdef CONFIG_SWP_EMULATION
> > >   /*
> > > -- 
> > > 2.17.1
> > > 
> > .
