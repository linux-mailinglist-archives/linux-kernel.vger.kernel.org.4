Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14775FB1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJKL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:57:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A77F26F;
        Tue, 11 Oct 2022 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665489439; x=1697025439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XzJyJLhn3OWIM+SDzpoP33h7icTAUN97RR03Oxsgpeo=;
  b=L+Np3Qi7RoB0r7xMZZ0OmhXBJ4m7wr0VBvEyUnReDUSsRauWLhus6I1v
   TwGaOIvoH3wFeK67bVI2EKUlrOtd3Vy0mKDTV7PcXW4pzDiLJFAmTlZNb
   0Rx5PdRITNcoQzwR4blkBF+/rwHteqDEE4/+fFCEjaWf7hqGkstYxDWKz
   SkzbXFv7N35RDCGC6gWTwZ0851tgL2bS8gIiehWCdQn23vz/qIMzE0JI/
   rY8WA7Jf47VcDTWQvTI93wJmRTRoWTMSGj+aatUfw8c9zYnLbKMfNcQNH
   zg3dlQ/pDlwc4s5gOx29bUzh4zjlBbUygx0Xn0CsjUww9JwwXw5JXc0iV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284864448"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="284864448"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:57:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="751708546"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="751708546"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.213.187.182]) ([10.213.187.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:57:12 -0700
Message-ID: <c65f10bd-e486-42d7-b221-dd763623775d@linux.intel.com>
Date:   Tue, 11 Oct 2022 07:57:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20221010053600.272854-1-namhyung@kernel.org>
 <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
 <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> My main concern would be subtle regressions since there are so many
>> different combinations and way to travel through the code, and a lot of
>> things are not covered by unit tests. When I worked on the code it was
>> difficult to keep it all working. I assume you have some way to
>> enumerate them all and tested that the output is identical?
> Right, that's my concern too.
>
> I have tested many combinations manually and checked if they
> produced similar results.

I had a script to test many combinations, but had to check the output 
manually


> But the problem is that I cannot test
> all hardwares and more importantly it's hard to check
> programmatically if the output is the same or not.

Can use "dummy" or some software event (e.g. a probe on some syscall) to 
get stable numbers. I don't think we need to cover all hardware for the 
output options, the different events should be similar, but need some 
coverage for the different aggregation. Or we could add some more tool 
events just for testing purposes, that would allow covering different 
core scopes etc. and would easily allow generating known counts.

-Andi


