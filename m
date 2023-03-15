Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429CC6BA47D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCOBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOBP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:15:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9329E25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678842955; x=1710378955;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vK4DMJA04GP+L4LXClAQFNWHErH0unzYpP3P+0wgFM=;
  b=ayJ9kElrKXo9tKgO2zIVEymHIDuzGolmMXdLxXnpNhAc0cMVTbtNZq21
   TyoQmt+jcF4+cc2og0uwuqpX8CiJDDR0PDwUiSRXxOJqMUWWfPfndFdEH
   Rt5vjEann3NCWjz5nNcPsgeur/h0WYi1bWigRPxYCankAYt9uSdsT7WEQ
   jwVn+0glBOi/djVtGZ4IngXogWBIiCCyCvUuvaAig/SBwel9L4pk9Mz6U
   MGjuIh/5nAcKjy+A6GVMG+lu5RLbf4vYBExdDtv0kjfCfVnzhEg3bUedj
   ZA2CX4YpiBhw9k+kMGWezQ+HqskP61bqGYLV8GXUzhCjaRQkDnGoJfJzs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="423857632"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="423857632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 18:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822583676"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="822583676"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 18:15:52 -0700
Message-ID: <3547b3a8-0ea4-bfe7-2bdc-2213ec89b7e5@linux.intel.com>
Date:   Wed, 15 Mar 2023 09:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <20230314085424.3e6141d1@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230314085424.3e6141d1@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 11:54 PM, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Tue, 14 Mar 2023 13:18:36 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
>> ("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
>> is used to protect DMAR related global data from DMAR hotplug operations.
>>
>> Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
>> the DMAR global data structures are not touched there. Remove it to avoid
>> below lockdep warning.
>>
>>   ======================================================
>>   WARNING: possible circular locking dependency detected
>>   6.3.0-rc2 #468 Not tainted
>>   ------------------------------------------------------
>>   swapper/0/1 is trying to acquire lock:
>>   ff1db4cb40178698 (&domain->mutex){+.+.}-{3:3},
>>     at: __irq_domain_alloc_irqs+0x3b/0xa0
>>
>>   but task is already holding lock:
>>   ffffffffa0c1cdf0 (dmar_global_lock){++++}-{3:3},
>>     at: intel_iommu_init+0x58e/0x880
>>
>>   which lock already depends on the new lock.
>>
>>   the existing dependency chain (in reverse order) is:
>>
>>   -> #1 (dmar_global_lock){++++}-{3:3}:
>>          lock_acquire+0xd6/0x320
>>          down_read+0x42/0x180
>>          intel_irq_remapping_alloc+0xad/0x750
>>          mp_irqdomain_alloc+0xb8/0x2b0
>>          irq_domain_alloc_irqs_locked+0x12f/0x2d0
>>          __irq_domain_alloc_irqs+0x56/0xa0
>>          alloc_isa_irq_from_domain.isra.7+0xa0/0xe0
>>          mp_map_pin_to_irq+0x1dc/0x330
>>          setup_IO_APIC+0x128/0x210
>>          apic_intr_mode_init+0x67/0x110
>>          x86_late_time_init+0x24/0x40
>>          start_kernel+0x41e/0x7e0
>>          secondary_startup_64_no_verify+0xe0/0xeb
>>
>>   -> #0 (&domain->mutex){+.+.}-{3:3}:
>>          check_prevs_add+0x160/0xef0
>>          __lock_acquire+0x147d/0x1950
>>          lock_acquire+0xd6/0x320
>>          __mutex_lock+0x9c/0xfc0
>>          __irq_domain_alloc_irqs+0x3b/0xa0
>>          dmar_alloc_hwirq+0x9e/0x120
>>          iommu_pmu_register+0x11d/0x200
>>          intel_iommu_init+0x5de/0x880
>>          pci_iommu_init+0x12/0x40
>>          do_one_initcall+0x65/0x350
>>          kernel_init_freeable+0x3ca/0x610
>>          kernel_init+0x1a/0x140
>>          ret_from_fork+0x29/0x50
>>
>>   other info that might help us debug this:
>>
>>   Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(dmar_global_lock);
>>                                  lock(&domain->mutex);
>>                                  lock(dmar_global_lock);
>>     lock(&domain->mutex);
>>
>>                  *** DEADLOCK ***
>>
>> Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/irq_remapping.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c index 6d01fa078c36..df9e261af0b5
>> 100644 --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -311,14 +311,12 @@ static int set_ioapic_sid(struct irte *irte, int
>> apic) if (!irte)
>>   		return -1;
>>   
>> -	down_read(&dmar_global_lock);
>>   	for (i = 0; i < MAX_IO_APICS; i++) {
>>   		if (ir_ioapic[i].iommu && ir_ioapic[i].id == apic) {
>>   			sid = (ir_ioapic[i].bus << 8) |
>> ir_ioapic[i].devfn; break;
>>   		}
>>   	}
>> -	up_read(&dmar_global_lock);
>>   
>>   	if (sid == 0) {
>>   		pr_warn("Failed to set source-id of IOAPIC (%d)\n",
>> apic); @@ -338,14 +336,12 @@ static int set_hpet_sid(struct irte *irte,
>> u8 id) if (!irte)
>>   		return -1;
>>   
>> -	down_read(&dmar_global_lock);
>>   	for (i = 0; i < MAX_HPET_TBS; i++) {
>>   		if (ir_hpet[i].iommu && ir_hpet[i].id == id) {
>>   			sid = (ir_hpet[i].bus << 8) | ir_hpet[i].devfn;
>>   			break;
>>   		}
>>   	}
>> -	up_read(&dmar_global_lock);
>>   
>>   	if (sid == 0) {
>>   		pr_warn("Failed to set source-id of HPET block (%d)\n",
>> id); @@ -1339,9 +1335,7 @@ static int intel_irq_remapping_alloc(struct
>> irq_domain *domain, if (!data)
>>   		goto out_free_parent;
>>   
>> -	down_read(&dmar_global_lock);
>>   	index = alloc_irte(iommu, &data->irq_2_iommu, nr_irqs);
>> -	up_read(&dmar_global_lock);
>>   	if (index < 0) {
>>   		pr_warn("Failed to allocate IRTE\n");
>>   		kfree(data);
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> slightly beyond the scope of this, do we need to take dmar_global_lock
> below? shouldn't it be in single threaded context?
> 
> 	down_write(&dmar_global_lock);
> 	ret = dmar_dev_scope_init();
> 	up_write(&dmar_global_lock);
> 
> 	return ret;
> }
> rootfs_initcall(ir_dev_scope_init);

Yes, agreed. This runs in a single threaded context. I will remove the
locking in a cleanup patch.

Best regards,
baolu
