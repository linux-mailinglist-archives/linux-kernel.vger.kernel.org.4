Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80636CD84F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC2LSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjC2LSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:18:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F664213;
        Wed, 29 Mar 2023 04:18:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB1C01FB;
        Wed, 29 Mar 2023 04:19:15 -0700 (PDT)
Received: from [10.57.56.86] (unknown [10.57.56.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281783F73F;
        Wed, 29 Mar 2023 04:18:29 -0700 (PDT)
Message-ID: <0ada81b0-42d7-a9fe-41ff-9476b4b68ee0@arm.com>
Date:   Wed, 29 Mar 2023 12:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v8 0/3] perf: cs-etm: Update perf to handle new Coresight
 Trace ID
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com
References: <20230329111422.3693-1-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230329111422.3693-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On 29/03/2023 12:14, Mike Leach wrote:
> The original method for allocating trace source ID values to sources was
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM was allocated ID 0x1.
> 
> This mechanism is broken for systems with more than 47 cores.
> 
> The kernel related patches the provide a fixed Trace ID allocation mechanism
> are now upstreamed.
> 
> This patchset updates the perf code to handle the changes to the trace ID
> notification mechanism that now uses the PERF_RECORD_AUX_OUTPUT_HW_ID
> packet to set Trace ID in the perf ETM decoders.
> 
> Applies to perf/core
> 
> Changes since v7:
> Split from original patchset [1] to be sent separately as kernel related
> patches are now upstream.

Please could you pull this in ? This is critical for enabling the 
CoreSight perf support on systems with > 47 cores. The kernel changes
are already in.

Suzuki


> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230116124928.5440-1-mike.leach@linaro.org/
> 
> Mike Leach (3):
>    perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>    perf: cs-etm: Update record event to use new Trace ID protocol
>    perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> 
>   tools/include/linux/coresight-pmu.h           |  47 ++-
>   tools/perf/arch/arm/util/cs-etm.c             |  21 +-
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
>   tools/perf/util/cs-etm.c                      | 326 +++++++++++++++---
>   tools/perf/util/cs-etm.h                      |  14 +-
>   5 files changed, 350 insertions(+), 65 deletions(-)
> 

