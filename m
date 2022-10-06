Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3835F6FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiJFVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJFVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:07:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85659C14A3;
        Thu,  6 Oct 2022 14:07:42 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296Kqeik004263;
        Thu, 6 Oct 2022 21:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1R0M70lNStrUnDIQ1CEWm8D1AU631195rQW77wCIWUs=;
 b=ZxQFPDzS3VIoXXpnfJfqqv/N3lRpINmelmoC9iPYd9psiPCnRvBuxFcAbqXNTe6T7PfY
 V2a6b8BGy1BdU6fBMfvsggm0Czr9vQSB5NzLL5r+6Lx/l7p6ZqsqXguF+sECgk8vpGnJ
 MwAROhCrHl7KpaC5v3L4g0OKXoP6tUxOlBjhMcEeNNbe6/wrGB38jCfdLj5ElXmv6XAu
 dO8ZifZdEUNrZ/xs6/a9OZ3wezo+ufml5dVSjXyDn7aQRstp+SfvIThkVHQaI7XjAXHu
 F8YtI3YD0tR2VlhIsgeAKA46gmEmnLtzjlTKu+vwiVL3lPHRdv1ThPO00YVhJFq64jCb YQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k26ej0ehs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 21:07:26 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296Koofp009179;
        Thu, 6 Oct 2022 21:02:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3jxd6anynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 21:02:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296L2OwS15532516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 21:02:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB72A58065;
        Thu,  6 Oct 2022 21:02:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAB7458059;
        Thu,  6 Oct 2022 21:02:21 +0000 (GMT)
Received: from [9.65.202.26] (unknown [9.65.202.26])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 21:02:21 +0000 (GMT)
Message-ID: <c778fc2b-2c0d-777c-52fb-1b315cf95552@linux.ibm.com>
Date:   Thu, 6 Oct 2022 17:02:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 1/6] iommu/s390: Fix duplicate domain attachments
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
 <20221006144700.3380098-2-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221006144700.3380098-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QCJJp0LGdo9-qAkW-bUc7SQl1oyt8ygO
X-Proofpoint-GUID: QCJJp0LGdo9-qAkW-bUc7SQl1oyt8ygO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=851 priorityscore=1501 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") we can end up with duplicates in the list of devices attached to
> a domain. This is inefficient and confusing since only one domain can
> actually be in control of the IOMMU translations for a device. Fix this
> by detaching the device from the previous domain, if any, on attach.
> Add a WARN_ON() in case we still have attached devices on freeing the
> domain. While here remove the re-attach on failure dance as it was
> determined to be unlikely to help and may confuse debug and recovery.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v4->v5:
> - Unregister IOAT and set zdev->dma_table on error (Matt)
>
...

>  static int s390_iommu_attach_device(struct iommu_domain *domain,
>  				    struct device *dev)
>  {
> @@ -90,7 +116,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	struct s390_domain_device *domain_device;
>  	unsigned long flags;
> -	int cc, rc;
> +	int cc, rc = 0;
>  
>  	if (!zdev)
>  		return -ENODEV;
> @@ -99,23 +125,17 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	if (!domain_device)
>  		return -ENOMEM;
>  
> -	if (zdev->dma_table && !zdev->s390_domain) {
> -		cc = zpci_dma_exit_device(zdev);
> -		if (cc) {
> -			rc = -EIO;
> -			goto out_free;
> -		}
> -	}
> -
>  	if (zdev->s390_domain)
> -		zpci_unregister_ioat(zdev, 0);
> +		__s390_iommu_detach_device(zdev);
> +	else if (zdev->dma_table)
> +		zpci_dma_exit_device(zdev);
>  
>  	zdev->dma_table = s390_domain->dma_table;
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
>  				virt_to_phys(zdev->dma_table));
>  	if (cc) {
>  		rc = -EIO;
> -		goto out_restore;
> +		goto out_free;
>  	}

Hmm, with this we will leave attach_dev with a zdev->dma_table associated with this domain (not one generated via zpci_dma_init_device) and zdev->s390_domain == 0.  Won't this cause both s390_domain_free and zpci_dma_exit_device() to try and free the same dma table?

I think we also have to leave with a NULL zdev->dma_table in this case too (you technically could skip the zpci_unregister_ioat)

>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> @@ -127,9 +147,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	/* Allow only devices with identical DMA range limits */
>  	} else if (domain->geometry.aperture_start != zdev->start_dma ||
>  		   domain->geometry.aperture_end != zdev->end_dma) {
> -		rc = -EINVAL;
>  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		goto out_restore;
> +		rc = -EINVAL;
> +		goto out_unregister;
>  	}
>  	domain_device->zdev = zdev;
>  	zdev->s390_domain = s390_domain;
> @@ -138,14 +158,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  
>  	return 0;
>  
> -out_restore:
> -	if (!zdev->s390_domain) {
> -		zpci_dma_init_device(zdev);
> -	} else {
> -		zdev->dma_table = zdev->s390_domain->dma_table;
> -		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -				   virt_to_phys(zdev->dma_table));
> -	}
> +out_unregister:
> +	zpci_unregister_ioat(zdev, 0);
> +	zdev->dma_table = NULL;
>  out_free:
>  	kfree(domain_device);
>  

