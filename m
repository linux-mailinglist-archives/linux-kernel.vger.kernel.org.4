Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7A5EA962
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiIZPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiIZO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:59:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D65D0E5;
        Mon, 26 Sep 2022 06:30:09 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QChv0h013211;
        Mon, 26 Sep 2022 13:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rgbfy+nZxnjpEYxv0t52YaUKJNuHCfDCkTrEBVsBgPw=;
 b=f7n5Nyp1pCf2Lj4CFd2Rvf96M7FPqGdj8yEvoVw2zJ/icMD7tSxwqN8zW2BTXmj9ZjWV
 u3fEYEdPjUelD+a5Bms/jvWy1TNRM/m6dk2bxYS4IpufNcsXAUfvvDBxQbQBbHOYsxOV
 Io2NMAfXCOBV94HoGkwDHm0SPGHN0FU/Kj1VY9FGLCeuORsmtokGBEb+FAoB9YIEcMaL
 5f/Woic9dCR6pTZH2SRf3Q3+MBhSdazlTeusgcG2qLCkGsSHhgtO+xenkPnN1XGkdsUH
 sOTHb3NTTJdWCqGA5KFBR1SrFlN7F4YQ3U7+oHp7hdm45/Hd3iE4E5zy22Gdco7XTn7A 7w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucbj9cm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:29:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QDLPEx030127;
        Mon, 26 Sep 2022 13:29:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapug5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:29:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QDTp1530540216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 13:29:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 112D3A4053;
        Mon, 26 Sep 2022 13:29:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44D20A4040;
        Mon, 26 Sep 2022 13:29:50 +0000 (GMT)
Received: from sig-9-145-86-133.uk.ibm.com (unknown [9.145.86.133])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 13:29:50 +0000 (GMT)
Message-ID: <b581d4f575b834831f8c17054f73b5b92a891d25.camel@linux.ibm.com>
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
Date:   Mon, 26 Sep 2022 15:29:49 +0200
In-Reply-To: <YyxyMtKXyvgHt3Kp@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RuCXoDObvouvgFlIW-yK9f-iI2DZ751n
X-Proofpoint-GUID: RuCXoDObvouvgFlIW-yK9f-iI2DZ751n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260083
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
> 
> That leaves the only error case as zpci_register_ioat() - which seems
> like it is the actual "attach" operation. Since
> __s390_iommu_detach_device() is just internal accounting (and can't
> fail) it should be moved after

I did miss a problem in my initial answer. While zpci_register_ioat()
is indeed the actual "attach" operation, it assumes that at that point
no DMA address translations are registered. In that state DMA is
blocked of course. With that zpci_register_ioat() needs to come after
the zpci_unregister_ioat() that is part of __s390_iommu_detach_device()
and zpci_dma_exit_device(). If we do call those though we fundamentally
need to restore the previous domain / DMA API state on any subsequent
failure. If we don't restore we would leave the device detached from
any domain with DMA blocked. I wonder if this could be an acceptable
failure state though? It's safe as no DMA is possible and we could get
out of it with a successful attach.

