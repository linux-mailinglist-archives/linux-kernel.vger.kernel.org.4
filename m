Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66F16789BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjAWVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWVfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:35:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7E16AD4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674509702; x=1706045702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tS2x0JbAhbDd/jJm0GSuTboIZBIqoIZh/LN4fngXNU=;
  b=JeDOJZFRhfFzTBGUJXzGha634DMxx3nl7FTeqFe4QzULf+BrAnCY2Ww5
   TaXASplTo1bKWVkr5EY5lSboDMoFV2UMRUQrnIS1F/dH1IO+fuh+uEH+R
   NvKrG7KgHpr5Q97FNqO9l8qJvevnNAS/w99dHy5DRrBmhtiIimwQE7z6X
   5uge1b4SQl63JoavAsovYxu6PJ+7B4N73UcIJqfLC3MCkvlKbSwczEcEW
   iZ8vDrKVsl2wxenNtZJ/u9+jF3LOzbwhgeGhVn+/FaZ/84n3Ju5wHhfSm
   ljMoQkW+Tvq5mpLdcAmhkccxR7w/L9nrqYVXpBMPt/LfHgbDwps+kwJqF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328243320"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328243320"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 13:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730457019"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="730457019"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jan 2023 13:35:01 -0800
Received: from [10.251.20.205] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 65094580AA4;
        Mon, 23 Jan 2023 13:35:00 -0800 (PST)
Message-ID: <f661cad2-1299-932e-5845-d95ccd263d75@linux.intel.com>
Date:   Mon, 23 Jan 2023 16:34:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86/intel/ds: Fix the conversion from TSC to perf
 time
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230123172027.125385-1-kan.liang@linux.intel.com>
 <Y87wfaMJ2HLchgap@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y87wfaMJ2HLchgap@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-23 3:39 p.m., Peter Zijlstra wrote:
> On Mon, Jan 23, 2023 at 09:20:27AM -0800, kan.liang@linux.intel.com wrote:
>> The TSC unstable case seems to be some corner cases (e.g., due to broken
>> BIOS). This patch doesn't support the conversion when the TSC is
>> unstable. The TSC in a PEBS record will be dropped and fallback to the
>> software perf time provided by the generic code.
> 
> :-(
> 
> You're saying there's modern systems (PEBS timestamps are fairly new)
> that trigger unstable TSC ?
> 
> What systems in specific have you observed this on -- we really need to
> name and shame them, this is fully unacceptable.

No, I didn't observe any systems which trigger unstable TSC.

Here, I tried to explain the reason why the patch didn't support the
conversion when the TSC is unstable. Because it's a corner case and very
unlikely to happen.
The "broken BIOS" case is quoted from the __sched_clock_work(), which
shows that the broken BIOS may be a reason of unstable TSC.

Sorry for the confusion caused.

Let me rephrase this.
"This patch doesn't support the conversion when the TSC is unstable.
Because the TSC unstable case is a corner case and very unlikely to
happen. Even if it happens, the TSC in a PEBS record will be dropped and
fall back to the inaccurate software perf time provided by the generic
code as perf does it on the previous platforms."

Thanks,
Kan

