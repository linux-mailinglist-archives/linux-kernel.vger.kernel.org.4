Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDA66C375
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjAPPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjAPPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:19:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085C234D0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673881930; x=1705417930;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9UTwY7nwwPu86B6nseiEfOv/6ULJSd/t/d8MooLfmcs=;
  b=gs2mnBOMXYciyxbB8aAlyic/19MXBUFUbWKDx4qKhvT6tTO73V3CzD5o
   P230v6lYUA0E9ERf+YhjChTSGuREGHbW/D0KPMCJChRzW68feZYHf4ms1
   zsv4Y0sQKRCoxqV8BqVw1wPwm7B4pxczz4wMThXK2txoQR3sMH1Jyvg2B
   3YaCuC+dz9ZyvaHQv4CIkBEXalkewurOejegpNj0AOfmMsRvwVkS+WP7p
   /Gu53ctm6b7rmoxcyjjvROxgb0A7BWi6aWI8m3oKmjtTM514NLPH50zvY
   brff+qZ/Y8KiGYzAC18FZE04lUrGQn6zybDwtXxnr4c61o12cS34DlHQY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325748189"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="325748189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 07:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652292306"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="652292306"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2023 07:12:09 -0800
Received: from [10.209.63.19] (kliang2-mobl1.ccr.corp.intel.com [10.209.63.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CA141580931;
        Mon, 16 Jan 2023 07:12:07 -0800 (PST)
Message-ID: <dd68ac33-f418-cc1a-9ce7-3cdc97282771@linux.intel.com>
Date:   Mon, 16 Jan 2023 10:12:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/7] iommu/vt-d: Add IOMMU perfmon support
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-5-kan.liang@linux.intel.com>
 <05624df9-bea1-5e95-55d6-02ac2d93c68c@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <05624df9-bea1-5e95-55d6-02ac2d93c68c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-14 4:00 a.m., Baolu Lu wrote:
> On 2023/1/12 4:25, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Implement the IOMMU performance monitor capability, which supports the
>> collection of information about key events occurring during operation of
>> the remapping hardware, to aid performance tuning and debug.
>>
>> The IOMMU perfmon support is implemented as part of the IOMMU driver and
>> interfaces with the Linux perf subsystem.
>>
>> The IOMMU PMU has the following unique features compared with the other
>> PMUs.
>> - Support counting. Not support sampling.
>> - Does not support per-thread counting. The scope is system-wide.
>> - Support per-counter capability register. The event constraints can be
>>    enumerated.
>> - The available event and event group can also be enumerated.
>> - Extra Enhanced Commands are introduced to control the counters.
>>
>> Add a new variable, struct iommu_pmu *pmu, to in the struct intel_iommu
>> to track the PMU related information.
>>
>> Add iommu_pmu_register() and iommu_pmu_unregister() to register and
>> unregister a IOMMU PMU. The register function setup the IOMMU PMU ops
>> and invoke the standard perf_pmu_register() interface to register a PMU
>> in the perf subsystem. This patch only exposes the functions. The
>> following patch will enable them in the IOMMU driver.
>>
>> The IOMMU PMUs can be found under /sys/bus/event_source/devices/dmar*
>>
>> The available filters and event format can be found at the format folder
>>   $ ls /sys/bus/event_source/devices/dmar0/format/
>> event  event_group  filter_ats  filter_page_table
>>
>> The supported events can be found at the events folder
>>
>>   $ ls /sys/bus/event_source/devices/dmar0/events/
>> ats_blocked        int_cache_hit_nonposted  iommu_mrds
>> pasid_cache_lookup
>> ctxt_cache_hit     int_cache_hit_posted     iommu_requests
>> pg_req_posted
>> ctxt_cache_lookup  int_cache_lookup         iotlb_hit
>> pw_occupancy
>> fs_nonleaf_hit     iommu_clocks             iotlb_lookup
>> ss_nonleaf_hit
>> fs_nonleaf_lookup  iommu_mem_blocked        pasid_cache_hit
>> ss_nonleaf_lookup
>>
>> The command below illustrates filter usage with a simple example.
>>
>>   $ perf stat -e dmar0/iommu_requests,filter_ats=0/ -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>                2135      dmar0/iommu_requests,filter_ats=0/
>>
>>         1.001087695 seconds time elapsed
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   .../sysfs-bus-event_source-devices-iommu      |  24 +
>>   drivers/iommu/intel/iommu.h                   |  15 +
>>   drivers/iommu/intel/perfmon.c                 | 496 ++++++++++++++++++
>>   drivers/iommu/intel/perfmon.h                 |  24 +
>>   4 files changed, 559 insertions(+)
>>   create mode 100644
>> Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>>
>> diff --git
>> a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>> b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>> new file mode 100644
>> index 000000000000..04e08851d8e6
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>> @@ -0,0 +1,24 @@
>> +What:        /sys/bus/event_source/devices/dmar*/format
>> +Date:        Jan 2023
>> +KernelVersion:  6.3
>> +Contact:    Kan Liang <kan.liang@linux.intel.com>
>> +Description:    Read-only.  Attribute group to describe the magic bits
>> +        that go into perf_event_attr.config,
>> +        perf_event_attr.config1 or perf_event_attr.config2 for
>> +        the IOMMU pmu.  (See also
>> +        ABI/testing/sysfs-bus-event_source-devices-format).
>> +
>> +        Each attribute in this group defines a bit range in
>> +        perf_event_attr.config, perf_event_attr.config1,
>> +        or perf_event_attr.config2. All supported attributes
>> +        are listed below (See the VT-d Spec 4.0 for possible
>> +        attribute values)::
>> +
>> +            event        = "config:0-27"   - event ID
>> +            event_group        = "config:28-31"  - event group ID
>> +
>> +            filter_requester_id    = "config1:0-15"  - Requester ID
>> filter
>> +            filter_domain    = "config1:16-31" - Domain ID filter
>> +            filter_pasid    = "config1:32-53" - PASID filter
> 
> Just out of curiosity, PCI PASID is 20-bit wide, why do you need 22 bits
> in config1 encoding?

The extra 2 bits are for PASID Filter Mode.

Please see Figure 11-60. Performance Monitoring PASID Filter
Configuration Registers of VT-d spec.

> 
>> +            filter_ats        = "config2:0-4"   - Address Type filter
>> +            filter_page_table    = "config2:8-12"  - Page Table Level
>> filter
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index f227107434ac..bbc5dda903e9 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -22,6 +22,7 @@
>>   #include <linux/ioasid.h>
>>   #include <linux/bitfield.h>
>>   #include <linux/xarray.h>
>> +#include <linux/perf_event.h>
>>     #include <asm/cacheflush.h>
>>   #include <asm/iommu.h>
>> @@ -601,6 +602,16 @@ struct dmar_domain {
>>                          iommu core */
>>   };
>>   +/*
>> + * In theory, the VT-d 4.0 spec can support up to 2 ^ 16 counters.
>> + * But in practice, there are only 14 counters for the existing
>> + * platform. Setting the max number of counters to 64 should be good
>> + * enough for a long time. Also, supporting more than 64 counters
>> + * requires more extras, e.g., extra freeze and overflow registers,
>> + * which is not necessary for now.
>> + */
>> +#define IOMMU_PMU_IDX_MAX        64
>> +
>>   struct iommu_pmu {
>>       struct intel_iommu    *iommu;
>>       u32            num_cntr;    /* Number of counters */
>> @@ -615,6 +626,10 @@ struct iommu_pmu {
>>         u64            *evcap;        /* Indicates all supported
>> events */
>>       u32            **cntr_evcap;    /* Supported events of each
>> counter. */
>> +
>> +    struct pmu        pmu;
>> +    DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
>> +    struct perf_event    *event_list[IOMMU_PMU_IDX_MAX];
>>   };
>>     struct intel_iommu {
>> diff --git a/drivers/iommu/intel/perfmon.c
>> b/drivers/iommu/intel/perfmon.c
>> index bc090f329c32..43a5075eaecd 100644
>> --- a/drivers/iommu/intel/perfmon.c
>> +++ b/drivers/iommu/intel/perfmon.c
>> @@ -8,6 +8,475 @@
>>   #include "iommu.h"
>>   #include "perfmon.h"
>>   +PMU_FORMAT_ATTR(event,        "config:0-27");        /* ES: Events
>> Select */
>> +PMU_FORMAT_ATTR(event_group,    "config:28-31");    /* EGI: Event
>> Group Index */
>> +
>> +static struct attribute *iommu_pmu_format_attrs[] = {
>> +    &format_attr_event_group.attr,
>> +    &format_attr_event.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group iommu_pmu_format_attr_group = {
>> +    .name = "format",
>> +    .attrs = iommu_pmu_format_attrs,
>> +};
>> +
>> +/* The available events are added in attr_update later */
>> +static struct attribute *attrs_empty[] = {
>> +    NULL
>> +};
>> +
>> +static struct attribute_group iommu_pmu_events_attr_group = {
>> +    .name = "events",
>> +    .attrs = attrs_empty,
>> +};
>> +
>> +static const struct attribute_group *iommu_pmu_attr_groups[] = {
>> +    &iommu_pmu_format_attr_group,
>> +    &iommu_pmu_events_attr_group,
>> +    NULL
>> +};
>> +
>> +static inline struct iommu_pmu *dev_to_iommu_pmu(struct device *dev)
>> +{
>> +    /*
>> +     * The perf_event creates its own dev for each PMU.
>> +     * See pmu_dev_alloc()
>> +     */
>> +    return container_of(dev_get_drvdata(dev), struct iommu_pmu, pmu);
>> +}
>> +
>> +#define IOMMU_PMU_ATTR(_name, _format, _filter)                \
>> +    PMU_FORMAT_ATTR(_name, _format);                \
>> +                                    \
>> +static struct attribute *_name##_attr[] = {                \
>> +    &format_attr_##_name.attr,                    \
>> +    NULL                                \
>> +};                                    \
>> +                                    \
>> +static umode_t                                \
>> +_name##_is_visible(struct kobject *kobj, struct attribute *attr, int
>> i)    \
>> +{                                    \
>> +    struct device *dev = kobj_to_dev(kobj);                \
>> +    struct iommu_pmu *iommu_pmu = dev_to_iommu_pmu(dev);        \
>> +                                    \
>> +    if (!iommu_pmu)                            \
>> +        return 0;                        \
>> +    return (iommu_pmu->filter & _filter) ? attr->mode : 0;        \
>> +}                                    \
>> +                                    \
>> +static struct attribute_group _name = {                    \
>> +    .name        = "format",                    \
>> +    .attrs        = _name##_attr,                    \
>> +    .is_visible    = _name##_is_visible,                \
>> +};
>> +
>> +IOMMU_PMU_ATTR(filter_requester_id,    "config1:0-15",       
>> IOMMU_PMU_FILTER_REQUESTER_ID);
>> +IOMMU_PMU_ATTR(filter_domain,        "config1:16-31",   
>> IOMMU_PMU_FILTER_DOMAIN);
>> +IOMMU_PMU_ATTR(filter_pasid,        "config1:32-53",   
>> IOMMU_PMU_FILTER_PASID);
>> +IOMMU_PMU_ATTR(filter_ats,        "config2:0-4",       
>> IOMMU_PMU_FILTER_ATS);
>> +IOMMU_PMU_ATTR(filter_page_table,    "config2:8-12",       
>> IOMMU_PMU_FILTER_PAGE_TABLE);
>> +
>> +#define iommu_pmu_get_requester_id(filter)    ((filter) & 0xffff)
>> +#define iommu_pmu_get_domain(filter)        (((filter) >> 16) & 0xffff)
>> +#define iommu_pmu_get_pasid(filter)        (((filter) >> 32) & 0x3fffff)
>> +#define iommu_pmu_get_ats(filter)        ((filter) & 0x1f)
>> +#define iommu_pmu_get_page_table(filter)    (((filter) >> 8) & 0x1f)
>> +
>> +#define iommu_pmu_set_filter(_name, _config, _filter, _idx)            \
>> +{                                        \
>> +    if ((iommu_pmu->filter & _filter) &&
>> iommu_pmu_get_##_name(_config)) {    \
>> +        dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET
>> +    \
>> +                IOMMU_PMU_CFG_SIZE +                \
>> +                (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,    \
>> +                iommu_pmu_get_##_name(_config) | IOMMU_PMU_FILTER_EN);\
>> +    }                                    \
>> +}
>> +
>> +#define iommu_pmu_clear_filter(_filter, _idx)                    \
>> +{                                        \
>> +    if (iommu_pmu->filter & _filter) {                    \
>> +        dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET
>> +    \
>> +                IOMMU_PMU_CFG_SIZE +                \
>> +                (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,    \
>> +                0);                            \
>> +    }                                    \
>> +}
>> +
>> +/*
>> + * Define the event attr related functions
>> + * Input: _name: event attr name
>> + *        _string: string of the event in sysfs
>> + *        _g_idx: event group encoding
>> + *        _event: event encoding
>> + */
>> +#define IOMMU_PMU_EVENT_ATTR(_name, _string, _g_idx,
>> _event)            \
>> +    PMU_EVENT_ATTR_STRING(_name, event_attr_##_name, _string)        \
>> +                                        \
>> +static struct attribute *_name##_attr[] = {                    \
>> +    &event_attr_##_name.attr.attr,                        \
>> +    NULL                                    \
>> +};                                        \
>> +                                        \
>> +static umode_t                                    \
>> +_name##_is_visible(struct kobject *kobj, struct attribute *attr, int
>> i)        \
>> +{                                        \
>> +    struct device *dev = kobj_to_dev(kobj);                    \
>> +    struct iommu_pmu *iommu_pmu = dev_to_iommu_pmu(dev);            \
>> +                                        \
>> +    if (!iommu_pmu)                                \
>> +        return 0;                            \
>> +    return (iommu_pmu->evcap[_g_idx] & _event) ? attr->mode :
>> 0;        \
>> +}                                        \
>> +                                        \
>> +static struct attribute_group _name = {                        \
>> +    .name        = "events",                        \
>> +    .attrs        = _name##_attr,                        \
>> +    .is_visible    = _name##_is_visible,                    \
>> +};
>> +
>> +IOMMU_PMU_EVENT_ATTR(iommu_clocks,       
>> "event_group=0x0,event=0x001", 0x0, 0x001)
>> +IOMMU_PMU_EVENT_ATTR(iommu_requests,       
>> "event_group=0x0,event=0x002", 0x0, 0x002)
>> +IOMMU_PMU_EVENT_ATTR(pw_occupancy,       
>> "event_group=0x0,event=0x004", 0x0, 0x004)
>> +IOMMU_PMU_EVENT_ATTR(ats_blocked,       
>> "event_group=0x0,event=0x008", 0x0, 0x008)
>> +IOMMU_PMU_EVENT_ATTR(iommu_mrds,       
>> "event_group=0x1,event=0x001", 0x1, 0x001)
>> +IOMMU_PMU_EVENT_ATTR(iommu_mem_blocked,       
>> "event_group=0x1,event=0x020", 0x1, 0x020)
>> +IOMMU_PMU_EVENT_ATTR(pg_req_posted,       
>> "event_group=0x1,event=0x040", 0x1, 0x040)
>> +IOMMU_PMU_EVENT_ATTR(ctxt_cache_lookup,       
>> "event_group=0x2,event=0x001", 0x2, 0x001)
>> +IOMMU_PMU_EVENT_ATTR(ctxt_cache_hit,       
>> "event_group=0x2,event=0x002", 0x2, 0x002)
>> +IOMMU_PMU_EVENT_ATTR(pasid_cache_lookup,   
>> "event_group=0x2,event=0x004", 0x2, 0x004)
>> +IOMMU_PMU_EVENT_ATTR(pasid_cache_hit,       
>> "event_group=0x2,event=0x008", 0x2, 0x008)
>> +IOMMU_PMU_EVENT_ATTR(ss_nonleaf_lookup,       
>> "event_group=0x2,event=0x010", 0x2, 0x010)
>> +IOMMU_PMU_EVENT_ATTR(ss_nonleaf_hit,       
>> "event_group=0x2,event=0x020", 0x2, 0x020)
>> +IOMMU_PMU_EVENT_ATTR(fs_nonleaf_lookup,       
>> "event_group=0x2,event=0x040", 0x2, 0x040)
>> +IOMMU_PMU_EVENT_ATTR(fs_nonleaf_hit,       
>> "event_group=0x2,event=0x080", 0x2, 0x080)
>> +IOMMU_PMU_EVENT_ATTR(hpt_nonleaf_lookup,   
>> "event_group=0x2,event=0x100", 0x2, 0x100)
>> +IOMMU_PMU_EVENT_ATTR(hpt_nonleaf_hit,       
>> "event_group=0x2,event=0x200", 0x2, 0x200)
>> +IOMMU_PMU_EVENT_ATTR(iotlb_lookup,       
>> "event_group=0x3,event=0x001", 0x3, 0x001)
>> +IOMMU_PMU_EVENT_ATTR(iotlb_hit,           
>> "event_group=0x3,event=0x002", 0x3, 0x002)
>> +IOMMU_PMU_EVENT_ATTR(hpt_leaf_lookup,       
>> "event_group=0x3,event=0x004", 0x3, 0x004)
>> +IOMMU_PMU_EVENT_ATTR(hpt_leaf_hit,       
>> "event_group=0x3,event=0x008", 0x3, 0x008)
>> +IOMMU_PMU_EVENT_ATTR(int_cache_lookup,       
>> "event_group=0x4,event=0x001", 0x4, 0x001)
>> +IOMMU_PMU_EVENT_ATTR(int_cache_hit_nonposted,   
>> "event_group=0x4,event=0x002", 0x4, 0x002)
>> +IOMMU_PMU_EVENT_ATTR(int_cache_hit_posted,   
>> "event_group=0x4,event=0x004", 0x4, 0x004)
>> +
>> +
>> +static const struct attribute_group *iommu_pmu_attr_update[] = {
>> +    &filter_requester_id,
>> +    &filter_domain,
>> +    &filter_pasid,
>> +    &filter_ats,
>> +    &filter_page_table,
>> +    &iommu_clocks,
>> +    &iommu_requests,
>> +    &pw_occupancy,
>> +    &ats_blocked,
>> +    &iommu_mrds,
>> +    &iommu_mem_blocked,
>> +    &pg_req_posted,
>> +    &ctxt_cache_lookup,
>> +    &ctxt_cache_hit,
>> +    &pasid_cache_lookup,
>> +    &pasid_cache_hit,
>> +    &ss_nonleaf_lookup,
>> +    &ss_nonleaf_hit,
>> +    &fs_nonleaf_lookup,
>> +    &fs_nonleaf_hit,
>> +    &hpt_nonleaf_lookup,
>> +    &hpt_nonleaf_hit,
>> +    &iotlb_lookup,
>> +    &iotlb_hit,
>> +    &hpt_leaf_lookup,
>> +    &hpt_leaf_hit,
>> +    &int_cache_lookup,
>> +    &int_cache_hit_nonposted,
>> +    &int_cache_hit_posted,
>> +    NULL
>> +};
>> +
>> +static inline void __iomem *
>> +iommu_event_base(struct iommu_pmu *iommu_pmu, int idx)
>> +{
>> +    return iommu_pmu->cntr_reg + idx * iommu_pmu->cntr_stride;
>> +}
>> +
>> +static inline void __iomem *
>> +iommu_config_base(struct iommu_pmu *iommu_pmu, int idx)
>> +{
>> +    return iommu_pmu->cfg_reg + idx * IOMMU_PMU_CFG_OFFSET;
>> +}
>> +
>> +static inline struct iommu_pmu *iommu_event_to_pmu(struct perf_event
>> *event)
>> +{
>> +    return container_of(event->pmu, struct iommu_pmu, pmu);
>> +}
>> +
>> +static inline u64 iommu_event_config(struct perf_event *event)
>> +{
>> +    u64 config = event->attr.config;
>> +
>> +    return (iommu_event_select(config) << IOMMU_EVENT_CFG_ES_SHIFT) |
>> +           (iommu_event_group(config) << IOMMU_EVENT_CFG_EGI_SHIFT) |
>> +           IOMMU_EVENT_CFG_INT;
>> +}
>> +
>> +static inline bool is_iommu_pmu_event(struct iommu_pmu *iommu_pmu,
>> +                      struct perf_event *event)
>> +{
>> +    return event->pmu == &iommu_pmu->pmu;
>> +}
>> +
>> +static int iommu_pmu_validate_event(struct perf_event *event)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    u32 event_group = iommu_event_group(event->attr.config);
>> +
>> +    if (event_group >= iommu_pmu->num_eg)
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static int iommu_pmu_validate_group(struct perf_event *event)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    struct perf_event *sibling;
>> +    int nr = 0;
>> +
>> +    /*
>> +     * All events in a group must be scheduled simultaneously.
>> +     * Check whether there is enough counters for all the events.
>> +     */
>> +    for_each_sibling_event(sibling, event->group_leader) {
>> +        if (!is_iommu_pmu_event(iommu_pmu, sibling) ||
>> +            sibling->state <= PERF_EVENT_STATE_OFF)
>> +            continue;
>> +
>> +        if (++nr > iommu_pmu->num_cntr)
>> +            return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int iommu_pmu_event_init(struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +
>> +    if (event->attr.type != event->pmu->type)
>> +        return -ENOENT;
>> +
>> +    /* sampling not supported */
>> +    if (event->attr.sample_period)
>> +        return -EINVAL;
>> +
>> +    if (event->cpu < 0)
>> +        return -EINVAL;
>> +
>> +    if (iommu_pmu_validate_event(event))
>> +        return -EINVAL;
>> +
>> +    hwc->config = iommu_event_config(event);
>> +
>> +    return iommu_pmu_validate_group(event);
>> +}
>> +
>> +static void iommu_pmu_event_update(struct perf_event *event)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    u64 prev_count, new_count, delta;
>> +    int shift = 64 - iommu_pmu->cntr_width;
>> +
>> +again:
>> +    prev_count = local64_read(&hwc->prev_count);
>> +    new_count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
>> +    if (local64_xchg(&hwc->prev_count, new_count) != prev_count)
>> +        goto again;
>> +
>> +    /*
>> +     * The counter width is enumerated.
>> +     * Always shift the counter before using it.
>> +     */
> 
> Re-org above comments and make it neat.

Sure.

> 
>> +    delta = (new_count << shift) - (prev_count << shift);
>> +    delta >>= shift;
>> +
>> +    local64_add(delta, &event->count);
>> +}
>> +
>> +static void iommu_pmu_start(struct perf_event *event, int flags)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    struct intel_iommu *iommu = iommu_pmu->iommu;
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    u64 count;
>> +
>> +    if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>> +        return;
>> +
>> +    if (WARN_ON_ONCE(hwc->idx < 0 || hwc->idx >= IOMMU_PMU_IDX_MAX))
>> +        return;
>> +
>> +    if (flags & PERF_EF_RELOAD)
>> +        WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
>> +
>> +    hwc->state = 0;
>> +
>> +    /* Always reprogram the period */
>> +    count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
>> +    local64_set((&hwc->prev_count), count);
>> +
>> +    ecmd_submit_sync(iommu, DMA_ECMD_ENABLE, hwc->idx, false, 0);
> 
> What happens when emcmd_submit_sync() returns an error? How should we
> handle this case? The same queestion to other places in this patch.
>

The existing perf_event subsystem doesn't handle the error, because
other PMUs never trigger such errors. Perf usually check all the PMU
counters once at the beginning when registering/initializing them.

For IOMMU PMU, the error will be ignored. I think it should be OK. Because
- It's a corner case, which is very unlikely to happen.
- The worst case is that the user will get <not count> with perf
command, which can the user some hints.

If it's not good enough, I think we can add a WARN_ON_ONCE() here and
everywhere for ecmd to dump the error in the dmesg.

What do you think?


>> +
>> +    perf_event_update_userpage(event);
>> +}
>> +
>> +static void iommu_pmu_stop(struct perf_event *event, int flags)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    struct intel_iommu *iommu = iommu_pmu->iommu;
>> +    struct hw_perf_event *hwc = &event->hw;
>> +
>> +    if (!(hwc->state & PERF_HES_STOPPED)) {
>> +        ecmd_submit_sync(iommu, DMA_ECMD_DISABLE, hwc->idx, false, 0);
>> +
>> +        iommu_pmu_event_update(event);
>> +
>> +        hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +    }
>> +}
>> +
>> +static inline int
>> +iommu_pmu_validate_per_cntr_event(struct iommu_pmu *iommu_pmu,
>> +                  int idx, struct perf_event *event)
>> +{
>> +    u32 event_group = iommu_event_group(event->attr.config);
>> +    u32 select = iommu_event_select(event->attr.config);
>> +
>> +    if (!(iommu_pmu->cntr_evcap[idx][event_group] & select))
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
>> +                  struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    int idx;
>> +
>> +    /*
>> +     * The counters which support limited events are usually at the end.
>> +     * Schedule them first to accommodate more events.
>> +     */
>> +    for (idx = iommu_pmu->num_cntr - 1; idx >= 0; idx--) {
>> +        if (test_and_set_bit(idx, iommu_pmu->used_mask))
>> +            continue;
>> +        /* Check per-counter event capabilities */
>> +        if (!iommu_pmu_validate_per_cntr_event(iommu_pmu, idx, event))
>> +            break;
>> +        clear_bit(idx, iommu_pmu->used_mask);
>> +    }
>> +    if (idx < 0)
>> +        return -EINVAL;
>> +
>> +    iommu_pmu->event_list[idx] = event;
>> +    hwc->idx = idx;
>> +
>> +    /* config events */
>> +    dmar_writeq(iommu_config_base(iommu_pmu, idx), hwc->config);
>> +
>> +    iommu_pmu_set_filter(requester_id, event->attr.config1,
>> +                 IOMMU_PMU_FILTER_REQUESTER_ID, idx);
>> +    iommu_pmu_set_filter(domain, event->attr.config1,
>> +                 IOMMU_PMU_FILTER_DOMAIN, idx);
>> +    iommu_pmu_set_filter(pasid, event->attr.config1,
>> +                 IOMMU_PMU_FILTER_PASID, idx);
>> +    iommu_pmu_set_filter(ats, event->attr.config2,
>> +                 IOMMU_PMU_FILTER_ATS, idx);
>> +    iommu_pmu_set_filter(page_table, event->attr.config2,
>> +                 IOMMU_PMU_FILTER_PAGE_TABLE, idx);
>> +
>> +    return 0;
>> +}
>> +
>> +static int iommu_pmu_add(struct perf_event *event, int flags)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    int ret;
>> +
>> +    ret = iommu_pmu_assign_event(iommu_pmu, event);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>> +
>> +    if (flags & PERF_EF_START)
>> +        iommu_pmu_start(event, 0);
>> +
>> +    return 0;
>> +}
>> +
>> +static void iommu_pmu_del(struct perf_event *event, int flags)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>> +    int idx = event->hw.idx;
>> +
>> +    iommu_pmu_stop(event, PERF_EF_UPDATE);
>> +
>> +    iommu_pmu_clear_filter(IOMMU_PMU_FILTER_REQUESTER_ID, idx);
>> +    iommu_pmu_clear_filter(IOMMU_PMU_FILTER_DOMAIN, idx);
>> +    iommu_pmu_clear_filter(IOMMU_PMU_FILTER_PASID, idx);
>> +    iommu_pmu_clear_filter(IOMMU_PMU_FILTER_ATS, idx);
>> +    iommu_pmu_clear_filter(IOMMU_PMU_FILTER_PAGE_TABLE, idx);
>> +
>> +    iommu_pmu->event_list[idx] = NULL;
>> +    event->hw.idx = -1;
>> +    clear_bit(idx, iommu_pmu->used_mask);
>> +
>> +    perf_event_update_userpage(event);
>> +}
>> +
>> +static void iommu_pmu_enable(struct pmu *pmu)
>> +{
>> +    struct iommu_pmu *iommu_pmu = container_of(pmu, struct iommu_pmu,
>> pmu);
>> +    struct intel_iommu *iommu = iommu_pmu->iommu;
>> +
>> +    ecmd_submit_sync(iommu, DMA_ECMD_UNFREEZE, 0, false, 0);
>> +}
>> +
>> +static void iommu_pmu_disable(struct pmu *pmu)
>> +{
>> +    struct iommu_pmu *iommu_pmu = container_of(pmu, struct iommu_pmu,
>> pmu);
>> +    struct intel_iommu *iommu = iommu_pmu->iommu;
>> +
>> +    ecmd_submit_sync(iommu, DMA_ECMD_FREEZE, 0, false, 0);
>> +}
>> +
>> +static int __iommu_pmu_register(struct intel_iommu *iommu)
>> +{
>> +    struct iommu_pmu *iommu_pmu = iommu->pmu;
>> +
>> +    iommu_pmu->pmu.name        = iommu->name;
>> +    iommu_pmu->pmu.task_ctx_nr    = perf_invalid_context;
>> +    iommu_pmu->pmu.event_init    = iommu_pmu_event_init;
>> +    iommu_pmu->pmu.pmu_enable    = iommu_pmu_enable;
>> +    iommu_pmu->pmu.pmu_disable    = iommu_pmu_disable;
>> +    iommu_pmu->pmu.add        = iommu_pmu_add;
>> +    iommu_pmu->pmu.del        = iommu_pmu_del;
>> +    iommu_pmu->pmu.start        = iommu_pmu_start;
>> +    iommu_pmu->pmu.stop        = iommu_pmu_stop;
>> +    iommu_pmu->pmu.read        = iommu_pmu_event_update;
>> +    iommu_pmu->pmu.attr_groups    = iommu_pmu_attr_groups;
>> +    iommu_pmu->pmu.attr_update    = iommu_pmu_attr_update;
>> +    iommu_pmu->pmu.capabilities    = PERF_PMU_CAP_NO_EXCLUDE;
>> +    iommu_pmu->pmu.module        = THIS_MODULE;
>> +
>> +    return perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
>> +}
>> +
>>   static inline void __iomem *
>>   get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
>>   {
>> @@ -40,11 +509,21 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
>>       if (!pcap_interrupt(perfcap))
>>           return -ENODEV;
>>   +    /* Check required Enhanced Command Capability */
>> +    if (!ecmd_has_pmu_essential(iommu))
>> +        return -ENODEV;
>> +
>>       iommu_pmu = kzalloc(sizeof(*iommu_pmu), GFP_KERNEL);
>>       if (!iommu_pmu)
>>           return -ENOMEM;
>>         iommu_pmu->num_cntr = pcap_num_cntr(perfcap);
>> +    if (iommu_pmu->num_cntr > IOMMU_PMU_IDX_MAX) {
>> +        WARN_ONCE(1, "The number of IOMMU counters %d > max(%d),
>> clipping!",
>> +              iommu_pmu->num_cntr, IOMMU_PMU_IDX_MAX);
> 
> Do we really need a kernel trace here? This isn't a software flaw,
> perhaps, use pr_info() to let users know about this is enough?

It's a software flaw. If the number of counter > 64, we need to update
the driver to support more extra registers, e.g., freeze and overflow
registers.

There are only 14 counters for the existing platform. It's far away from
64 counters. I would not expect that the warning can be triggered soon.

> 
>> +        iommu_pmu->num_cntr = IOMMU_PMU_IDX_MAX;
>> +    }
>> +
>>       iommu_pmu->cntr_width = pcap_cntr_width(perfcap);
>>       iommu_pmu->filter = pcap_filters_mask(perfcap);
>>       iommu_pmu->cntr_stride = pcap_cntr_stride(perfcap);
>> @@ -157,3 +636,20 @@ void free_iommu_pmu(struct intel_iommu *iommu)
>>       kfree(iommu_pmu);
>>       iommu->pmu = NULL;
>>   }
>> +
>> +void iommu_pmu_register(struct intel_iommu *iommu)
>> +{
>> +    if (!iommu->pmu)
>> +        return;
>> +
>> +    if (__iommu_pmu_register(iommu)) {
>> +        pr_err("Failed to register PMU for iommu (seq_id = %d)\n",
>> +               iommu->seq_id);
> 
> What will happen if iommu_pmu_unregister() is called after
> __iommu_pmu_register() has returned error?


Yes, we should avoid iommu_pmu_unregister().

I will free the iommu->pmu via free_iommu_pmu() for this case.

Thanks,
Kan
> 
>> +    }
>> +}
>> +
>> +void iommu_pmu_unregister(struct intel_iommu *iommu)
>> +{
>> +    if (iommu->pmu)
>> +        perf_pmu_unregister(&iommu->pmu->pmu);
>> +}
>> diff --git a/drivers/iommu/intel/perfmon.h
>> b/drivers/iommu/intel/perfmon.h
>> index 8587c80501cd..b60f0cad5bfd 100644
>> --- a/drivers/iommu/intel/perfmon.h
>> +++ b/drivers/iommu/intel/perfmon.h
>> @@ -7,6 +7,14 @@
>>   #define IOMMU_PMU_NUM_OFF_REGS            4
>>   #define IOMMU_PMU_OFF_REGS_STEP            4
>>   +#define IOMMU_PMU_FILTER_REQUESTER_ID        0x01
>> +#define IOMMU_PMU_FILTER_DOMAIN            0x02
>> +#define IOMMU_PMU_FILTER_PASID            0x04
>> +#define IOMMU_PMU_FILTER_ATS            0x08
>> +#define IOMMU_PMU_FILTER_PAGE_TABLE        0x10
>> +
>> +#define IOMMU_PMU_FILTER_EN            (1 << 31)
>> +
>>   #define IOMMU_PMU_CFG_OFFSET            0x100
>>   #define IOMMU_PMU_CFG_CNTRCAP_OFFSET        0x80
>>   #define IOMMU_PMU_CFG_CNTREVCAP_OFFSET        0x84
>> @@ -21,12 +29,18 @@
>>   #define iommu_cntrcap_ios(p)            ((p >> 16) & 0x1)
>>   #define iommu_cntrcap_egcnt(p)            ((p >> 28) & 0xf)
>>   +#define IOMMU_EVENT_CFG_EGI_SHIFT        8
>> +#define IOMMU_EVENT_CFG_ES_SHIFT        32
>> +#define IOMMU_EVENT_CFG_INT            (1ULL << 1)
>> +
>>   #define iommu_event_select(p)            ((p) & 0xfffffff)
>>   #define iommu_event_group(p)            ((p >> 28) & 0xf)
>>     #ifdef CONFIG_INTEL_IOMMU_PERF_EVENTS
>>   int alloc_iommu_pmu(struct intel_iommu *iommu);
>>   void free_iommu_pmu(struct intel_iommu *iommu);
>> +void iommu_pmu_register(struct intel_iommu *iommu);
>> +void iommu_pmu_unregister(struct intel_iommu *iommu);
>>   #else
>>   static inline int
>>   alloc_iommu_pmu(struct intel_iommu *iommu)
>> @@ -38,4 +52,14 @@ static inline void
>>   free_iommu_pmu(struct intel_iommu *iommu)
>>   {
>>   }
>> +
>> +static inline void
>> +iommu_pmu_register(struct intel_iommu *iommu)
>> +{
>> +}
>> +
>> +static inline void
>> +iommu_pmu_unregister(struct intel_iommu *iommu)
>> +{
>> +}
>>   #endif /* CONFIG_INTEL_IOMMU_PERF_EVENTS */
> 
> -- 
> Best regards,
> baolu
