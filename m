Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738167FA50
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjA1S6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 13:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjA1S6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 13:58:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68966113FE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674932316; x=1706468316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0igZZSZ35WPHNtplLHFg7EG3QA4Q2VrQiwYSgkKTf7o=;
  b=mjhOvGwX8KLe+Uc4ITEUFY6h7366XK7rEEXX7w7/bS0fwdGw6O9LFCVo
   bxQnt9fQV/vutssvqlVsldF9Ngdu8wZpN1c8Fr1i+3G3tVoFFbJeV+dhS
   ai8mhi5+KDOkJd2hmqaCeGQbb5lriM7sVbaHfRnqgLuLnV4CyrhqOgHcJ
   Z12irbWSwGyrX9FjkSA0zFsab2sLh1ID7bvV3yde0wqxpZfZWOHWFwJ0m
   DYQpc4Hr4RIOmSEVWWnDqln3f7olxjO6dlT4zs7xHphQka+z0N7yVCszt
   bUIdongUfbE7EK3i5q+jirmnezHKKpNatJZuhF7c2/eeNjpnKDHQZM6IZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325015396"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325015396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:58:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="771960983"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="771960983"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2023 10:58:16 -0800
Received: from [10.209.53.179] (shedrick-mobl.amr.corp.intel.com [10.209.53.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1C6F158093E;
        Sat, 28 Jan 2023 10:58:15 -0800 (PST)
Message-ID: <7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com>
Date:   Sat, 28 Jan 2023 13:58:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 0/7] iommu/vt-d: Support performance monitoring for
 IOMMU
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com
References: <20230120165408.500511-1-kan.liang@linux.intel.com>
 <723f8070-1f03-dcab-4592-bceaf9cbdf07@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <723f8070-1f03-dcab-4592-bceaf9cbdf07@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-28 2:10 a.m., Baolu Lu wrote:
> On 2023/1/21 0:54, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V2:
>> - Move ecmd_submit_sync() to iommu.c to avoid #ifdef CONFIG_INTEL_IOMMU
>>
>> Changes since V1:
>> - The cap and ecap registers are always in the first page. It's not
>>    necessary to use the reg size in dmar_validate_one_drhd(). (Patch 1)
>> - Move reg_size up and pair it with reg_base_addr in struct
>>    dmar_drhd_unit (Patch 1)
>> - Update the year of Copyright (Patch 2)
>> - Return 0 if PMS is not supported (Patch 2)
>> - Refine the comments and add a pr_warn for per-counter capabilities
>>    check (Patch 2)
>> - Remove unnecessary iommu_pmu->num_cntr = i (Patch 2)
>> - Remove has_ob of ecmd_submit_sync() (Patch 3)
>> - Remove the helpers from non-INTEL_IOMMU. (Patch 3)
>> - Still keep #ifdef CONFIG_INTEL_IOMMU for ecmd_submit_sync() to
>>    avoid compile warning with non-INTEL_IOMMU config.
>> - Use pr_warn_once() to replace WARN_ONCE() (Patch 4 & 6)
>> - Free iommu PMU if it fails to be registered. (Patch 4)
>> - Remove unnecessary 'handled' variable. (Patch 6)
>>
>> A performance monitoring infrastructure, perfmon, is introduced with
>> the VT-d Spec 4.0. The purpose of perfmon is to support collection of
>> information about key events occurring during operation of the remapping
>> hardware, to aid performance tuning and debug. The patch series is to
>> support the perfmon for IOMMU.
>>
>> To facilitate the perfmon support, the patch series also supports two
>> new generic features of VT-d Spec 4.0.
>> - Support the 'size' field to retrieve the accurate size of the register
>>    set for each dmar device from DRHD. (Patch 1)
>> - Support the new Enhanced Command Interface. (Patch 3)
>>
>> With the patch series, users can collect the performance data of IOMMU
>> via Linux perf tool. For example,
>>
>>   $ perf stat -e dmar0/iommu_requests,filter_ats=0/ -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>                2135      dmar0/iommu_requests,filter_ats=0/
>>
>>         1.001087695 seconds time elapsed
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
>> Kan Liang (7):
>>    iommu/vt-d: Support size of the register set in DRHD
>>    iommu/vt-d: Retrieve IOMMU perfmon capability information
>>    iommu/vt-d: Support Enhanced Command Interface
>>    iommu/vt-d: Add IOMMU perfmon support
>>    iommu/vt-d: Support cpumask for IOMMU perfmon
>>    iommu/vt-d: Add IOMMU perfmon overflow handler support
>>    iommu/vt-d: Enable IOMMU perfmon support
>>
>>   .../sysfs-bus-event_source-devices-iommu      |  32 +
>>   drivers/iommu/intel/Kconfig                   |   9 +
>>   drivers/iommu/intel/Makefile                  |   1 +
>>   drivers/iommu/intel/dmar.c                    |  33 +-
>>   drivers/iommu/intel/iommu.c                   |  59 ++
>>   drivers/iommu/intel/iommu.h                   | 101 +-
>>   drivers/iommu/intel/perfmon.c                 | 860 ++++++++++++++++++
>>   drivers/iommu/intel/perfmon.h                 |  65 ++
>>   drivers/iommu/intel/svm.c                     |   2 +-
>>   include/acpi/actbl1.h                         |   2 +-
>>   include/linux/cpuhotplug.h                    |   1 +
>>   include/linux/dmar.h                          |   1 +
>>   12 files changed, 1159 insertions(+), 7 deletions(-)
>>   create mode 100644
>> Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>>   create mode 100644 drivers/iommu/intel/perfmon.c
>>   create mode 100644 drivers/iommu/intel/perfmon.h
> 
> Thanks for the work. The overall looks good to me now. But I am still
> seeing some code style issues after running "./scripts/checkpatch.pl
> --strict" scripts.
> 
> Can you please fix those issues and post a v4?
> 
Sure.

Thanks,
Kan
