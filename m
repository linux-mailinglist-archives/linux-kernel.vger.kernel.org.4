Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52532663C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjAJJAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjAJI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:58:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5921C68786;
        Tue, 10 Jan 2023 00:54:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1557165C;
        Tue, 10 Jan 2023 00:55:13 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 513603F587;
        Tue, 10 Jan 2023 00:54:25 -0800 (PST)
Message-ID: <895daf8d-3303-ac70-16ab-76bead23d389@arm.com>
Date:   Tue, 10 Jan 2023 14:24:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 6/8] perf: arm_spe: Support new SPEv1.2/v8.7 'not
 taken' event
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
 <20220825-arm-spe-v8-7-v4-6-327f860daf28@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v4-6-327f860daf28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 00:56, Rob Herring wrote:
> Arm SPEv1.2 (Armv8.7/v9.2) adds a new event, 'not taken', in bit 6 of
> the PMSEVFR_EL1 register. Update arm_spe_pmsevfr_res0() to support the
> additional event.
> 
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v4:
>  - Rebase on v6.2-rc1
> v3:
>  - No change
> v2:
>  - Update for v6.1 sysreg generated header changes
> ---
>  arch/arm64/include/asm/sysreg.h | 2 ++
>  drivers/perf/arm_spe_pmu.c      | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index db269eda7c1c..fc8787727792 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -221,6 +221,8 @@
>  	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
>  #define PMSEVFR_EL1_RES0_V1P1	\
>  	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
> +#define PMSEVFR_EL1_RES0_V1P2	\
> +	(PMSEVFR_EL1_RES0_V1P1 & ~BIT_ULL(6))
>  
>  /* Buffer error reporting */
>  #define PMBSR_EL1_FAULT_FSC_SHIFT	PMBSR_EL1_MSS_SHIFT
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index af6d3867c3e7..82f67e941bc4 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -677,9 +677,11 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
>  	case ID_AA64DFR0_EL1_PMSVer_IMP:
>  		return PMSEVFR_EL1_RES0_IMP;
>  	case ID_AA64DFR0_EL1_PMSVer_V1P1:
> +		return PMSEVFR_EL1_RES0_V1P1;
> +	case ID_AA64DFR0_EL1_PMSVer_V1P2:
>  	/* Return the highest version we support in default */
>  	default:
> -		return PMSEVFR_EL1_RES0_V1P1;
> +		return PMSEVFR_EL1_RES0_V1P2;
>  	}
>  }
>  
> 
