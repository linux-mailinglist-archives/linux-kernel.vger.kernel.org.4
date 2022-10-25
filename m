Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E189A60CD37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiJYNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiJYNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:17:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E89DCAF4;
        Tue, 25 Oct 2022 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666703828; x=1698239828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2F7Eoa9lBQCmf/5MvcL4NAHZcvTMNySoe8rV9kJTiZQ=;
  b=EgKuYrLTgcBzYTKWx/MyWkotI6T4BfMz/qyJ4eJUQz8RPCvW6PYWmgYX
   f00fonDagLQrkZHhfs/EyKS73skitojJSrjCiD5vKo4m9KGHjuxvCxwWR
   4DemFSUTnfjduQqJl207weX1vxLsRfD/194zS5dOSKNya4DLPz3U9b6xw
   YWTjqA1v8RLqteocJ4Y2L2APLvaIwGmbU0d8pGlZSNX7EcjhmJ5dE7uCH
   cOwcQir+dso3CL2rhExBtDfvn/fdaYMqSMGpmCPt03LhWJKDUrtmmO7pc
   dNBZ2PxpIvw6jovGBGpc+ceLU2RJFZHCcZddWxGpdRs6yQzP/S6FvHv68
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371882989"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="371882989"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:17:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626417672"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="626417672"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:17:05 -0700
Message-ID: <243d2f33-258e-4bc2-326f-e74f39c6a714@intel.com>
Date:   Tue, 25 Oct 2022 16:17:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
 <Y1Z3/t4RtnB8r03t@kernel.org>
 <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
 <Y1a2lmO/dmjEiZb0@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y1a2lmO/dmjEiZb0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 19:00, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 24, 2022 at 05:00:14PM +0300, Adrian Hunter escreveu:
>> On 24/10/22 14:33, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
>>>> I wonder if these utilities should just be built into perf to avoid
>>>> the cc dependency. Perhaps we can have a hidden option built into
>>>> perf test.
> 
>>> Agreed, not depending on a compiler makes 'perf test' usable in more
>>> systems, particularly production ones where we may want to check if perf
>>> is passing all tests applicable to that system.
>  
>> I haven't seen anyone package anything except the perf executable, so
>> I presume the only people running these tests install the source, and
>> so need a compiler anyway.
> 
> Humm?
> 
> [root@quaco ~]# head -3 /etc/os-release
> NAME="Fedora Linux"
> VERSION="36 (Workstation Edition)"
> ID=fedora
> [root@quaco ~]#G

I guess I got confused - it seems it is only Ubuntu that does that.

