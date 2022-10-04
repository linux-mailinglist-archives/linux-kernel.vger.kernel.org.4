Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEB5F475B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJDQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJDQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:18:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60E5F119;
        Tue,  4 Oct 2022 09:18:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294FjMRn011075;
        Tue, 4 Oct 2022 16:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DWbF2aNk6D11GkD4DglwPcBOhfpBbUu0tQ6d831AVYI=;
 b=OZjf1frPJfLvm/KsTdwJY41POxOqOqrgjyB4eUvwir2Fq8T0n7o6gU5mLQ3j/JQZUoHt
 4YvvLqDpXqX1sKJVjWoOOEztjJb2dhyWQtFFiklgIzw9dQbTRtSbUOE2lB7wkldF9AIS
 PhPLxBLrpsYMLrd9PgJEh0AMfzn0g0jvU+rtoj5xQ6gziU6+oLG9cxOPs0GpuhORE/KY
 KVo20z0DP4RNFyJ7VNOd7/D/A8T3F21vx1p+N9gXBTTyR+DQ5bgg9wtFwcMml5YvosJI
 /jNYGpiPTkVl/s4HD5GVmcMFVN0THmAham0GCte8rDqge4Kg7MMD/eCBR/kP+gJDL+K1 9w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0pbgm87v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:18:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294G5kis031180;
        Tue, 4 Oct 2022 16:18:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3jxd69ucd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:18:10 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294GI8YM8389136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 16:18:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DC5E5805E;
        Tue,  4 Oct 2022 16:18:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5640858050;
        Tue,  4 Oct 2022 16:18:06 +0000 (GMT)
Received: from [9.77.144.104] (unknown [9.77.144.104])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 16:18:06 +0000 (GMT)
Message-ID: <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
Date:   Tue, 4 Oct 2022 12:18:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-2-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221004120706.2957492-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tGhT3v-pNpfpBfQZ5pCzRvqNYvJxcXrx
X-Proofpoint-GUID: tGhT3v-pNpfpBfQZ5pCzRvqNYvJxcXrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210040104
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 8:07 AM, Niklas Schnelle wrote:
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

I've been testing this in isolation and it looks good to me, but one question...

> ---
> v3 -> v4:
> - Drop s390_domain from __s390_iommu_detach_device() (Jason)
> - WARN_ON() mismatched domain in s390_iommu_detach_device() (Jason)
> - Use __s390_iommu_detach_device() in s390_iommu_release_device() (Jason)
> 
>  drivers/iommu/s390-iommu.c | 97 +++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..0f58e897bc95 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -79,10 +79,36 @@ static void s390_domain_free(struct iommu_domain *domain)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  
> +	WARN_ON(!list_empty(&s390_domain->devices));
>  	dma_cleanup_tables(s390_domain->dma_table);
>  	kfree(s390_domain);
>  }
>  
> +static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> +{
> +	struct s390_domain *s390_domain = zdev->s390_domain;
> +	struct s390_domain_device *domain_device, *tmp;
> +	unsigned long flags;
> +
> +	if (!s390_domain)
> +		return;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> +				 list) {
> +		if (domain_device->zdev == zdev) {
> +			list_del(&domain_device->list);
> +			kfree(domain_device);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +
> +	zpci_unregister_ioat(zdev, 0);
> +	zdev->s390_domain = NULL;
> +	zdev->dma_table = NULL;
> +}
> +
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
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> @@ -129,7 +149,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		   domain->geometry.aperture_end != zdev->end_dma) {
>  		rc = -EINVAL;
>  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		goto out_restore;
> +		goto out_free;
>  	}
>  	domain_device->zdev = zdev;
>  	zdev->s390_domain = s390_domain;
> @@ -138,14 +158,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
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

^ I see you removed this awkward backout scenario (and replace the aperture check later) and I generally agree, but I'm looking at just this patch in isolation since its a fix...
If we leave due to a failed register_ioat or aperture mismatch, what do we expect to happen moving forward?  In one case (aperture mismatch -- how?) something is left registered with firmware and another (register_ioat fails) we have nothing registered with firmware (as we've discussed for, then the device is probably in an error state).  Is the expectation that the device is just broken for now and, more importantly, will device recovery clean both of these scenarios up?


>  out_free:
>  	kfree(domain_device);
>  
> @@ -155,32 +167,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  static void s390_iommu_detach_device(struct iommu_domain *domain,
>  				     struct device *dev)
>  {
> -	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
> -	struct s390_domain_device *domain_device, *tmp;
> -	unsigned long flags;
> -	int found = 0;
>  
> -	if (!zdev)
> -		return;
> +	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
>  
> -	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> -				 list) {
> -		if (domain_device->zdev == zdev) {
> -			list_del(&domain_device->list);
> -			kfree(domain_device);
> -			found = 1;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -
> -	if (found && (zdev->s390_domain == s390_domain)) {
> -		zdev->s390_domain = NULL;
> -		zpci_unregister_ioat(zdev, 0);
> -		zpci_dma_init_device(zdev);
> -	}
> +	__s390_iommu_detach_device(zdev);
> +	zpci_dma_init_device(zdev);
>  }
>  
>  static struct iommu_device *s390_iommu_probe_device(struct device *dev)
> @@ -193,24 +185,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>  static void s390_iommu_release_device(struct device *dev)
>  {
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
> -	struct iommu_domain *domain;
>  
>  	/*
> -	 * This is a workaround for a scenario where the IOMMU API common code
> -	 * "forgets" to call the detach_dev callback: After binding a device
> -	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
> -	 * the attach_dev), removing the device via
> -	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
> -	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
> -	 * notifier.
> -	 *
> -	 * So let's call detach_dev from here if it hasn't been called before.
> +	 * release_device is expected to detach any domain currently attached
> +	 * to the device, but keep it attached to other devices in the group.
>  	 */
> -	if (zdev && zdev->s390_domain) {
> -		domain = iommu_get_domain_for_dev(dev);
> -		if (domain)
> -			s390_iommu_detach_device(domain, dev);
> -	}
> +	if (zdev)
> +		__s390_iommu_detach_device(zdev);
>  }
>  
>  static int s390_iommu_update_trans(struct s390_domain *s390_domain,

