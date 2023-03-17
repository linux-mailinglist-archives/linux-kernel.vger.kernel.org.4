Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8D6BEB19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCQOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:25:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA1559CB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E325B825AA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D7C433EF;
        Fri, 17 Mar 2023 14:25:29 +0000 (UTC)
Date:   Fri, 17 Mar 2023 14:25:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] KVM: arm64: initialize HCRX_EL2
Message-ID: <ZBR4Vv9m11kEviDF@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-2-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-2-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:03PM +0000, Kristina Martsenko wrote:
> ARMv8.7/9.2 adds a new hypervisor configuration register HCRX_EL2.
> Initialize the register to a safe value (all fields 0), to be robust
> against firmware that has not initialized it.

I think the risk of firmware not initialising this register is small
given that EL3 needs to set SCR_EL3.HXEn to allow EL2 access. But it
doesn't hurt to re-initialise it in the hypervisor.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 212d93aca5e6..e06b34322339 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -572,6 +572,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	msr	hcr_el2, x0
>  	isb
>  
> +	mrs	x0, ID_AA64MMFR1_EL1
> +	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
> +	cbz	x0, 3f
> +	mov_q	x1, HCRX_HOST_FLAGS
> +	msr_s	SYS_HCRX_EL2, x1
> +	isb
> +3:
>  	init_el2_state

Nitpick: we can probably leave a single ISB after both HCR_EL2 and
HCRX_EL2 are initialised. Well, we could probably drop all of them
altogether, there's at least one down this path.

>  
>  	/* Hypervisor stub */
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index a6d67c2bb5ae..01f854697c70 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -95,6 +95,12 @@ SYM_CODE_START_LOCAL(___kvm_hyp_init)
>  	ldr	x1, [x0, #NVHE_INIT_HCR_EL2]
>  	msr	hcr_el2, x1
>  
> +	mrs	x1, ID_AA64MMFR1_EL1
> +	ubfx	x1, x1, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
> +	cbz	x1, 1f
> +	mov_q	x2, HCRX_HOST_FLAGS
> +	msr_s	SYS_HCRX_EL2, x2
> +1:

Maybe you could use a macro to avoid writing this sequence twice. I lost
track of the KVM initialisation refactoring since pKVM, it looks like
the other register values are loaded from a structure here. I guess a
value of 0 doesn't make sense to store (unless at a later point it
becomes non-zero).

-- 
Catalin
