Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD36256F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiKKJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:39:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8074B654FF;
        Fri, 11 Nov 2022 01:39:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96CB81FB;
        Fri, 11 Nov 2022 01:39:40 -0800 (PST)
Received: from [10.57.69.19] (unknown [10.57.69.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E17A3F534;
        Fri, 11 Nov 2022 01:39:32 -0800 (PST)
Message-ID: <a396936c-7df6-8fb7-320e-435b852d0702@arm.com>
Date:   Fri, 11 Nov 2022 09:39:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/12] perf test: Replace brstack test workload
To:     German Gomez <german.gomez@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
References: <20221110181920.84900-1-namhyung@kernel.org>
 <20221110181920.84900-11-namhyung@kernel.org>
 <1036a42b-b438-67b2-c4ca-0e440d266d6d@arm.com>
 <a9a6eabf-e102-b7f8-92b4-48c2b77e013e@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a9a6eabf-e102-b7f8-92b4-48c2b77e013e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 19:31, German Gomez wrote:
> 
> On 10/11/2022 19:20, German Gomez wrote:
>> Hi Namhyung, thanks for doing the refactor, it looks a lot cleaner
>>
>> On 10/11/2022 18:19, Namhyung Kim wrote:
>>> So that it can get rid of requirement of a compiler.  Also rename the
>>> symbols to match with the perf test workload.
>>>
>>> Cc: German Gomez <german.gomez@arm.com>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/tests/shell/test_brstack.sh | 66 +++++---------------------
>>>  1 file changed, 12 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
>>> index ec801cffae6b..a8a182dea25f 100755
>>> --- a/tools/perf/tests/shell/test_brstack.sh
>>> +++ b/tools/perf/tests/shell/test_brstack.sh
>>> @@ -4,18 +4,12 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  # German Gomez <german.gomez@arm.com>, 2022
>>>  
>>> -# we need a C compiler to build the test programs
>>> -# so bail if none is found
>>> -if ! [ -x "$(command -v cc)" ]; then
>>> -	echo "failed: no compiler, install gcc"
>>> -	exit 2
>>> -fi
>>> -
>>>  # skip the test if the hardware doesn't support branch stack sampling
>>>  # and if the architecture doesn't support filter types: any,save_type,u
>>>  perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
> 
> Hmm I was wondering why this command was failing for me and always skipping the test. Is the -b conflicting with the --branch-filter here?
> 

Yes, the fix is here [1], but I don't see it on git yet.

[1]:
https://lore.kernel.org/linux-perf-users/Y2rDhkyn9ta5skDm@kernel.org/T/#t
