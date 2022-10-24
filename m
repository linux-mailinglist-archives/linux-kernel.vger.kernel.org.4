Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0860B21A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiJXQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiJXQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:41:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5246226C9;
        Mon, 24 Oct 2022 08:28:47 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OEijmo002466;
        Mon, 24 Oct 2022 15:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CXbPk6KfVbEUj4mvUy75NRKeO6rjMSSdAQ2/7/QtbBo=;
 b=ZZmSvkhLj5SSBrPdoeQWpzZWaAldgYJ0njL5k3kby2GdmItkePmhuW7YERbZk0V+HFz1
 ZTryhdspaoIHlwMdwnSZBKOByuctSIexpOWpEUy3t53QRKQLEhMj4fBnFgdsK2MbCnNY
 zVGkR7Nc7LgLQwPOYmLMkkBOSlaaUTZH/qwoEPoITXJ0ckOK9IK8dZFpqtGcBlrOcfCB
 HqoeFbkci+wi3G5rg4HpGwTiDnejnIFKWDHCBY9EYpAzvt1YXILNTfyINbeTmevH9WTz
 TR8lv+Ssx8Fy/b0fTnNWMgQpOYB4e2J+jlM7yzJ+RgiGhpizk2CvY0a9CQACnfeaXN7l aQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdvqy106m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:07:18 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OEoQSe019281;
        Mon, 24 Oct 2022 15:02:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3kc7sj2kqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:02:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OF2Cst35586708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 15:02:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E21AA4054;
        Mon, 24 Oct 2022 15:02:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C1DA405F;
        Mon, 24 Oct 2022 15:02:11 +0000 (GMT)
Received: from sig-9-145-54-55.uk.ibm.com (unknown [9.145.54.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 15:02:11 +0000 (GMT)
Message-ID: <e16bbc699445c15788727b2094b032323168bad1.camel@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] iommu/s390: Fix potential s390_domain aperture
 shrinking
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Date:   Mon, 24 Oct 2022 17:02:11 +0200
In-Reply-To: <20221017124558.1386337-4-schnelle@linux.ibm.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
         <20221017124558.1386337-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mp3qej8oda2Ka77tiT84HKTasKin6PS0
X-Proofpoint-GUID: mp3qej8oda2Ka77tiT84HKTasKin6PS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 14:45 +0200, Niklas Schnelle wrote:
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
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v5->v6:
> - Return -EINVAL after WARN_ON() in attach
> v4->v5:
> - Make aperture check in attach a WARN_ON() and fail in probe if
>   zdev->start_dma/end_dma doesn't git in aperture  (Jason)
> 
>  drivers/iommu/s390-iommu.c | 63 ++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index af83ccde16a4..c4203a37faa4 100644
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
> @@ -102,11 +105,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	unsigned long flags;
> -	int cc, rc = 0;
> +	int cc;
>  
>  	if (!zdev)
>  		return -ENODEV;
>  
> +	if (WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
> +		domain->geometry.aperture_end < zdev->start_dma))
> +		return -EINVAL;
> +
>  	if (zdev->s390_domain)
>  		__s390_iommu_detach_device(zdev);
>  	else if (zdev->dma_table)
> @@ -118,30 +125,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		return -EIO;
>  	zdev->dma_table = s390_domain->dma_table;
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
> @@ -155,6 +146,30 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
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

Heads up! The iommu_alloc_resv_region() function gained a gfp parameter
from v6.1-rc1 to v6.1-rc2 so the above needs "…, GFP_KERNEL);".
@Joerg, @Will if you don't mind I'll rebase on v6.1-rc2 and resend.
@Jason if you want to re-add your R-b this would be good time.


> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +
> +	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
> +		region = iommu_alloc_resv_region(zdev->end_dma + 1,
> +						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
> +						 0, IOMMU_RESV_RESERVED);

Same as above.

> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +}
> +
>  static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>  {
>  	struct zpci_dev *zdev;
> @@ -164,6 +179,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>  
>  	zdev = to_zpci_dev(dev);
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
> @@ -342,6 +364,7 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.release_device = s390_iommu_release_device,
>  	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.get_resv_regions = s390_iommu_get_resv_regions,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= s390_iommu_attach_device,
>  		.detach_dev	= s390_iommu_detach_device,


