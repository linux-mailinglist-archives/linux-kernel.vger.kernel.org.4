Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6635BEA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiITPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:23:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327A5C971;
        Tue, 20 Sep 2022 08:23:11 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KFBlFJ026120;
        Tue, 20 Sep 2022 15:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=B4YxW+jAT3P/8goQQsCV3T+dXi8mRABjmmGoxH0/phg=;
 b=YZnLQvH0QGYJSHJKprHA5LoWkL9BucjMSzzlCaLu3GCvgczlVLnXeGvQ965eURGQ2omi
 SmHq6DwdcS1a6s7ESu6XHGghhR69I5pMySnCvvqhsFuEbywTaUb5drtS88AIHSa6EOjd
 PYJ82ZH/bS/dBFtGvKJPmZUi0s+XywQVCcLfArCCfOzYZb/2xrBYZUHWB8wvM9MrlhCt
 IRd0DQMMiiYOzsU3CzQ2hINfu2e1i+ap+ABdlVtdevsAa6o0uzEXX0VksT9cZvsjeRXJ
 C7hzYA0EDk7nZjvX2Gar8BzVnRf6qW4MhuRAn2K7HLvfWlmfu0mqkQVG/fEkmGUkxH6r rg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqfxpgdvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 15:22:59 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KFL2UJ022166;
        Tue, 20 Sep 2022 15:22:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3jn5v8k0qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 15:22:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KFMruE51052900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 15:22:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF81AE051;
        Tue, 20 Sep 2022 15:22:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC540AE04D;
        Tue, 20 Sep 2022 15:22:52 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 15:22:52 +0000 (GMT)
Message-ID: <92e00af653b6c84bfbccd60651d106a73e54887b.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Tue, 20 Sep 2022 17:22:52 +0200
In-Reply-To: <YynMUNCrGCzaFPjI@nvidia.com>
References: <20220915151402.121032-1-schnelle@linux.ibm.com>
         <20220915151402.121032-2-schnelle@linux.ibm.com>
         <YynMUNCrGCzaFPjI@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3DpJK-EC_yVMF7IhipQBESqkR5E4RO33
X-Proofpoint-ORIG-GUID: 3DpJK-EC_yVMF7IhipQBESqkR5E4RO33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209200090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-20 at 11:21 -0300, Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 05:14:00PM +0200, Niklas Schnelle wrote:
> > Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > calls") we can end up with duplicates in the list of devices attached to
> > a domain. This is inefficient and confusing since only one domain can
> > actually be in control of the IOMMU translations for a device. Fix this
> > by detaching the device from the previous domain, if any, on attach.
> > This also makes the restore behavior analogous between IOMMU and DMA API
> > control.
> > 
> > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/iommu/s390-iommu.c | 82 ++++++++++++++++++++++----------------
> >  1 file changed, 47 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index c898bcbbce11..de8f76775240 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -83,14 +83,41 @@ static void s390_domain_free(struct iommu_domain *domain)
> >  	kfree(s390_domain);
> >  }
> >  
> > +static bool __s390_iommu_detach_device(struct s390_domain *s390_domain,
> > +				     struct zpci_dev *zdev)
> > +{
> > +	struct s390_domain_device *domain_device, *tmp;
> > +	unsigned long flags;
> > +	bool found = false;
> > +
> > +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > +	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> > +				 list) {
> > +		if (domain_device->zdev == zdev) {
> 
> Why all this searching? The domain argument is only being provided to
> help drivers find their data structures, in most cases I would expect
> it to be mostly unused.

Before patch 3 we have no other way besides searching in the list to
get from the struct device to the struct s390_domain_device that we
need to kfree(). But yeah as shown by patch 3 this whole
s390_domain_device thing is not needed anyway.

> 
> After patch 3 the struct is gone, so isn't this just
> 
>  spin_lock_irqsave(&s390_domain->list_lock, flags);
>  list_del_init(&zdev->iommu_list)
>  spin_unlock_irqsave(&s390_domain->list_lock, flags);
> 
> ?

Yes with patch 3 I think you're right, the above should be enough to
get it removed from the list and there really shouldn't be a call to
detach from a domain if it wasn't attached to it, right? Just to be
safe we could also do nothing if (zdev->s390_domain != s390_domain) or
maybe better just BUG_ON()?

One thing that is still a bit of a mismatch is that architecturally
zpci_unregister_ioat() can fail but detach returns void. Now, one
reason for that is a hot unplug of the device has occurred in the
meantime in which case the device doesn't use the DMA translations
anymore anyway.

If anything else happens I don't know what we should do,
zpci_dma_exit_device() in our DMA API implementation in these cases
leaks the DMA tables such that any hardware still accessing them would
get valid tables but I don't think I've ever seen this occurring.

