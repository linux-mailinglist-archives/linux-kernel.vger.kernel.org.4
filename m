Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599C70DD33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjEWNIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbjEWNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:08:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB4FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684847286; x=1716383286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w4g0jZTCQwWIdPyJPZFl0PE2bqk2J1uMFazRTFxacW4=;
  b=hTA7J35f7nFa8/pic9N9+o/SXUYLkMMHTsmG3SHDy15HZukVg84j8ddU
   v1sF4YV1tFpIL5cYQE988ny/gQPRQgeUOjclmRuZl/PUfE0V8VzJSnohy
   RA+Ku8c2AU+DOznMFAsDAyRk9JsRNjjziS4661NfQXmHDYM1R3VOAjKvA
   Wq9S2zr8ImxQCVkxqFYi5xDNKj5IhPIUoImDpyiQ99qpiz2GpNCk5F2qO
   V1rtb3hJf+twBzSdhWgMeQXqku6BVrwrD9YbQvWVTJYocat1+8GUxhwjl
   eNBpYtqbSDBp1moCKYf56VShwPYcO/apuW2XH7J9j9w82jaj3/VZLs3Or
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337815778"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="337815778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="703922225"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="703922225"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2023 06:08:06 -0700
Received: from [10.212.205.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.205.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1DDD8580D67;
        Tue, 23 May 2023 06:08:04 -0700 (PDT)
Message-ID: <2f09023a-cccb-35df-da0a-d245ee5238be@linux.intel.com>
Date:   Tue, 23 May 2023 09:08:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/6] perf: Add branch stack extension
To:     Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522113040.2329924-2-kan.liang@linux.intel.com>
 <10695901-8f38-1177-19e3-74b42d060758@amd.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <10695901-8f38-1177-19e3-74b42d060758@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-23 2:03 a.m., Sandipan Das wrote:
> Hi Kan,
> 
> On 5/22/2023 5:00 PM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Currently, the extra information of a branch entry is stored in a u64
>> space. With more and more information added, the space is running out.
>> For example, the information of occurrences of events will be added for
>> each branch.
>>
>> Add an extension space to record the new information for each branch
>> entry. The space is appended after the struct perf_branch_stack.
>>
>> Add a bit in struct perf_branch_entry to indicate whether the extra
>> information is included.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Sandipan Das <sandipan.das@amd.com>
>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>
>> New patch
>> - Introduce a generic extension space which can be used to
>>   store the LBR event information for Intel. It can also be used by
>>   other ARCHs for the other purpose.
>> - Add a new bit in struct perf_branch_entry to indicate whether the
>>   extra information is included.
>>
>>  arch/powerpc/perf/core-book3s.c |  2 +-
>>  arch/x86/events/amd/core.c      |  2 +-
>>  arch/x86/events/intel/core.c    |  2 +-
>>  arch/x86/events/intel/ds.c      |  4 ++--
>>  include/linux/perf_event.h      | 18 +++++++++++++++++-
>>  include/uapi/linux/perf_event.h |  4 +++-
>>  kernel/events/core.c            |  5 +++++
>>  7 files changed, 30 insertions(+), 7 deletions(-)
>>
> 
> This seems to be missing the following:

Oh, right, the patch set based on the perf/core branch which doesn't
include the latest fix, 90befef5a9e8 ("perf/x86: Fix missing sample size
update on AMD BRS").

Peter,

Could you please backport the 90befef5a9e8 to your perf/core branch?
Then I will fold the below change into V3.
Or should I rebase the patch set on top of perf/urgent?


> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 6310fc5c9f52..b6739f63dc34 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1704,7 +1704,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>                 perf_sample_data_init(&data, 0, event->hw.last_period);
> 
>                 if (has_branch_stack(event))
> -                       perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
> +                       perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
> 
>                 if (perf_event_overflow(event, &data, regs))
>                         x86_pmu_stop(event, 0);
> 
> 
> Otherwise, the changes look good to me.
> 
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>


Thanks!

Kan

