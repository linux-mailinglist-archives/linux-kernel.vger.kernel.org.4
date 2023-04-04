Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF786D6C63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDDSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjDDSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:38:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970082108;
        Tue,  4 Apr 2023 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680633449; x=1712169449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BCqe1K199HYpCvTKZWDbQiWocdkrHSITuIJF8Dcwfrc=;
  b=ioj87efvFi/PCjPPPzyvS1AWph+F7S+LhTmxYixNZ2y1j+823/b2AQde
   3p6L0Cp5xehlcYbclfPEY3LtYilpDVTPLikn0YV3YwMHzgXSt2o70QqGH
   46MMbzj8CuF8veaiYoDLOAeHOxyjFwj33GSTSjNKkND/p8sdiaQYzL7BN
   nbPy382x85heDAocpnbr7mMC8/GGTJPiMH3QlP+JGEWzTkL0pdDe6KKYN
   8v7uzhTeX5U2na6eIv3qWXuQeMlF68mrRDv1GFj+yqnAreAuCOh7V68wx
   ZkC6lORdnhOhFynLhpCKz1qu9YDBp5g5d3VEo0lK6BWH3vSY3zG+JcQSE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330869220"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="330869220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 11:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="636629338"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="636629338"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.86])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 11:37:18 -0700
Message-ID: <f2f6b5fc-11fc-11d9-ccfd-74c5baeea8ca@intel.com>
Date:   Tue, 4 Apr 2023 21:37:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/04/23 20:35, Ian Rogers wrote:
> On Tue, Apr 4, 2023 at 10:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 4/04/23 18:58, Ian Rogers wrote:
>>> Ping. It would be nice to have this landed or at least the first 10
>>> patches that refactor the map API and are the bulk of the
>>> lines-of-code changed. Having those landed would make it easier to
>>> rebase in the future, but I also think the whole series is ready to
>>> go.
>>
>> I was wondering if the handling of dynamic data like struct map makes
>> any sense at present.  Perhaps someone can reassure me.
>>
>> A struct map can be updated when an MMAP event is processed.  So it
>> seems like anything racing with event processing is already broken, and
>> reference counting / locking cannot help - unless there is also
>> copy-on-write (which there isn't at present)?
>>
>> For struct maps, referencing it while simultaneously processing
>> events seems to make even less sense?
> 
> Agreed. The point of this work isn't to reimplement the maps/map APIs
> but to add a layer of reference count checking. A refactor to change
> the implementation without reference counts can delete the reference
> count checking and I think that is great! I'm trying to get the code
> base, in its current shape, to be more correct guided by sanitizers.
> Unfortunately the sanitizers come from a C++ RAII world where
> maintaining reference counts is somewhat trivial, we have to work
> harder as done here.
> 
> A similar thing to refactoring maps is changing symbol. The rb_node
> there accounts for 3*8 bytes of pointer, but is just to sort the
> symbol by address. A sorted array would suffice as well complexity
> wise, freeing 16-bytes per symbol, and is already done for symbols
> sorted by name.

Ok, just stuff to keep in mind.

