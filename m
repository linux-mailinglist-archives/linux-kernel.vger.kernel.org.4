Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB76644117
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiLFKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiLFKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:14:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF7D83;
        Tue,  6 Dec 2022 02:14:13 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B69GwFl013684;
        Tue, 6 Dec 2022 10:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PgwwJWjuzBEqBgNnVDA7d9YauHafIGKqsuWTi8n/4dE=;
 b=UeuuWn0q2k8/rX+FJj8lmiVa+5cn7Kq4eJ+vGGaX7hV53qVN0x6sLPraMhyDjnDzxCRn
 W9ELQ/TEmawAoUSjVGV2fA3P3MHJJNJnEjRVn25IBnKDgWzbdIPBMkx4CwIt7bQrEiR5
 11aNbxjqSQoi7QPMDlatDjeN9d+iDz9wLaxPv5SRmmxRoNRH24OxhFOS1FpY7o9fBD8V
 66A5f+uOioALVZhVuePeOLVX3gARaUxQA9B4SIg1ukakz5w3CIJMfTBJD1DIv5GHaGy1
 8klz0xH5g31EB4aC2CfsYcC3ryTCJRXSiTbaChtjaBWTuA9g/fgrF7Cb6Ec0zxQA4+ZI ZA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m9tqmc882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 10:13:55 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B5K5UUa016521;
        Tue, 6 Dec 2022 10:13:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y0vbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 10:13:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com ([9.149.105.58])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B6ADnXa36307306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 10:13:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE3B64C04E;
        Tue,  6 Dec 2022 10:13:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF584C050;
        Tue,  6 Dec 2022 10:13:48 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Dec 2022 10:13:48 +0000 (GMT)
Message-ID: <44e2bc660f0fb4fdb2061be1553c93339146cef9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Tue, 06 Dec 2022 11:13:48 +0100
In-Reply-To: <fa9729b7-5d20-fb3d-4bf9-e073d18235b3@arm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-8-schnelle@linux.ibm.com>
         <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
         <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
         <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
         <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
         <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
         <fa9729b7-5d20-fb3d-4bf9-e073d18235b3@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q9EPtG6DgEOvon2tF5gG404xss28XCqI
X-Proofpoint-ORIG-GUID: q9EPtG6DgEOvon2tF5gG404xss28XCqI
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_05,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-05 at 18:24 +0000, Robin Murphy wrote:
> On 2022-12-02 14:29, Niklas Schnelle wrote:
> > On Tue, 2022-11-29 at 15:40 +0100, Niklas Schnelle wrote:
> > > On Tue, 2022-11-29 at 12:53 +0000, Robin Murphy wrote:
> > > > On 2022-11-29 12:00, Niklas Schnelle wrote:
> > > > > On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
> > > > > > On 2022-11-16 17:16, Niklas Schnelle wrote:
> > > > > > > When RPCIT indicates that the underlying hypervisor has run o=
ut of
> > > > > > > resources it often means that its IOVA space is exhausted and=
 IOVAs need
> > > > > > > to be freed before new ones can be created. By triggering a f=
lush of the
> > > > > > > IOVA queue we can get the queued IOVAs freed and also get the=
 new
> > > > > > > mapping established during the global flush.
> > > > > >=20
> > > > > > Shouldn't iommu_dma_alloc_iova() already see that the IOVA spac=
e is
> > > > > > exhausted and fail the DMA API call before even getting as far =
as
> > > > > > iommu_map(), though? Or is there some less obvious limitation l=
ike a
> > > > > > maximum total number of distinct IOVA regions regardless of siz=
e?
> > > > >=20
> > > > > Well, yes and no. Your thinking is of course correct if the adver=
tised
> > > > > available IOVA space can be fully utilized without exhausting
> > > > > hypervisor resources we won't trigger this case. However sadly th=
ere
> > > > > are complications. The most obvious being that in QEMU/KVM the
> > > > > restriction of the IOVA space to what QEMU can actually have mapp=
ed at
> > > > > once was just added recently[0] prior to that we would regularly =
go
> > > > > through this "I'm out of resources free me some IOVAs" dance with=
 our
> > > > > existing DMA API implementation where this just triggers an early=
 cycle
> > > > > of freeing all unused IOVAs followed by a global flush. On z/VM I=
 know
> > > > > of no situations where this is triggered. That said this signalli=
ng is
> > > > > architected so z/VM may have corner cases where it does this. On =
our
> > > > > bare metal hypervisor (no paging) this return code is unused and =
IOTLB
> > > > > flushes are simply hardware cache flushes as on bare metal platfo=
rms.
> > > > >=20
> > > > > [0]
> > > > > https://lore.kernel.org/qemu-devel/20221028194758.204007-4-mjrosa=
to@linux.ibm.com/
> > > >=20
> > > > That sheds a bit more light, thanks, although I'm still not confide=
nt I
> > > > fully understand the whole setup. AFAICS that patch looks to me like
> > > > it's putting a fixed limit on the size of the usable address space.=
 That
> > > > in turn implies that "free some IOVAs and try again" might be a red
> > > > herring and never going to work; for your current implementation, w=
hat
> > > > that presumably means in reality is "free some IOVAs, resetting the
> > > > allocator to start allocating lower down in the address space where=
 it
> > > > will happen to be below that limit, and try again", but the iommu-d=
ma
> > > > allocator won't do that. If it doesn't know that some arbitrary ran=
ge
> > > > below the top of the driver-advertised aperture is unusable, it will
> > > > just keep allocating IOVAs up there and mappings will always fail.
> > > >=20
> > > > If the driver can't accurately represent the usable IOVA space via =
the
> > > > aperture and/or reserved regions, then this whole approach seems do=
omed.
> > > > If on the other hand I've misunderstood and you can actually still =
use
> > > > any address, just not all of them at the same time,
> > >=20
> > >=20
> > > This is exactly it, the problem is a limit on the number of IOVAs that
> > > are concurrently mapped. In QEMU pass-through the tightest limit is
> > > usually the one set by the host kernel parameter
> > > vfio_iommu_type1.dma_entry_limit which defaults to 65535 mappings. Wi=
th
> > > IOMMU_DOMAIN_DMA we stay under this limit without extra action but on=
ce
> > > there is a flush queue (including the existing per-CPU one) where each
> > > entry may keep many pages lazily unmapped this is easly hit with fio
> > > bandwidth tests on an NVMe. For this case this patch works reliably
> > > because of course the number of actually active mappings without the
> > > lazily freed ones is similar to the number of active ones with
> > > IOMMU_DOMAIN_DMA.
> > >=20
> > > >   then it might in
> > > > fact be considerably easier to skip the flush queue mechanism entir=
ely
> > > > and implement this internally to the driver - basically make .iotlb=
_sync
> > > > a no-op for non-strict DMA domains,
> > >=20
> > > I'm assuming you mean .iotlb_sync_map above.
>=20
> No, I did mean .iotlb_sync, however on reflection that was under the=20
> assumption that it's OK for the hypervisor to see a new mapping for a=20
> previously-used IOVA without having seen it explicitly unmapped in=20
> between. Fair enough if that isn't the case, but if it is then your=20
> pagetable can essentially act as the "flush queue" by itself.

Hmm, I see. We do want the hypervisor to see mappings as invalid before
they are changed again to a new valid mapping. In case of e.g. QEMU/KVM
this allows the hypervisor to itself rely on the hardware to fill in
the IOTLB on map i.e. use a no-op .iotlb_sync_map and a .iotlb_sync
that flushes the hardware IOTLB. Also this allows QEMU to emulate the
IOMMU with just map/unmap primitives on vfio/iommufd. Consequently, I
recently found that vfio-pci pass-through works in combination with an
emulated s390 guest on an x86_64 host albeit very slowly of course.

>=20
> > > >   put the corresponding RPCIT flush
> > > > and retry in .sync_map, then allow that to propagate an error back =
to
> > > > iommu_map() if the new mapping still hasn't taken.
> > > >=20
> > > > Thanks,
> > > > Robin.
> > >=20
> > > Hmm, interesting. This would leave the IOVAs in the flush queue lazily
> > > unmapped and thus still block their re-use but free their host
> > > resources via a global RPCIT allowing the guest to use a different
> > > porition of the IOVA space with those resources. It could work, though
> > > I need to test it, but it feels a bit clunky.
> > >=20
> > > Maybe we can go cleaner while using this idea of not having to flush
> > > the queue but just freeing their host side resources. If we allowed
> > > .iotlb_sync_map to return an error that fails the mapping operation,
> > > then we could do it all in there. In the normal case it just does the
> > > RPCIT but if that returns that the hypervisor ran out of resources it
> > > does another global RPCIT allowing the hypervisor to free IOVAs that
> > > were lazily unmapped. If the latter succeeds all is good if not then
> > > the mapping operation failed. Logically it makes sense too,
> > > .iotlb_sync_map is the final step of syncing the mapping to the host
> > > which can fail just like the mapping operation itself.
> > >=20
> > > Apart from the out of active IOVAs case this would also handle the
> > > other useful error case when using .iotlb_sync_map for shadowing where
> > > it fails because the host ran against a pinned pages limit or out of
> > > actual memory. Not by fixing it but at least we would get a failed
> > > mapping operation.
> > >=20
> > > The other callbacks .flush_iotlb_all and .iotlb_sync
> > > could stay the same as they are only used for unmapped pages where we
> > > can't reasonably run out of resources in the host neither active IOVAs
> > > nor pinned pages.
> > >=20
> >=20
> > Ok, I've done some testing with the above idea and this seems to work
> > great. I've verified that my version of QEMU (without Matt's IOVA
> > aperture resrtriction patch) creates the RPCIT out of resource
> > indications and then the global flush in .iotlb_sync_map is triggered
> > and allows QEMU to unpin pages and free IOVAs while the guest still has
> > them lazily unpapeg (sitting in the flush queue) and thus uses
> > different IOVAs.
> >=20
> > @Robin @Joerg, if you are open to changing .iotlb_sync_map such that it
> > can return and error and then failing the mapping operation I think
> > this is a great approach. One advantage over the previous approach of
> > flushing the queue isthat this should work for the pure IOMMU API too.
>=20
> Whatever happens I think allowing .iotlb_sync_map to propagate an error=20
> out through iommu_map() is an appropriate thing to do - it sounds like=20
> s390 might technically need that for regular IOMMU API correctness in=20
> some circumstances anyway. Besides, even in the cases where it=20
> represents "simple" TLB maintenance, there are potentially ways that=20
> could fail (like timing out if the IOMMU has gone completely wrong), so=20
> it wouldn't seem entirely unreasonable if a driver might want to report=20
> overall failure if it can't guarantee that the new mapping will actually=
=20
> be usable.
>=20
> Thanks,
> Robin.
>=20

Great then I'll use this approach for v3 or maybe even sent this
separately as a prerequisite IOMMU fix as yes this is also required for
the IOMMU API to work in a guest where the hypervisor may report
running out of resources.
>=20
