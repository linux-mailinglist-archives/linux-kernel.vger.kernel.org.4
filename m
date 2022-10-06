Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF75F6FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiJFVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJFVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:02:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B636B0B00;
        Thu,  6 Oct 2022 14:02:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296JVWXS032290;
        Thu, 6 Oct 2022 21:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FQvx4KJiujxSSVTb3MfTVA0S62D6kbyVVZvcbfU4GYU=;
 b=J2anyoBc4/eSqV0PjqbcpY4CUwAYXZqL7ivivwZuw046lvcy/reYxw3ptkS48r3mwZxU
 z+Wf539/fkhWxesH+DRZFNpC3lrVpDw5+PmDYuHjXsgB06yw09Ux5AN35XyKCnMPc0M4
 W6Jl/z2ksJx//xtLC5EsJ7xyGyzrm+Sw8zLNtuFJh2ZBfwXPiWiBni8teUyqDPrY7GZP
 m7PzQIOUop1zgqkmNnuVaVVwLgwUeoe/4szYPNxeQiMmgmBIsPXBNK0HWmjj5e3NyapL
 dxBA746Io1fgKtx4BAzY34IoHpUMaIg090xLbwMgcEujk498TgmMo0OUaOxN1z0wJCLj SQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k258mjj7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 21:02:44 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296KpOBE010949;
        Thu, 6 Oct 2022 21:02:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3jxd6ady68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 21:02:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296L2guC1049324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 21:02:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEB4758066;
        Thu,  6 Oct 2022 21:02:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D105806D;
        Thu,  6 Oct 2022 21:02:39 +0000 (GMT)
Received: from [9.65.202.26] (unknown [9.65.202.26])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 21:02:39 +0000 (GMT)
Message-ID: <acbc56b3-41b4-f71a-01d7-63c34348e079@linux.ibm.com>
Date:   Thu, 6 Oct 2022 17:02:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 3/6] iommu/s390: Fix potential s390_domain aperture
 shrinking
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
 <20221006144700.3380098-4-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221006144700.3380098-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QSmO1E6YNkr_Gu6ynuFjhElmAGURD42w
X-Proofpoint-ORIG-GUID: QSmO1E6YNkr_Gu6ynuFjhElmAGURD42w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060124
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 10:46 AM, Niklas Schnelle wrote:
> The s390 IOMMU driver currently sets the IOMMU domain's aperture to
> match the device specific DMA address range of the device that is first
> attached. This is not ideal. For one if the domain has no device
> attached in the meantime the aperture could be shrunk allowing
> translations outside the aperture to exist in the translation tables.
> Also this is a bit of a misuse of the aperture which really should
> describe what addresses can be translated and not some device specific
> limitations.
> 
> Instead of misusing the aperture like this we can instead create
> reserved ranges for the ranges inaccessible to the attached devices
> allowing devices with overlapping ranges to still share an IOMMU domain.
> This also significantly simplifies s390_iommu_attach_device() allowing
> us to move the aperture check to the beginning of the function and
> removing the need to hold the device list's lock to check the aperture.
> 
> As we then use the same aperture for all domains and it only depends on
> the table properties we can already check zdev->start_dma/end_dma at
> probe time and turn the check on attach into a WARN_ON().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
> v4->v5:
> - Make aperture check in attach a WARN_ON() and fail in probe if
>   zdev->start_dma/end_dma doesn't git in aperture  (Jason)
> 
>  drivers/iommu/s390-iommu.c | 65 +++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 9b3ae4b14636..1f6c9bee9a80 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -62,6 +62,9 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
>  		kfree(s390_domain);
>  		return NULL;
>  	}
> +	s390_domain->domain.geometry.force_aperture = true;
> +	s390_domain->domain.geometry.aperture_start = 0;
> +	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
>  
>  	spin_lock_init(&s390_domain->dma_table_lock);
>  	spin_lock_init(&s390_domain->list_lock);
> @@ -102,46 +105,32 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	unsigned long flags;
> -	int cc, rc = 0;
> +	int cc;
>  
>  	if (!zdev)
>  		return -ENODEV;
>  
> +	WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
> +		domain->geometry.aperture_end < zdev->start_dma);
> +
>  	if (zdev->s390_domain)
>  		__s390_iommu_detach_device(zdev);
>  	else if (zdev->dma_table)
>  		zpci_dma_exit_device(zdev);
>  
> -	zdev->dma_table = s390_domain->dma_table;
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -				virt_to_phys(zdev->dma_table));
> +				virt_to_phys(s390_domain->dma_table));
>  	if (cc)
>  		return -EIO;
>  
> -	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	/* First device defines the DMA range limits */
> -	if (list_empty(&s390_domain->devices)) {
> -		domain->geometry.aperture_start = zdev->start_dma;
> -		domain->geometry.aperture_end = zdev->end_dma;
> -		domain->geometry.force_aperture = true;
> -	/* Allow only devices with identical DMA range limits */
> -	} else if (domain->geometry.aperture_start != zdev->start_dma ||
> -		   domain->geometry.aperture_end != zdev->end_dma) {
> -		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		rc = -EINVAL;
> -		goto out_unregister;
> -	}
> +	zdev->dma_table = s390_domain->dma_table;
>  	zdev->s390_domain = s390_domain;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	list_add(&zdev->iommu_list, &s390_domain->devices);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
>  	return 0;
> -
> -out_unregister:
> -	zpci_unregister_ioat(zdev, 0);
> -	zdev->dma_table = NULL;
> -
> -	return rc;
>  }
>  
>  static void s390_iommu_detach_device(struct iommu_domain *domain,
> @@ -155,10 +144,41 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>  	zpci_dma_init_device(zdev);
>  }
>  
> +static void s390_iommu_get_resv_regions(struct device *dev,
> +					struct list_head *list)
> +{
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +	struct iommu_resv_region *region;
> +
> +	if (zdev->start_dma) {
> +		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
> +						 IOMMU_RESV_RESERVED);
> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +
> +	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
> +		region = iommu_alloc_resv_region(zdev->end_dma + 1,
> +						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
> +						 0, IOMMU_RESV_RESERVED);
> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +}
> +
>  static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>  {
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  
> +	if (zdev->start_dma > zdev->end_dma ||
> +	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
> +		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
> +
>  	return &zdev->iommu_dev;
>  }
>  
> @@ -337,6 +357,7 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.release_device = s390_iommu_release_device,
>  	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.get_resv_regions = s390_iommu_get_resv_regions,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= s390_iommu_attach_device,
>  		.detach_dev	= s390_iommu_detach_device,

