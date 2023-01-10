Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D74663B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbjAJIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbjAJIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:46:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E6C726F5;
        Tue, 10 Jan 2023 00:46:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA62FAD7;
        Tue, 10 Jan 2023 00:46:52 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47043F587;
        Tue, 10 Jan 2023 00:46:04 -0800 (PST)
Message-ID: <c6b506d6-0dc8-8cc6-7260-804e341e5103@arm.com>
Date:   Tue, 10 Jan 2023 14:16:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 5/8] perf: arm_spe: Use new PMSIDR_EL1 register enums
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
 <20220825-arm-spe-v8-7-v4-5-327f860daf28@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v4-5-327f860daf28@kernel.org>
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
> Now that the SPE register definitions include enums for some PMSIDR_EL1
> fields, use them in the driver in place of magic values.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v4:
>  - Rebase on v6.2-rc1
> v3: New patch
> ---
>  drivers/perf/arm_spe_pmu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 9b4bd72087ea..af6d3867c3e7 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -1006,32 +1006,32 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  	/* This field has a spaced out encoding, so just use a look-up */
>  	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
>  	switch (fld) {
> -	case 0:
> +	case PMSIDR_EL1_INTERVAL_256:
>  		spe_pmu->min_period = 256;
>  		break;
> -	case 2:
> +	case PMSIDR_EL1_INTERVAL_512:
>  		spe_pmu->min_period = 512;
>  		break;
> -	case 3:
> +	case PMSIDR_EL1_INTERVAL_768:
>  		spe_pmu->min_period = 768;
>  		break;
> -	case 4:
> +	case PMSIDR_EL1_INTERVAL_1024:
>  		spe_pmu->min_period = 1024;
>  		break;
> -	case 5:
> +	case PMSIDR_EL1_INTERVAL_1536:
>  		spe_pmu->min_period = 1536;
>  		break;
> -	case 6:
> +	case PMSIDR_EL1_INTERVAL_2048:
>  		spe_pmu->min_period = 2048;
>  		break;
> -	case 7:
> +	case PMSIDR_EL1_INTERVAL_3072:
>  		spe_pmu->min_period = 3072;
>  		break;
>  	default:
>  		dev_warn(dev, "unknown PMSIDR_EL1.Interval [%d]; assuming 8\n",
>  			 fld);
>  		fallthrough;
> -	case 8:
> +	case PMSIDR_EL1_INTERVAL_4096:
>  		spe_pmu->min_period = 4096;
>  	}
>  
> @@ -1050,10 +1050,10 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  		dev_warn(dev, "unknown PMSIDR_EL1.CountSize [%d]; assuming 2\n",
>  			 fld);
>  		fallthrough;
> -	case 2:
> +	case PMSIDR_EL1_COUNTSIZE_12_BIT_SAT:
>  		spe_pmu->counter_sz = 12;
>  		break;
> -	case 3:
> +	case PMSIDR_EL1_COUNTSIZE_16_BIT_SAT:
>  		spe_pmu->counter_sz = 16;
>  	}
>  
> 
