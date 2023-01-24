Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8A6796C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjAXLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjAXLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:36:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58DC273D;
        Tue, 24 Jan 2023 03:36:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46D51FB;
        Tue, 24 Jan 2023 03:36:54 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7CC3F64C;
        Tue, 24 Jan 2023 03:36:11 -0800 (PST)
Message-ID: <5b7df6df-0c2d-6953-0f50-e85745cb1f4b@arm.com>
Date:   Tue, 24 Jan 2023 11:36:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 00/15] coresight: Add new API to allocate trace source
 ID values
Content-Language: en-US
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
In-Reply-To: <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo

Gentle ping.

On 19/01/2023 12:00, Suzuki K Poulose wrote:
> Hi Arnaldo,
> 
> On 16/01/2023 12:49, Mike Leach wrote:
>> The current method for allocating trace source ID values to sources is
>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
>> The STM is allocated ID 0x1.
>>
>> This fixed algorithm is used in both the CoreSight driver code, and by
>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>
>> The method needs replacing as currently:-
>> 1. It is inefficient in using available IDs.
>> 2. Does not scale to larger systems with many cores and the algorithm
>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>
>> Additionally requirements to allocate additional system IDs on some
>> systems have been seen.
>>
>> This patch set  introduces an API that allows the allocation of trace IDs
>> in a dynamic manner.
>>
>> Architecturally reserved IDs are never allocated, and the system is
>> limited to allocating only valid IDs.
>>
>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to 
>> use
>> the new API.
>>
>> For the ETMx.x devices IDs are allocated on certain events
>> a) When using sysfs, an ID will be allocated on hardware enable, or a 
>> read of
>> sysfs TRCTRACEID register and freed when the sysfs reset is written.
>>
>> b) When using perf, ID is allocated on during setup AUX event, and 
>> freed on
>> event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
>> The ID allocator is notified when perf sessions start and stop
>> so CPU based IDs are kept constant throughout any perf session.
>>
>>
>> Note: This patchset breaks some backward compatibility for perf record 
>> and
>> perf report.
>>
>> The version of the AUXTRACE_INFO has been updated to reflect the fact 
>> that
>> the trace source IDs are generated differently. This will
>> mean older versions of perf report cannot decode the newer file.
>>
>> Appies to coresight/next
>>

...

>> Mike Leach (15):
>>    coresight: trace-id: Add API to dynamically assign Trace ID values
>>    coresight: Remove obsolete Trace ID unniqueness checks
>>    coresight: perf: traceid: Add perf ID allocation and notifiers
>>    coresight: stm: Update STM driver to use Trace ID API
>>    coresight: etm4x: Update ETM4 driver to use Trace ID API
>>    coresight: etm3x: Update ETM3 driver to use Trace ID API
>>    coresight: etmX.X: stm: Remove trace_id() callback
>>    coresight: trace id: Remove legacy get trace ID function.
>>    perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>>    perf: cs-etm: Update record event to use new Trace ID protocol
>>    kernel: events: Export perf_report_aux_output_id()
>>    perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>>    coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>>    coresight: trace-id: Add debug & test macros to Trace ID allocation
>>    coresight: etm3x: docs: Alter sysfs documentation for trace id updates
> 
> I have pushed the kernel patches on this series to coresight tree next[0].
> 
> I will be sending them out to Greg for v6.3. Please could you queue the
> perf tool changes in the series ? i.e., Patches 9,10 and 12.
> 
> 
> [0] 
> https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next
> 

Please could you pick up the perf tool changes above ?

Suzuki

