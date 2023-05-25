Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A127C7107E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjEYItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEYIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:48:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301BC9E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:48:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE7A61FB;
        Thu, 25 May 2023 01:49:41 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60BAD3F67D;
        Thu, 25 May 2023 01:48:55 -0700 (PDT)
Message-ID: <2898744e-1a67-5a8f-6adc-462d7f362b93@arm.com>
Date:   Thu, 25 May 2023 14:18:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64/cpufeature: Use helper for ECV CNTPOFF cpufeature
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230523-arm64-ecv-helper-v1-1-506dfb5fb199@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230523-arm64-ecv-helper-v1-1-506dfb5fb199@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/23 03:19, Mark Brown wrote:
> The newly added support for ECV CNTPOFF open codes the recently added
> helper ARM64_CPUID_FIELDS(), make use of the helper.  No functional
> change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7d7128c65161..27326f35b646 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2235,11 +2235,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_HAS_ECV_CNTPOFF,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  		.matches = has_cpuid_feature,
> -		.sys_reg = SYS_ID_AA64MMFR0_EL1,
> -		.field_pos = ID_AA64MMFR0_EL1_ECV_SHIFT,
> -		.field_width = 4,
> -		.sign = FTR_UNSIGNED,
> -		.min_field_value = ID_AA64MMFR0_EL1_ECV_CNTPOFF,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, ECV, CNTPOFF)
>  	},
>  #ifdef CONFIG_ARM64_PAN
>  	{
> 
> ---
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> change-id: 20230523-arm64-ecv-helper-c1665690b8b0
> 
> Best regards,
