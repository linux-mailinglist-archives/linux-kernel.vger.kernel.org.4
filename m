Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBE71A0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjFAOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:49:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C959E2;
        Thu,  1 Jun 2023 07:49:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC2D1063;
        Thu,  1 Jun 2023 07:50:04 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D493F663;
        Thu,  1 Jun 2023 07:49:17 -0700 (PDT)
Message-ID: <7269d265-154b-e79a-2622-287e149d85ad@arm.com>
Date:   Thu, 1 Jun 2023 15:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/5] perf: arm_cspmu: Support 32-bit accesses to 64-bit
 registers
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
 <20230601030144.3458136-2-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230601030144.3458136-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-01 04:01, Ilkka Koskinen wrote:
> Split the 64-bit register accesses if 64-bit access is not supported
> by the PMU.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
>   drivers/perf/arm_cspmu/arm_cspmu.h | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index a3f1c410b417..88547a2b73e6 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -701,8 +701,12 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
>   
>   	if (use_64b_counter_reg(cspmu)) {
>   		offset = counter_offset(sizeof(u64), event->hw.idx);
> -
> -		writeq(val, cspmu->base1 + offset);
> +		if (!cspmu->impl.split_64bit_access) {

Could we not just hang this off the 64-bit atomicity property to match 
the read path? It doesn't seem like there's much benefit in 
micro-optimising for whether the interconnect splits 64-bit accesses 
into 32-bit bursts vs. just not accepting them at all.

> +			writeq(val, cspmu->base1 + offset);
> +		} else {
> +			writel(lower_32_bits(val), cspmu->base1 + offset);
> +			writel(upper_32_bits(val), cspmu->base1 + offset + 4);

lo_hi_writeq() - the header's already included for 32-bit build 
coverage, so we may as well put it to use :)

Thanks,
Robin.

> +		}
>   	} else {
>   		offset = counter_offset(sizeof(u32), event->hw.idx);
>   
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..c0412cf2bd97 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -110,6 +110,7 @@ struct arm_cspmu_impl_ops {
>   /* Vendor/implementer descriptor. */
>   struct arm_cspmu_impl {
>   	u32 pmiidr;
> +	bool split_64bit_access;
>   	struct arm_cspmu_impl_ops ops;
>   	void *ctx;
>   };
