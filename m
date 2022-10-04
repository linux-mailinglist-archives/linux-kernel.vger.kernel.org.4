Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE82B5F4738
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJDQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJDQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:13:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB12C124;
        Tue,  4 Oct 2022 09:13:26 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294FkmJp010878;
        Tue, 4 Oct 2022 16:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=46SayH01nZ7idobg+tOSIbfFlcDN1QkIJq1FYmwpg8Q=;
 b=lUJtP8d4aT/OVLw3JW6A+ZrQ6R+fKPaB3NtVi+/qHIhwK2cFR3ZG4tc+Qw8UUVS/g9IS
 DgYT5BZgauixcbXAYPSOJyUxStaDy+qONFtuo8B0dt0hBBslWU2l999A21lIn0u/BFn6
 k4DCm8miq0TP01ZBWNxIFVILn7Vu0mbkDgvV/oKiqfjqOeoBKYexJf1CtJ0Qq0HLih+A
 mauOyIVZB6ExWuSnT1Y3Apcmw1CPFGJWR7k6hxXd54zkmAqoHNqYSoZ+L+96RrPg7VCP
 bGEv2Z16UT+IKEsBDm7A4fTkeBeZ2eCQubFzUDHLxjgTXXfvHtMskGhak+QJU47ysP1L jQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fsn090p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:13:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294G64VA017682;
        Tue, 4 Oct 2022 16:13:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3jxctj4etu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:13:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294G8f6F50004270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 16:08:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2C811C04A;
        Tue,  4 Oct 2022 16:13:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77DF511C04C;
        Tue,  4 Oct 2022 16:13:09 +0000 (GMT)
Received: from sig-9-145-21-9.uk.ibm.com (unknown [9.145.21.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 16:13:09 +0000 (GMT)
Message-ID: <0da03411190c004e85cc856965b0aca901fd78fb.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] iommu/s390: Fix incorrect pgsize_bitmap
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Tue, 04 Oct 2022 18:13:09 +0200
In-Reply-To: <a02a3cee-773a-da00-616f-04652c0905ce@arm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
         <20221004120706.2957492-6-schnelle@linux.ibm.com>
         <eb1955e4-a618-ebf0-562d-17f9dd58b0da@arm.com>
         <b3c6fd2b-74d4-91d7-dc53-ba526c41b067@linux.ibm.com>
         <a02a3cee-773a-da00-616f-04652c0905ce@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _EhYxTJ-zUdsJ2mF6sGVTORYpyIgjgig
X-Proofpoint-GUID: _EhYxTJ-zUdsJ2mF6sGVTORYpyIgjgig
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-04 at 16:31 +0100, Robin Murphy wrote:
> On 2022-10-04 16:12, Matthew Rosato wrote:
> > On 10/4/22 11:02 AM, Robin Murphy wrote:
> > > On 2022-10-04 13:07, Niklas Schnelle wrote:
> > > > The .pgsize_bitmap property of struct iommu_ops is not a page mask but
> > > > rather has a bit set for each size of pages the IOMMU supports. As the
> > > > comment correctly pointed out at this moment the code only support 4K
> > > > pages so simply use SZ_4K here.
> > > 
> > > Unless it's already been done somewhere else, you'll want to switch over to the {map,unmap}_pages() interfaces as well to avoid taking a hit on efficiency here. The "page mask" thing was an old hack to trick the core API into making fewer map/unmap calls where the driver could map arbitrary numbers of pages at once anyway. The multi-page interfaces now do that more honestly and generally better (since they work for non-power-of-two sizes as well).
> > 
> > Thanks for the heads up -- Niklas has some additional series coming soon as described here:
> > 
> > https://lore.kernel.org/linux-iommu/a10424adbe01a0fd40372cbd0736d11e517951a1.camel@linux.ibm.com/
> > 
> > So implementing the _pages() interfaces is soon up on the roadmap.  But given what you say I wonder if this patch should just wait until the series that implements {map,unmap}_pages().
> 
> Perhaps, although the full change should be trivial enough that there's 
> probably just as much argument for doing the whole thing in its own 
> right for the sake of this cleanup. The main point is that 
> S390_IOMMU_PGSIZES is not incorrect as such, it's just not spelling out 
> the deliberate trick that it's achieving - everyone copied it from 
> intel-iommu, but since that got converted to the new interfaces the 
> original explanation is now gone. The only effect of "fixing" it in 
> isolation right now will be to make large VFIO mappings slower.
> 
> Robin.

The patch changing to map_pages()/unmap_pages() is currently part of a
larger series of improvements, some of which are less trivial. So I'm
planning to send those as RFC first. Those include changing the
spin_lock protected list to RCU so the map/unmap can paralellize
better. Another one is atomic updates to the IOMMU tables to do away
with locks in map/unmap. So I think pulling that whole
series into this one isn't ideal. I could pull just the
map_pages()/unmap_pages() change though.

> 
> > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >    drivers/iommu/s390-iommu.c | 9 +--------
> > > >    1 file changed, 1 insertion(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > > > index 94c444b909bd..6bf23e7830a2 100644
> > > > --- a/drivers/iommu/s390-iommu.c
> > > > +++ b/drivers/iommu/s390-iommu.c
> > > > @@ -12,13 +12,6 @@
> > > >    #include <linux/sizes.h>
> > > >    #include <asm/pci_dma.h>
> > > >    -/*
> > > > - * Physically contiguous memory regions can be mapped with 4 KiB alignment,
> > > > - * we allow all page sizes that are an order of 4KiB (no special large page
> > > > - * support so far).
> > > > - */
> > > > -#define S390_IOMMU_PGSIZES    (~0xFFFUL)
> > > > -
> > > >    static const struct iommu_ops s390_iommu_ops;
> > > >      struct s390_domain {
> > > > @@ -350,7 +343,7 @@ static const struct iommu_ops s390_iommu_ops = {
> > > >        .probe_device = s390_iommu_probe_device,
> > > >        .release_device = s390_iommu_release_device,
> > > >        .device_group = generic_device_group,
> > > > -    .pgsize_bitmap = S390_IOMMU_PGSIZES,
> > > > +    .pgsize_bitmap = SZ_4K,
> > > >        .get_resv_regions = s390_iommu_get_resv_regions,
> > > >        .default_domain_ops = &(const struct iommu_domain_ops) {
> > > >            .attach_dev    = s390_iommu_attach_device,


