Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70471FF50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjFBK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjFBK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043FEE61
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:26:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BA41063;
        Fri,  2 Jun 2023 03:26:30 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2BA3F7BD;
        Fri,  2 Jun 2023 03:25:43 -0700 (PDT)
Message-ID: <81f0fbed-e4f4-f3a0-c269-3834a2fa6cd5@arm.com>
Date:   Fri, 2 Jun 2023 11:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 1/4] perf/arm_cspmu: Fix event attribute type
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc:     mark.rutland@arm.com, bwicaksono@nvidia.com,
        ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1685619571.git.robin.murphy@arm.com>
 <83b65c432db89df0427c2d55e09c643264299f08.1685619571.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <83b65c432db89df0427c2d55e09c643264299f08.1685619571.git.robin.murphy@arm.com>
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

On 01/06/2023 12:59, Robin Murphy wrote:
> ARM_CSPMU_EVENT_ATTR() defines a struct perf_pmu_events_attr, so
> arm_cspmu_sysfs_event_show() should not be interpreting it as struct
> dev_ext_attribute.
> 
> Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index a3f1c410b417..72dc7a9e1ca8 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -189,10 +189,10 @@ static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
>   ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
>   				struct device_attribute *attr, char *buf)
>   {
> -	struct dev_ext_attribute *eattr =
> -		container_of(attr, struct dev_ext_attribute, attr);
> -	return sysfs_emit(buf, "event=0x%llx\n",
> -			  (unsigned long long)eattr->var);
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, typeof(*pmu_attr), attr);
> +	return sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
>   }

Thanks for catching this !  The other option would be to, which was
the original intention.

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h 
b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..b5e454be95b3 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -32,7 +32,7 @@
         ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_sysfs_format_show, (char 
*)_config)

  #define ARM_CSPMU_EVENT_ATTR(_name, _config)			                   \
-       PMU_EVENT_ATTR_ID(_name, arm_cspmu_sysfs_event_show, _config)
+       ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_sysfs_event_show, 
(void*)(unsigned long)_config)


  /* Default event id mask */

Either way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

