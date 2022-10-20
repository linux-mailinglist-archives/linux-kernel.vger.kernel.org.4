Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81E606161
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiJTNTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJTNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:19:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1080B13F58;
        Thu, 20 Oct 2022 06:19:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E38CED1;
        Thu, 20 Oct 2022 06:18:41 -0700 (PDT)
Received: from [10.57.5.187] (unknown [10.57.5.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9AA23F67D;
        Thu, 20 Oct 2022 06:18:31 -0700 (PDT)
Message-ID: <a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com>
Date:   Thu, 20 Oct 2022 14:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC 5/6] iommu/dma: Add simple batching flush queue
 implementation
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
 <20221019144435.369902-6-schnelle@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221019144435.369902-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-19 15:44, Niklas Schnelle wrote:
> Having dma-iommu prepared for alternative flush queue implementations we
> add a simple per-domain flush queue that optimzes for scenarios where
> global IOTLB flushes are used but are quite expensive and poorly
> parallelized. This is for example the case when IOTLB flushes are used
> to trigger updates to an underlying hypervisor's shadow tables and
> approximates the global flushing scheme previously in use on s390.
> 
> This is achieved by having a per-domain global flush queue that allows
> queuing a much large number of lazily freed IOVAs than the per-CPU flush
> queues. While using a single queue reduces parallelism this is not
> a problem when global IOTLB flushes are synchronized in the hypervisor
> anyway. While this flush queue allows queuing a large number of IOVAs we
> do limit the time a freed IOVA remains accessible by hardware to
> 1 second using a timeout that is reset on flush.
> 
> Enable this new flush queue implementation by default on s390 systems
> which use IOTLB flushes to trigger shadowing namely z/VM and KVM guests.

There seems to be way more duplication here than there probably needs to 
be. Is there any reason we can't keep using the same iova_fq and 
iova_fq_entry structures and just refactor how cookie->fq is 
allocated/freed/dereferenced to choose between percpu and direct? Making 
the queue size and timout variable - and thus potentially tuneable - 
isn't necessarily a bad thing for percpu queues either (the size can be 
constrained to powers of two and stored as a mask to keep the wrapping 
arithemetic efficient).

Thanks,
Robin.

> Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/dma-iommu.c  | 157 +++++++++++++++++++++++++++++++++++--
>   drivers/iommu/iommu.c      |  19 +++--
>   drivers/iommu/s390-iommu.c |  11 +++
>   include/linux/iommu.h      |   6 ++
>   4 files changed, 180 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77d969f5aad7..427fb84f50c3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -49,8 +49,13 @@ struct iommu_dma_cookie {
>   		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
>   		struct {
>   			struct iova_domain		iovad;
> -			/* Flush queue */
> -			struct iova_percpu __percpu *percpu_fq;
> +			/* Flush queues */
> +			union {
> +				struct iova_percpu __percpu *percpu_fq;
> +				struct iova_simple *simple_fq;
> +			};
> +			/* Queue timeout in milliseconds */
> +			unsigned int		fq_timeout;
>   			/* Number of TLB flushes that have been started */
>   			atomic64_t		fq_flush_start_cnt;
>   			/* Number of TLB flushes that have been finished */
> @@ -104,6 +109,119 @@ struct iova_percpu {
>   	spinlock_t lock;
>   };
>   
> +/* Simplified batched flush queue for expensive IOTLB flushes */
> +#define IOVA_SIMPLE_SIZE	32768
> +/* Maximum time in milliseconds an IOVA can remain lazily freed */
> +#define IOVA_SIMPLE_TIMEOUT	1000
> +
> +struct iova_simple_entry {
> +	unsigned long iova_pfn;
> +	unsigned long pages;
> +};
> +
> +struct iova_simple {
> +	/* Unlike iova_percpu we use a single queue lock */
> +	spinlock_t lock;
> +	unsigned int tail;
> +	unsigned long total_pages;
> +	struct list_head freelist;
> +	struct iova_simple_entry entries[];
> +};
> +
> +static bool is_full_simple(struct iommu_dma_cookie *cookie)
> +{
> +	struct iommu_domain *fq_domain = cookie->fq_domain;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_simple *sq = cookie->simple_fq;
> +	unsigned long aperture_pages;
> +
> +	assert_spin_locked(&sq->lock);
> +
> +	/* If more than 7/8 the aperture is batched let's flush */
> +	aperture_pages = ((fq_domain->geometry.aperture_end +  1) -
> +		fq_domain->geometry.aperture_start) >> iova_shift(iovad);
> +	aperture_pages -= aperture_pages >> 3;
> +
> +	return (sq->tail >= IOVA_SIMPLE_SIZE ||
> +		sq->total_pages >= aperture_pages);
> +}
> +
> +static void flush_simple(struct iommu_dma_cookie *cookie)
> +{
> +	struct iova_simple *sq = cookie->simple_fq;
> +	unsigned int i;
> +
> +	assert_spin_locked(&sq->lock);
> +	/* We're flushing so postpone timeout */
> +	mod_timer(&cookie->fq_timer,
> +		  jiffies + msecs_to_jiffies(cookie->fq_timeout));
> +	cookie->fq_domain->ops->flush_iotlb_all(cookie->fq_domain);
> +
> +	put_pages_list(&sq->freelist);
> +	for (i = 0; i < sq->tail; i++) {
> +		free_iova_fast(&cookie->iovad,
> +			       sq->entries[i].iova_pfn,
> +			       sq->entries[i].pages);
> +	}
> +	sq->tail = 0;
> +	sq->total_pages = 0;
> +}
> +
> +static void flush_simple_lock(struct iommu_dma_cookie *cookie)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cookie->simple_fq->lock, flags);
> +	flush_simple(cookie);
> +	spin_unlock_irqrestore(&cookie->simple_fq->lock, flags);
> +}
> +
> +static void queue_iova_simple(struct iommu_dma_cookie *cookie,
> +			      unsigned long pfn, unsigned long pages,
> +			      struct list_head *freelist)
> +{
> +	struct iova_simple *sq = cookie->simple_fq;
> +	unsigned long flags;
> +	unsigned int idx;
> +
> +	spin_lock_irqsave(&sq->lock, flags);
> +	if (is_full_simple(cookie))
> +		flush_simple(cookie);
> +	idx = sq->tail++;
> +
> +	sq->entries[idx].iova_pfn = pfn;
> +	sq->entries[idx].pages    = pages;
> +	list_splice(freelist, &sq->freelist);
> +	sq->total_pages += pages;
> +	spin_unlock_irqrestore(&sq->lock, flags);
> +}
> +
> +static int iommu_dma_init_simple(struct iommu_dma_cookie *cookie)
> +{
> +	struct iova_simple *queue;
> +
> +	queue = vzalloc(sizeof(*queue) +
> +			IOVA_SIMPLE_SIZE * sizeof(struct iova_simple_entry));
> +	if (!queue)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&queue->freelist);
> +	cookie->fq_timeout = IOVA_SIMPLE_TIMEOUT;
> +	cookie->simple_fq = queue;
> +
> +	return 0;
> +}
> +
> +static void iommu_dma_free_simple(struct iommu_dma_cookie *cookie)
> +{
> +	if (!cookie->simple_fq)
> +		return;
> +
> +	put_pages_list(&cookie->simple_fq->freelist);
> +	vfree(cookie->simple_fq);
> +	cookie->simple_fq = NULL;
> +}
> +
>   #define ring_for_each_percpu(i, fq) \
>   	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_PERCPU_SIZE)
>   
> @@ -169,12 +287,23 @@ static void flush_percpu(struct iommu_dma_cookie *cookie)
>   	}
>   }
>   
> +static void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
> +{
> +	if (!cookie->fq_domain)
> +		return;
> +
> +	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
> +		flush_percpu(cookie);
> +	else
> +		flush_simple_lock(cookie);
> +}
> +
>   static void fq_flush_timeout(struct timer_list *t)
>   {
>   	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
>   
>   	atomic_set(&cookie->fq_timer_on, 0);
> -	flush_percpu(cookie);
> +	iommu_dma_flush_fq(cookie);
>   }
>   
>   static void queue_iova_percpu(struct iommu_dma_cookie *cookie,
> @@ -223,13 +352,16 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	 */
>   	smp_mb();
>   
> -	queue_iova_percpu(cookie, pfn, pages, freelist);
> +	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
> +		queue_iova_percpu(cookie, pfn, pages, freelist);
> +	else
> +		queue_iova_simple(cookie, pfn, pages, freelist);
>   
>   	/* Avoid false sharing as much as possible. */
>   	if (!atomic_read(&cookie->fq_timer_on) &&
>   	    !atomic_xchg(&cookie->fq_timer_on, 1))
>   		mod_timer(&cookie->fq_timer,
> -			  jiffies + msecs_to_jiffies(IOVA_PERCPU_TIMEOUT));
> +			  jiffies + msecs_to_jiffies(cookie->fq_timeout));
>   }
>   
>   static void iommu_dma_free_percpu(struct iommu_dma_cookie *cookie)
> @@ -253,7 +385,10 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
>   {
>   	del_timer_sync(&cookie->fq_timer);
>   	/* The IOVAs will be torn down separately, so just free our queued pages */
> -	iommu_dma_free_percpu(cookie);
> +	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
> +		iommu_dma_free_percpu(cookie);
> +	else
> +		iommu_dma_free_simple(cookie);
>   }
>   
>   static int iommu_dma_init_percpu(struct iommu_dma_cookie *cookie)
> @@ -280,6 +415,7 @@ static int iommu_dma_init_percpu(struct iommu_dma_cookie *cookie)
>   			INIT_LIST_HEAD(&fq->entries[i].freelist);
>   	}
>   
> +	cookie->fq_timeout = IOVA_PERCPU_TIMEOUT;
>   	cookie->percpu_fq = queue;
>   
>   	return 0;
> @@ -294,7 +430,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
>   	if (cookie->fq_domain)
>   		return 0;
>   
> -	rc = iommu_dma_init_percpu(cookie);
> +	if (domain->type == IOMMU_DOMAIN_DMA_FQ)
> +		rc = iommu_dma_init_percpu(cookie);
> +	else
> +		rc = iommu_dma_init_simple(cookie);
>   	if (rc) {
>   		pr_warn("iova flush queue initialization failed\n");
>   		return rc;
> @@ -613,7 +752,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   		goto done_unlock;
>   
>   	/* If the FQ fails we can simply fall back to strict mode */
> -	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> +	if ((domain->type == IOMMU_DOMAIN_DMA_FQ ||
> +	     domain->type == IOMMU_DOMAIN_DMA_SQ) &&
> +	    iommu_dma_init_fq(domain))
>   		domain->type = IOMMU_DOMAIN_DMA;
>   
>   	ret = iova_reserve_iommu_regions(dev, domain);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..2b3a12799702 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -140,6 +140,7 @@ static const char *iommu_domain_type_str(unsigned int t)
>   		return "Unmanaged";
>   	case IOMMU_DOMAIN_DMA:
>   	case IOMMU_DOMAIN_DMA_FQ:
> +	case IOMMU_DOMAIN_DMA_SQ:
>   		return "Translated";
>   	default:
>   		return "Unknown";
> @@ -437,7 +438,8 @@ early_param("iommu.strict", iommu_dma_setup);
>   void iommu_set_dma_strict(void)
>   {
>   	iommu_dma_strict = true;
> -	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
> +	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ ||
> +	    iommu_def_domain_type == IOMMU_DOMAIN_DMA_SQ)
>   		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
>   
> @@ -638,6 +640,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
>   		case IOMMU_DOMAIN_DMA_FQ:
>   			type = "DMA-FQ\n";
>   			break;
> +		case IOMMU_DOMAIN_DMA_SQ:
> +			type = "DMA-SQ\n";
> +			break;
>   		}
>   	}
>   	mutex_unlock(&group->mutex);
> @@ -2908,10 +2913,11 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   	}
>   
>   	/* We can bring up a flush queue without tearing down the domain */
> -	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
> +	if ((type == IOMMU_DOMAIN_DMA_FQ || type == IOMMU_DOMAIN_DMA_SQ) &&
> +	    prev_dom->type == IOMMU_DOMAIN_DMA) {
>   		ret = iommu_dma_init_fq(prev_dom);
>   		if (!ret)
> -			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
> +			prev_dom->type = type;
>   		goto out;
>   	}
>   
> @@ -2982,6 +2988,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   		req_type = IOMMU_DOMAIN_DMA;
>   	else if (sysfs_streq(buf, "DMA-FQ"))
>   		req_type = IOMMU_DOMAIN_DMA_FQ;
> +	else if (sysfs_streq(buf, "DMA-SQ"))
> +		req_type = IOMMU_DOMAIN_DMA_SQ;
>   	else if (sysfs_streq(buf, "auto"))
>   		req_type = 0;
>   	else
> @@ -3033,8 +3041,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   
>   	/* Check if the device in the group still has a driver bound to it */
>   	device_lock(dev);
> -	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
> -	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
> +	if (device_is_bound(dev) &&
> +	    !((req_type == IOMMU_DOMAIN_DMA_FQ || req_type == IOMMU_DOMAIN_DMA_SQ) &&
> +	      group->default_domain->type == IOMMU_DOMAIN_DMA)) {
>   		pr_err_ratelimited("Device is still bound to driver\n");
>   		ret = -EBUSY;
>   		goto out;
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c2b8a7b96b8e..506f8b92931f 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -324,6 +324,15 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
>   	}
>   }
>   
> +static int s390_iommu_def_domain_type(struct device *dev)
> +{
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +
> +	if (zdev->tlb_refresh)
> +		return IOMMU_DOMAIN_DMA_SQ;
> +	return IOMMU_DOMAIN_DMA_FQ;
> +}
> +
>   static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
>   {
>   	struct s390_domain *s390_domain;
> @@ -331,6 +340,7 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
>   	switch (domain_type) {
>   	case IOMMU_DOMAIN_DMA:
>   	case IOMMU_DOMAIN_DMA_FQ:
> +	case IOMMU_DOMAIN_DMA_SQ:
>   	case IOMMU_DOMAIN_UNMANAGED:
>   		break;
>   	default:
> @@ -774,6 +784,7 @@ subsys_initcall(s390_iommu_init);
>   
>   static const struct iommu_ops s390_iommu_ops = {
>   	.capable = s390_iommu_capable,
> +	.def_domain_type = s390_iommu_def_domain_type,
>   	.domain_alloc = s390_domain_alloc,
>   	.probe_device = s390_iommu_probe_device,
>   	.probe_finalize = s390_iommu_probe_finalize,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a325532aeab5..6c3fe62ec0df 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -63,6 +63,7 @@ struct iommu_domain_geometry {
>   					      implementation              */
>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
> +#define __IOMMU_DOMAIN_DMA_SQ	(1U << 4)  /* DMA-API uses max fill queue */
>   
>   /*
>    * This are the possible domain-types
> @@ -77,6 +78,8 @@ struct iommu_domain_geometry {
>    *				  certain optimizations for these domains
>    *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
>    *				  invalidation.
> + *	IOMMU_DOMAIN_DMA_SQ	- As above, but batched invalidations are only
> + *				  flushed when running out of queue space.
>    */
>   #define IOMMU_DOMAIN_BLOCKED	(0U)
>   #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -86,6 +89,9 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_DMA_SQ	(__IOMMU_DOMAIN_PAGING |	\
> +				 __IOMMU_DOMAIN_DMA_API |	\
> +				 __IOMMU_DOMAIN_DMA_SQ)
>   
>   struct iommu_domain {
>   	unsigned type;
