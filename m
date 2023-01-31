Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23F6825F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjAaHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjAaHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:55:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A33E609
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151704; x=1706687704;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YGP3Zf7KaslK46KT4ZdpOe8BqHP3ROGlVR+cuxazIyA=;
  b=dJONDMyT+Ow9dULZweLgbYcPgK1+NvgNeJiIARK1tC6eA7gytS/sWOgJ
   tgjm2j7wj/e01TQYg0t9jZQPd1HzfUS902KN4+8KwCjoxqfLqeQm9yLEn
   +Mzpaiell3uKj78cSf4mDBMdwwyhD3yQ3cn/f2xhOimp90nK6MQrPqf47
   5nZ6shTrKF49KfvOCAGfs3t8npmPxRaYR6Ud8aDqJYkND2rX2kjHdUawT
   8CB5AkwUn8tmfqvdNKwdkPnKzFIAPRmY78Gt//4axIDihghBgvdjQ/X9I
   c5+SbyZxongalHKp8ZZgOTNuy/0fN0XsKeEjE0ZuXChOsROHZmdh10lwY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="355101007"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="355101007"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:55:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788348067"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="788348067"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:55:00 -0800
Message-ID: <91b485f7-ffd9-65ce-5656-5659a48968b4@linux.intel.com>
Date:   Tue, 31 Jan 2023 15:54:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, yu-cheng.yu@intel.com
Subject: Re: [PATCH V4 0/7] iommu/vt-d: Support performance monitoring for
 IOMMU
Content-Language: en-US
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/29 4:04, kan.liang@linux.intel.com wrote:
> From: Kan Liang<kan.liang@linux.intel.com>
> 
> Changes since V3:
> - Fix issues found by "./scripts/checkpatch.pl --strict" scripts
>    Doesn't fix the "macros should not use a trailing semicolon" warning,
>    since the macros has to include several struct and functions to
>    further reduce the code duplication.
> - To fix the 0 value filter issue, introduce new "*_filter_en" attrs
>    for each filter. The end user must set both filter_en and filter
>    to utilize a filter.
> - Re-organize the layout of config1 and config2.
> 
> Changes since V2:
> - Move ecmd_submit_sync() to iommu.c to avoid #ifdef CONFIG_INTEL_IOMMU
> 
> Changes since V1:
> - The cap and ecap registers are always in the first page. It's not
>    necessary to use the reg size in dmar_validate_one_drhd(). (Patch 1)
> - Move reg_size up and pair it with reg_base_addr in struct
>    dmar_drhd_unit (Patch 1)
> - Update the year of Copyright (Patch 2)
> - Return 0 if PMS is not supported (Patch 2)
> - Refine the comments and add a pr_warn for per-counter capabilities
>    check (Patch 2)
> - Remove unnecessary iommu_pmu->num_cntr = i (Patch 2)
> - Remove has_ob of ecmd_submit_sync() (Patch 3)
> - Remove the helpers from non-INTEL_IOMMU. (Patch 3)
> - Still keep #ifdef CONFIG_INTEL_IOMMU for ecmd_submit_sync() to
>    avoid compile warning with non-INTEL_IOMMU config.
> - Use pr_warn_once() to replace WARN_ONCE() (Patch 4 & 6)
> - Free iommu PMU if it fails to be registered. (Patch 4)
> - Remove unnecessary 'handled' variable. (Patch 6)
> 
> A performance monitoring infrastructure, perfmon, is introduced with
> the VT-d Spec 4.0. The purpose of perfmon is to support collection of
> information about key events occurring during operation of the remapping
> hardware, to aid performance tuning and debug. The patch series is to
> support the perfmon for IOMMU.
> 
> To facilitate the perfmon support, the patch series also supports two
> new generic features of VT-d Spec 4.0.
> - Support the 'size' field to retrieve the accurate size of the register
>    set for each dmar device from DRHD. (Patch 1)
> - Support the new Enhanced Command Interface. (Patch 3)
> 
> With the patch series, users can collect the performance data of IOMMU
> via Linux perf tool. For example,
> 
>   $ perf stat -e dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/
>     -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>     368,947      dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/
> 
>   1.002592074 seconds time elapsed
> 
> Kan Liang (7):
>    iommu/vt-d: Support size of the register set in DRHD
>    iommu/vt-d: Retrieve IOMMU perfmon capability information
>    iommu/vt-d: Support Enhanced Command Interface
>    iommu/vt-d: Add IOMMU perfmon support
>    iommu/vt-d: Support cpumask for IOMMU perfmon
>    iommu/vt-d: Add IOMMU perfmon overflow handler support
>    iommu/vt-d: Enable IOMMU perfmon support

Patches queued for v6.3. Thank you!

https://lore.kernel.org/linux-iommu/20230131073740.378984-1-baolu.lu@linux.intel.com/

Best regards,
baolu
