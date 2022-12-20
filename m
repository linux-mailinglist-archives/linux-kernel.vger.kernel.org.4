Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511B1651EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLTKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiLTKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:22:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD3129FE9;
        Tue, 20 Dec 2022 02:22:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857892F4;
        Tue, 20 Dec 2022 02:23:18 -0800 (PST)
Received: from [10.57.12.74] (unknown [10.57.12.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A50E3F71A;
        Tue, 20 Dec 2022 02:22:34 -0800 (PST)
Message-ID: <6f7291d7-ed3d-2ed2-654f-b8ba1a63cbad@arm.com>
Date:   Tue, 20 Dec 2022 10:22:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] perf event: Add simd_flags field to perf_sample
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, robh@kernel.org,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221219161259.3097213-1-james.clark@arm.com>
 <20221219161259.3097213-2-james.clark@arm.com>
 <CAM9d7chFXKTcD80dLkFLwQVT9M+k0oRSB5C7gXUXUS2OZ0UusQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7chFXKTcD80dLkFLwQVT9M+k0oRSB5C7gXUXUS2OZ0UusQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2022 18:21, Namhyung Kim wrote:
> Hi James,
> 
> On Mon, Dec 19, 2022 at 8:13 AM James Clark <james.clark@arm.com> wrote:
>>
>> From: German Gomez <german.gomez@arm.com>
>>
>> Add new field to the struct perf_sample to store flags related to SIMD
>> ops.
>>
>> It will be used to store SIMD information from SVE and NEON when
>> profiling using ARM SPE.
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/sample.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
>> index 60ec79d4eea4..bdf52faf165f 100644
>> --- a/tools/perf/util/sample.h
>> +++ b/tools/perf/util/sample.h
>> @@ -66,6 +66,18 @@ struct aux_sample {
>>         void *data;
>>  };
>>
>> +struct simd_flags {
>> +       u64     arch:1, /* architecture (isa) */
>> +               pred:2; /* predication */
> 
> Can we reserve more bits for possible future extension or
> other arch support?  It seems to be too tight for each field.
> Do you plan to add more info to the struct in the future?

As far as I can see because this is userspace only, reserving bits
doesn't be done ahead of time. When we need more bits we can just add
it. It never gets written to a file either so there is no need for
backwards compatibility.

> 
> Thanks,
> Namhyung
> 
> 
>> +};
>> +
>> +/* simd architecture flags */
>> +#define SIMD_OP_FLAGS_ARCH_SVE         0x01    /* ARM SVE */
>> +
>> +/* simd predicate flags */
>> +#define SIMD_OP_FLAGS_PRED_PARTIAL     0x01    /* partial predicate */
>> +#define SIMD_OP_FLAGS_PRED_EMPTY       0x02    /* empty predicate */
>> +
>>  struct perf_sample {
>>         u64 ip;
>>         u32 pid, tid;
>> @@ -103,6 +115,7 @@ struct perf_sample {
>>         struct stack_dump user_stack;
>>         struct sample_read read;
>>         struct aux_sample aux_sample;
>> +       struct simd_flags simd_flags;
>>  };
>>
>>  /*
>> --
>> 2.25.1
>>
