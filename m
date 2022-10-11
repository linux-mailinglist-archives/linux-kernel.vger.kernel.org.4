Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F15FB0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJKLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKLDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:03:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDE8A7F3;
        Tue, 11 Oct 2022 04:03:49 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BAvusI009461;
        Tue, 11 Oct 2022 11:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hDAVq3DyAX2CiZcYvnqC7pQdQLMzQ4OcNhupPzYwZVI=;
 b=VFzh7EM0QdwKBgO8G17fTNAZKj7x0wrssbLG7j9qIYfJqM+K4gVHHfykE+5O5zBQsYCY
 VHLSDaVStGAZWRLhu180FTu8F88OJcgQwk5wvtSrxU0tWPbpUszZbtIfLGYYqFwGFXXK
 dCt/YJQ/qGDjsTpb/ESoZvh7/M5oHRj5nwhh/IdQ13m0nTnOgXGCl/FIz4hYPJe8C+67
 PvK47PzJj2Hp8jQULCfRycKQphXolEKcCYZdlnkjqeK4nei9KtFwwH9QI7gsls78t+HG
 L0T5ObaAIes1ZBl9R4/CO3MoDJoJc8SqfqpcInGLuRXeCwyPl7g1JNM973tchacZb5Fm yw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k576v04x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 11:03:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29BAxYlj021732;
        Tue, 11 Oct 2022 11:03:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3k30fj34b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 11:03:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29BB3R1n3932756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 11:03:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94DF11C05C;
        Tue, 11 Oct 2022 11:03:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E83711C04A;
        Tue, 11 Oct 2022 11:03:27 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Oct 2022 11:03:27 +0000 (GMT)
Message-ID: <fa42d70524225e37bd221f13276d8e75d4d711c5.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/6] iommu/s390: Fixes related to attach and aperture
 handling
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Oct 2022 13:03:27 +0200
In-Reply-To: <Y0RoXXclqRiMzN9T@nvidia.com>
References: <20221007095005.2017126-1-schnelle@linux.ibm.com>
         <838e7df1128e52ac5229307dde6690c2e26b830c.camel@linux.ibm.com>
         <Y0RoXXclqRiMzN9T@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kzmMuTmDm40wcihcNVp-gc5-ZfHH0cB5
X-Proofpoint-ORIG-GUID: kzmMuTmDm40wcihcNVp-gc5-ZfHH0cB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=826
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 15:45 -0300, Jason Gunthorpe wrote:
> On Mon, Oct 10, 2022 at 04:54:07PM +0200, Niklas Schnelle wrote:
> > On Fri, 2022-10-07 at 11:49 +0200, Niklas Schnelle wrote:
> > > Hi All,
> > > 
> > > This is v5 of a follow up to Matt's recent series[0] where he tackled
> > > a race that turned out to be outside of the s390 IOMMU driver itself as
> > > well as duplicate device attachments. After an internal discussion we came
> > > up with what I believe is a cleaner fix. Instead of actively checking for
> > > duplicates we instead detach from any previous domain on attach. From my
> > > cursory reading of the code this seems to be what the Intel IOMMU driver is
> > > doing as well.
> > > 
> > > Moreover we drop the attempt to re-attach the device to its previous IOMMU
> > > domain on failure. This was fragile, unlikely to help and unexpected for
> > > calling code. Thanks Jason for the suggestion.
> > > 
> > > We can also get rid of struct s390_domain_device entirely if we instead
> > > thread the list through the attached struct zpci_devs. This saves us from
> > > having to allocate during attach and gets rid of one level of indirection
> > > during IOMMU operations.
> > > 
> > > Additionally 3 more fixes have been added in v3 that weren't in v2 of this
> > > series. One is for a potential situation where the aperture of a domain
> > > could shrink and leave invalid translations. The next one fixes an off by
> > > one in checking validity of an IOVA and the last one fixes a wrong value
> > > for pgsize_bitmap.
> > > 
> > > In v4 we also add a patch changing to the map_pages()/unmap_pages()
> > > interface in order to prevent a performance regression due to the
> > > pgsize_bitmap change.
> > > 
> > > *Note*:
> > > This series is against the s390 features branch[1] which already contains
> > > the bus_next field removal that was part of v2.
> > > 
> > > It is also available as branch iommu_fixes_v6 with the GPG signed tag
> > > s390_iommu_fixes_v5 on my niks/linux.git on git.kernel.org[2].
> > > 
> > > *Open Question*:
> > > Which tree should this go via?
> > 
> > The conflicting commit that removed the bus_next field from struct
> > zpci_dev has now made it into Linus' tree via the s390 pull. So this
> > series now applies cleanly on mainline master. Still not sure though
> > which tree this would best go into.
> 
> Arguably it should go through Joerg's iommu tree since it is only in
> the iommu driver..
> 
> If you need it on a branch to share with the s390 tree then send Joerg
> a PR.
> 
> Jason

Ok makes sense, I don't think I need it on an extra branch and whatever
is easiest for Joerg is fine. I hope that since all but patch 6 are
fixes and that one is quite simple that this could maybe still go into
v6.1.

Not sure if Joerg is still waiting on some Acks or R-bs though. I did
remove yours on patches 1, 2,  and 3 as there were some changes since
you gave it. I don't think you gave one for patch 4 and patch 6 is new.

I plan on sending further IOMMU improvements and the DMA conversion
based on this but will just reference it and provide private branches
on git.kernel.org. I think those will target the next merge window at
the earliest so that should be fine.

Thanks,
Niklas

