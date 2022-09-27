Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B775EC999
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiI0Qeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiI0QeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:34:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A61D929B;
        Tue, 27 Sep 2022 09:34:16 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RG6jQq031235;
        Tue, 27 Sep 2022 16:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7Qmvt/yiIMwMHM6EZgLoxQRN9yMjBsbBXFpoJxb/6lg=;
 b=aOIZXUDTK2x38vWd1OGUh6ZYr9MjpNou6T/5DoaaFe4I9OTZ1qgtLEVu47X5seMwQhJB
 lR5JUtIOyBE/ELZsVzQ1dyXHHseB1J0X/HO/SP3eeYT6nkeZTuJyrqM/1pOw0wwCX1sn
 kzKsM0BzeGKfnewOB4j2AxOiF6mq5gjmIxaQDzyTEGk5uDcBWx79YCFaTTgzgGtCr2X0
 5ll8uns+UFmzK/Z+4FaD1Mx/ATO6bVRMZrj563A3U2T/kXB5YygveqI4JlId9ZetstlO
 YO/QfOirAs8M0tODYjSaEmg0lZQRyG+/V42MiBAdFjtrP0BrbQnrPs3VIFF5jrQb4+7F Xw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jv2fgdpu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:33:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28RGK0tO022586;
        Tue, 27 Sep 2022 16:33:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9c3cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:33:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28RGXnSa62259638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 16:33:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29D214C046;
        Tue, 27 Sep 2022 16:33:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B3D34C040;
        Tue, 27 Sep 2022 16:33:48 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 16:33:48 +0000 (GMT)
Message-ID: <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
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
Date:   Tue, 27 Sep 2022 18:33:48 +0200
In-Reply-To: <YzGtQY+uw4ZzZoSH@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
         <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
         <YzGtQY+uw4ZzZoSH@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fnREZ9yzlkXPKEbReJ3GIeRoVNmTed3v
X-Proofpoint-ORIG-GUID: fnREZ9yzlkXPKEbReJ3GIeRoVNmTed3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_07,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 10:46 -0300, Jason Gunthorpe wrote:
> On Mon, Sep 26, 2022 at 11:00:53AM +0200, Niklas Schnelle wrote:
> 
> > > > +out_unregister_restore:
> > > > +	zpci_unregister_ioat(zdev, 0);
> > > >  out_restore:
> > > > -	if (!zdev->s390_domain) {
> > > > +	zdev->dma_table = NULL;
> > > > +	if (prev_domain)
> > > > +		s390_iommu_attach_device(&prev_domain->domain,
> > > > +					 dev);
> > > 
> > > Huh. That is a surprising thing
> > > 
> > > I think this function needs some re-ordering to avoid this condition
> > > 
> > > The checks for aperture should be earlier, and they are not quite
> > > right. The aperture is only allowed to grow. If it starts out as 0 and
> > > then is set to something valid on first attach, a later attach cannot
> > > then shrink it. There could already be mappings in the domain under
> > > the now invalidated aperture and no caller is prepared to deal with
> > > this.
> > 
> > Ohh I think this is indeed broken. Let me rephrase to see if I
> > understand correctly. You're saying that while we only allow exactly
> > matching apertures on additional attaches, we do allow shrinking if
> > there is temporarily no device attached to the domain. That part is
> > then broken because there could still be mappings outside the new
> > aperture stored in the translation tables?
> 
> Right, go from 0 -> sized apperture on first attach, and then once it
> is sized it doesn't change again.

Ok, some background. This is currently largely a theoretical issue as
all native PCI devices that currently exist on s390 have the same zdev-
>start_dma (0x100000000) and we will set zdev->end_dma to (zdev-
>start_dma + MEMORY_SIZE) in zpci_dma_init_device() to save space for
our IOVA allocation bitmap. So currently no shrinking can occur.

Still I think we should do this properly. Also by the way, there is a
known off-by-one (aperture too small) in the current checks for which I
was about to send a patch as part of the conversion to using dma-
iommu.c.

>  
> > > That leaves the only error case as zpci_register_ioat() - which seems
> > > like it is the actual "attach" operation. Since
> > > __s390_iommu_detach_device() is just internal accounting (and can't
> > > fail) it should be moved after
> > > 
> > > So the logic order should be
> > > 
> > > 1) Attempt to widen the aperture, if this fails the domain is
> > >    incompatible bail immediately
> > 
> > Question. If the widening succeeds but we fail later during the attach
> > e.g. in 2) then the aperture remains widend or would that be rolled
> > back? 
> 
> I'd leave it widened.
> 
> IMHO I don't like this trick of setting the aperture on attach. It is
> logically wrong. The aperture is part of the configuration of the page
> table itself. The domain should know what page table format and thus
> apterture it has the moment it is allocated. Usually this is the
> related to the number of levels in the radix tree.
> 
> It seems to me that the issue here is trying to use the aperture when
> the reserved region is the appropriate tool.
> 
> eg I see that s390_domain_alloc calls dma_alloc_cpu_table() which just
> allocates a 3 level radix tree. This means it has a specific max
> address that can be passed to dma_walk_cpu_trans(). So the aperture
> should be fixed based on the radix tree parameters.

Yes, we even have the ZPCI_TABLE_SIZE_RT constant already that is the
maximum number of translations.

> 
> The device specific start/end should be represented as a reserved
> regions per-device. See patch below..
> 
> This is meaningful because it effects when VFIO can share the domains
> across devices. If devices have different reserved ranges we can still
> share domains, so long as no mapping is placed in the union of the
> reserved ranges. However if you vary the aperture, like is currently
> happening, then the domains become unsharable.

Ok, interesting idea.

As we haven't used these reserved regions so far and I'm not familiar
with what they are usually used for, I had a look at my x86_64 test box
(amd_iommu=on) and see the following:

# cat /sys/bus/pci/devices/*/iommu_group/reserved_regions | sort | uniq 
0x00000000fee00000 0x00000000feefffff msi
0x000000fd00000000 0x000000ffffffffff reserved

Not sure what the non-MSI reservation is for? It does seem like x86_64
also uses this for quite large ranges.

With your patch and the off by one fixed (see below) on an s390x
machine with 32 GiB memory I then get the following:

# cat /sys/bus/pci/devices/*/iommu_group/reserved_regions | sort | uniq
0x0000000000000000 0x00000000ffffffff reserved
0x0000000900000000 0x000003ffffffffff reserved

As the upper limit is shown inclusive this looks correct to me. 

Not all is rosy though, while this seems to work with the current code
and KVM pass-through, it breaks my conversion for using dma-iommu. 

This is because I'm getting a map request for an IOVA in the reserved
region. I pass the zdev->start_dma and zdev->end_dma to
iommu_setup_dma_ops() but while iommu_dma_init_domain() uses the lower
limit for the base_pfn it only checks if the upper limit fits in the
aperture and otherwise ignores it.  Looking at iommu_dma_alloc_iova() I
don't think that avoids the reserved regions either but it does use the
domain->geometry.aperture_end or dev->bus_dma_limit, whichever is
smaller.

With that knowledge setting dev->bus_dma_limit to zdev->end_dma makes
my conversion work again that feels wrong though but at least confirms
the issue.

> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce118f..ba80325da76cd9 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -51,6 +51,12 @@ static bool s390_iommu_capable(enum iommu_cap cap)
>  	}
>  }
>  
> 
---8<---
>  
> +static void s390_iommu_get_resv_regions(struct device *dev,
> +					struct list_head *list)
> +{
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +	struct iommu_resv_region *region;
> +
> +	if (zdev->start_dma) {
> +		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
> +						 IOMMU_RESV_RESERVED);
> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +
> +	if (zdev->end_dma < MAX_DMA_TABLE_ADDR) {
> +		region = iommu_alloc_resv_region(
> +			zdev->end_dma, MAX_DMA_TABLE_ADDR - zdev->end_dma, 0,

Not your fault since there is a pre-existing bug in the range check but
I think there is an off-by-one error here as zdev->end_dma is the
highest usable address.

> +			IOMMU_RESV_RESERVED);
> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, list);
> +	}
> +}
> +
>  static void s390_iommu_detach_device(struct iommu_domain *domain,
>  				     struct device *dev)
>  {
> @@ -376,6 +398,7 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.release_device = s390_iommu_release_device,
>  	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.get_resv_regions = s390_iommu_get_resv_regions,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= s390_iommu_attach_device,
>  		.detach_dev	= s390_iommu_detach_device,


