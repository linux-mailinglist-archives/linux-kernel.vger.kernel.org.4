Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C96EB055
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjDURLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjDURLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:11:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B1415461;
        Fri, 21 Apr 2023 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682097073; x=1713633073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XKFGiZ5Gxu4bfPEtAO1uWePDTPjRIArHOyyLBpD7uL8=;
  b=ZIdp38Gt6kP4dUKOaYOvH22XA44jbFKGVib0jJsWsZWFgzwGeexy5MVZ
   Fq+F2NCxHBW2ZNIg5lQdLnaqQB678B4YqgwhVpigY07X/UW0y+cCIUsqK
   ERPPvzCNJrQSeHLrYzQc9mOWJKqHS3OKpaVCUIJMzPKVHS2tFRIyB1Nhu
   iAr9RztSA9y7/CFETtuOLxFfp8+KPf1dHD5epK0/Oc3Y9cZ146WDtvWQb
   CugU+CV/FGMIgn5i6k+BezoRGojQo0ZpGYnOHqXk5N40waa7oO+PieOOf
   0PXgWRROW8cG4HDLdjVyJQ5wBum+aaUZrwmMyNWE6nC3mV7HBpMLg1dlo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="347940311"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="347940311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 10:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="695015761"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="695015761"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2023 10:10:57 -0700
Received: from [10.212.170.184] (kliang2-mobl1.ccr.corp.intel.com [10.212.170.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 54DE7580C3B;
        Fri, 21 Apr 2023 10:10:55 -0700 (PDT)
Message-ID: <c48515e6-6ba1-2c8e-7f84-869e227c5089@linux.intel.com>
Date:   Fri, 21 Apr 2023 13:10:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>
References: <20230414051922.3625666-1-irogers@google.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
 <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com>
 <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com>
 <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
 <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
 <CAP-5=fVnuQ08zUg8XxFhT-oddRd9PC8GPu6q-FU-_H0QLqO91w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVnuQ08zUg8XxFhT-oddRd9PC8GPu6q-FU-_H0QLqO91w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-21 11:49 a.m., Ian Rogers wrote:
>> Can we take a step back? Create a perf/json_metric or whatever branch,
>> fix all the issues thoroughly, and then merge to the mainline.
>>
>> I think the default of perf stat is frequently used by not only the
>> newbees but also the veterans. That could have a big user-visible impact.
>>
>> The 6.4 merge window is approaching. Can we at least revert the patches
>> for 6.4?
>>
>> Arnaldo, what do you think?
> Revert is a complete no go, we'd be reintroducing the bugs that are
> fixed and who will then fix those? How will they be fixed in any way
> other than how they've already been fixed? I've yet to see a
> description of a bug that isn't either:
> 1) an issue because the output formatting changed - the fix here is to
> use CSV or json output, using the hard coded metrics was a bug here
> anyway, not least as the metrics are wrong,
> 2) a pre-existing issue, such as hybrid is broken,
> 3) a non-issue, such as multiplexing on Skylake.
> That's not to say everything couldn't run better, which was the issue
> this patch was looking to address.

Sigh, we really need a clear design and definition regarding the default
of perf stat, especially what is included, what's the expected layout,
the forbidden. So everyone from the developers to the users is on the
same page. Could you please update the document for the default of perf
stat?


One more thing I want to point out is that the json metric may keep
changing. While the kernel metics (only includes the core part of the
json metric) is quite stable. For the default of perf stat, the kernel
metics should be a better choice.


Clarification: I'm not looking for reverting all the patches of the json
metrics in the perf-tool-next branch. The request is to revert the
patches which impact the default of perf stat. More specifically, the
patch 39 and 41.
https://lore.kernel.org/lkml/20230219092848.639226-40-irogers@google.com/


This is really a long discussion. I think we all express the arguments
clearly. Let's make the final decision and stop here.

Arnaldo? Peter? Ingo?

Could you please share your opinions?

Thanks,
Kan
