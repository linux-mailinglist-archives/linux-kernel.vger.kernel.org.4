Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002876AE030
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCGNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCGNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:17:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CEB30D6;
        Tue,  7 Mar 2023 05:17:05 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327CreC9024670;
        Tue, 7 Mar 2023 13:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RbombY6WkH4lJKT52ssIwQZhPfm3t0xDTCi+53SOjO8=;
 b=oUDBmag/fNc99DbxOXF2cUJlDSqvlIiBi3K1Wwl97aAcpHhFkEXeG3fbh+cFOBvEkLsZ
 9NecY+RDrmafA214+ggBqp1ycc44xFIPdIyeHygB6OOYAwbhLY1dsa/SUeiluCeALteJ
 RENnydkQ3tldeLtWNO2tMQ1/lu9xQAPnlWOwHCrMrTtEBbMNQYw3IAuCpTVn4VyHvAaw
 fpBR+3sI2+XRzTRzAyK3IQ6vto2o3Bq8xGBVIK3a+HqNJlwCtY4wT2QSu8V3vK4wYH1U
 UtnCC2ZG4EPBkp+3dLd921YQHnpWpCihpql2iqI8ukNrlS16hx1vGZOlxqRtQBa7G1bI Xw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p65p3gnrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 13:16:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3277vEdi004261;
        Tue, 7 Mar 2023 13:16:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p41b0ubdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 13:16:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327DGcJL52166954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 13:16:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2F3220043;
        Tue,  7 Mar 2023 13:16:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BA702004D;
        Tue,  7 Mar 2023 13:16:38 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 13:16:38 +0000 (GMT)
Message-ID: <a5e2178782c862dd3241ce821a471b584b8089a9.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Tue, 07 Mar 2023 14:16:37 +0100
In-Reply-To: <20230220152222.1818344-1-schnelle@linux.ibm.com>
References: <20230220152222.1818344-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xWZtNCWb1-UDIaAdONcCovIaQpAlqo9V
X-Proofpoint-ORIG-GUID: xWZtNCWb1-UDIaAdONcCovIaQpAlqo9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_07,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-20 at 16:22 +0100, Niklas Schnelle wrote:
> Hi All,
>=20
> This patch series converts s390's PCI support from its platform specific =
DMA
> API implementation in arch/s390/pci/pci_dma.c to the common DMA IOMMU lay=
er.
> The conversion itself is done in patches 3-4 with patch 2 providing the f=
inal
> necessary IOMMU driver improvement to handle s390's special IOTLB flush
> out-of-resource indication in virtualized environments. Patches 1-2 may b=
e
> applied independently. The conversion itself only touches the s390 IOMMU =
driver
> and s390 arch code moving over remaining functions from the s390 DMA API
> implementation. No changes to common code are necessary.
>=20
> After patch 4 the basic conversion is done and on our partitioning machin=
e
> hypervisor LPAR performance matches or exceeds the existing code. When ru=
nning
> under z/VM or KVM however, performance plummets to about half of the exis=
ting
> code due to a much higher rate of IOTLB flushes for unmapped pages. Due t=
o the
> hypervisors use of IOTLB flushes to synchronize their shadow tables these=
 are
> very expensive and minimizing them is key for regaining the performance l=
oss.
>=20
> To this end patches 5-6 propose a new, single queue, IOTLB flushing schem=
e as
> an alternative to the existing per-CPU flush queues. Introducing an alter=
native
> scheme was also suggested by Robin Murphy[1]. In the previous RFC of this
> conversion Robin suggested reusing more of the existing queuing logic whi=
ch
> I incorporated since v2. The single queue mode is introduced in patch
> 5 together with a new dma_iommu_options struct and tune_dma_iommu callbac=
k in
> IOMMU ops which allows IOMMU drivers to switch to a single flush queue.
>=20
> Then patch 6 enables variable queue sizes using power of 2 queue sizes an=
d
> shift/mask to keep performance as close to the existing code as possible.=
 The
> variable queue size and a variable timeout are added to the dma_iommu_opt=
ions
> struct and utilized by s390 in the z/VM and KVM guest cases. As it is
> implemented in common code the single queue IOTLB flushing scheme can of =
course
> be used by other platforms with expensive IOTLB flushes. Particularly
> virtio-iommu may be a candidate.
>=20
> In a previous version I verified that the new scheme does work on my x86_=
64
> Ryzen workstation by locally modifying iommu_subsys_init() to default to =
the
> single queue mode and verifying its use via "/sys/.../iommu_group/type". =
I did
> not find problems with an AMD GPU, Intel NIC (with SR-IOV and KVM
> pass-through), NVMes or any on board peripherals.
>=20
> As with previous series this is available via my git.kernel.org tree[3] i=
n the
> dma_iommu_v7 branch with signed s390_dma_iommu_v7 tag. This version appli=
es
> on top of iommu-next to incorporate the ops->set_platform_dma() and GFP
> changes.

FYI this patch set now applies cleanly (and works) on v6.3-rc1. If need
be I can resend with Matt's R-b added but other than that I currently
don't have open TODOs for this so review away.

Thanks,
Niklas

