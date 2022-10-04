Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3C5F476A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJDQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJDQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:21:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C25B7B6;
        Tue,  4 Oct 2022 09:21:02 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294FaFJK027601;
        Tue, 4 Oct 2022 16:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ld05Yh9O6nRCRRVnFyZ6YMI1JBs5AmR0FP+RYbJGIDU=;
 b=dDve3KROT2nSQCdDtKVfjbU4y/bYfo50/njyk+kGDd2OvF80kiWhW35W+SyK7zkvi+yU
 ppNa+4ZUXgv/Hy9GXyBbCYxnHSDSaSY00SL/hb6BNlyJJkYLxygxdZnRv+cCs72tcKoN
 6fZ0LtNLMOTwMOleJ4vQDgo3tZ+LkDUuyvo0qBWA5PGP3MWyz7zvxHfqpOOThOT6j5fW
 Aih61peb86j8Kn7ZhxT0YCrWPD77TgWk9jHprohW4gSn4Zi7O3G8BrZfBVaRkB4cwnVS
 WOpEQ0d2/MZgh79+0uSn5pMvNLgDHmyNALph5ilopzFwYpeu8kQsO4uMqhB3BM8wEsBP fw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fcah6wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:20:52 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294G58WD009433;
        Tue, 4 Oct 2022 16:20:51 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3jxd69dya2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:20:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294GKoex27263282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 16:20:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8E3358050;
        Tue,  4 Oct 2022 16:20:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A9E258061;
        Tue,  4 Oct 2022 16:20:48 +0000 (GMT)
Received: from [9.77.144.104] (unknown [9.77.144.104])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 16:20:48 +0000 (GMT)
Message-ID: <95df349e-3b8d-57b4-6e07-ba80f685d4f1@linux.ibm.com>
Date:   Tue, 4 Oct 2022 12:20:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/5] iommu/s390: Get rid of s390_domain_device
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-3-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221004120706.2957492-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1-Rtll0XEWR7M0mOES8GL13ZsOMb3hKR
X-Proofpoint-ORIG-GUID: 1-Rtll0XEWR7M0mOES8GL13ZsOMb3hKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040104
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 8:07 AM, Niklas Schnelle wrote:
> The struct s390_domain_device serves the sole purpose as list entry for
> the devices list of a struct s390_domain. As it contains no additional
> information besides a list_head and a pointer to the struct zpci_dev we
> can simplify things and just thread the device list through struct
> zpci_dev directly. This removes the need to allocate during domain
> attach and gets rid of one level of indirection during mapping
> operations.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/include/asm/pci.h |  1 +
>  drivers/iommu/s390-iommu.c  | 45 ++++++++-----------------------------
>  2 files changed, 10 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 108e732d7b14..15f8714ca9b7 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -117,6 +117,7 @@ struct zpci_bus {
>  struct zpci_dev {
>  	struct zpci_bus *zbus;
>  	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
> +	struct list_head iommu_list;
>  	struct kref kref;
>  	struct hotplug_slot hotplug_slot;
>  
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 0f58e897bc95..6f87dd4b85af 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -29,11 +29,6 @@ struct s390_domain {
>  	spinlock_t		list_lock;
>  };
>  
> -struct s390_domain_device {
> -	struct list_head	list;
> -	struct zpci_dev		*zdev;
> -};
> -
>  static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
>  {
>  	return container_of(dom, struct s390_domain, domain);
> @@ -87,21 +82,13 @@ static void s390_domain_free(struct iommu_domain *domain)
>  static void __s390_iommu_detach_device(struct zpci_dev *zdev)
>  {
>  	struct s390_domain *s390_domain = zdev->s390_domain;
> -	struct s390_domain_device *domain_device, *tmp;
>  	unsigned long flags;
>  
>  	if (!s390_domain)
>  		return;
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> -				 list) {
> -		if (domain_device->zdev == zdev) {
> -			list_del(&domain_device->list);
> -			kfree(domain_device);
> -			break;
> -		}
> -	}
> +	list_del_init(&zdev->iommu_list);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
>  	zpci_unregister_ioat(zdev, 0);
> @@ -114,17 +101,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
> -	struct s390_domain_device *domain_device;
>  	unsigned long flags;
> -	int cc, rc = 0;
> +	int cc;
>  
>  	if (!zdev)
>  		return -ENODEV;
>  
> -	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
> -	if (!domain_device)
> -		return -ENOMEM;
> -
>  	if (zdev->s390_domain)
>  		__s390_iommu_detach_device(zdev);
>  	else if (zdev->dma_table)
> @@ -133,10 +115,8 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	zdev->dma_table = s390_domain->dma_table;
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
>  				virt_to_phys(zdev->dma_table));
> -	if (cc) {
> -		rc = -EIO;
> -		goto out_free;
> -	}
> +	if (cc)
> +		return -EIO;
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	/* First device defines the DMA range limits */
> @@ -147,21 +127,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	/* Allow only devices with identical DMA range limits */
>  	} else if (domain->geometry.aperture_start != zdev->start_dma ||
>  		   domain->geometry.aperture_end != zdev->end_dma) {
> -		rc = -EINVAL;
>  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		goto out_free;
> +		return -EINVAL;
>  	}
> -	domain_device->zdev = zdev;
>  	zdev->s390_domain = s390_domain;
> -	list_add(&domain_device->list, &s390_domain->devices);
> +	list_add(&zdev->iommu_list, &s390_domain->devices);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
>  	return 0;
> -
> -out_free:
> -	kfree(domain_device);
> -
> -	return rc;
>  }
>  
>  static void s390_iommu_detach_device(struct iommu_domain *domain,
> @@ -198,10 +171,10 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>  				   phys_addr_t pa, dma_addr_t dma_addr,
>  				   size_t size, int flags)
>  {
> -	struct s390_domain_device *domain_device;
>  	phys_addr_t page_addr = pa & PAGE_MASK;
>  	dma_addr_t start_dma_addr = dma_addr;
>  	unsigned long irq_flags, nr_pages, i;
> +	struct zpci_dev *zdev;
>  	unsigned long *entry;
>  	int rc = 0;
>  
> @@ -226,8 +199,8 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>  	}
>  
>  	spin_lock(&s390_domain->list_lock);
> -	list_for_each_entry(domain_device, &s390_domain->devices, list) {
> -		rc = zpci_refresh_trans((u64) domain_device->zdev->fh << 32,
> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> +		rc = zpci_refresh_trans((u64)zdev->fh << 32,
>  					start_dma_addr, nr_pages * PAGE_SIZE);
>  		if (rc)
>  			break;

