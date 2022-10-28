Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C16116D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJ1QGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJ1QFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CB421B4;
        Fri, 28 Oct 2022 09:04:28 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFghvG001128;
        Fri, 28 Oct 2022 16:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/UxvKL5Ig6VFiXv94NOVkSIIHUnbRiag6SyoU1kkxDQ=;
 b=ZDpzPYOWZnRhwJyBrluQinwHPkAyvwoYXQL7GwhkV01/Ki7oLyLKjWaKabJep44JoJ66
 DXpoupF1MeryeUgPgI8KnH2wCnKLfvFabcYN/UTUuX7e6X37IAP+qZ7MP/jo5CAlJEzX
 HD9A9tYdtj6F2rSV5cCb1kKauXTXw0eJx0TUJd+AJT7biqMkHXEo/fzjp7oRTdWuJDRK
 /R2bH/wzUGgIn2h3oLivd5RuPpeQUXN3k+fgXgk68tT5virDOmlcwgVx5pOzlFffDafa
 KATS5Z9li4nA7cSCMRVx+J2RavOCPoTExn5LSO+v6B+XwjxJBjV3ixfTKlO11u6+px1u Hw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kghy8grxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:04:00 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SFpr6a024714;
        Fri, 28 Oct 2022 16:03:55 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3kfah7verr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:03:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SG3smV2491026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:03:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2CA958073;
        Fri, 28 Oct 2022 16:03:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD76A5805F;
        Fri, 28 Oct 2022 16:03:51 +0000 (GMT)
Received: from [9.160.93.208] (unknown [9.160.93.208])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 16:03:51 +0000 (GMT)
Message-ID: <7da1ab0b-e78a-2ed1-0263-e9174c3af256@linux.ibm.com>
Date:   Fri, 28 Oct 2022 12:03:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/5] iommu/s390: Add I/O TLB ops
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-3-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221018145132.998866-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8HAKoJX2PLUmZbLnwHR0HMxnCbyoJzpN
X-Proofpoint-GUID: 8HAKoJX2PLUmZbLnwHR0HMxnCbyoJzpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210280100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 10:51 AM, Niklas Schnelle wrote:
> Currently s390-iommu does an I/O TLB flush (RPCIT) for every update of
> the I/O translation table explicitly. For one this is wasteful since
> RPCIT can be skipped after a mapping operation if zdev->tlb_refresh is
> unset. Moreover we can do a single RPCIT for a range of pages including
> whne doing lazy unmapping.
> 
> Thankfully both of these optimizations can be achieved by implementing
> the IOMMU operations common code provides for the different types of I/O
> tlb flushes:
> 
>  * flush_iotlb_all: Flushes the I/O TLB for the entire IOVA space
>  * iotlb_sync:  Flushes the I/O TLB for a range of pages that can be
>    gathered up, for example to implement lazy unmapping.
>  * iotlb_sync_map: Flushes the I/O TLB after a mapping operation
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 76 ++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index ee88e717254b..a4c2e9bc6d83 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -199,14 +199,72 @@ static void s390_iommu_release_device(struct device *dev)
>  		__s390_iommu_detach_device(zdev);
>  }
>  
> +static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	struct zpci_dev *zdev;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> +		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> +					zdev->end_dma - zdev->start_dma + 1);
> +		if (rc)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +}
> +
> +static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
> +				  struct iommu_iotlb_gather *gather)
> +{
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	size_t size = gather->end - gather->start + 1;
> +	struct zpci_dev *zdev;
> +	unsigned long flags;
> +	int rc;
> +
> +	/* If gather was never added to there is nothing to flush */
> +	if (gather->start == ULONG_MAX)
> +		return;

Hmm, this seems a little awkward in that it depends on the init value in iommu_iotlb_gather_init never changing.  I don't see any other iommu drivers doing this -- Is there no other way to tell there's nothing to flush?

If we really need to do this, maybe some shared #define in iommu.h that is used in iommu_iotlb_gather_init and here?

> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> +		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
> +					size);
> +		if (rc)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +}
> +
> +static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	struct zpci_dev *zdev;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> +		if (!zdev->tlb_refresh)
> +			continue;
> +		rc = zpci_refresh_trans((u64)zdev->fh << 32,
> +					iova, size);
> +		if (rc)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +}
> +
>  static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>  				   phys_addr_t pa, dma_addr_t dma_addr,
>  				   unsigned long nr_pages, int flags)
>  {
>  	phys_addr_t page_addr = pa & PAGE_MASK;
> -	dma_addr_t start_dma_addr = dma_addr;
>  	unsigned long irq_flags, i;
> -	struct zpci_dev *zdev;
>  	unsigned long *entry;
>  	int rc = 0;
>  
> @@ -225,15 +283,6 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>  		dma_addr += PAGE_SIZE;
>  	}
>  
> -	spin_lock(&s390_domain->list_lock);
> -	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> -		rc = zpci_refresh_trans((u64)zdev->fh << 32,
> -					start_dma_addr, nr_pages * PAGE_SIZE);
> -		if (rc)
> -			break;
> -	}
> -	spin_unlock(&s390_domain->list_lock);
> -
>  undo_cpu_trans:
>  	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
>  		flags = ZPCI_PTE_INVALID;
> @@ -340,6 +389,8 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
>  	if (rc)
>  		return 0;
>  
> +	iommu_iotlb_gather_add_range(gather, iova, size);
> +
>  	return size;
>  }
>  
> @@ -384,6 +435,9 @@ static const struct iommu_ops s390_iommu_ops = {
>  		.detach_dev	= s390_iommu_detach_device,
>  		.map_pages	= s390_iommu_map_pages,
>  		.unmap_pages	= s390_iommu_unmap_pages,
> +		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
> +		.iotlb_sync      = s390_iommu_iotlb_sync,
> +		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
>  		.iova_to_phys	= s390_iommu_iova_to_phys,
>  		.free		= s390_domain_free,
>  	}

