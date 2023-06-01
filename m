Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058671A279
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFAPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFAPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:24:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12232E2;
        Thu,  1 Jun 2023 08:24:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F7FA1063;
        Thu,  1 Jun 2023 08:24:52 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 444463F663;
        Thu,  1 Jun 2023 08:24:05 -0700 (PDT)
Message-ID: <e15f1773-e843-3bc3-f265-65524ea3385a@arm.com>
Date:   Thu, 1 Jun 2023 16:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for
 Ampere SoC PMU
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
 <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
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
[...]
> +static bool ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
> +					struct perf_event *new)
> +{
> +	struct perf_event *curr;
> +	unsigned int idx;
> +	u32 threshold = 0, rank = 0, bank = 0;
> +
> +	/* We compare the global filter settings to existing events */
> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
> +			     cspmu->cycle_counter_logical_idx);
> +
> +	/* This is the first event */
> +	if (idx == cspmu->cycle_counter_logical_idx)
> +		return true;
> +
> +	curr = cspmu->hw_events.events[idx];
> +
> +	if (get_filter_enable(new)) {
> +		threshold	= get_threshold(new);
> +		rank		= get_rank(new);
> +		bank		= get_bank(new);
> +	}
> +
> +	if (get_filter_enable(new) != get_filter_enable(curr) ||

Is there any useful purpose in allowing the user to specify nonzero 
rank, bank or threshold values with filter_enable=0? Assuming not, then 
between this and ampere_cspmu_set_ev_filter() it appears that you don't 
need filter_enable at all.

Thanks,
Robin.

> +	    get_threshold(curr) != threshold ||
> +	    get_rank(curr) != rank ||
> +	    get_bank(curr) != bank)
> +		return false;
> +
> +	return true;
> +}
