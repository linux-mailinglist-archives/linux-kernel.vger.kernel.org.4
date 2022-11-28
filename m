Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798163A7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiK1MPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiK1MPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:15:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27E128E12;
        Mon, 28 Nov 2022 04:07:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D97CD6E;
        Mon, 28 Nov 2022 04:06:34 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.7.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DBFD3F73B;
        Mon, 28 Nov 2022 04:06:26 -0800 (PST)
Date:   Mon, 28 Nov 2022 12:06:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/perf: Replace PMU version number '0' with
 ID_AA64DFR0_EL1_PMUVer_NI
Message-ID: <Y4SkP5MgJ8OrjRvL@FVFF77S0Q05N>
References: <20221128025449.39085-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128025449.39085-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:24:49AM +0530, Anshuman Khandual wrote:
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

This looks fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll leave it to Will to pick this as his convenience.

Mark.

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
> 2.25.1
> 
