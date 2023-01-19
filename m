Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED16737BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjASMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:00:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED18E6F88E;
        Thu, 19 Jan 2023 04:00:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9267176A;
        Thu, 19 Jan 2023 04:00:45 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9441D3F71A;
        Thu, 19 Jan 2023 04:00:02 -0800 (PST)
Message-ID: <546f218f-3ac9-8fc2-c843-2f2f16882f31@arm.com>
Date:   Thu, 19 Jan 2023 12:00:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 00/15] coresight: Add new API to allocate trace source
 ID values
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
References: <20230116124928.5440-1-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 16/01/2023 12:49, Mike Leach wrote:
> The current method for allocating trace source ID values to sources is
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM is allocated ID 0x1.
> 
> This fixed algorithm is used in both the CoreSight driver code, and by
> perf when writing the trace metadata in the AUXTRACE_INFO record.
> 
> The method needs replacing as currently:-
> 1. It is inefficient in using available IDs.
> 2. Does not scale to larger systems with many cores and the algorithm
> has no limits so will generate invalid trace IDs for cpu number > 44.
> 
> Additionally requirements to allocate additional system IDs on some
> systems have been seen.
> 
> This patch set  introduces an API that allows the allocation of trace IDs
> in a dynamic manner.
> 
> Architecturally reserved IDs are never allocated, and the system is
> limited to allocating only valid IDs.
> 
> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> the new API.
> 
> For the ETMx.x devices IDs are allocated on certain events
> a) When using sysfs, an ID will be allocated on hardware enable, or a read of
> sysfs TRCTRACEID register and freed when the sysfs reset is written.
> 
> b) When using perf, ID is allocated on during setup AUX event, and freed on
> event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> The ID allocator is notified when perf sessions start and stop
> so CPU based IDs are kept constant throughout any perf session.
> 
> 
> Note: This patchset breaks some backward compatibility for perf record and
> perf report.
> 
> The version of the AUXTRACE_INFO has been updated to reflect the fact that
> the trace source IDs are generated differently. This will
> mean older versions of perf report cannot decode the newer file.
> 
> Appies to coresight/next
> 
> Changes since v6:
> 1) Export perf_report_aux_output_id() Acked by Peter,
> 2) Update to ETMv3 docs requested by suzuki
> 3) rebased and re-tested on coresight/next (6.2-rc2)
> 
> Changes since v5: (requested by suzuki)
> 1) Prefer odd ID values for system IDs to avoid overlap with legacy CPU IDs
> 2) Some style changes
> 
> Changes since v4:
> 1) update to ensure that compiling after each individual patch added still
> works - ie. git bisect not broken through the patchset..
> 
> 2) Revision to some of the now redundant code in cs-etm (James)
> 
> 3) Comments and other minor fixes requested by Suzuki.
> 
> Changes since v3:
> 1) Fixed aarch32 build error in ETM3.x driver.
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Changes since v2:
> 1) Improved backward compatibility: (requested by James)
> 
> Using the new version of perf on an old kernel will generate a usable file
> legacy metadata values are set by the new perf and will be used if mew
> ID packets are not present in the file.
> 
> Using an older version of perf / simpleperf on an updated kernel may still
> work. The trace ID allocator has been updated to use the legacy ID values
> where possible, so generated file and used trace IDs will match up to the
> point where the legacy algorithm is broken anyway.
> 
> 2) Various changes to the ID allocator and ID packet format.
> (suggested by Suzuki)
> 
> 3) per CPU ID info in allocator now stored as atomic type to allow a passive read
> without taking the allocator spinlock. perf flow now allocates and releases ID
> values in setup_aux / free_event. Device enable and event enable use the passive
> read to set the allocated values. This simplifies the locking mechanisms on the
> perf run and fixes issues that arose with locking dependencies.
> 
> Changes since v1:
> (after feedback & discussion with Mathieu & Suzuki).
> 
> 1) API has changed. The global trace ID map is managed internally, so it
> is no longer passed in to the API functions.
> 
> 2) perf record does not use sysfs to find the trace IDs. These are now
> output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
> have been updated accordingly to generate and handle these events.
> 
> Mike Leach (15):
>    coresight: trace-id: Add API to dynamically assign Trace ID values
>    coresight: Remove obsolete Trace ID unniqueness checks
>    coresight: perf: traceid: Add perf ID allocation and notifiers
>    coresight: stm: Update STM driver to use Trace ID API
>    coresight: etm4x: Update ETM4 driver to use Trace ID API
>    coresight: etm3x: Update ETM3 driver to use Trace ID API
>    coresight: etmX.X: stm: Remove trace_id() callback
>    coresight: trace id: Remove legacy get trace ID function.
>    perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>    perf: cs-etm: Update record event to use new Trace ID protocol
>    kernel: events: Export perf_report_aux_output_id()
>    perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>    coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>    coresight: trace-id: Add debug & test macros to Trace ID allocation
>    coresight: etm3x: docs: Alter sysfs documentation for trace id updates

I have pushed the kernel patches on this series to coresight tree next[0].

I will be sending them out to Greg for v6.3. Please could you queue the
perf tool changes in the series ? i.e., Patches 9,10 and 12.


[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next


Kind regards
Suzuki


