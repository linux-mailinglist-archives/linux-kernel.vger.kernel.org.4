Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD60601116
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJQO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:26:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E965675
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666016816; x=1697552816;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9PAc3phGTfp3tAb95lX0MS4Cx6+tAqeFB65JZzGsviA=;
  b=MCI1pQ3hktBijB5g6Z1twFykCWGjrsjtYBU7Xkjj4mFIAqpBlKMaHPLq
   CqWJ2MsFScqb+f+7yrWMP1jd5H5ck1ZOADW51NXgRWzZrxqE46MkB91k5
   jYKqOSSdJZGPNm+byENKH8jpKxJD5cJUnrrnSYY1t50+2U3u60gO+LO/9
   t17Iylbquj2044KgSsXF3o0JtBr8TA3bVEZKYt/hpNxVrRJKbpzLPW0zU
   kO9YQDOatlPc9KJ5L+CPOEQNE6l68WSPCvcC+jq7CMeG1PQQqK6TShB6g
   mCoHr+UeCwJTYG9TE7BpFEkOAV/PjoNqxHbT+TCKJcqXrHRlXs7nh2uB6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285533889"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285533889"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 07:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606140197"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="606140197"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2022 07:26:56 -0700
Received: from [10.252.212.216] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8B1D6580801;
        Mon, 17 Oct 2022 07:26:55 -0700 (PDT)
Message-ID: <b121de4a-1f75-b84c-3637-cc676b4f5406@linux.intel.com>
Date:   Mon, 17 Oct 2022 10:26:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <Y0nffphm+aqtMBMc@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: assert from intel_pmu_hw_config
In-Reply-To: <Y0nffphm+aqtMBMc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-10-14 6:15 p.m., Peter Zijlstra wrote:
> Hi Kan,
> 
> While fuzzing on my ADL, I saw a splat (sadly not captured because
> MeshCommander is a pain in the backside).
> 
> The thing I did recover was that it was the new
> lockdep_assert_event_ctx() triggering from intel_pmu_hw_config().
> 
> Now; that code reads:
> 
> 	if (require_mem_loads_aux_event(event) &&
> 	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
> 	    is_mem_loads_event(event)) {
> 		struct perf_event *leader = event->group_leader;
> 		struct perf_event *sibling = NULL;
> 
> 		if (!is_mem_loads_aux_event(leader)) {
> 			for_each_sibling_event(sibling, leader) {
> 				if (is_mem_loads_aux_event(sibling))
> 					break;
> 			}
> 			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
> 				return -ENODATA;
> 		}
> 	}
> 
> And it is trying to assert leader->ctx->mutex is held.
> 
> Now, the calling context perf_try_init_event() has:
> 
> 	/*
> 	 * A number of pmu->event_init() methods iterate the sibling_list to,
> 	 * for example, validate if the group fits on the PMU. Therefore,
> 	 * if this is a sibling event, acquire the ctx->mutex to protect
> 	 * the sibling_list.
> 	 */
> 	if (event->group_leader != event && pmu->task_ctx_nr != perf_sw_context) {
> 		/*
> 		 * This ctx->mutex can nest when we're called through
> 		 * inheritance. See the perf_event_ctx_lock_nested() comment.
> 		 */
> 		ctx = perf_event_ctx_lock_nested(event->group_leader,
> 						 SINGLE_DEPTH_NESTING);
> 		BUG_ON(!ctx);
> 	}
> 
> IOW; we only hold leader->ctx->mutex when event is *NOT* the group
> leader; while the above code *can* in fact use for_each_sibilng_event()
> on the group leader when conditions are just right.
> 
> Now, it's really late and my brain has long since started the weekend,
> but I think something like the below ought to fix things.
> 
> Does that make sense? IIRC this would not destroy the purpose of this
> code -- although admittedly, the comment there tickles only vague
> memories.
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d8af75466ee9..450463d36450 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3975,7 +3975,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		struct perf_event *leader = event->group_leader;
>  		struct perf_event *sibling = NULL;
>  
> -		if (!is_mem_loads_aux_event(leader)) {
> +		if (event != leader && !is_mem_loads_aux_event(leader)) {
>  			for_each_sibling_event(sibling, leader) {
>  				if (is_mem_loads_aux_event(sibling))
>  					break;

If the leader is the load latency event, I think we can error out
directly. Because the auxiliary event never can be in front of the load
latency event. Does the below patch help?

		struct perf_event *leader = event->group_leader;
		struct perf_event *sibling = NULL;

+		if (event == leader)
+			return -ENODATA;
+
		if (!is_mem_loads_aux_event(leader)) {
			for_each_sibling_event(sibling, leader) {
				if (is_mem_loads_aux_event(sibling))
					break;
			}

Thanks,
Kan
