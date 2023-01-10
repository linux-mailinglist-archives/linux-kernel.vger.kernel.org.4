Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B966443E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbjAJPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbjAJPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:11:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E96C192B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:11:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35D6B2F4;
        Tue, 10 Jan 2023 07:12:11 -0800 (PST)
Received: from [10.57.76.227] (unknown [10.57.76.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92853F67D;
        Tue, 10 Jan 2023 07:11:27 -0800 (PST)
Message-ID: <e4d5db37-a7b9-9b33-4ecf-c168b6d41a9a@arm.com>
Date:   Tue, 10 Jan 2023 15:11:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Content-Language: en-GB
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, ashish.kalra@amd.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 14:31, Suravee Suthikulpanit wrote:
> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
> a KVM structure to a VFIO group. The information in struct KVM is also
> useful for IOMMU drivers when setting up VFIO domain.
> 
> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
> IOMMU drivers to provide call-back to process the struct KVM assigned.

Hmm, it sounds like this has quite some overlap of intent with the 
existing "enable_nesting" op, and my gut feeling is that it's not great 
to have two completely different "this is a VFIO domain" mechanisms... :/

Robin.

> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/iommu.c    | 10 ++++++++++
>   drivers/vfio/vfio_main.c |  1 +
>   include/linux/iommu.h    |  4 ++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 65a3b3d886dc..5116d5fe35f2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3231,3 +3231,13 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   	return user;
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +void iommu_set_kvm(struct iommu_group *group, struct kvm *kvm)
> +{
> +	if (!group || !group->domain || !group->domain->ops)
> +		return;
> +
> +	if (group->domain->ops->set_kvm)
> +		group->domain->ops->set_kvm(group->domain, kvm);
> +}
> +EXPORT_SYMBOL_GPL(iommu_set_kvm);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 2d168793d4e1..7641e3a0c986 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>   
>   	mutex_lock(&group->group_lock);
>   	group->kvm = kvm;
> +	iommu_set_kvm(group->iommu_group, kvm);
>   	mutex_unlock(&group->group_lock);
>   }
>   EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3c9da1f8979e..43000231d3d7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,7 @@ struct notifier_block;
>   struct iommu_sva;
>   struct iommu_fault_event;
>   struct iommu_dma_cookie;
> +struct kvm;
>   
>   /* iommu fault flags */
>   #define IOMMU_FAULT_READ	0x0
> @@ -314,6 +315,8 @@ struct iommu_domain_ops {
>   				  unsigned long quirks);
>   
>   	void (*free)(struct iommu_domain *domain);
> +
> +	void (*set_kvm)(struct iommu_domain *domain, struct kvm *kvm);
>   };
>   
>   /**
> @@ -391,6 +394,7 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu);
>   int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
>   void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
> +void iommu_set_kvm(struct iommu_group *group, struct kvm *kvm);
>   
>   static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
>   {
