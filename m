Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633AE65C58C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbjACR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbjACR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:59:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB012747
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:59:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72760B8107B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B243C433EF;
        Tue,  3 Jan 2023 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768755;
        bh=BQBoYvfeaYrZ/ZnQHX8h/k1Ir4dAZykoRUflCWLpJfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkCE0jAhiVPssH7l8lOr8dQjbEUrpGkUrth2kWwRPYN1I+NLfcClNKp1sqla6Me7o
         SMHzi91kte32ChBAoysjwEBkuOuEy4DVBMIKXOyU+TJpc4t7nwPYbcH/ZF/dyYFrpO
         jp1FgiyAZPCQ7aBzo2V7BbfzWv/sc37DTDzyfNQ3yiETANpZV8/qT++PEHJChb13Fw
         DdBMt5VuYcUfHleNL8O95sq/f1YUwky4n9BmSJC/qIS1O2IeghkDvMhZGltZVeDLxu
         5SxNY1YP3++6tX/FGXkBkaJlPg0hcvEB+dmH39TvLUCIiEDj1XKHgmqXV46P01TNpQ
         5LBiMveMr6/bQ==
Date:   Tue, 3 Jan 2023 10:59:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Sven Peter <sven@svenpeter.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 1/3] KVM: arm64: vgic: Add Apple M2 cpus to the list of
 broken SEIS implementations
Message-ID: <Y7Rs8Lc5u6L2Bz6o@dev-arch.thelio-3990X>
References: <20230103095022.3230946-1-maz@kernel.org>
 <20230103095022.3230946-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103095022.3230946-2-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I have only been lurking on the kvmarm mailing list for a little bit and
it has mainly just been reading patches/review to get more familiar with
various virtualization concepts so I apologize if the following review
is rather shallow but...

On Tue, Jan 03, 2023 at 09:50:20AM +0000, Marc Zyngier wrote:
> I really hoped that Apple had fixed their not-quite-a-vgic implementation
> when moving from M1 to M2. Alas, it seems they didn't, and running
> a buggy EFI version results in the vgic generating SErrors outside
> of the guest and taking the host down.
> 
> Apply the same workaround as for M1. Yes, this is all a bit crap.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  arch/arm64/kvm/vgic/vgic-v3.c    | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 4e8b66c74ea2..683ca3af4084 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -124,6 +124,8 @@
>  #define APPLE_CPU_PART_M1_FIRESTORM_PRO	0x025
>  #define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
>  #define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
> +#define APPLE_CPU_PART_M2_BLIZZARD	0x032
> +#define APPLE_CPU_PART_M2_AVALANCHE	0x033
>  
>  #define AMPERE_CPU_PART_AMPERE1		0xAC3
>  
> @@ -177,6 +179,8 @@
>  #define MIDR_APPLE_M1_FIRESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_PRO)
>  #define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
>  #define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
> +#define MIDR_APPLE_M2_BLIZZARD MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD)
> +#define MIDR_APPLE_M2_AVALANCHE MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE)
>  #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
>  
>  /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> index 826ff6f2a4e7..c6442b08fe80 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> @@ -615,7 +615,8 @@ static const struct midr_range broken_seis[] = {
>  	MIDR_ALL_VERSIONS(MIDR_APPLE_M1_ICESTORM_PRO),
>  	MIDR_ALL_VERSIONS(MIDR_APPLE_M1_FIRESTORM_PRO),
>  	MIDR_ALL_VERSIONS(MIDR_APPLE_M1_ICESTORM_MAX),
> -	MIDR_ALL_VERSIONS(MIDR_APPLE_M1_FIRESTORM_MAX),

The commit message makes no note of this removal, was it intentional?
MIDR_APPLE_M1_FIRESTORM_MAX is only used here so I assume it is not.

> +	MIDR_ALL_VERSIONS(MIDR_APPLE_M2_BLIZZARD),
> +	MIDR_ALL_VERSIONS(MIDR_APPLE_M2_AVALANCHE),
>  	{},
>  };
>  
> -- 
> 2.34.1
> 

Cheers,
Nathan
