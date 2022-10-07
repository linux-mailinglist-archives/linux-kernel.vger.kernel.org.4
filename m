Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF15F774E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJGLU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC354371B0;
        Fri,  7 Oct 2022 04:20:54 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297AM6db009568;
        Fri, 7 Oct 2022 11:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BuTx5xrIpaoPNRiE49GYZFCJdJ2bm9SZfnB463TZQzQ=;
 b=WvxCH8QPIaFuX87OXwBte6pnfaUMjzt9fNPrYQhmYTc4OPYiPpTpaNOsUqDc9fbC1OsN
 q3xhv5/8FH0iWLd/ndPRUVOE072JSCV8pIh+oE9swjxN5ODGnJPQZJ11DIR+4mJuM0y/
 Z7LQ2RB3romOnf9RkmXoVrTtKwnfgUi2dGaY5/T75sMSmaREXwsDox8LegtY0mIsxO9J
 8kOUHcPkwh+gYgMkVqM0LpLbSyPWjAwwJVLQokxbyHFaeySXSQDQ5Hh8rc2pGtSR+n90
 WXXpiDpndkaNDhxyZh8D9C+GBb2YhD5YBcEbYOVeXiq1NUfvplZ+bEKvjp6YfYs+Kcu2 lg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2ja01n94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 11:20:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 297BKdmp002145;
        Fri, 7 Oct 2022 11:20:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68x91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 11:20:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 297BL6F649152402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Oct 2022 11:21:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5359AE04D;
        Fri,  7 Oct 2022 11:20:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1CDFAE045;
        Fri,  7 Oct 2022 11:20:35 +0000 (GMT)
Received: from sig-9-145-159-233.de.ibm.com (unknown [9.145.159.233])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Oct 2022 11:20:35 +0000 (GMT)
Message-ID: <f066ce84e415dc2726a23fe8a8886fa157b34bcd.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/6] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 13:20:35 +0200
In-Reply-To: <ce0d9e782ae523c35173f053cbb3924e6880420c.camel@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
         <20221006144700.3380098-2-schnelle@linux.ibm.com>
         <c778fc2b-2c0d-777c-52fb-1b315cf95552@linux.ibm.com>
         <ce0d9e782ae523c35173f053cbb3924e6880420c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cLaEMDZnlJRvqcX-IDnWMr1HnA9PeWry
X-Proofpoint-GUID: cLaEMDZnlJRvqcX-IDnWMr1HnA9PeWry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 08:55 +0200, Niklas Schnelle wrote:
> On Thu, 2022-10-06 at 17:02 -0400, Matthew Rosato wrote:
> > On 10/6/22 10:46 AM, Niklas Schnelle wrote:
> > > Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > > calls") we can end up with duplicates in the list of devices attached to
> > > a domain. This is inefficient and confusing since only one domain can
> > > actually be in control of the IOMMU translations for a device. Fix this
> > > by detaching the device from the previous domain, if any, on attach.
> > > Add a WARN_ON() in case we still have attached devices on freeing the
> > > domain. While here remove the re-attach on failure dance as it was
> > > determined to be unlikely to help and may confuse debug and recovery.
> > > 
> > > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > v4->v5:
> > > - Unregister IOAT and set zdev->dma_table on error (Matt)
> > > 
> > ...
> > 
> > >  static int s390_iommu_attach_device(struct iommu_domain *domain,
> > >  				    struct device *dev)
> > >  {
> > > @@ -90,7 +116,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> > >  	struct zpci_dev *zdev = to_zpci_dev(dev);
> > >  	struct s390_domain_device *domain_device;
> > >  	unsigned long flags;
> > > -	int cc, rc;
> > > +	int cc, rc = 0;
> > >  
> > >  	if (!zdev)
> > >  		return -ENODEV;
> > > @@ -99,23 +125,17 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> > >  	if (!domain_device)
> > >  		return -ENOMEM;
> > >  
> > > -	if (zdev->dma_table && !zdev->s390_domain) {
> > > -		cc = zpci_dma_exit_device(zdev);
> > > -		if (cc) {
> > > -			rc = -EIO;
> > > -			goto out_free;
> > > -		}
> > > -	}
> > > -
> > >  	if (zdev->s390_domain)
> > > -		zpci_unregister_ioat(zdev, 0);
> > > +		__s390_iommu_detach_device(zdev);
> > > +	else if (zdev->dma_table)
> > > +		zpci_dma_exit_device(zdev);
> > >  
> > >  	zdev->dma_table = s390_domain->dma_table;
> > >  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> > >  				virt_to_phys(zdev->dma_table));
> > >  	if (cc) {
> > >  		rc = -EIO;
> > > -		goto out_restore;
> > > +		goto out_free;
> > >  	}
> > 
> > Hmm, with this we will leave attach_dev with a zdev->dma_table associated with this domain (not one generated via zpci_dma_init_device) and zdev->s390_domain == 0.  Won't this cause both s390_domain_free and zpci_dma_exit_device() to try and free the same dma table?
> > 
> > I think we also have to leave with a NULL zdev->dma_table in this case too (you technically could skip the zpci_unregister_ioat)
> 
> Argh you're right. This is I think a a bad rebase, in v4 I had the
> zpci_register_ioat() use s390_domain->dma_table and only set zdev-
> > dma_table after that succeeded. I seem to have lost that part
> somewhere along the way. With that we zdev->dma_table would be NULL and
> all would be good.
> 

Went back to the way I did it in v4 for v6. I think I was simply an
idiot and when comparing to the state prior to the commit forgot why I
did it this way and thought it was an unneeded change..

> > >  
> > >  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > @@ -127,9 +147,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> > >  	/* Allow only devices with identical DMA range limits */
> > >  	} else if (domain->geometry.aperture_start != zdev->start_dma ||
> > >  		   domain->geometry.aperture_end != zdev->end_dma) {
> > > -		rc = -EINVAL;
> > >  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > -		goto out_restore;
> > > +		rc = -EINVAL;
> > > +		goto out_unregister;
> > >  	}
> > >  	domain_device->zdev = zdev;
> > >  	zdev->s390_domain = s390_domain;
> > > @@ -138,14 +158,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> > >  
> > >  	return 0;
> > >  
> > > -out_restore:
> > > -	if (!zdev->s390_domain) {
> > > -		zpci_dma_init_device(zdev);
> > > -	} else {
> > > -		zdev->dma_table = zdev->s390_domain->dma_table;
> > > -		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> > > -				   virt_to_phys(zdev->dma_table));
> > > -	}
> > > +out_unregister:
> > > +	zpci_unregister_ioat(zdev, 0);
> > > +	zdev->dma_table = NULL;
> > >  out_free:
> > >  	kfree(domain_device);
> > >  
> 
> 


