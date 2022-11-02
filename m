Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9961613C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKBKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKBKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBA1403C;
        Wed,  2 Nov 2022 03:51:35 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2AeBUW012255;
        Wed, 2 Nov 2022 10:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kyw/sn6JnGZPdpoMSon99r5WGNuNqqYx+UyXssV+cUk=;
 b=okCH4kaPULuwYpwG0sjn+CXNcHowtL8cBZxcQ7aKFhINkIVvAQaqYSThL0FjhZ4ohZSi
 j3/U/Ckdh6+dVPathhBBDsNglaNKGMyw+w/W1Fk0oe9heUEeEm6x0gyj3lgVzt1sFHeV
 Lkug1XDsHcLtNu9XUgYOw8dTDmzVmMhK1NmC9UNVOEMPNsUiqFbq2A3pTIXfOfBIXaS1
 Gbb/QEOmiYtEhPnszd3rAabC5tNrfN8k5uAaKdXO2AAFsbvJL1AcM9T/SoD7XbPDLBt6
 xLqYcG1yWJuhabbMlnbVHnOpDajotqqieAkewqXfLc2qVeQs73MDfPqT0eUYVpwcLQzU /g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkppg8mma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:51:17 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2AZS7p004402;
        Wed, 2 Nov 2022 10:51:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3kgut8vx6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:51:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2ApBNg4063920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 10:51:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC62542042;
        Wed,  2 Nov 2022 10:51:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473EF4203F;
        Wed,  2 Nov 2022 10:51:11 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 10:51:11 +0000 (GMT)
Message-ID: <a56e99d67e3fe75acc1c133875ab64ff0eed69b2.camel@linux.ibm.com>
Subject: Re: [PATCH 2/5] iommu/s390: Add I/O TLB ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Date:   Wed, 02 Nov 2022 11:51:11 +0100
In-Reply-To: <e789fcbe-fa3a-0286-c0f7-361762764a3e@arm.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-3-schnelle@linux.ibm.com>
         <7da1ab0b-e78a-2ed1-0263-e9174c3af256@linux.ibm.com>
         <e789fcbe-fa3a-0286-c0f7-361762764a3e@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: isr3l8R_vAYmoyxsRxAvStKK8-5wOmSN
X-Proofpoint-ORIG-GUID: isr3l8R_vAYmoyxsRxAvStKK8-5wOmSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-31 at 16:11 +0000, Robin Murphy wrote:
> On 2022-10-28 17:03, Matthew Rosato wrote:
> > On 10/18/22 10:51 AM, Niklas Schnelle wrote:
> > > Currently s390-iommu does an I/O TLB flush (RPCIT) for every update of
> > > the I/O translation table explicitly. For one this is wasteful since
> > > RPCIT can be skipped after a mapping operation if zdev->tlb_refresh is
> > > unset. Moreover we can do a single RPCIT for a range of pages including
> > > whne doing lazy unmapping.
> > > 
> > > Thankfully both of these optimizations can be achieved by implementing
> > > the IOMMU operations common code provides for the different types of I/O
> > > tlb flushes:
> > > 
> > >   * flush_iotlb_all: Flushes the I/O TLB for the entire IOVA space
> > >   * iotlb_sync:  Flushes the I/O TLB for a range of pages that can be
> > >     gathered up, for example to implement lazy unmapping.
> > >   * iotlb_sync_map: Flushes the I/O TLB after a mapping operation
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >   drivers/iommu/s390-iommu.c | 76 ++++++++++++++++++++++++++++++++------
> > >   1 file changed, 65 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > > index ee88e717254b..a4c2e9bc6d83 100644
> > > --- a/drivers/iommu/s390-iommu.c
> > > +++ b/drivers/iommu/s390-iommu.c
> > > @@ -199,14 +199,72 @@ static void s390_iommu_release_device(struct device *dev)
> > >   		__s390_iommu_detach_device(zdev);
> > >   }
> > >   
> > > +static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > > +{
> > > +	struct s390_domain *s390_domain = to_s390_domain(domain);
> > > +	struct zpci_dev *zdev;
> > > +	unsigned long flags;
> > > +	int rc;
> > > +
> > > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> > > +		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> > > +					zdev->end_dma - zdev->start_dma + 1);
> > > +		if (rc)
> > > +			break;
> > > +	}
> > > +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > +}
> > > +
> > > +static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
> > > +				  struct iommu_iotlb_gather *gather)
> > > +{
> > > +	struct s390_domain *s390_domain = to_s390_domain(domain);
> > > +	size_t size = gather->end - gather->start + 1;
> > > +	struct zpci_dev *zdev;
> > > +	unsigned long flags;
> > > +	int rc;
> > > +
> > > +	/* If gather was never added to there is nothing to flush */
> > > +	if (gather->start == ULONG_MAX)
> > > +		return;
> > 
> > Hmm, this seems a little awkward in that it depends on the init value in iommu_iotlb_gather_init never changing.  I don't see any other iommu drivers doing this -- Is there no other way to tell there's nothing to flush?
> > 
> > If we really need to do this, maybe some shared #define in iommu.h that is used in iommu_iotlb_gather_init and here?
> 
> If you can trust yourselves to never gather a single byte (which by 
> construction should be impossible), "!gather->end" is perhaps a tiny bit 
> more robust (and consistent with iommu_iotlb_gather_is_disjoint()), 
> although given the way that iommu_iotlb_gather_add_*() work I don't 
> think either initial value has much chance of changing in practice, 
> short of some larger refactoring that would likely have to touch all the 
> users anyway. If you still want to be as foolproof as possible, using 
> "gather->start > gather->end" would represent the most general form of 
> the initial conditions.
> 
> FWIW, SMMUv3 does also check for an empty range, but using 
> gather->pgsize that is only relevant with add_page(). The other gather 
> users seem happy to go ahead and just issue whatever wacky invalidation 
> command those initial values end up looking like. I think an empty sync 
> should really only happen in unexpected conditions like an unmap 
> failing, so it shouldn't be a case that deserves a great deal of 
> optimisation effort.
> 
> Thanks,
> Robin.
> 

Yeah I agree this should only happen when unmap failed. I think I added
this when I was playing around with adding an intermediate flush
similar to what amd_iommu_iotlb_gather_add_page() does, only that in
some intermediate stages I could end up with nothing left to flush.
That whole optimization did turn out not to help and I removed it
again. I think even if it's only for the error case now, I'd like to
keep it though. This makes sure we don't get weirdly sized flushes in
the error case. I'll use '!gather->end' to be consistent with
iommu_iotlb_gather_is_disjoint() as you suggested.

Speaking of that AMD optimization, I'm actually not sure that it does
the right thing for AMD either. The way I read the code, it does more
but only contiguous TLB flushes in virtualized mode and at least for us
this turned out detrimental. Also the comment, at least to me, makes it
sound as if they were trying for fewer flushes but it's worded a bit
confusingly so not sure.

Thanks,
Niklas

> > > +
> > > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> > > +		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
> > > +					size);
> > > +		if (rc)
> > > +			break;
> > > +	}
> > > +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > +}
> > > +
> > > +static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
> > > +				      unsigned long iova, size_t size)
> > > +{
> > > +	struct s390_domain *s390_domain = to_s390_domain(domain);
> > > +	struct zpci_dev *zdev;
> > > +	unsigned long flags;
> > > +	int rc;
> > > +
> > > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> > > +		if (!zdev->tlb_refresh)
> > > +			continue;
> > > +		rc = zpci_refresh_trans((u64)zdev->fh << 32,
> > > +					iova, size);
> > > +		if (rc)
> > > +			break;
> > > +	}
> > > +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > +}
> > > +
> > >   static int s390_iommu_update_trans(struct s390_domain *s390_domain,
> > >   				   phys_addr_t pa, dma_addr_t dma_addr,
> > >   				   unsigned long nr_pages, int flags)
> > >   {
> > >   	phys_addr_t page_addr = pa & PAGE_MASK;
> > > -	dma_addr_t start_dma_addr = dma_addr;
> > >   	unsigned long irq_flags, i;
> > > -	struct zpci_dev *zdev;
> > >   	unsigned long *entry;
> > >   	int rc = 0;
> > >   
> > > @@ -225,15 +283,6 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
> > >   		dma_addr += PAGE_SIZE;
> > >   	}
> > >   
> > > -	spin_lock(&s390_domain->list_lock);
> > > -	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
> > > -		rc = zpci_refresh_trans((u64)zdev->fh << 32,
> > > -					start_dma_addr, nr_pages * PAGE_SIZE);
> > > -		if (rc)
> > > -			break;
> > > -	}
> > > -	spin_unlock(&s390_domain->list_lock);
> > > -
> > >   undo_cpu_trans:
> > >   	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
> > >   		flags = ZPCI_PTE_INVALID;
> > > @@ -340,6 +389,8 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
> > >   	if (rc)
> > >   		return 0;
> > >   
> > > +	iommu_iotlb_gather_add_range(gather, iova, size);
> > > +
> > >   	return size;
> > >   }
> > >   
> > > @@ -384,6 +435,9 @@ static const struct iommu_ops s390_iommu_ops = {
> > >   		.detach_dev	= s390_iommu_detach_device,
> > >   		.map_pages	= s390_iommu_map_pages,
> > >   		.unmap_pages	= s390_iommu_unmap_pages,
> > > +		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
> > > +		.iotlb_sync      = s390_iommu_iotlb_sync,
> > > +		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
> > >   		.iova_to_phys	= s390_iommu_iova_to_phys,
> > >   		.free		= s390_domain_free,
> > >   	}


