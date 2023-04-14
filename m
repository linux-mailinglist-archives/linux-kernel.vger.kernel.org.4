Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651F6E2458
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDNNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:35:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D01B83E3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681479341; x=1713015341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D+zz0tEHaGd9SlvWrGZxRWoOTNG2kIKrzZCePJm8HSk=;
  b=VyN5p4kisUSsHVQEVJ2OmwVnjIAf4yz8Mj3xWuAAsWKPP+g6I5liXd3+
   ovuCjB4PC8SPhZyIViVt7dBW0uA/zYYcnjBAPn2GO+nYAG9o36Krod7AF
   gREmQrJ/uecQwp7mdotPMg6iALqVA3AxQhS4kxXh0KSslKHWqIJ8ZKFkF
   +bo/ZNbmFIBl02D0cjXfOk9M2cd8NQlyqlH/72s22iOyqlSC0DmxPHZrA
   pn4jjTNCGn2EFr2XOxSrV6ql2bRbw5NmB0cLivtA7i+6Caqh/18Ovfay8
   vuokNDm7QM4W0XAxqqYDzsoglITJBdRXOiAualMWK7wWcfxu3g9EA8K3A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324816148"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="324816148"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 06:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="813874132"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="813874132"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2023 06:35:40 -0700
Received: from [10.212.165.245] (kliang2-mobl1.ccr.corp.intel.com [10.212.165.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 790865805EE;
        Fri, 14 Apr 2023 06:35:38 -0700 (PDT)
Message-ID: <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
Date:   Fri, 14 Apr 2023 09:35:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-14 6:38 a.m., Peter Zijlstra wrote:
> On Mon, Apr 10, 2023 at 01:43:48PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> With the cycle time information between branches, stalls can be easily
>> observed. But it's difficult to explain what causes the long delay.
>>
>> Add a new field to collect the occurrences of events since the last
>> branch entry, which can be used to provide some causality information
>> for the cycle time values currently recorded in branches.
>>
>> Add a new branch sample type to indicate whether include occurrences of
>> events in branch info.
>>
>> Only support up to 4 events with saturating at value 3.
>> In the current kernel, the events are ordered by either the counter
>> index or the enabling sequence. But none of the order information is
>> available to the user space tool.
>> Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, and generic
>> support to dump the event IDs of the branch events.
>> Add a helper function to detect the branch event flag.
>> These will be used in the following patch.
> 
> I'm having trouble reverse engineering this. Can you more coherently
> explain this feature and how you've implemented it?

Sorry for that.

The feature is an enhancement of ARCH LBR. It adds new fields in the
LBR_INFO MSRs to log the occurrences of events on the first 4 GP
counters. Worked with the previous timed LBR feature together, the user
can understand not only the latency between two LBR blocks, but also
which events causes the stall.

The spec can be found at the latest Intel® Architecture Instruction Set
Extensions and Future Features, v048. Chapter 8.4.
https://cdrdv2.intel.com/v1/dl/getContent/671368

To support the feature, there are three main changes in ABIs.
- A new branch sample type, PERF_SAMPLE_BRANCH_EVENT, is used as a knob
to enable the feature.
- Extend the struct perf_branch_entry layout, because we have to save
and pass the occurrences of events to user space. Since it's only
available for 4 counters and saturating at value 3, it only occupies 8
bits. For the current Intel implementation, the order is the order of
counters.
- Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, to dump
the order information. User space tool doesn't understand the order of
counters. So it cannot map the new fields in struct perf_branch_entry to
a specific event. We have to dump the order information.
I once considered using enabling order to avoid this new sample format.
It works for some cases, e.g., group. But it doesn't work for some
complex cases, e.g., multiplexing, in which the enabling order keeps
changing.
Ideally, we should dump the order information for each LBR entry. But
that will include too much duplicate information. So the order
information is only dumped for each sample. The drawback is that we have
to flush/update old LBR entries once the events are rescheduled between
samples, e.g., multiplexing. Because it's possible that the new sample
can still see the stall LBR entries. That's specially handled in the
next Intel specific patch.

For the current implementation, perf tool has to apply both
PERF_SAMPLE_BRANCH_EVENT and PERF_SAMPLE_BRANCH_EVENT_IDS to enable the
feature.

Thanks,
Kan
