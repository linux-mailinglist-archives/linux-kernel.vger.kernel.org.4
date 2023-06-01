Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC771A217
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjFAPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjFAPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:10:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05069E74;
        Thu,  1 Jun 2023 08:10:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D851063;
        Thu,  1 Jun 2023 08:10:46 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC563F663;
        Thu,  1 Jun 2023 08:09:59 -0700 (PDT)
Message-ID: <2a081ab9-f1f3-569e-72e8-1c743e8357a1@arm.com>
Date:   Thu, 1 Jun 2023 16:09:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] perf: arm_cspmu: Support implementation specific
 event validation
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
 <20230601030144.3458136-5-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230601030144.3458136-5-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-01 04:01, Ilkka Koskinen wrote:
> Some platforms may use e.g. different filtering mechanism and, thus,
> may need different way to validate the events.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 4 ++++
>   drivers/perf/arm_cspmu/arm_cspmu.h | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index b4c4ef81c719..a26f484e06b1 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -593,6 +593,10 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>   	if (idx >= cspmu->num_logical_ctrs)
>   		return -EAGAIN;
>   
> +	if (cspmu->impl.ops.validate_event &&
> +	    !cspmu->impl.ops.validate_event(cspmu, event))
> +		return -EAGAIN;

Seems like this should be -EINVAL, or maybe the callback should return 
int so it can make its own distinction (yes, I know the outer logic 
doesn't actually propagate it, but there's no reason that couldn't 
improve at some point as well).

Another thought is that once we get into imp-def conditions for whether 
an event is valid in itself, we presumably also need to consider imp-def 
conditions for whether a given pair of events are compatible to be grouped?

Thanks,
Robin.

> +
>   	set_bit(idx, hw_events->used_ctrs);
>   
>   	return idx;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 4a29b921f7e8..0e5c316c96f9 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -106,6 +106,8 @@ struct arm_cspmu_impl_ops {
>   	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>   			      struct hw_perf_event *hwc,
>   			      u32 filter);
> +	/* Implementation specific event validation */
> +	bool (*validate_event)(struct arm_cspmu *cspmu, struct perf_event *new);
>   	/* Hide/show unsupported events */
>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>   					 struct attribute *attr, int unused);
