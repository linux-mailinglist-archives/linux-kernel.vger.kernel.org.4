Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54D6D9C80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjDFPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbjDFPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:37:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88456E82
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680795417; x=1712331417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RSuKlqLGPKWhfVgHlvf1htxnxLkC+h8DaNCqY4VdQRA=;
  b=mHvTJ7jCx6IkFxjZht3OsFyZ6NRY6NcD+7A//M2EfcpYrE45PWGcXR3R
   aW+GoH6/2dsnzvbG+905mUhurwRvaWyib6GsUHPDI4lUtjIEHCVz1Lb+S
   0CQ2cc4DNrGbX3z/oY/sMz9NLMbb0zpzjQFruzaERmIvhWlXAEiPnW0rf
   UFwO1+84bK08p3rZHHS04G3XUfuJDe6MxRz7IqIgHM6YX7CAhxA6gotW4
   LuGfEQCX7l0GwwTLSbD2izyIkPAg5j1rVQDkqdJ4KBximRxsyr/3QIJXw
   Z8i55BwdP9Q3CXAK54XV6IHrrI8zHZ8jdv3SW9NA3SioZ+/6VFuczV/yY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="405579511"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405579511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 08:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="717507703"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="717507703"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Apr 2023 08:36:57 -0700
Received: from [10.251.27.208] (kliang2-mobl1.ccr.corp.intel.com [10.251.27.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E21F15807A3;
        Thu,  6 Apr 2023 08:36:56 -0700 (PDT)
Message-ID: <1185d81f-71cc-0428-881a-db4f2cbac823@linux.intel.com>
Date:   Thu, 6 Apr 2023 11:36:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] perf/x86/intel/ds: Use the size from each PEBS record
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
References: <20230328222735.1367829-1-kan.liang@linux.intel.com>
 <20230328222735.1367829-2-kan.liang@linux.intel.com>
 <20230406131351.GL386572@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230406131351.GL386572@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-06 9:13 a.m., Peter Zijlstra wrote:
> On Tue, Mar 28, 2023 at 03:27:35PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The kernel warning for the unexpected PEBS record can also be observed
>> during a context switch, when the below commands are running in parallel
>> for a while on SPR.
>>
>>   while true; do perf record --no-buildid -a --intr-regs=AX -e
>>   cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &
>>
>>   while true; do perf record -o /tmp/out -W -d -e
>>   '{ld_blocks.store_forward:period=1000000,
>>   MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
>>   -c 1037 ./triad; done
>>   *The triad program is just the generation of loads/stores.
>>
>> The current PEBS code assumes that all the PEBS records in the DS buffer
>> have the same size, aka cpuc->pebs_record_size. It's true for the most
>> cases, since the DS buffer is always flushed in every context switch.
>>
>> However, there is a corner case that breaks the assumption.
>> A system-wide PEBS event with the large PEBS config may be enabled
>> during a context switch. Some PEBS records for the system-wide PEBS may
>> be generated while the old task is sched out but the new one hasn't been
>> sched in yet. When the new task is sched in, the cpuc->pebs_record_size
>> may be updated for the per-task PEBS events. So the existing system-wide
>> PEBS records have a different size from the later PEBS records.
>>
>> Two methods were considered to fix the issue.
>> One is to flush the DS buffer for the system-wide PEBS right before the
>> new task sched in. It has to be done in the generic code via the
>> sched_task() call back. However, the sched_task() is shared among
>> different ARCHs. The movement may impact other ARCHs, e.g., AMD BRS
>> requires the sched_task() is called after the PMU has started on a
>> ctxswin. The method is dropped.
>>
>> The other method is implemented here. It doesn't assume that all the
>> PEBS records have the same size any more. The size from each PEBS record
>> is used to parse the record. For the previous platform (PEBS format < 4),
>> which doesn't support adaptive PEBS, there is nothing changed.
> 
> Same as with the other; why can't we flush the buffer when we reprogram
> the hardware?

For the current code, the pebs_record_size has been updated in another
place before we reprogram the hardware.
But I think it's possible to move the update of the pebs_record_size
right before the hardware reprogram. So we can flush the buffer before
everything is updated. Let me try this method.

Thanks,
Kan
