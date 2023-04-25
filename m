Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F76EE0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjDYLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYLDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:03:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7985274;
        Tue, 25 Apr 2023 04:03:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A124B3;
        Tue, 25 Apr 2023 04:04:27 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1E233F5A1;
        Tue, 25 Apr 2023 04:03:40 -0700 (PDT)
Message-ID: <6a55956e-4218-4e11-4d7b-841761430a42@arm.com>
Date:   Tue, 25 Apr 2023 12:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] perf tools: Add util function for overriding user set
 config values
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-3-james.clark@arm.com>
 <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
 <ZEbAS2yx2fguW60w@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZEbAS2yx2fguW60w@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 18:45, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 24, 2023 at 06:36:14PM +0300, Adrian Hunter escreveu:
>> On 24/04/23 16:47, James Clark wrote:
>>> There is some duplicated code to only override config values if they
>>> haven't already been set by the user so make a util function for this.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> One minor comment, nevertheless:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I just moved to  evsel__set_config_if_unset() to util/pmu.c, next to
> some other evsel__ functions to not break the python.so binding, before
> I was getting:
> 
> [acme@quaco perf-tools-next]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>  19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 500086
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: perf_pmu__format_bits
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [acme@quaco perf-tools-next]$
> 
> Please run 'perf test' and 'make -C tools/perf build-test' prior to
> sending pull requests,
> 
> Thanks, applied.
> 

Ah sorry! I ran it from an in source build and got the python import
error so I ignored that test. I see the new error if I run it from
tools/perf instead.

Interestingly with an out of source build it doesn't matter which cwd
you run the Python test from because $OUTPUT is an absolute path.
Normally I do an out of source build, but the Coresight tests don't
currently work with that. Which I will submit another fix for...

I don't know if it's worth getting rid of that edge by making sure
PYTHONPATH is always absolute even for in source builds or if it will
break something else like a make install? It's because of this line:

  -DPYTHONPATH="BUILD_STR($(OUTPUT)python)"

Will make sure that they all pass next time. I also sent a fix for the
build-test target on my platform.

> - Arnaldo
> 
