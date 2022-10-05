Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A146B5F508B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJEH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJEH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:59:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE204754B9;
        Wed,  5 Oct 2022 00:59:16 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2956AJuF031516;
        Wed, 5 Oct 2022 07:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1ZXjOUYkf0/p7kvq8+0h0qy8M54rTqIEq9cNWgWeZ4g=;
 b=ExcnS3rx9H8iN/pAAsJBJsfBfpXp0BQ186F1qREXBme80m4VpASSdurmf+z1vSpJ0PQa
 OZ8v40n6rSZN+YvAFuTe9mxMy2DVeFI/bPI87HbxysTQ+pwb5HGZS1EtOQLkxFSgMh19
 sci5tJtAB5rCVJBc6nqAmeqLR06ENS9elAvvjCV1W1ChA9zHN/0pNntR2qA3uUgzIHbk
 mOz4h9HGNfI481ushfB/2EcOOJy/GiVMToJiacFAsTqObsvx+hqJw9xjUiEJaz5T/ALK
 FuU3f84ezxQFlmXiyyrzTveKvFbOZuGe47TMqTEq0G2bAi+y+w8c0WD+EBASNeubOygB 3A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gwum0bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 07:59:04 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2957pPcx030941;
        Wed, 5 Oct 2022 07:59:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3jxd68uufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 07:59:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2957sTgA43122960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 07:54:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 297F1A404D;
        Wed,  5 Oct 2022 07:58:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A43A2A4040;
        Wed,  5 Oct 2022 07:58:58 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Oct 2022 07:58:58 +0000 (GMT)
Message-ID: <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Wed, 05 Oct 2022 09:58:58 +0200
In-Reply-To: <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
         <20221004120706.2957492-2-schnelle@linux.ibm.com>
         <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D0R6H6PpJnJAl9l7JpYs-kpzCXo0KvpB
X-Proofpoint-ORIG-GUID: D0R6H6PpJnJAl9l7JpYs-kpzCXo0KvpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-04 at 12:18 -0400, Matthew Rosato wrote:
> On 10/4/22 8:07 AM, Niklas Schnelle wrote:
> > Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > calls") we can end up with duplicates in the list of devices attached to
> > a domain. This is inefficient and confusing since only one domain can
> > actually be in control of the IOMMU translations for a device. Fix this
> > by detaching the device from the previous domain, if any, on attach.
> > Add a WARN_ON() in case we still have attached devices on freeing the
> > domain. While here remove the re-attach on failure dance as it was
> > determined to be unlikely to help and may confuse debug and recovery.
> > 
> > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> I've been testing this in isolation and it looks good to me, but one question...
> 
> > ---
> > v3 -> v4:
> > - Drop s390_domain from __s390_iommu_detach_device() (Jason)
> > - WARN_ON() mismatched domain in s390_iommu_detach_device() (Jason)
> > - Use __s390_iommu_detach_device() in s390_iommu_release_device() (Jason)
> > 
> >  drivers/iommu/s390-iommu.c | 97 +++++++++++++++-----------------------
> >  1 file changed, 39 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index c898bcbbce11..0f58e897bc95 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -79,10 +79,36 @@ static void s390_domain_free(struct iommu_domain *domain)
> >  {
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> >  
> > +	WARN_ON(!list_empty(&s390_domain->devices));
> >  	dma_cleanup_tables(s390_domain->dma_table);
> >  	kfree(s390_domain);
> >  }
> >  
> > +static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> > +{
> > +	struct s390_domain *s390_domain = zdev->s390_domain;
> > +	struct s390_domain_device *domain_device, *tmp;
> > +	unsigned long flags;
> > +
> > +	if (!s390_domain)
> > +		return;
> > +
> > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > +	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> > +				 list) {
> > +		if (domain_device->zdev == zdev) {
> > +			list_del(&domain_device->list);
> > +			kfree(domain_device);
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > +
> > +	zpci_unregister_ioat(zdev, 0);
> > +	zdev->s390_domain = NULL;
> > +	zdev->dma_table = NULL;
> > +}
> > +
> >  static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  				    struct device *dev)
> >  {
> > @@ -90,7 +116,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> >  	struct s390_domain_device *domain_device;
> >  	unsigned long flags;
> > -	int cc, rc;
> > +	int cc, rc = 0;
> >  
> >  	if (!zdev)
> >  		return -ENODEV;
> > @@ -99,23 +125,17 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  	if (!domain_device)
> >  		return -ENOMEM;
> >  
> > -	if (zdev->dma_table && !zdev->s390_domain) {
> > -		cc = zpci_dma_exit_device(zdev);
> > -		if (cc) {
> > -			rc = -EIO;
> > -			goto out_free;
> > -		}
> > -	}
> > -
> >  	if (zdev->s390_domain)
> > -		zpci_unregister_ioat(zdev, 0);
> > +		__s390_iommu_detach_device(zdev);
> > +	else if (zdev->dma_table)
> > +		zpci_dma_exit_device(zdev);
> >  
> >  	zdev->dma_table = s390_domain->dma_table;
> >  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> >  				virt_to_phys(zdev->dma_table));
> >  	if (cc) {
> >  		rc = -EIO;
> > -		goto out_restore;
> > +		goto out_free;
> >  	}
> >  
> >  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > @@ -129,7 +149,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  		   domain->geometry.aperture_end != zdev->end_dma) {
> >  		rc = -EINVAL;
> >  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > -		goto out_restore;
> > +		goto out_free;
> >  	}
> >  	domain_device->zdev = zdev;
> >  	zdev->s390_domain = s390_domain;
> > @@ -138,14 +158,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  
> >  	return 0;
> >  
> > -out_restore:
> > -	if (!zdev->s390_domain) {
> > -		zpci_dma_init_device(zdev);
> > -	} else {
> > -		zdev->dma_table = zdev->s390_domain->dma_table;
> > -		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> > -				   virt_to_phys(zdev->dma_table));
> > -	}
> 
> ^ I see you removed this awkward backout scenario (and replace the aperture check later) and I generally agree, but I'm looking at just this patch in isolation since its a fix...
> If we leave due to a failed register_ioat or aperture mismatch, what do we expect to happen moving forward?  In one case (aperture mismatch -- how?) something is left registered with firmware and another (register_ioat fails) we have nothing registered with firmware (as we've discussed for, then the device is probably in an error state).  Is the expectation that the device is just broken for now and, more importantly, will device recovery clean both of these scenarios up?

A failed aperture test leaving the IOAT registered would indeed be bad.
I guess I focused too much on the failure scenarios at the state after
these patches where this can't happen. I think this would leave us in a
bad state because zpci_register_ioat() succeeded with the domain's DMA
table but we won't have attached leading to the wrong decisions in
recovery paths (see below). 

I think we should do a zpci_unregister_ioat() and zdev->dma_table =
NULL in this case just to be safe. It's certainly still much less
fragile than the full rollback and even if the zpci_unregister_ioat()
fails it prevents recovery from restoring the wrong DMA translation
tables. I don't think we can really get into this situation though as
the aperture should match what firmware accepts but it's still a valid
code path.

@Jason would you be okay with that?

Recovery (via zpci_hot_reset_device()) should then be able to deal with
these situations as long as zdev->dma_table matches the IOAT
registration state.

1. If zdev->dma_table != NULL we re-register the previous DMA table
2. If zdev->dma_table == NULL we do zpci_dma_init_device()

> 
> 
> >  out_free:
> >  	kfree(domain_device);
> >  
> > @@ -155,32 +167,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  static void s390_iommu_detach_device(struct iommu_domain *domain,
> >  				     struct device *dev)
> >  {
> > -	struct s390_domain *s390_domain = to_s390_domain(domain);
> >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> > -	struct s390_domain_device *domain_device, *tmp;
> > -	unsigned long flags;
> > -	int found = 0;
> >  
> > -	if (!zdev)
> > -		return;
> > +	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
> >  
> > -	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > -	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> > -				 list) {
> > -		if (domain_device->zdev == zdev) {
> > -			list_del(&domain_device->list);
> > -			kfree(domain_device);
> > -			found = 1;
> > -			break;
> > -		}
> > -	}
> > -	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > -
> > -	if (found && (zdev->s390_domain == s390_domain)) {
> > -		zdev->s390_domain = NULL;
> > -		zpci_unregister_ioat(zdev, 0);
> > -		zpci_dma_init_device(zdev);
> > -	}
> > +	__s390_iommu_detach_device(zdev);
> > +	zpci_dma_init_device(zdev);
> >  }
> >  
> >  static struct iommu_device *s390_iommu_probe_device(struct device *dev)
> > @@ -193,24 +185,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
> >  static void s390_iommu_release_device(struct device *dev)
> >  {
> >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> > -	struct iommu_domain *domain;
> >  
> >  	/*
> > -	 * This is a workaround for a scenario where the IOMMU API common code
> > -	 * "forgets" to call the detach_dev callback: After binding a device
> > -	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
> > -	 * the attach_dev), removing the device via
> > -	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
> > -	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
> > -	 * notifier.
> > -	 *
> > -	 * So let's call detach_dev from here if it hasn't been called before.
> > +	 * release_device is expected to detach any domain currently attached
> > +	 * to the device, but keep it attached to other devices in the group.
> >  	 */
> > -	if (zdev && zdev->s390_domain) {
> > -		domain = iommu_get_domain_for_dev(dev);
> > -		if (domain)
> > -			s390_iommu_detach_device(domain, dev);
> > -	}
> > +	if (zdev)
> > +		__s390_iommu_detach_device(zdev);
> >  }
> >  
> >  static int s390_iommu_update_trans(struct s390_domain *s390_domain,


