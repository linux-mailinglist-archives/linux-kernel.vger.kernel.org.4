Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF115E9CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiIZJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiIZJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:01:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3213ED6A;
        Mon, 26 Sep 2022 02:01:17 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8WsXj029983;
        Mon, 26 Sep 2022 09:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=w3dPSbi+pE9UJO5DF3OD826Cl4aEXL4/S9Y3T9UYKrg=;
 b=J6YtWh0E2b80iDvG34cLwU/aPs8BpiFgi66Uu78b5LgA1SYgzGjTR4aExiQNxcM6QzEO
 QbDsdZBGpJIoK3tLV5XMe49pcqapoJhlWaolNMxJvSDmyI3WH+IWB84l3l/g4LHjs7Re
 mxZoG7uniXGTNz/o3bFrfi66RIDbYzDMVW4PJbbADILzFDR7QDsxhVDz95KzXgZtPy40
 p3OTUvGOoNWwSuSp0V4gJ9beyz79c5qb9CqoconPLMEm1DCGR/Q1YKN1efXK0tYeFWBl
 SoOd1H3OEI7OuQbLFeKO6eS93uRFRocC3/twON2pqpLAi/AUa5cR8s7hkrh8Nsw4PzlF lA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ju8nw0res-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:01:00 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q8pkC3009451;
        Mon, 26 Sep 2022 09:00:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3jssh91mjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:00:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q90sLV42598732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:00:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F4452054;
        Mon, 26 Sep 2022 09:00:54 +0000 (GMT)
Received: from sig-9-145-86-133.uk.ibm.com (unknown [9.145.86.133])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7558452050;
        Mon, 26 Sep 2022 09:00:53 +0000 (GMT)
Message-ID: <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Mon, 26 Sep 2022 11:00:53 +0200
In-Reply-To: <YyxyMtKXyvgHt3Kp@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uG7h3FHAyoBzFXcFvwIwO8bH4ga5fdXH
X-Proofpoint-GUID: uG7h3FHAyoBzFXcFvwIwO8bH4ga5fdXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 11:33 -0300, Jason Gunthorpe wrote:
> On Thu, Sep 22, 2022 at 11:52:37AM +0200, Niklas Schnelle wrote:
> > Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > calls") we can end up with duplicates in the list of devices attached to
> > a domain. This is inefficient and confusing since only one domain can
> > actually be in control of the IOMMU translations for a device. Fix this
> > by detaching the device from the previous domain, if any, on attach.
> > Add a WARN_ON() in case we still have attached devices on freeing the
> > domain.
> > 
> > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Changes since v1:
> > - WARN_ON() non-empty list in s390_domain_free()
> > - Drop the found flag and instead WARN_ON() if we're detaching
> >   from a domain that isn't the active domain for the device
> > 
> >  drivers/iommu/s390-iommu.c | 81 ++++++++++++++++++++++----------------
> >  1 file changed, 46 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index c898bcbbce11..187d2c7ba9ff 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -78,19 +78,48 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
> >  static void s390_domain_free(struct iommu_domain *domain)
> >  {
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> > +	unsigned long flags;
> >  
> > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > +	WARN_ON(!list_empty(&s390_domain->devices));
> > +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> 
> Minor, but, this is about to free the memory holding the lock, we
> don't need to take it to do the WARN_ON.. list_empty() is already
> lockless safe.

Makes sense.

> 
> > static int __s390_iommu_detach_device(struct s390_domain *s390_domain,
> >                                      struct zpci_dev *zdev)
> > {
> 
> This doesn't return a failure code anymore, make it void
> 
> >  static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  				    struct device *dev)
> >  {
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> >  	struct s390_domain_device *domain_device;
> > +	struct s390_domain *prev_domain = NULL;
> >  	unsigned long flags;
> > -	int cc, rc;
> > +	int cc, rc = 0;
> >  
> >  	if (!zdev)
> >  		return -ENODEV;
> > @@ -99,16 +128,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  	if (!domain_device)
> >  		return -ENOMEM;
> >  
> > -	if (zdev->dma_table && !zdev->s390_domain) {
> > -		cc = zpci_dma_exit_device(zdev);
> > -		if (cc) {
> > +	if (zdev->s390_domain) {
> > +		prev_domain = zdev->s390_domain;
> > +		rc = __s390_iommu_detach_device(zdev->s390_domain, zdev);
> > +	} else if (zdev->dma_table) {
> > +		if (zpci_dma_exit_device(zdev))
> >  			rc = -EIO;
> > -			goto out_free;
> > -		}
> >  	}
> > -
> > -	if (zdev->s390_domain)
> > -		zpci_unregister_ioat(zdev, 0);
> > +	if (rc)
> > +		goto out_free;
> >  
> >  	zdev->dma_table = s390_domain->dma_table;
> >  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> > @@ -129,7 +157,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  		   domain->geometry.aperture_end != zdev->end_dma) {
> >  		rc = -EINVAL;
> >  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > -		goto out_restore;
> > +		goto out_unregister_restore;
> >  	}
> >  	domain_device->zdev = zdev;
> >  	zdev->s390_domain = s390_domain;
> > @@ -138,14 +166,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  
> >  	return 0;
> >  
> > +out_unregister_restore:
> > +	zpci_unregister_ioat(zdev, 0);
> >  out_restore:
> > -	if (!zdev->s390_domain) {
> > +	zdev->dma_table = NULL;
> > +	if (prev_domain)
> > +		s390_iommu_attach_device(&prev_domain->domain,
> > +					 dev);
> 
> Huh. That is a surprising thing
> 
> I think this function needs some re-ordering to avoid this condition
> 
> The checks for aperture should be earlier, and they are not quite
> right. The aperture is only allowed to grow. If it starts out as 0 and
> then is set to something valid on first attach, a later attach cannot
> then shrink it. There could already be mappings in the domain under
> the now invalidated aperture and no caller is prepared to deal with
> this.

Ohh I think this is indeed broken. Let me rephrase to see if I
understand correctly. You're saying that while we only allow exactly
matching apertures on additional attaches, we do allow shrinking if
there is temporarily no device attached to the domain. That part is
then broken because there could still be mappings outside the new
aperture stored in the translation tables?

> 
> That leaves the only error case as zpci_register_ioat() - which seems
> like it is the actual "attach" operation. Since
> __s390_iommu_detach_device() is just internal accounting (and can't
> fail) it should be moved after
> 
> So the logic order should be
> 
> 1) Attempt to widen the aperture, if this fails the domain is
>    incompatible bail immediately

Question. If the widening succeeds but we fail later during the attach
e.g. in 2) then the aperture remains widend or would that be rolled
back? Rolling this back seems bad at least if we can't hold the lock
over the entire process. So to do this properly it sounds to me like we
really want to get rid of the allocation (i.e. patch 3) and hold the
lock over the entire process. If we do that I think it would be okay to
keep enforcing equality for now as it is only overly strict not broken
like the shrinking.

> 
> 2) zpci_register_ioat() to make the new domain current in the HW
>  
> 3) fixup the internal records to record the now current domain (eg 
>    __s390_iommu_detach_device)
> 
> And some similar changing to the non-domain path..
> 
> No sketchy error unwind attempting to re-attach a domain..
> 
> Jason

You make very good points and this sounds like it could simplify the
process too. We did have the aperture check moved to the beginning of
the function in an earlier version. The problem with that was the
raciness created by having to release and re-take the lock after the
allocation. So I think the best approach would be to roll the struct
s390_domain removal into the fix and do the steps as you describe them
but with the lock held during the entire process which we should be
able to do if there is no allocation.

