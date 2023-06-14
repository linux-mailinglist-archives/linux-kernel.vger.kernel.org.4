Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4E73018B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbjFNOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbjFNOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:19:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB43E1BC6;
        Wed, 14 Jun 2023 07:19:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD86B1FB;
        Wed, 14 Jun 2023 07:19:59 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5E43F64C;
        Wed, 14 Jun 2023 07:19:13 -0700 (PDT)
Message-ID: <d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com>
Date:   Wed, 14 Jun 2023 15:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] perf tools: Add a place to put kernel config
 fragments for test runs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230614140219.2335639-1-james.clark@arm.com>
 <ZInLBt9q2F99gTg8@kernel.org>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZInLBt9q2F99gTg8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/2023 15:13, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 14, 2023 at 03:02:19PM +0100, James Clark escreveu:
>> We are currently keeping something like this in our CI because defconfig
>> doesn't give full coverage. It's not complete yet, but is a starting
>> point as a place to add to when a specific test needs something extra to
>> run.
>>
>> The RFC is for discussion on folder placement and file naming etc.
> 
> Would be interesting to add the Kconfig maintainer to see if they have
> an opinion, Masahiro?
> 
> - Arnaldo
>  

One concern I have is that uname -m gives a different result to the
ARCH= option for a kernel build (ARCH=arm64). Probably the build time
version is more useful to us so maybe that should be the file name. Not
sure what the x86 version is or if anyone is actually doing cross x86
builds...

>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/config-fragments/README  |  7 +++++++
>>  tools/perf/tests/config-fragments/aarch64 |  1 +
>>  tools/perf/tests/config-fragments/config  | 11 +++++++++++
>>  3 files changed, 19 insertions(+)
>>  create mode 100644 tools/perf/tests/config-fragments/README
>>  create mode 100644 tools/perf/tests/config-fragments/aarch64
>>  create mode 100644 tools/perf/tests/config-fragments/config
>>
>> diff --git a/tools/perf/tests/config-fragments/README b/tools/perf/tests/config-fragments/README
>> new file mode 100644
>> index 000000000000..e816cfb1b96d
>> --- /dev/null
>> +++ b/tools/perf/tests/config-fragments/README
>> @@ -0,0 +1,7 @@
>> +This folder is for kernel config fragments that can be merged with
>> +defconfig to give full test coverage of a perf test run. This is only
>> +an optimistic set as some features require hardware support in order to
>> +pass and not skip.
>> +
>> +'config' is shared across all platforms, and for arch specific files,
>> +the file name should match that returned by 'uname -m'.
>> diff --git a/tools/perf/tests/config-fragments/aarch64 b/tools/perf/tests/config-fragments/aarch64
>> new file mode 100644
>> index 000000000000..64c4ab17cd58
>> --- /dev/null
>> +++ b/tools/perf/tests/config-fragments/aarch64
>> @@ -0,0 +1 @@
>> +CONFIG_CORESIGHT_SOURCE_ETM4X=y
>> diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
>> new file mode 100644
>> index 000000000000..c340b3195fca
>> --- /dev/null
>> +++ b/tools/perf/tests/config-fragments/config
>> @@ -0,0 +1,11 @@
>> +CONFIG_TRACEPOINTS=y
>> +CONFIG_STACKTRACE=y
>> +CONFIG_NOP_TRACER=y
>> +CONFIG_RING_BUFFER=y
>> +CONFIG_EVENT_TRACING=y
>> +CONFIG_CONTEXT_SWITCH_TRACER=y
>> +CONFIG_TRACING=y
>> +CONFIG_GENERIC_TRACER=y
>> +CONFIG_FTRACE=y
>> +CONFIG_FTRACE_SYSCALLS=y
>> +CONFIG_BRANCH_PROFILE_NONE=y
>> -- 
>> 2.34.1
>>
> 
