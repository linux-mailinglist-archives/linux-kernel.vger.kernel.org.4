Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CB72DD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjFMI4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbjFMI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:56:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 531E8D2;
        Tue, 13 Jun 2023 01:56:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119DB1FB;
        Tue, 13 Jun 2023 01:57:18 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29543F71E;
        Tue, 13 Jun 2023 01:56:30 -0700 (PDT)
Message-ID: <94e91db2-182e-836f-2edc-f804c4bb7290@arm.com>
Date:   Tue, 13 Jun 2023 09:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/5] perf cs-etm: Track exception level
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612111403.100613-1-james.clark@arm.com>
 <ZIdk1ArKuXLpKZT7@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZIdk1ArKuXLpKZT7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2023 19:32, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 12, 2023 at 12:13:57PM +0100, James Clark escreveu:
>> Changes since v2:
>>
>>   * Rename prev_thread -> prev_packet_thread and prev_el ->
>>     prev_packet_el
>>   * Add a comment about tracking the previous packet's thread
>>
>> Changes since v1:
>>
>>   * Always assume host kernel when the trace was captured at EL1 (nVHE)
>>   * Fix EL validation to work with ETMv3
>>   * Add a commit to make PID format accessible from struct
>>     cs_etm_auxtrace
> 
> Please take a look in my tmp.perf-tools-next branch, there were some
> conflicts I had to fix as those files were touched by refactorings for
> addr_location and thread reference counting.
> 

Yeah I got the same result and the tests are still passing. Thanks for
fixing those.

> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
> aa53fb2c482e70c2 (HEAD -> perf-tools-next) perf cs-etm: Add exception level consistency check
> 2918e9895224541f perf cs-etm: Track exception level
> f492a33909829a75 perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
> e29ec19b0751c6b2 perf cs-etm: Use previous thread for branch sample source IP
> e9e03e9c3ca7088c perf cs-etm: Only track threads instead of PID and TIDs
> 6fd34445b8c94aa7 perf map: Fix double 'struct map' reference free found with -DREFCNT_CHECKING=1
> e9c0a7f63e45e76f perf srcline: Optimize comparision against SRCLINE_UNKNOWN
> fd87a79c7ed62804 perf hist: Fix srcline memory leak
> 933f9651d47cdda2 perf srcline: Change free_srcline to zfree_srcline
> d22cfb063bcc674e perf callchain: Use pthread keys for tls callchain_cursor
> ⬢[acme@toolbox perf-tools-next]$
> 
> 
> - Arnaldo
>  
>> ======
>>
>> Some fixes to support an issue reported by Denis Nikitin where decoding
>> trace that contains different EL1 and EL2 kernels can crash or go into
>> an infinite loop because the wrong kernel maps are used for the decode.
>>
>> This still doesn't support distinguishing guest and host userspace,
>> we'd still have to fix the timestamps and do a bit more work to
>> correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
>> possible outcome of cs_etm__cpu_mode(). As far as I know this could
>> never have been returned anyway because machine__is_host(machine) was
>> always true due to session.machines.host being hard coded. And I'm not
>> sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
>> and PERF_RECORD_MISC_HYPERVISOR in this scenario.
>>
>> The first commit is a tidy up, second fixes a bug that I found when
>> comparing the exception level and thread of branch records, the third
>> is the main fix, and the last commit is some extra error checking. 
>>
>> Applies to acme/perf-tools-next (42713dafc)
>>
>> James Clark (5):
>>   perf cs-etm: Only track threads instead of PID and TIDs
>>   perf cs-etm: Use previous thread for branch sample source IP
>>   perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
>>   perf cs-etm: Track exception level
>>   perf cs-etm: Add exception level consistency check
>>
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  33 +-
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   4 +-
>>  tools/perf/util/cs-etm.c                      | 282 ++++++++++--------
>>  tools/perf/util/cs-etm.h                      |  13 +-
>>  4 files changed, 184 insertions(+), 148 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 
