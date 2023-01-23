Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4814D6784E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjAWSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjAWS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A627830EB9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:29:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DCAC14;
        Mon, 23 Jan 2023 10:29:40 -0800 (PST)
Received: from [10.57.89.237] (unknown [10.57.89.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DDDD3F71E;
        Mon, 23 Jan 2023 10:28:56 -0800 (PST)
Message-ID: <535c160a-855d-f6c4-7bd0-1c63958c77fd@arm.com>
Date:   Mon, 23 Jan 2023 18:28:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/arm-cmn: Check all the DTCs when reading global
 counters
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>, will@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
References: <20230121021045.47595-1-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230121021045.47595-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-21 02:10, Ilkka Koskinen wrote:
> Some events may be available on nodes, none of which belongs to DTC0.
> When the driver reads the global counters, it stops as soon as it finds a
> DTC that's not being used and, thus, ignores the rest. As the driver
> doesn't read the paired global counters, overflowing local counters are
> regarded as overflowing global counters (assuming the new local counter
> value is smaller than the previous one) and therefore we can see values
> around 2^64. Fix the issue by checking all the used DTCs.
> 
> The driver is still trying to find a counter that's available on all the
> DTCs rather than doing per-DTC allocation of global counters. We may
> need to change it in the future, if needed.

Urgh, this is probably the same thing that came to me via Arm support 
from another customer just recently as well... I'd been waiting to get a 
bit more diagnostic information back to figure out what to look for, but 
  you've made it clear now, thanks.

If you don't mind, for now I think I'd rather go with a simpler option, 
which I shall post momentarily...

Cheers,
Robin.

> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 41 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b80a9b74662b..c516f091a002 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -540,7 +540,7 @@ struct arm_cmn_hw_event {
>   	struct arm_cmn_node *dn;
>   	u64 dtm_idx[4];
>   	unsigned int dtc_idx;
> -	u8 dtcs_used;
> +	unsigned long dtcs_used;
>   	u8 num_dns;
>   	u8 dtm_offset;
>   	bool wide_sel;
> @@ -550,6 +550,9 @@ struct arm_cmn_hw_event {
>   #define for_each_hw_dn(hw, dn, i) \
>   	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
>   
> +#define for_each_used_dtc(hw, cmn, i) \
> +	for_each_set_bit(i, &(hw)->dtcs_used, (cmn)->num_dtcs)
> +
>   static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
>   {
>   	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
> @@ -1272,7 +1275,7 @@ static void arm_cmn_init_counter(struct perf_event *event)
>   	unsigned int i, pmevcnt = CMN_DT_PMEVCNT(hw->dtc_idx);
>   	u64 count;
>   
> -	for (i = 0; hw->dtcs_used & (1U << i); i++) {
> +	for_each_used_dtc(hw, cmn, i) {
>   		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + pmevcnt);
>   		cmn->dtc[i].counters[hw->dtc_idx] = event;
>   	}
> @@ -1301,7 +1304,7 @@ static void arm_cmn_event_read(struct perf_event *event)
>   	delta = new - prev;
>   
>   	local_irq_save(flags);
> -	for (i = 0; hw->dtcs_used & (1U << i); i++) {
> +	for_each_used_dtc(hw, cmn, i) {
>   		new = arm_cmn_read_counter(cmn->dtc + i, hw->dtc_idx);
>   		delta += new << 16;
>   	}
> @@ -1614,10 +1617,32 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   	}
>   	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
>   
> -	for (i = 0; hw->dtcs_used & (1U << i); i++)
> +	for_each_used_dtc(hw, cmn, i)
>   		cmn->dtc[i].counters[hw->dtc_idx] = NULL;
>   }
>   
> +static int arm_cmn_get_global_counter(struct arm_cmn *cmn,
> +				      struct arm_cmn_hw_event *hw)
> +{
> +	int dtc_idx, i;
> +	bool available;
> +
> +	for (dtc_idx = 0; dtc_idx < CMN_DT_NUM_COUNTERS; dtc_idx++) {
> +		available = true;
> +		for_each_used_dtc(hw, cmn, i) {
> +			if (cmn->dtc[i].counters[dtc_idx]) {
> +				available = false;
> +				break;
> +			}
> +		}
> +
> +		if (available)
> +			return dtc_idx;
> +	}
> +
> +	return -ENOSPC;
> +}
> +
>   static int arm_cmn_event_add(struct perf_event *event, int flags)
>   {
>   	struct arm_cmn *cmn = to_cmn(event->pmu);
> @@ -1642,11 +1667,9 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   		return 0;
>   	}
>   
> -	/* Grab a free global counter first... */
> -	dtc_idx = 0;
> -	while (dtc->counters[dtc_idx])
> -		if (++dtc_idx == CMN_DT_NUM_COUNTERS)
> -			return -ENOSPC;
> +	dtc_idx = arm_cmn_get_global_counter(cmn, hw);
> +	if (dtc_idx < 0)
> +		return dtc_idx;
>   
>   	hw->dtc_idx = dtc_idx;
>   
