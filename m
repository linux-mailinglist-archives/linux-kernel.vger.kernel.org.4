Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126967794B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjAWKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAWKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:36:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD74417176;
        Mon, 23 Jan 2023 02:36:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46346AD7;
        Mon, 23 Jan 2023 02:37:23 -0800 (PST)
Received: from [10.57.49.17] (unknown [10.57.49.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1D83F71A;
        Mon, 23 Jan 2023 02:36:37 -0800 (PST)
Message-ID: <a4119c5a-1393-10e2-232d-c8f961f16c1b@arm.com>
Date:   Mon, 23 Jan 2023 10:36:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 2/8] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230120143702.4035046-1-james.clark@arm.com>
 <20230120143702.4035046-3-james.clark@arm.com> <Y8rNtO5HNcPJDpQ2@kernel.org>
 <Y8rQLirdlgU8nMEW@kernel.org> <Y8rS0BOUeXaGvwPv@kernel.org>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y8rS0BOUeXaGvwPv@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 17:43, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 20, 2023 at 02:32:30PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Jan 20, 2023 at 02:21:56PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Jan 20, 2023 at 02:36:55PM +0000, James Clark escreveu:
>>>> Remove some code that duplicates existing methods. Copy strings where
>>>> const strings are required.
>>>>
>>>> No functional changes.
>>>
>>>
>>> Have you used 'perf test'?
>>>
>>> [acme@quaco perf]$ perf test -v python
>>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>>>  19: 'import perf' in python                                         :
>>> --- start ---
>>> test child forked, pid 232379
>>> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
>>> Traceback (most recent call last):
>>>   File "<stdin>", line 1, in <module>
>>> ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: perf_pmu__scan_file
>>> test child finished with -1
>>> ---- end ----
>>> 'import perf' in python: FAILED!
>>> [acme@quaco perf]$
>>
>> I added this to this cset, now it passes.
> 
> So, what I have is now at my tmp.perf/core branch, pending container
> testing, later today probably will move to perf/core, so that it gets
> exposure on linux-next for v6.3.
> 

Gah! Sorry, I must have only run the Coresight tests. I will make sure
all the tests are passing on my setup so it's easier to spot next time.

Thanks for the fix.
