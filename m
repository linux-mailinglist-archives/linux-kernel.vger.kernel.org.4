Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4015621CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKHTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKHTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:14:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05E401CFDB;
        Tue,  8 Nov 2022 11:14:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57A401FB;
        Tue,  8 Nov 2022 11:14:37 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776F73F703;
        Tue,  8 Nov 2022 11:14:29 -0800 (PST)
Message-ID: <73d7a338-08f8-73e7-fab0-99dd36de92e7@arm.com>
Date:   Tue, 8 Nov 2022 19:14:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 01/14] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 16:30, Mike Leach wrote:
> The existing mechanism to assign Trace ID values to sources is limited
> and does not scale for larger multicore / multi trace source systems.
> 
> The API introduces functions that reserve IDs based on availabilty
> represented by a coresight_trace_id_map structure. This records the
> used and free IDs in a bitmap.
> 
> CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
> coresight_trace_id_put_cpu_id pair of functions. The API will record
> the ID associated with the CPU. This ensures that the same ID will be
> re-used while perf events are active on the CPU. The put_cpu_id function
> will pend release of the ID until all perf cs_etm sessions are complete.
> 
> For backward compatibility the functions will attempt to use the same
> CPU IDs as the legacy system would have used if these are still available.
> 
> Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> coresight_trace_id_put_system_id.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   4 +
>   .../hwtracing/coresight/coresight-trace-id.c  | 225 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-trace-id.h  | 154 ++++++++++++
>   include/linux/coresight-pmu.h                 |  10 +
>   5 files changed, 394 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> 

> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> new file mode 100644
> index 000000000000..1d27977346b3
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h

> +/* check an ID is in the valid range */
> +#define IS_VALID_ID(id)	\
> +	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))

Please could we make this more explicit as it is also used
by code outside the trace-id.c ? i.e, IS_VALID_TRACEID() ?
This stood out, while looking at the users of this helper.

Suzuki

