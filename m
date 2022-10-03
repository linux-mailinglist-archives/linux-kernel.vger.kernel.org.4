Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697C5F2F47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJCLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJCLGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:06:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44AC402C9;
        Mon,  3 Oct 2022 04:06:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BAD313D5;
        Mon,  3 Oct 2022 04:06:59 -0700 (PDT)
Received: from [10.57.65.226] (unknown [10.57.65.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEEF23F792;
        Mon,  3 Oct 2022 04:06:50 -0700 (PDT)
Message-ID: <231e1e51-ab6c-2084-bb97-0594eb5fcbad@arm.com>
Date:   Mon, 3 Oct 2022 12:06:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 13/13] coresight: trace-id: Add debug & test macros to
 Trace ID allocation
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220809223401.24599-1-mike.leach@linaro.org>
 <20220809223401.24599-14-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220809223401.24599-14-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 23:34, Mike Leach wrote:
> Adds in a number of pr_debug macros to allow the debugging and test of
> the trace ID allocation system.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-trace-id.c  | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index ac9092896dec..24c19ff493a9 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -69,6 +69,30 @@ static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_ma
>   	set_bit(id, id_map->pend_rel_ids);
>   }
>   
> +/* #define TRACE_ID_DEBUG 1 */
> +#ifdef TRACE_ID_DEBUG
> +static char page_buf[PAGE_SIZE];
> +
> +static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
> +					  const char *func_name)
> +{
> +	pr_debug("%s id_map::\n", func_name);
> +	bitmap_print_to_pagebuf(0, page_buf, id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
> +	pr_debug("Avial= %s\n", page_buf);

Could we not use %pb directly and skip the bitmap_print_to_pagebuf  ?

Suzuki
