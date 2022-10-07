Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B865F74C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJGHhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJGHha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:37:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47EBEFBC;
        Fri,  7 Oct 2022 00:37:29 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2977Dko6007623;
        Fri, 7 Oct 2022 07:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0tJIjO6ybCsXmZLLUXndslexBjrOkGwVENGAZilreYg=;
 b=InkWfKS9a7cKAduI3pS0rtIn3MBbwD9H0d5UK2hQ6KQqXwPW9qDRsQ5UDESypv9WSKA4
 pBCaIt3Vwc5O8Ch+7BS+gV0Gq04ffYMLEstg/jqWVDEJ1nkUs+ldy8EIa0fRZvwMWhIF
 BUm1PURFVB3Hw1VFyU3aIEtbwIV2fzDHnd/xTD0KDefNoymLEz9H3/LvvRvSmJm2ufCF
 j+0v2cldyyQ9SDpgj12+BE326OueYO7mFkTJ/d2Bw7bws8DFY3GAgFeS4ijrlaV/txlx
 3e6+kaIrYUw0RV1h5olgPhBZkTPQ2tFQWYEgO99mvZTEughqJBIBgCM+CdHaNL8EnXq9 Cw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2fhmrqsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 07:37:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2977aV4K012516;
        Fri, 7 Oct 2022 07:37:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3jxctj898g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 07:37:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2977bDFi59507154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Oct 2022 07:37:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4248E5207E;
        Fri,  7 Oct 2022 07:37:13 +0000 (GMT)
Received: from sig-9-145-159-233.de.ibm.com (unknown [9.145.159.233])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D9935208C;
        Fri,  7 Oct 2022 07:37:12 +0000 (GMT)
Message-ID: <e4b0a9cfd0abfcb6647466166bdc3b8378dcf720.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] iommu/s390: Fix potential s390_domain aperture
 shrinking
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 09:37:11 +0200
In-Reply-To: <acbc56b3-41b4-f71a-01d7-63c34348e079@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
         <20221006144700.3380098-4-schnelle@linux.ibm.com>
         <acbc56b3-41b4-f71a-01d7-63c34348e079@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pK7i9V4qkNRS--P0ujSBBu4fItO-833k
X-Proofpoint-ORIG-GUID: pK7i9V4qkNRS--P0ujSBBu4fItO-833k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 17:02 -0400, Matthew Rosato wrote:
> On 10/6/22 10:46 AM, Niklas Schnelle wrote:
> > The s390 IOMMU driver currently sets the IOMMU domain's aperture to
> > match the device specific DMA address range of the device that is first
> > attached. This is not ideal. For one if the domain has no device
> > attached in the meantime the aperture could be shrunk allowing
> > translations outside the aperture to exist in the translation tables.
> > Also this is a bit of a misuse of the aperture which really should
> > describe what addresses can be translated and not some device specific
> > limitations.
> > 
> > Instead of misusing the aperture like this we can instead create
> > reserved ranges for the ranges inaccessible to the attached devices
> > allowing devices with overlapping ranges to still share an IOMMU domain.
> > This also significantly simplifies s390_iommu_attach_device() allowing
> > us to move the aperture check to the beginning of the function and
> > removing the need to hold the device list's lock to check the aperture.
> > 
> > As we then use the same aperture for all domains and it only depends on
> > the table properties we can already check zdev->start_dma/end_dma at
> > probe time and turn the check on attach into a WARN_ON().
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> > ---
> > v4->v5:
> > - Make aperture check in attach a WARN_ON() and fail in probe if
> >   zdev->start_dma/end_dma doesn't git in aperture  (Jason)
> > 
> >  drivers/iommu/s390-iommu.c | 65 +++++++++++++++++++++++++-------------
> >  1 file changed, 43 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index 9b3ae4b14636..1f6c9bee9a80 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -62,6 +62,9 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
> >  		kfree(s390_domain);
> >  		return NULL;
> >  	}
> > +	s390_domain->domain.geometry.force_aperture = true;
> > +	s390_domain->domain.geometry.aperture_start = 0;
> > +	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
> >  
> >  	spin_lock_init(&s390_domain->dma_table_lock);
> >  	spin_lock_init(&s390_domain->list_lock);
> > @@ -102,46 +105,32 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >  	struct s390_domain *s390_domain = to_s390_domain(domain);
> >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> >  	unsigned long flags;
> > -	int cc, rc = 0;
> > +	int cc;
> >  
> >  	if (!zdev)
> >  		return -ENODEV;
> >  
> > +	WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
> > +		domain->geometry.aperture_end < zdev->start_dma);
> > +

I think this one should still return with -EINVAL.

> >  	if (zdev->s390_domain)
> >  		__s390_iommu_detach_device(zdev);
> >  	else if (zdev->dma_table)
> >  		zpci_dma_exit_device(zdev);
> >  
> > -	zdev->dma_table = s390_domain->dma_table;
> >  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> > -				virt_to_phys(zdev->dma_table));
> > +				virt_to_phys(s390_domain->dma_table));
> >  	if (cc)
> >  		return -EIO;
> >  
> > -	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > -	/* First device defines the DMA range limits */
> > -	if (list_empty(&s390_domain->devices)) {
> > -		domain->geometry.aperture_start = zdev->start_dma;
> > -		domain->geometry.aperture_end = zdev->end_dma;
> > -		domain->geometry.force_aperture = true;
> > -	/* Allow only devices with identical DMA range limits */
> > -	} else if (domain->geometry.aperture_start != zdev->start_dma ||
> > -		   domain->geometry.aperture_end != zdev->end_dma) {
> > -		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > -		rc = -EINVAL;
> > -		goto out_unregister;
> > -	}
> > +	zdev->dma_table = s390_domain->dma_table;
> >  	zdev->s390_domain = s390_domain;
> > +
> > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> >  	list_add(&zdev->iommu_list, &s390_domain->devices);
> >  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> >  
> >  	return 0;
> > -
> > -out_unregister:
> > -	zpci_unregister_ioat(zdev, 0);
> > -	zdev->dma_table = NULL;
> > -
> > -	return rc;
> >  }
> >  
> > 
---8<---


