Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57B6CDB40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjC2Ny1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjC2NyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:54:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD9BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680098063; x=1711634063;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kJU0gl9NmSnDcPetJBwG5dSajnFbHqFvFDWP07InU6Q=;
  b=nquOn1e/5e2SlaZlVg+BrbLd1bem8HdEDhQpTocwwqgYMYaEJ+X06gMZ
   1uxacLWsAaTcWtMhO/7Prj46Svjp7q64b1B/F/9GZpDbGLicfXvJoI1Xc
   zHax416QybO2u65Ygc222B6xU7QCNYZYaLh0q4DsUCdCW88vXefmSrrPe
   m2/pATDxO0gSe3JHGBKBCMGY/6cIkgUkPDlauDTPEyifRCFesxUvnGPvA
   baXuV4KoDyDwtrKMXIdpkJBPWP98fP6Ort9wgwLoXi+EUUJpvEa9FIzOP
   pgBzUe5TfIgpu3pJXTCA5b6hEjvVrLM3sWfc2wKxdutPTgLzfX21qxdvF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="340901543"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="340901543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="827901879"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="827901879"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:54:21 -0700
Message-ID: <b69e622b-505c-39fd-a5d1-2bc9ee84929c@linux.intel.com>
Date:   Wed, 29 Mar 2023 21:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH V2] iommu/vt-d: Fix a IOMMU perfmon warning when CPU
 hotplug
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230328182028.1366416-1-kan.liang@linux.intel.com>
 <0b0e6fd6-b775-cdd0-c3c0-dc20056e07d2@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0b0e6fd6-b775-cdd0-c3c0-dc20056e07d2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/29 21:12, Liang, Kan wrote:
> 
> On 2023-03-28 2:20 p.m.,kan.liang@linux.intel.com  wrote:
>> From: Kan Liang<kan.liang@linux.intel.com>
>>
>> A warning can be triggered when hotplug CPU 0.
>> $ echo 0 > /sys/devices/system/cpu/cpu0/online
>>
>> [11958.737635] ------------[ cut here ]------------
>> [11958.742882] Voluntary context switch within RCU read-side critical
>> section!
>> [11958.742891] WARNING: CPU: 0 PID: 19 at kernel/rcu/tree_plugin.h:318
>> rcu_note_context_switch+0x4f4/0x580
>> [11958.860095] RIP: 0010:rcu_note_context_switch+0x4f4/0x580
>> [11958.960360] Call Trace:
>> [11958.963161]  <TASK>
>> [11958.965565]  ? perf_event_update_userpage+0x104/0x150
>> [11958.971293]  __schedule+0x8d/0x960
>> [11958.975165]  ? perf_event_set_state.part.82+0x11/0x50
>> [11958.980891]  schedule+0x44/0xb0
>> [11958.984464]  schedule_timeout+0x226/0x310
>> [11958.989017]  ? __perf_event_disable+0x64/0x1a0
>> [11958.994054]  ? _raw_spin_unlock+0x14/0x30
>> [11958.998605]  wait_for_completion+0x94/0x130
>> [11959.003352]  __wait_rcu_gp+0x108/0x130
>> [11959.007616]  synchronize_rcu+0x67/0x70
>> [11959.011876]  ? invoke_rcu_core+0xb0/0xb0
>> [11959.016333]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
>> [11959.022147]  perf_pmu_migrate_context+0x121/0x370
>> [11959.027478]  iommu_pmu_cpu_offline+0x6a/0xa0
>> [11959.032325]  ? iommu_pmu_del+0x1e0/0x1e0
>> [11959.036782]  cpuhp_invoke_callback+0x129/0x510
>> [11959.041825]  cpuhp_thread_fun+0x94/0x150
>> [11959.046283]  smpboot_thread_fn+0x183/0x220
>> [11959.050933]  ? sort_range+0x20/0x20
>> [11959.054902]  kthread+0xe6/0x110
>> [11959.058479]  ? kthread_complete_and_exit+0x20/0x20
>> [11959.063911]  ret_from_fork+0x1f/0x30
>> [11959.067982]  </TASK>
>> [11959.070489] ---[ end trace 0000000000000000 ]---
>>
>> The synchronize_rcu() will be invoked in the perf_pmu_migrate_context(),
>> when migrating a PMU to a new CPU. However, the current for_each_iommu()
>> is within RCU read-side critical section.
>>
>> Two methods were considered to fix the issue.
>> - Use the dmar_global_lock to replace the RCU read lock when going
>>    through the drhd list. But it triggers a lockdep warning.
>> - Use the cpuhp_setup_state_multi() to set up a dedicated state for each
>>    IOMMU PMU. The lock can be avoided.
>>
>> The latter method is implemented in this patch. Since each IOMMU PMU has
>> a dedicated state, add cpuhp_node and cpu in struct iommu_pmu to track
>> the state. The state can be dynamically allocated now. Remove the
>> CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE.
>>
>> Fixes: 46284c6ceb5e ("iommu/vt-d: Support cpumask for IOMMU perfmon")
> Forgot to add a tag. If the patch looks good, please add the below tag
> when you pull the patch.
> 
> Reported-by: Ammy Yi<ammy.yi@intel.com>

Sure. Patch has been queued after my test.

https://lore.kernel.org/linux-iommu/20230329134721.469447-1-baolu.lu@linux.intel.com/

Best regards,
baolu
