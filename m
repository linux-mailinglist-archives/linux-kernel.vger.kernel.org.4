Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B165BE510
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiITL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiITL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:58:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1A72EE7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:58:57 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oabtp-0001Sy-6g; Tue, 20 Sep 2022 13:58:49 +0200
Message-ID: <d2224046-f457-5daf-f944-a13dd4b31477@leemhuis.info>
Date:   Tue, 20 Sep 2022 13:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()"
To:     Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663675137;b6af61bc;
X-HE-SMSGID: 1oabtp-0001Sy-6g
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 10:17, Lu Baolu wrote:
> This reverts commit 9cd4f1434479f1ac25c440c421fbf52069079914.

Thx for taking care of this.

> Some issues were reported on the original commit. Some thunderbolt devices
> don't work anymore due to the following DMA fault.
> 
> DMAR: DRHD: handling fault status reg 2
> DMAR: [INTR-REMAP] Request device [09:00.0] fault index 0x8080
>       [fault reason 0x25]
>       Blocked a compatibility format interrupt request
> 
> Bring it back for now to avoid functional regression.
> 
> Fixes: 9cd4f1434479f ("iommu/vt-d: Fix possible recursive locking in intel_iommu_init()")
> Link: https://lore.kernel.org/linux-iommu/485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216497

Both those reports were against 5.19.y, so this afaics should have a

Cc: <stable@vger.kernel.org> # 5.19.x

to ensure it's backported.

Speaking of which: Joerg/Will/Robin, it seems quite a few people are
running into this, it hence would be great to get this quickly mainlined
(maybe by letting Linus pick it up straight from the list once ready?)
so stable can pick it up.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-and-tested-by: George Hilliard <thirtythreeforty@gmail.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/dmar.h        |  4 +---
>  drivers/iommu/intel/dmar.c  |  7 -------
>  drivers/iommu/intel/iommu.c | 27 +++++++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 8917a32173c4..d81a51978d01 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -65,7 +65,6 @@ struct dmar_pci_notify_info {
>  
>  extern struct rw_semaphore dmar_global_lock;
>  extern struct list_head dmar_drhd_units;
> -extern int intel_iommu_enabled;
>  
>  #define for_each_drhd_unit(drhd)					\
>  	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
> @@ -89,8 +88,7 @@ extern int intel_iommu_enabled;
>  static inline bool dmar_rcu_check(void)
>  {
>  	return rwsem_is_locked(&dmar_global_lock) ||
> -	       system_state == SYSTEM_BOOTING ||
> -	       (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled);
> +	       system_state == SYSTEM_BOOTING;
>  }
>  
>  #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 04f7991734a9..3528058d253e 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2356,13 +2356,6 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
>  	if (!dmar_in_use())
>  		return 0;
>  
> -	/*
> -	 * It's unlikely that any I/O board is hot added before the IOMMU
> -	 * subsystem is initialized.
> -	 */
> -	if (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled)
> -		return -EOPNOTSUPP;
> -
>  	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
>  		tmp = handle;
>  	} else {
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c20f3e060bac..5bab71a05830 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3029,7 +3029,13 @@ static int __init init_dmars(void)
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
> +			/*
> +			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
> +			 * could cause possible lock race condition.
> +			 */
> +			up_write(&dmar_global_lock);
>  			ret = intel_svm_enable_prq(iommu);
> +			down_write(&dmar_global_lock);
>  			if (ret)
>  				goto free_iommu;
>  		}
> @@ -3941,6 +3947,7 @@ int __init intel_iommu_init(void)
>  	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
>  		    platform_optin_force_iommu();
>  
> +	down_write(&dmar_global_lock);
>  	if (dmar_table_init()) {
>  		if (force_on)
>  			panic("tboot: Failed to initialize DMAR table\n");
> @@ -3953,6 +3960,16 @@ int __init intel_iommu_init(void)
>  		goto out_free_dmar;
>  	}
>  
> +	up_write(&dmar_global_lock);
> +
> +	/*
> +	 * The bus notifier takes the dmar_global_lock, so lockdep will
> +	 * complain later when we register it under the lock.
> +	 */
> +	dmar_register_bus_notifier();
> +
> +	down_write(&dmar_global_lock);
> +
>  	if (!no_iommu)
>  		intel_iommu_debugfs_init();
>  
> @@ -3997,9 +4014,11 @@ int __init intel_iommu_init(void)
>  		pr_err("Initialization failed\n");
>  		goto out_free_dmar;
>  	}
> +	up_write(&dmar_global_lock);
>  
>  	init_iommu_pm_ops();
>  
> +	down_read(&dmar_global_lock);
>  	for_each_active_iommu(iommu, drhd) {
>  		/*
>  		 * The flush queue implementation does not perform
> @@ -4017,10 +4036,12 @@ int __init intel_iommu_init(void)
>  				       "%s", iommu->name);
>  		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
>  	}
> +	up_read(&dmar_global_lock);
>  
>  	if (si_domain && !hw_pass_through)
>  		register_memory_notifier(&intel_iommu_memory_nb);
>  
> +	down_read(&dmar_global_lock);
>  	if (probe_acpi_namespace_devices())
>  		pr_warn("ACPI name space devices didn't probe correctly\n");
>  
> @@ -4031,15 +4052,17 @@ int __init intel_iommu_init(void)
>  
>  		iommu_disable_protect_mem_regions(iommu);
>  	}
> +	up_read(&dmar_global_lock);
>  
> -	intel_iommu_enabled = 1;
> -	dmar_register_bus_notifier();
>  	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
>  
> +	intel_iommu_enabled = 1;
> +
>  	return 0;
>  
>  out_free_dmar:
>  	intel_iommu_free_dmars();
> +	up_write(&dmar_global_lock);
>  	return ret;
>  }
>  
