Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644173953F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjFVCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFVCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:07:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD9471BFF;
        Wed, 21 Jun 2023 19:07:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694EE1063;
        Wed, 21 Jun 2023 19:08:26 -0700 (PDT)
Received: from [10.162.40.20] (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356A33F64C;
        Wed, 21 Jun 2023 19:07:37 -0700 (PDT)
Message-ID: <4dc97e9f-e103-9120-373d-8f4f472e8332@arm.com>
Date:   Thu, 22 Jun 2023 07:37:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V12 08/10] arm64/perf: Add struct brbe_regset helper
 functions
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230615133239.442736-1-anshuman.khandual@arm.com>
 <20230615133239.442736-9-anshuman.khandual@arm.com>
 <ZJL346ZgQRcHNA7E@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZJL346ZgQRcHNA7E@FVFF77S0Q05N>
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



On 6/21/23 18:45, Mark Rutland wrote:
> Hi Anshuman,
> 
> Thanks, this is looking much better; I just a have a couple of minor comments.
> 
> With those fixed up:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
> On Thu, Jun 15, 2023 at 07:02:37PM +0530, Anshuman Khandual wrote:
>> The primary abstraction level for fetching branch records from BRBE HW has
>> been changed as 'struct brbe_regset', which contains storage for all three
>> BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
>> happens in the task sched out path, or in the PMU IRQ handling path, these
>> registers need to be extracted from the HW. Afterwards both live and stored
>> sets need to be stitched together to create final branch records set. This
>> adds required helper functions for such operations.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_brbe.c | 127 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 127 insertions(+)
>>
>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
>> index 4729cb49282b..f6693699fade 100644
>> --- a/drivers/perf/arm_brbe.c
>> +++ b/drivers/perf/arm_brbe.c
>> @@ -44,6 +44,133 @@ static void select_brbe_bank(int bank)
>>  	isb();
>>  }
>>  
>> +static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
>> +{
>> +	entry->brbinf = get_brbinf_reg(idx);
>> +
>> +	/*
>> +	 * There are no valid entries anymore on the buffer.
>> +	 * Abort the branch record processing to save some
>> +	 * cycles and also reduce the capture/process load
>> +	 * for the user space as well.
>> +	 */
> 
> This comment refers to the process of handling multiple entries, though it's
> only handling one entry, and I don't think we need to mention saving cycles here.
> 
> Could we please delete this comment entirely? The comment above
> capture_brbe_regset() already explains that we read until the first invalid
> entry.

Sure, will drop the comment.

> 
>> +	if (brbe_invalid(entry->brbinf))
>> +		return false;
>> +
>> +	entry->brbsrc = get_brbsrc_reg(idx);
>> +	entry->brbtgt = get_brbtgt_reg(idx);
>> +	return true;
>> +}
>> +
>> +/*
>> + * This scans over BRBE register banks and captures individual branch records
>> + * [BRBSRC, BRBTGT, BRBINF] into a pre-allocated 'struct brbe_regset' buffer,
>> + * until an invalid one gets encountered. The caller for this function needs
>> + * to ensure BRBE is an appropriate state before the records can be captured.
>> + */
> 
> Could we simplify this to:
> 
> /*
>  * Read all BRBE entries in HW until the first invalid entry.
>  *
>  * The caller must ensure that the BRBE is not concurrently modifying these
>  * entries.
>  */

Okay, will change the comment as suggested.
