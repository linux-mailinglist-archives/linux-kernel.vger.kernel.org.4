Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B95F78FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJGN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:29:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC8CA889;
        Fri,  7 Oct 2022 06:29:12 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297DLncI015651;
        Fri, 7 Oct 2022 13:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KmLWC7caEAF8G8pcYDWCwiGe6+5p+IexfVJhmKq4pss=;
 b=HLHx4BPVdWM5VCFtXgmSxOo3Hk+Eih400mMYjJTZpUtWf3weG0SZWIIhUXrR8WtruZfS
 CXwXCl8ZHnAW61Us1AttA/jm8kcdg92YDnhcs04cnG0R5jEb2e/9cAzDKTP+QG2qEhID
 LQ6CyWjy3W29YNmvYWKnAtS1rlfZkpZB3JLgT/EfrIHiZoAltTRG8KOwMS5eJKcK4u4W
 hFgVj40TBw3oiWdy+lS3r3uTkbru01SK/MD25e/YRgcnPaBsTJaF0Y5fLm4MjDQolTpa
 ghgBy5AdLpSyCAYWOfPecrwsdD/mEV8Ouwwnwe33LU9SUQg1Ii//724D2VRQiZ0dVZXJ rg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2mxar7t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 13:28:53 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 297DLh6J011727;
        Fri, 7 Oct 2022 13:28:52 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3jxd6a11yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 13:28:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 297DSoKO58720730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Oct 2022 13:28:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8600F58052;
        Fri,  7 Oct 2022 13:28:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4074C58045;
        Fri,  7 Oct 2022 13:28:48 +0000 (GMT)
Received: from [9.160.126.121] (unknown [9.160.126.121])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Oct 2022 13:28:48 +0000 (GMT)
Message-ID: <e9754210-0907-56ac-c286-0aa82ee79e4c@linux.ibm.com>
Date:   Fri, 7 Oct 2022 09:28:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 1/6] iommu/s390: Fix duplicate domain attachments
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221007095005.2017126-1-schnelle@linux.ibm.com>
 <20221007095005.2017126-2-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221007095005.2017126-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: udghyNtkqEZ8lOwdLRlc10adetjrinGe
X-Proofpoint-GUID: udghyNtkqEZ8lOwdLRlc10adetjrinGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070078
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 5:50 AM, Niklas Schnelle wrote:
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

Looks good to me now, thanks!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
> v5->v6:
> - Only set zdev->dma_table once zpci_register_ioat() succeeded (Matt)
> v4->v5:
> - Unregister IOAT and set zdev->dma_table on error (Matt)
> 
>  drivers/iommu/s390-iommu.c | 106 ++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..96173cfee324 100644
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
> @@ -99,24 +125,18 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
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
> -	zdev->dma_table = s390_domain->dma_table;
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -				virt_to_phys(zdev->dma_table));
> +				virt_to_phys(s390_domain->dma_table));
>  	if (cc) {
>  		rc = -EIO;
> -		goto out_restore;
> +		goto out_free;
>  	}
> +	zdev->dma_table = s390_domain->dma_table;
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
>  	/* First device defines the DMA range limits */
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
> @@ -155,32 +170,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
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
> @@ -193,24 +188,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
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

