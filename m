Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC8724B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjFFSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbjFFSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:34:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69D1707
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686076490; x=1717612490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJjMtX6JV3KGQfsw82yer2ZuikypQbyMMcAY2zodLUg=;
  b=Qff4uGquX3hTUzkFcZCUKiqdjDss1FuYrCTkevqFqOa3pj8UZY3pQhwq
   /JYsKO7xFIuirN8BfO+jGORqwn1rkZmSQI9mZXttHOXppQHx7uStfisNV
   7MIiUzZRCMdAya1WRKL8xkl2O6VV/OfKEDYW4foV+ORXxZWNvjrFFLh7v
   AV5L6Ow7RtddiK0kRNHzuuyrZxBaMYephOycm+YeaPikEgKQkin1pZKCj
   cPHA8aH9qCaf8sIw56drD1FFa9TE7TcsOMVdzWXXUk8O0FU+i3sPgFCLy
   hdVq5ojaV7xVLIpx87B8nukLlMiC9AnDg10k6vfpORu05gQOvONt/jZvq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385082283"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="385082283"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 11:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="659636951"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="659636951"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2023 11:34:49 -0700
Received: from [10.212.191.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.191.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1C4C9580C9B;
        Tue,  6 Jun 2023 11:34:48 -0700 (PDT)
Message-ID: <ea1c56f9-fc93-ff1e-2102-757e7e9c0dd7@linux.intel.com>
Date:   Tue, 6 Jun 2023 14:34:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
 <20230606132432.GD905437@hirez.programming.kicks-ass.net>
 <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
 <20230606181757.GB942082@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230606181757.GB942082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-06 2:17 p.m., Peter Zijlstra wrote:
> On Tue, Jun 06, 2023 at 12:16:29PM -0400, Liang, Kan wrote:
> 
>>> names for a reason, so that enums like the above become something
>>> sensible like:
>>>
>>> 	case INTEL_FAM6_ATOM_CRESTMONT:
>>> 	case INTEL_FAM6_ATOM_CRESTMONT_X:
>>>
>>> and now it's super obvious why they're grouped.
>>>
>>>>> +		pr_cont("Crestmont events, ");
>>
>> The Sierra Forest should not be a platform name. I think it's the code
>> name of the processor.
>>
>> The problem is that the uarch name doesn't work for the hybrid, since it
>> has different uarchs in the same processors. To make the naming rules
>> consistent among big core, atom, and hybrid, maybe we should use the
>> code name of the processor in intel-family.h.
> 
> I obviously disagree; these are not hybrid and calling them both
> CRESTMONT makes *far* more sense than the random gibberish they're
> called now.
> 
> Yes, hybrid made a complete mess of things (in many ways), but we should
> then not do the obvious correct thing for when we can.

Besides hybrid, it seems there is a bigger problem for the big core.

The big core uses the processor code name since Ice Lake. In the perf
code, we also uses the processor code name for the big core.
	pr_cont("Icelake events, ");

Is it OK to leave the big core as is (using processor code name), but
only change the name for Grand Ridge and Sierra Forest?

Thanks,
Kan
