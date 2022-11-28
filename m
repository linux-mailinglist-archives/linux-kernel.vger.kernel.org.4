Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974F639FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK1DGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1DGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:06:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07D8AB7F2;
        Sun, 27 Nov 2022 19:06:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3A4D6E;
        Sun, 27 Nov 2022 19:06:28 -0800 (PST)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0833E3F73D;
        Sun, 27 Nov 2022 19:06:18 -0800 (PST)
Message-ID: <60767243-2f3e-a7aa-06e1-674e43f18e9c@arm.com>
Date:   Mon, 28 Nov 2022 08:36:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64/perf: Replace PMU version number '0' with
 ID_AA64DFR0_EL1_PMUVer_NI
To:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        Marc Zyngier <maz@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128025449.39085-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221128025449.39085-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/22 08:24, Anshuman Khandual wrote:
> __armv8pmu_probe_pmu() returns if detected PMU is either not implemented or
> implementation defined. Extracted ID_AA64DFR0_EL1_PMUVer value, when PMU is
> not implemented is '0' which can be replaced with ID_AA64DFR0_EL1_PMUVer_NI
> defined as '0b0000'.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc6
> 
>  arch/arm64/kernel/perf_event.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 85a3aaefc0fb..b638f584b4dd 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1188,7 +1188,8 @@ static void __armv8pmu_probe_pmu(void *info)
>  	dfr0 = read_sysreg(id_aa64dfr0_el1);
>  	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
>  			ID_AA64DFR0_EL1_PMUVer_SHIFT);
> -	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF || pmuver == 0)
> +	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
> +	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
>  		return;
>  
>  	cpu_pmu->pmuver = pmuver;
> --

+ Marc Zyngier <maz@kernel.org>

There are some KVM related pmuver not-implemented check as well, should they be
replaced in this patch or rather in a separate patch ?

arch/arm64/kvm/pmu-emul.c:      if (pmu->pmuver == 0 || pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
arch/arm64/kvm/pmu-emul.c:              if (pmu->pmuver == 0 ||
arch/arm64/kvm/pmu-emul.c:                  pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)

- Anshuman
