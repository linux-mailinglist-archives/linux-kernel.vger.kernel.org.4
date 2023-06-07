Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA7725366
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjFGFeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjFGFeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:34:01 -0400
X-Greylist: delayed 136322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 22:33:59 PDT
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461A19BD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:33:59 -0700 (PDT)
Date:   Wed, 7 Jun 2023 05:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686116037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKbA0mls5g+nAhVBAv/6T7uMneQtU0Cj+96AOZemPpU=;
        b=GkkVkEOoVgEvLdZTvT58H5xMEOeZW/DtyDe0QWxpx3uAzaoAwrst9aEEfYCHH3Mn2M0q+E
        NmJIQTy2a3LYs/PxixXfJaRxphU0zv7LL4E8vo8r9RTY9eHlo3gsocg3jAOm9+0GyYUEq7
        gNQY1Vl0ko5UpM9+UeQAelbYd0oYbGo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZIAWwXp4IQUIlCzq@linux.dev>
References: <20230606114927.227a66a5@canb.auug.org.au>
 <20230607110521.442280f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607110521.442280f9@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:05:21AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 6 Jun 2023 11:49:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the kvm-arm tree got a conflict in:
> > 
> >   arch/arm64/kernel/cpufeature.c
> > 
> > between commits:
> > 
> >   b7564127ffcb ("arm64: mops: detect and enable FEAT_MOPS")
> >   c1fa32c8f189 ("arm64: cpufeature: add TCR2 cpucap")
> >   b5a8e35236ee ("arm64: cpufeature: add Permission Indirection Extension cpucap")
> > 
> > from the arm64 tree and commit:
> > 
> >   c876c3f182a5 ("KVM: arm64: Relax trapping of CTR_EL0 when FEAT_EVT is available")
> > 
> > from the kvm-arm tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Commit b5a8e35236ee changed a bit, so the new resolution is below.

LGTM, thanks Stephen.

Catalin, I'm  only planning on dragging in the MOPS branch as needed
due to some more involved conflicts that'll arise from KVM ID register
changes. Otherwise the resolution seems trivial enough and doesn't need
to be explicitly dealt with. Still learning the ropes, so all ears if
anyone disagrees :)

> diff --cc arch/arm64/kernel/cpufeature.c
> index c3bdb14bb4bd,4a2ab3f366de..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -2662,27 -2641,17 +2662,38 @@@ static const struct arm64_cpu_capabilit
>   		.cpu_enable = cpu_enable_dit,
>   		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, DIT, IMP)
>   	},
>  +	{
>  +		.desc = "Memory Copy and Memory Set instructions",
>  +		.capability = ARM64_HAS_MOPS,
>  +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		.cpu_enable = cpu_enable_mops,
>  +		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, MOPS, IMP)
>  +	},
>  +	{
>  +		.capability = ARM64_HAS_TCR2,
>  +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, TCRX, IMP)
>  +	},
>  +	{
>  +		.desc = "Stage-1 Permission Indirection Extension (S1PIE)",
>  +		.capability = ARM64_HAS_S1PIE,
>  +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1PIE, IMP)
>  +	},
> + 	{
> + 		.desc = "Enhanced Virtualization Traps",
> + 		.capability = ARM64_HAS_EVT,
> + 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> + 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
> + 		.sign = FTR_UNSIGNED,
> + 		.field_pos = ID_AA64MMFR2_EL1_EVT_SHIFT,
> + 		.field_width = 4,
> + 		.min_field_value = ID_AA64MMFR2_EL1_EVT_IMP,
> + 		.matches = has_cpuid_feature,
> + 	},
>   	{},
>   };
>   

-- 
Thanks,
Oliver
