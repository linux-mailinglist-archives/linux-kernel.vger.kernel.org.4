Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5C5F747C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJGG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJGG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:59:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCDF7663;
        Thu,  6 Oct 2022 23:59:44 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2976nlWA012112;
        Fri, 7 Oct 2022 06:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ALEzG3H8IXk8X/1LktPCdLufKyeosbBOA4PrRCztSk8=;
 b=qZER7fSdo8kX0nG2+LtfzKjvu3Wtpbtp+oz1ogqkE27687Fcv8tPjwo+TTYKikKumCkd
 EO+xda2c3Wbm8dQO51C33HbFos5itFbaqbeKBqKlxmyBy7gDcyLy58h9h6vCrw/Hxnv5
 7RKocIG41PvbAe7HQ71BQ25pSSffg2IdCNOGWoO8LMEZdgCaNfzKME9ftscpXpsRDU7p
 HZ2gt5Sp7Fa+hcnF+zP4PJ/fGMEeookq4lHBxwuofO9MIf1QpZsh07SALc5W2Wr5UzBI
 JW1MNPw1Uswwv+zHhEIYNHN+pFL4OhgCmh6kNx6GcbWm2dX7RGgi4UUqE2ttzsxZVaUu Dw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2f6j8710-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 06:59:33 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2976nxUU017307;
        Fri, 7 Oct 2022 06:59:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3jxd68x1e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 06:59:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2976xSd943647348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Oct 2022 06:59:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4337A405B;
        Fri,  7 Oct 2022 06:59:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B541EA4054;
        Fri,  7 Oct 2022 06:59:27 +0000 (GMT)
Received: from sig-9-145-159-233.de.ibm.com (unknown [9.145.159.233])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Oct 2022 06:59:27 +0000 (GMT)
Message-ID: <53d610ad882f073904048a03050a084331464188.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/6] iommu/s390: Implement map_pages()/unmap_pages()
 instead of map()/unmap()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 08:59:27 +0200
In-Reply-To: <33573393-3b75-5c71-6f62-8b207f46fd16@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
         <20221006144700.3380098-7-schnelle@linux.ibm.com>
         <33573393-3b75-5c71-6f62-8b207f46fd16@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KdblrkNodPebo6Tni2qIpW_hKuaf5sEo
X-Proofpoint-GUID: KdblrkNodPebo6Tni2qIpW_hKuaf5sEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210070039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 17:03 -0400, Matthew Rosato wrote:
> On 10/6/22 10:47 AM, Niklas Schnelle wrote:
> > While s390-iommu currently implements the map_page()/unmap_page()
> > operations which only map/unmap a single page at a time the internal
> > s390_iommu_update_trans() API already supports mapping/unmapping a range
> > of pages at once. Take advantage of this by implementing the
> > map_pages()/unmap_pages() operations instead thus allowing users of the
> > IOMMU drivers to map multiple pages in a single call followed by
> > a single I/O TLB flush if needed.
> > 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/iommu/s390-iommu.c | 48 +++++++++++++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index ac200f0b81fa..7b92855135ac 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -189,20 +189,15 @@ static void s390_iommu_release_device(struct device *dev)
> >  
> >  static int s390_iommu_update_trans(struct s390_domain *s390_domain,
> >  				   phys_addr_t pa, dma_addr_t dma_addr,
> > -				   size_t size, int flags)
> > +				   unsigned long nr_pages, int flags)
> >  {
> >  	phys_addr_t page_addr = pa & PAGE_MASK;
> >  	dma_addr_t start_dma_addr = dma_addr;
> > -	unsigned long irq_flags, nr_pages, i;
> > +	unsigned long irq_flags, i;
> >  	struct zpci_dev *zdev;
> >  	unsigned long *entry;
> >  	int rc = 0;
> >  
> > -	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
> > -	    (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end)
> > -		return -EINVAL;
> > -
> > -	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >  	if (!nr_pages)
> >  		return 0;
> >  
> > @@ -245,11 +240,24 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
> >  	return rc;
> >  }
> >  
> > -static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
> > -			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +static int s390_iommu_map_pages(struct iommu_domain *domain,
> > +				unsigned long iova, phys_addr_t paddr,
> > +				size_t pgsize, size_t pgcount,
> > +				int prot, gfp_t gfp, size_t *mapped)
> >  {
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> >  	int flags = ZPCI_PTE_VALID, rc = 0;
> > +	size_t size = pgcount << __ffs(pgsize);
> > +
> > +	if (pgsize != SZ_4K)
> > +		return -EINVAL;
> > +
> > +	if (iova < s390_domain->domain.geometry.aperture_start ||
> > +	    (iova + size - 1) > s390_domain->domain.geometry.aperture_end)
> > +		return -EINVAL;
> > +
> > +	if (!IS_ALIGNED(iova | paddr, pgsize))
> > +		return -EINVAL;
> >  
> >  	if (!(prot & IOMMU_READ))
> >  		return -EINVAL;
> > @@ -258,7 +266,9 @@ static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		flags |= ZPCI_TABLE_PROTECTED;
> >  
> >  	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
> > -				     size, flags);
> > +				     pgcount, flags);
> > +	if (!rc)
> > +		*mapped = size;
> >  
> >  	return rc;
> >  }
> > @@ -294,21 +304,27 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
> >  	return phys;
> >  }
> >  
> > -static size_t s390_iommu_unmap(struct iommu_domain *domain,
> > -			       unsigned long iova, size_t size,
> > -			       struct iommu_iotlb_gather *gather)
> > +static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
> > +				     unsigned long iova,
> > +				     size_t pgsize, size_t pgcount,
> > +				     struct iommu_iotlb_gather *gather)
> >  {
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> > +	size_t size = pgcount << __ffs(pgsize);
> >  	int flags = ZPCI_PTE_INVALID;
> >  	phys_addr_t paddr;
> >  	int rc;
> >  
> > +	if (iova < s390_domain->domain.geometry.aperture_start ||
> > +	    (iova + size - 1) > s390_domain->domain.geometry.aperture_end)
> > +		return 0;
> > +
> 
> Overall this LGTM and runs well with my testing.  But I'm curious why we silently ignore an egregiously bad unmap request here?  We've already done an -EINVAL for an attempt to map_pages() something outside of the aperture.  If something still tries to unmap_pages() outside of the aperture, that seems like a bug?  Maybe this should be surrounded by a if (WARN_ON(... || ...) to signify the unexpected behavior and then still return 0?
> 

Well, the problem here is that .unmap_pages() returns size_t so
0 is kind of the only invalid value.But yes, a WARN_ON() seems
warranted.

> Otherwise:
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> >  	paddr = s390_iommu_iova_to_phys(domain, iova);
> >  	if (!paddr)
> >  		return 0;
> >  
> >  	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
> > -				     size, flags);
> > +				     pgcount, flags);
> >  	if (rc)
> >  		return 0;
> >  
> > @@ -354,8 +370,8 @@ static const struct iommu_ops s390_iommu_ops = {
> >  	.default_domain_ops = &(const struct iommu_domain_ops) {
> >  		.attach_dev	= s390_iommu_attach_device,
> >  		.detach_dev	= s390_iommu_detach_device,
> > -		.map		= s390_iommu_map,
> > -		.unmap		= s390_iommu_unmap,
> > +		.map_pages	= s390_iommu_map_pages,
> > +		.unmap_pages	= s390_iommu_unmap_pages,
> >  		.iova_to_phys	= s390_iommu_iova_to_phys,
> >  		.free		= s390_domain_free,
> >  	}


