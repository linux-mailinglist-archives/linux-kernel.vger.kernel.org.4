Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B7681535
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjA3PhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjA3PhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:37:11 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625223CE36;
        Mon, 30 Jan 2023 07:37:09 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UF7ojk012216;
        Mon, 30 Jan 2023 15:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ploVHXp8hKaR9ySWVv3fEMoKmp8S30tuM+qV+bf/7g8=;
 b=C4XVZzxQt77mweJpL4h4kepnMPbprAnUfxSd+kBlCT+nn2D3tJxgg2NuYRy4zOMz4mwS
 jpm2cr9wGoVJVqN/UC3QkuDUHxq4GY9R00mgkNdIjyaRiD/UeBmHWi/ENKiET1lojDi9
 PBKPMZSH3lRSHluEqQxXVXbU4+5+x4mvC7WcFEEna2R2yfndrtcUS3KgzW6aYDP7mtrk
 vJCqpnbCUI/DOqFPf58y7V5VTHa34nZquOihopLfxvIgJ49hjFJ/Degtvn1WCNVF6QUt
 H+WqKd0kMs6F8JGWRWU6hHGGQ/F/7fQlfXETaQN+Yi6x++mFzg1umJSBtVeUo5yae0qK yQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neg8x0waw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:36:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U4s6TH012859;
        Mon, 30 Jan 2023 15:36:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtyadt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:36:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UFaiL939584232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 15:36:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC79F2005A;
        Mon, 30 Jan 2023 15:36:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94842004B;
        Mon, 30 Jan 2023 15:36:42 +0000 (GMT)
Received: from [9.171.38.212] (unknown [9.171.38.212])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 15:36:42 +0000 (GMT)
Message-ID: <d71905cc4978eb204527f8d058489f8491f3d149.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
Date:   Mon, 30 Jan 2023 16:36:42 +0100
In-Reply-To: <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
         <20230124125037.3201345-6-schnelle@linux.ibm.com>
         <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iFnzcJp162I3mNH2AvuNgxYRvW9QdNAy
X-Proofpoint-ORIG-GUID: iFnzcJp162I3mNH2AvuNgxYRvW9QdNAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=445 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 15:13 +0000, Robin Murphy wrote:
> On 2023-01-24 12:50, Niklas Schnelle wrote:
> > In some virtualized environments, including s390 paged memory guests,
> > IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> > are much more expensive than in typical bare metal environments or
> > non-paged s390 guests. In addition they may parallelize more poorly in
> > virtualized environments. This changes the trade off for flushing IOVAs
> > such that minimizing the number of IOTLB flushes trumps any benefit of
> > cheaper queuing operations or increased paralellism.
> >=20
> > In this scenario per-CPU flush queues pose several problems. Firstly
> > per-CPU memory is often quite limited prohibiting larger queues.
> > Secondly collecting IOVAs per-CPU but flushing via a global timeout
> > reduces the number of IOVAs flushed for each timeout especially on s390
> > where PCI interrupts may not be bound to a specific CPU.
> >=20
> > Thus let's introduce a single flush queue mode IOMMU_DOMAIN_DMA_SQ that
> > reuses the same queue logic but only allocates a single global queue
> > allowing larger batches of IOVAs to be freed at once and with larger
> > timeouts. This is to allow the common IOVA flushing code to more closel=
y
> > resemble the global flush behavior used on s390's previous internal DMA
> > API implementation.
> >=20
> > As we now support two different variants of flush queues rename the
> > existing __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to indicate
> > the general case of having a flush queue and introduce separate
> > __IOMMU_DOMAIN_DMA_PERCPU_Q and __IOMMU_DOMAIN_DMA_SINGLE_Q bits to
> > indicate the two queue variants.
>=20
> Is there any actual need for the flush queue type to vary on a=20
> per-domain basis? All the descriptions here seem to imply that in fact=
=20
> it's always going to be a global decision one way or the other on s390,=
=20
> so if that's all we really need, we can save ourselves a bunch of=20
> trouble here by not having to mess with the core code at all, and just=
=20
> having some kind of switch in iommu-dma.
>=20
> Either way, the more I think about this the more I'm starting to agree=
=20
> that adding more domain types for iommu-dma policy is a step in the=20
> wrong direction. If I may, I'd like to fall back on the "or at least=20
> some definite internal flag" part of my original suggestion :)
>=20
> Thanks,
> Robin.
>=20
>=20

Our PCI architecture has the relevant flags per PCI device so in theory
one device could use expensive shadow tables updated via IOTLB flushes
while another might use nested IO page table walks. This isn't the case
for any existing hardware though, there it's indeed all or nothing so
at least for now that would be enough. Also that just makes it per
device not necessarily per domain or creates a need to switch while in
use. I'll discuss where such a flag could go in an answer to Jason's
mail.
