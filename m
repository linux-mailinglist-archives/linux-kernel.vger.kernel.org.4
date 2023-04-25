Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6178E6EDEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjDYJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjDYJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:14:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C552510FE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:14:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841D94B3;
        Tue, 25 Apr 2023 02:15:30 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59673F587;
        Tue, 25 Apr 2023 02:14:45 -0700 (PDT)
Message-ID: <55ed1d19-cce9-b9b0-30d6-21b5ee3e5fe9@arm.com>
Date:   Tue, 25 Apr 2023 10:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] coresight: perf: Release Coresight path when alloc trace
 id failed
Content-Language: en-US
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230425032416.125542-1-tianruidong@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230425032416.125542-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 04:24, Ruidong Tian wrote:
> Error handler for etm_setup_aux can not release coresight path because
> cpu mask was cleared when coresight_trace_id_get_cpu_id failed.
> 
> Call coresight_release_path function explicitly when alloc trace id filed.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>

Good catch, I will queue this.

Thanks
Suzuki

> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 711f451b6946..89e8ed214ea4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -402,6 +402,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		trace_id = coresight_trace_id_get_cpu_id(cpu);
>   		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>   			cpumask_clear_cpu(cpu, mask);
> +			coresight_release_path(path);
>   			continue;
>   		}
>   

