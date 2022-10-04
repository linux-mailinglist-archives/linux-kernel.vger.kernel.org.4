Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00E55F4AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJDVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:12:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E95F7C6;
        Tue,  4 Oct 2022 14:12:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294J1fm1029319;
        Tue, 4 Oct 2022 21:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ybPiVCLipzMS22kFfV5SbC1HhChZcTgMTg/hzzxXb1o=;
 b=VoAXbhBcQbsUrno7SAZkzvjokE/IbAlbjwcNiBD0jcvBOrudBFo5rLNEdQnIRs+o1r5D
 7phD84kWaVXVTHKSBRrucHr/QhobUT9KtrB2RWFg8GEWcsmr7FmCuUVUT1N7xMuhpRx+
 WiLpdxtm8sx/8x6UNSM5fyPSq0VGZ4JV3xUM//08Pmo+uvTZnYhWvT1tcEL69h8vhJ1P
 Ha8/w1TnuiU5nsvVlP8PXNotYceKr/tm4tftAhYBypoJlESuRG5NYHsR3Ecl0LtSYKiH
 0EHjMkaWDVyjBbgxLmb8IKDBTA7rbjE7fbQNWPPszvHSQMY8jXZEeOQOhJJ/vwdKmS9v Ng== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gpq5g39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 21:12:36 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294L5jrt003102;
        Tue, 4 Oct 2022 21:12:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3jxd69w31t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 21:12:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294LCXR69110134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 21:12:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0651058050;
        Tue,  4 Oct 2022 21:12:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C8858045;
        Tue,  4 Oct 2022 21:12:31 +0000 (GMT)
Received: from [9.77.144.104] (unknown [9.77.144.104])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 21:12:30 +0000 (GMT)
Message-ID: <c76d2534-3318-32f0-f115-0c44fac53dc9@linux.ibm.com>
Date:   Tue, 4 Oct 2022 17:12:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 3/5] iommu/s390: Fix potential s390_domain aperture
 shrinking
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-4-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221004120706.2957492-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yKQ5wHsc7Y0LxX5owqJxKQG2PHNVo0Yj
X-Proofpoint-ORIG-GUID: yKQ5wHsc7Y0LxX5owqJxKQG2PHNVo0Yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040136
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 8:07 AM, Niklas Schnelle wrote:
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
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/iommu/s390-iommu.c | 50 +++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 6f87dd4b85af..762dc55aea1e 100644
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
> @@ -107,30 +110,24 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	if (!zdev)
>  		return -ENODEV;
>  
> +	if (domain->geometry.aperture_start > zdev->end_dma ||
> +	    domain->geometry.aperture_end < zdev->start_dma)
> +		return -EINVAL;
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
> -		return -EINVAL;
> -	}
> +	zdev->dma_table = s390_domain->dma_table;
>  	zdev->s390_domain = s390_domain;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	list_add(&zdev->iommu_list, &s390_domain->devices);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
> @@ -148,6 +145,30 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
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
> @@ -330,6 +351,7 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.release_device = s390_iommu_release_device,
>  	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.get_resv_regions = s390_iommu_get_resv_regions,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= s390_iommu_attach_device,
>  		.detach_dev	= s390_iommu_detach_device,

