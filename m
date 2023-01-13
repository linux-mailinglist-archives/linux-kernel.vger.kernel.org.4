Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D3669E45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjAMQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAMQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:37:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08FDF0B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673627553; x=1705163553;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Cp9fXTqZLCZ4Ksu6mCfGuvAO0cJOR4vjVhinTZ6ZuTk=;
  b=ZcnU8BT9CiyuEBV2sOPKFRULEQC7o6sfx5NWUlLyPVu3rrgSC1lgIpLV
   BJXs8WJgqoX5IIk5TJujVca10ki0arG8nqjjTFCnYTZDyVgO0MpFfvL1g
   lc0elyTUVF9eCWm5tG3l9XHSZo6erD3pfv7agQfY354hSbUGGylE/yqjW
   Ox2IY4ZDZrGr3ocXvpisTlH7QeUWmmTLHwenQPQq8srsabRMSFp1AmfH1
   7RcZyyfw1Na898HdSmVvjNFFDX3SOCFmYxQ6sBzyvrV+zdCkqvortWS/x
   ukynA7lHRb8RsuBU8r5onAfFnSqyAi4agiiB+J6UemnjWrZREHkNM9Q1y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410267709"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="410267709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 08:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="903619349"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="903619349"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2023 08:32:32 -0800
Received: from [10.252.208.111] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E28BF58068A;
        Fri, 13 Jan 2023 08:32:30 -0800 (PST)
Message-ID: <d94621d0-8cc8-bb2e-7323-97e500b6a3fa@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:32:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/7] iommu/vt-d: Retrieve IOMMU perfmon capability
 information
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-3-kan.liang@linux.intel.com>
 <63905ff2-ee69-39de-507f-b02ebad39444@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <63905ff2-ee69-39de-507f-b02ebad39444@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-13 7:58 a.m., Baolu Lu wrote:
> On 2023/1/12 4:24, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The performance monitoring infrastructure, perfmon, is to support
>> collection of information about key events occurring during operation of
>> the remapping hardware, to aid performance tuning and debug. Each
>> remapping hardware unit has capability registers that indicate support
>> for performance monitoring features and enumerate the capabilities.
>>
>> Add alloc_iommu_pmu() to retrieve IOMMU perfmon capability information
>> for each iommu unit. The information is stored in the iommu->pmu data
>> structure. Capability registers are read-only, so it's safe to prefetch
>> and store them in the pmu structure. This could avoid unnecessary VMEXIT
>> when this code is running in the virtualization environment.
>>
>> Add free_iommu_pmu() to free the saved capability information when
>> freeing the iommu unit.
>>
>> Add a kernel config option for the IOMMU perfmon feature. Unless a user
>> explicitly uses the perf tool to monitor the IOMMU perfmon event, there
>> isn't any impact for the existing IOMMU. Enable it by default.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   drivers/iommu/intel/Kconfig   |   9 ++
>>   drivers/iommu/intel/Makefile  |   1 +
>>   drivers/iommu/intel/dmar.c    |   7 ++
>>   drivers/iommu/intel/iommu.h   |  41 +++++++++
>>   drivers/iommu/intel/perfmon.c | 159 ++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel/perfmon.h |  41 +++++++++
>>   6 files changed, 258 insertions(+)
>>   create mode 100644 drivers/iommu/intel/perfmon.c
>>   create mode 100644 drivers/iommu/intel/perfmon.h
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index b7dff5092fd2..1a4aebddc9a6 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -96,4 +96,13 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>         passing intel_iommu=sm_on to the kernel. If not sure, please use
>>         the default value.
>>   +config INTEL_IOMMU_PERF_EVENTS
>> +    def_bool y
>> +    bool "Intel IOMMU performance events"
>> +    depends on INTEL_IOMMU && PERF_EVENTS
>> +    help
>> +      Include support for Intel IOMMU performance events. These are
>> +      available on modern processors which support Intel VT-d 4.0 and
>> +      later.
>> +
>>   endif # INTEL_IOMMU
>> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
>> index fa0dae16441c..7af3b8a4f2a0 100644
>> --- a/drivers/iommu/intel/Makefile
>> +++ b/drivers/iommu/intel/Makefile
>> @@ -6,3 +6,4 @@ obj-$(CONFIG_DMAR_PERF) += perf.o
>>   obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
>>   obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
>>   obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
>> +obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 6a411d964474..91bb48267df2 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -34,6 +34,7 @@
>>   #include "../irq_remapping.h"
>>   #include "perf.h"
>>   #include "trace.h"
>> +#include "perfmon.h"
>>     typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
>>   struct dmar_res_callback {
>> @@ -1114,6 +1115,9 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>>       if (sts & DMA_GSTS_QIES)
>>           iommu->gcmd |= DMA_GCMD_QIE;
>>   +    if (alloc_iommu_pmu(iommu))
>> +        pr_debug("Cannot alloc PMU for iommu (seq_id = %d)\n",
>> iommu->seq_id);
>> +
>>       raw_spin_lock_init(&iommu->register_lock);
>>         /*
>> @@ -1148,6 +1152,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>>   err_sysfs:
>>       iommu_device_sysfs_remove(&iommu->iommu);
>>   err_unmap:
>> +    free_iommu_pmu(iommu);
>>       unmap_iommu(iommu);
>>   error_free_seq_id:
>>       ida_free(&dmar_seq_ids, iommu->seq_id);
>> @@ -1163,6 +1168,8 @@ static void free_iommu(struct intel_iommu *iommu)
>>           iommu_device_sysfs_remove(&iommu->iommu);
>>       }
>>   +    free_iommu_pmu(iommu);
>> +
>>       if (iommu->irq) {
>>           if (iommu->pr_irq) {
>>               free_irq(iommu->pr_irq, iommu);
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 06e61e474856..5bcefbea55c9 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -125,6 +125,11 @@
>>   #define DMAR_MTRR_PHYSMASK8_REG 0x208
>>   #define DMAR_MTRR_PHYSBASE9_REG 0x210
>>   #define DMAR_MTRR_PHYSMASK9_REG 0x218
>> +#define DMAR_PERFCAP_REG    0x300
>> +#define DMAR_PERFCFGOFF_REG    0x310
>> +#define DMAR_PERFOVFOFF_REG    0x318
>> +#define DMAR_PERFCNTROFF_REG    0x31c
>> +#define DMAR_PERFEVNTCAP_REG    0x380
>>   #define DMAR_VCCAP_REG        0xe30 /* Virtual command capability
>> register */
>>   #define DMAR_VCMD_REG        0xe00 /* Virtual command register */
>>   #define DMAR_VCRSP_REG        0xe10 /* Virtual command response
>> register */
>> @@ -148,6 +153,7 @@
>>    */
>>   #define cap_esrtps(c)        (((c) >> 63) & 1)
>>   #define cap_esirtps(c)        (((c) >> 62) & 1)
>> +#define cap_ecmds(c)        (((c) >> 61) & 1)
>>   #define cap_fl5lp_support(c)    (((c) >> 60) & 1)
>>   #define cap_pi_support(c)    (((c) >> 59) & 1)
>>   #define cap_fl1gp_support(c)    (((c) >> 56) & 1)
>> @@ -179,6 +185,7 @@
>>    * Extended Capability Register
>>    */
>>   +#define ecap_pms(e)        (((e) >> 51) & 0x1)
>>   #define    ecap_rps(e)        (((e) >> 49) & 0x1)
>>   #define ecap_smpwc(e)        (((e) >> 48) & 0x1)
>>   #define ecap_flts(e)        (((e) >> 47) & 0x1)
>> @@ -210,6 +217,22 @@
>>   #define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
>>   #define ecap_sc_support(e)    (((e) >> 7) & 0x1) /* Snooping Control */
>>   +/*
>> + * Decoding Perf Capability Register
>> + */
>> +#define pcap_num_cntr(p)    ((p) & 0xffff)
>> +#define pcap_cntr_width(p)    (((p) >> 16) & 0x7f)
>> +#define pcap_num_event_group(p)    (((p) >> 24) & 0x1f)
>> +#define pcap_filters_mask(p)    (((p) >> 32) & 0x1f)
>> +#define pcap_interrupt(p)    (((p) >> 50) & 0x1)
>> +/* The counter stride is calculated as 2 ^ (x+10) bytes */
>> +#define pcap_cntr_stride(p)    (1ULL << ((((p) >> 52) & 0x7) + 10))
>> +
>> +/*
>> + * Decoding Perf Event Capability Register
>> + */
>> +#define pecap_es(p)        ((p) & 0xfffffff)
>> +
>>   /* Virtual command interface capability */
>>   #define vccap_pasid(v)        (((v) & DMA_VCS_PAS)) /* PASID
>> allocation */
>>   @@ -554,6 +577,22 @@ struct dmar_domain {
>>                          iommu core */
>>   };
>>   +struct iommu_pmu {
>> +    struct intel_iommu    *iommu;
>> +    u32            num_cntr;    /* Number of counters */
>> +    u32            num_eg;        /* Number of event group */
>> +    u32            cntr_width;    /* Counter width */
>> +    u32            cntr_stride;    /* Counter Stride */
>> +    u32            filter;        /* Bitmask of filter support */
>> +    void __iomem        *base;        /* the PerfMon base address */
>> +    void __iomem        *cfg_reg;    /* counter configuration base
>> address */
>> +    void __iomem        *cntr_reg;    /* counter 0 address*/
>> +    void __iomem        *overflow;    /* overflow status register */
>> +
>> +    u64            *evcap;        /* Indicates all supported events */
>> +    u32            **cntr_evcap;    /* Supported events of each
>> counter. */
>> +};
>> +
>>   struct intel_iommu {
>>       void __iomem    *reg; /* Pointer to hardware regs, virtual addr */
>>       u64         reg_phys; /* physical address of hw register set */
>> @@ -600,6 +639,8 @@ struct intel_iommu {
>>         struct dmar_drhd_unit *drhd;
>>       void *perf_statistic;
>> +
>> +    struct iommu_pmu *pmu;
>>   };
>>     /* PCI domain-device relationship */
>> diff --git a/drivers/iommu/intel/perfmon.c
>> b/drivers/iommu/intel/perfmon.c
>> new file mode 100644
>> index 000000000000..bc090f329c32
>> --- /dev/null
>> +++ b/drivers/iommu/intel/perfmon.c
>> @@ -0,0 +1,159 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Support Intel IOMMU PerfMon
>> + * Copyright(c) 2022 Intel Corporation.
> 
> Copyright 2023

Happy new year!

> 
>> + */
>> +
>> +#include <linux/dmar.h>
>> +#include "iommu.h"
>> +#include "perfmon.h"
>> +
>> +static inline void __iomem *
>> +get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
>> +{
>> +    u32 off = dmar_readl(iommu->reg + offset);
>> +
>> +    return iommu->reg + off;
>> +}
>> +
>> +int alloc_iommu_pmu(struct intel_iommu *iommu)
>> +{
>> +    struct iommu_pmu *iommu_pmu;
>> +    int i, j, ret;
>> +    u64 perfcap;
>> +    u32 cap;
>> +
>> +    /* The IOMMU PMU requires the ECMD support as well */
>> +    if (!ecap_pms(iommu->ecap) || !cap_ecmds(iommu->cap))
>> +        return -ENODEV;
> 
> It's normal that PMS is not supported on an IOMMU, how about,
> 
>     if (!ecap_pms(iommu->ecap))
>         return 0;
> 
>     /* The IOMMU PMU requires the ECMD support as well */
>     if (!cap_ecmds(iommu->cap))
>         return -ENODEV;

Sure

> 
>> +
>> +    perfcap = dmar_readq(iommu->reg + DMAR_PERFCAP_REG);
>> +    /* The performance monitoring is not supported. */
>> +    if (!perfcap)
>> +        return -ENODEV;
>> +
>> +    /* Sanity check for the number of the counters and event groups */
>> +    if (!pcap_num_cntr(perfcap) || !pcap_num_event_group(perfcap))
>> +        return -ENODEV;
>> +
>> +    /* The interrupt on overflow is required */
>> +    if (!pcap_interrupt(perfcap))
>> +        return -ENODEV;
>> +
>> +    iommu_pmu = kzalloc(sizeof(*iommu_pmu), GFP_KERNEL);
>> +    if (!iommu_pmu)
>> +        return -ENOMEM;
>> +
>> +    iommu_pmu->num_cntr = pcap_num_cntr(perfcap);
>> +    iommu_pmu->cntr_width = pcap_cntr_width(perfcap);
>> +    iommu_pmu->filter = pcap_filters_mask(perfcap);
>> +    iommu_pmu->cntr_stride = pcap_cntr_stride(perfcap);
>> +    iommu_pmu->num_eg = pcap_num_event_group(perfcap);
>> +
>> +    iommu_pmu->evcap = kcalloc(iommu_pmu->num_eg, sizeof(u64),
>> GFP_KERNEL);
>> +    if (!iommu_pmu->evcap) {
>> +        ret = -ENOMEM;
>> +        goto free_pmu;
>> +    }
>> +
>> +    /* Parse event group capabilities */
>> +    for (i = 0; i < iommu_pmu->num_eg; i++) {
>> +        u64 pcap;
>> +
>> +        pcap = dmar_readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
>> +                  i * IOMMU_PMU_CAP_REGS_STEP);
>> +        iommu_pmu->evcap[i] = pecap_es(pcap);
>> +    }
>> +
>> +    iommu_pmu->cntr_evcap = kcalloc(iommu_pmu->num_cntr, sizeof(u32
>> *), GFP_KERNEL);
>> +    if (!iommu_pmu->cntr_evcap) {
>> +        ret = -ENOMEM;
>> +        goto free_pmu_evcap;
>> +    }
>> +    for (i = 0; i < iommu_pmu->num_cntr; i++) {
>> +        iommu_pmu->cntr_evcap[i] = kcalloc(iommu_pmu->num_eg,
>> sizeof(u32), GFP_KERNEL);
>> +        if (!iommu_pmu->cntr_evcap[i]) {
>> +            ret = -ENOMEM;
>> +            iommu_pmu->num_cntr = i;
> 
> Do we really need above line? kfree() is friendly to a NULL pointer,
> right?

OK. I will remove it.

> 
>> +            goto free_pmu_cntr_evcap;
>> +        }
>> +        /*
>> +         * Set to the global capabilities, will adjust according
>> +         * to per-counter capabilities later.
>> +         */
>> +        for (j = 0; j < iommu_pmu->num_eg; j++)
>> +            iommu_pmu->cntr_evcap[i][j] = (u32)iommu_pmu->evcap[j];
>> +    }
>> +
>> +    iommu_pmu->cfg_reg = get_perf_reg_address(iommu,
>> DMAR_PERFCFGOFF_REG);
>> +    iommu_pmu->cntr_reg = get_perf_reg_address(iommu,
>> DMAR_PERFCNTROFF_REG);
>> +    iommu_pmu->overflow = get_perf_reg_address(iommu,
>> DMAR_PERFOVFOFF_REG);
>> +
>> +    /*
>> +     * Check per-counter capabilities
>> +     * All counters should have the same capabilities on
>> +     * Interrupt on Overflow Support and Counter Width
>> +     */
> 
> Please re-org this comment and make it neat.

OK.

> 
>> +    for (i = 0; i < iommu_pmu->num_cntr; i++) {
>> +        cap = dmar_readl(iommu_pmu->cfg_reg +
>> +                 i * IOMMU_PMU_CFG_OFFSET +
>> +                 IOMMU_PMU_CFG_CNTRCAP_OFFSET);
>> +        if (!iommu_cntrcap_pcc(cap))
>> +            continue;
>> +        if ((iommu_cntrcap_cw(cap) != iommu_pmu->cntr_width) ||
>> +            !iommu_cntrcap_ios(cap))
>> +            iommu_pmu->num_cntr = i;
> 
> Can you please add some words describing how do you handle the
> capability inconsistent case? It seems that you just truncate the number
> of counters? Any rationality behind that?

In practice, the counters have the same capabilities of Interrupt on
Overflow Support and Counter Width. The current implementation is also
based on this assumption.

But it's possible that some counters have a different capability because
of e.g., HW bug. We can check such corner case here and simply drop
those counters.

I will add some comments and print a warnning for the rare case here in V2.

Thanks,
Kan
> 
>> +
>> +        /* Clear the pre-defined events group */
>> +        for (j = 0; j < iommu_pmu->num_eg; j++)
>> +            iommu_pmu->cntr_evcap[i][j] = 0;
>> +
>> +        /* Override with per-counter event capabilities */
>> +        for (j = 0; j < iommu_cntrcap_egcnt(cap); j++) {
>> +            cap = dmar_readl(iommu_pmu->cfg_reg + i *
>> IOMMU_PMU_CFG_OFFSET +
>> +                     IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
>> +                     (j * IOMMU_PMU_OFF_REGS_STEP));
>> +            iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] =
>> iommu_event_select(cap);
>> +            /*
>> +             * Some events may only be supported by a specific counter.
>> +             * Track them in the evcap as well.
>> +             */
>> +            iommu_pmu->evcap[iommu_event_group(cap)] |=
>> iommu_event_select(cap);
>> +        }
>> +    }
>> +
>> +    iommu_pmu->iommu = iommu;
>> +    iommu->pmu = iommu_pmu;
>> +
>> +    return 0;
>> +
>> +free_pmu_cntr_evcap:
>> +    for (i = 0; i < iommu_pmu->num_cntr; i++)
>> +        kfree(iommu_pmu->cntr_evcap[i]);
>> +    kfree(iommu_pmu->cntr_evcap);
>> +free_pmu_evcap:
>> +    kfree(iommu_pmu->evcap);
>> +free_pmu:
>> +    kfree(iommu_pmu);
>> +
>> +    return ret;
>> +}
>> +
>> +void free_iommu_pmu(struct intel_iommu *iommu)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu->pmu;
>> +
>> +    if (!iommu_pmu)
>> +        return;
>> +
>> +    if (iommu_pmu->evcap) {
>> +        int i;
>> +
>> +        for (i = 0; i < iommu_pmu->num_cntr; i++)
>> +            kfree(iommu_pmu->cntr_evcap[i]);
>> +        kfree(iommu_pmu->cntr_evcap);
>> +    }
>> +    kfree(iommu_pmu->evcap);
>> +    kfree(iommu_pmu);
>> +    iommu->pmu = NULL;
>> +}
>> diff --git a/drivers/iommu/intel/perfmon.h
>> b/drivers/iommu/intel/perfmon.h
>> new file mode 100644
>> index 000000000000..8587c80501cd
>> --- /dev/null
>> +++ b/drivers/iommu/intel/perfmon.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * PERFCFGOFF_REG, PERFFRZOFF_REG
>> + * PERFOVFOFF_REG, PERFCNTROFF_REG
>> + */
>> +#define IOMMU_PMU_NUM_OFF_REGS            4
>> +#define IOMMU_PMU_OFF_REGS_STEP            4
>> +
>> +#define IOMMU_PMU_CFG_OFFSET            0x100
>> +#define IOMMU_PMU_CFG_CNTRCAP_OFFSET        0x80
>> +#define IOMMU_PMU_CFG_CNTREVCAP_OFFSET        0x84
>> +#define IOMMU_PMU_CFG_SIZE            0x8
>> +#define IOMMU_PMU_CFG_FILTERS_OFFSET        0x4
>> +
>> +
>> +#define IOMMU_PMU_CAP_REGS_STEP            8
>> +
>> +#define iommu_cntrcap_pcc(p)            ((p) & 0x1)
>> +#define iommu_cntrcap_cw(p)            ((p >> 8) & 0xff)
>> +#define iommu_cntrcap_ios(p)            ((p >> 16) & 0x1)
>> +#define iommu_cntrcap_egcnt(p)            ((p >> 28) & 0xf)
>> +
>> +#define iommu_event_select(p)            ((p) & 0xfffffff)
>> +#define iommu_event_group(p)            ((p >> 28) & 0xf)
>> +
>> +#ifdef CONFIG_INTEL_IOMMU_PERF_EVENTS
>> +int alloc_iommu_pmu(struct intel_iommu *iommu);
>> +void free_iommu_pmu(struct intel_iommu *iommu);
>> +#else
>> +static inline int
>> +alloc_iommu_pmu(struct intel_iommu *iommu)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline void
>> +free_iommu_pmu(struct intel_iommu *iommu)
>> +{
>> +}
>> +#endif /* CONFIG_INTEL_IOMMU_PERF_EVENTS */
> 
> -- 
> Best regards,
> baolu
