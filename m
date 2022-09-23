Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E975E787A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiIWKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIWKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:35:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F3D5AC61;
        Fri, 23 Sep 2022 03:35:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9281413D5;
        Fri, 23 Sep 2022 03:35:09 -0700 (PDT)
Received: from [10.57.2.155] (unknown [10.57.2.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ED743F73D;
        Fri, 23 Sep 2022 03:35:00 -0700 (PDT)
Message-ID: <6f2e16b5-7fec-3d54-21ef-dd42acfab553@arm.com>
Date:   Fri, 23 Sep 2022 11:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/5] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220525154114.718321-1-james.clark@arm.com>
 <Yo+bdSMUOkd1N4HE@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Yo+bdSMUOkd1N4HE@kernel.org>
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



On 26/05/2022 16:23, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 25, 2022 at 04:41:09PM +0100, James Clark escreveu:
>> Changes since v2:
>>   * Add commit to fix header include path to use Perf's copy
>>   * Apply Leo's review tags
>>
>> When SVE registers are pushed onto the stack the VG register is required to
>> unwind because the stack offsets would vary by the SVE register width at the
>> time when the sample was taken.
>>
>> The patches ("[PATCH v2 0/2] perf: arm64: Kernel support for Dwarf unwinding
>> through SVE functions") add support for sampling the VG register to the kernel
>> and the docs. This is the patchset to add support to userspace perf.
>>
>> A small change is also required to libunwind or libdw depending on which
>> unwinder is used, and these will be published later. Without these changes Perf
>> continues to work with both libraries, although the VG register is still not
>> used for unwinding. 
> 
> Thanks, applied.
> 
> - Arnaldo

Hi Arnaldo,

Will has applied the kernel side here:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=cbb0c02caf4bd98b9e0cd6d7420734b8e9a35703

There was a small change in the formatting in perf_regs.h, but the
values are all the same. So in theory it's fine to leave Perf's copy
until the next update, although it is a bit weird.

Thanks
James

> 
>  
>> Thanks
>> James
>>
>> James Clark (5):
>>   perf tools: arm64: Use perf's copy of kernel headers
>>   perf tools: arm64: Copy perf_regs.h from the kernel
>>   perf tools: Use dynamic register set for Dwarf unwind
>>   perf tools: arm64: Decouple Libunwind register names from Perf
>>   perf tools: arm64: Add support for VG register
>>
>>  tools/arch/arm64/include/uapi/asm/perf_regs.h |  7 +-
>>  tools/perf/arch/arm64/util/perf_regs.c        | 34 +++++++++
>>  tools/perf/arch/arm64/util/unwind-libunwind.c | 73 +------------------
>>  tools/perf/util/evsel.c                       |  2 +-
>>  tools/perf/util/libunwind/arm64.c             |  2 +-
>>  tools/perf/util/perf_regs.c                   |  2 +
>>  6 files changed, 46 insertions(+), 74 deletions(-)
>>
>> -- 
>> 2.28.0
> 
