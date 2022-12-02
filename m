Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2602764086D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiLBOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLBOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:30:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F670BDB;
        Fri,  2 Dec 2022 06:30:15 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2DCATa023034;
        Fri, 2 Dec 2022 14:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Iy74FY5ttmEd2X6soXLCrl5de+aNjSSbBqLI5MTAwmk=;
 b=LznhoBpqq5x3QgiezNSYxRZ7r9YhCNekkODq6ho8J7UnZtuWx9TKucuvNx9hszpiy4PL
 JQF5gYlrmHwSZ7Nj7C5YfQ7+lzf1Uhr7JAPcV6d7N4t8scEtm71FFzeXP04Mui29Zn3q
 Xb0se+GlNQFX4dyMx2D32FIMcJtpaOhn41GwXXS6CeOCuBClNWVo4ULxUFV8FKrIRN6x
 8ucqr3kZqdy3ghwWFgKV1zu0abWtRzc7Hjp/cg8QQUpg6L3xbJV5822U7C6I81fpSumh
 Iphtw/fjjkz+8lzcgo2zubV6yBQdHiuTsMWAgODhxyD8uHF4wg4IYIhtQZDfvVYaSITT DQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7j1jhwnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 14:29:58 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B2EMhMo003234;
        Fri, 2 Dec 2022 14:29:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3m3ae96rhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 14:29:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B2ETpIY4850326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 14:29:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 565E9AE04D;
        Fri,  2 Dec 2022 14:29:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DA9BAE045;
        Fri,  2 Dec 2022 14:29:50 +0000 (GMT)
Received: from [9.179.19.13] (unknown [9.179.19.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Dec 2022 14:29:50 +0000 (GMT)
Message-ID: <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
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
Date:   Fri, 02 Dec 2022 15:29:50 +0100
In-Reply-To: <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-8-schnelle@linux.ibm.com>
         <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
         <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
         <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
         <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fz6wlvx-xWAfJ7iy46IPudYEzFQRLirM
X-Proofpoint-GUID: fz6wlvx-xWAfJ7iy46IPudYEzFQRLirM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_06,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 15:40 +0100, Niklas Schnelle wrote:
> On Tue, 2022-11-29 at 12:53 +0000, Robin Murphy wrote:
> > On 2022-11-29 12:00, Niklas Schnelle wrote:
> > > On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
> > > > On 2022-11-16 17:16, Niklas Schnelle wrote:
> > > > > When RPCIT indicates that the underlying hypervisor has run out of
> > > > > resources it often means that its IOVA space is exhausted and IOV=
As need
> > > > > to be freed before new ones can be created. By triggering a flush=
 of the
> > > > > IOVA queue we can get the queued IOVAs freed and also get the new
> > > > > mapping established during the global flush.
> > > >=20
> > > > Shouldn't iommu_dma_alloc_iova() already see that the IOVA space is
> > > > exhausted and fail the DMA API call before even getting as far as
> > > > iommu_map(), though? Or is there some less obvious limitation like a
> > > > maximum total number of distinct IOVA regions regardless of size?
> > >=20
> > > Well, yes and no. Your thinking is of course correct if the advertised
> > > available IOVA space can be fully utilized without exhausting
> > > hypervisor resources we won't trigger this case. However sadly there
> > > are complications. The most obvious being that in QEMU/KVM the
> > > restriction of the IOVA space to what QEMU can actually have mapped at
> > > once was just added recently[0] prior to that we would regularly go
> > > through this "I'm out of resources free me some IOVAs" dance with our
> > > existing DMA API implementation where this just triggers an early cyc=
le
> > > of freeing all unused IOVAs followed by a global flush. On z/VM I know
> > > of no situations where this is triggered. That said this signalling is
> > > architected so z/VM may have corner cases where it does this. On our
> > > bare metal hypervisor (no paging) this return code is unused and IOTLB
> > > flushes are simply hardware cache flushes as on bare metal platforms.
> > >=20
> > > [0]
> > > https://lore.kernel.org/qemu-devel/20221028194758.204007-4-mjrosato@l=
inux.ibm.com/
> >=20
> > That sheds a bit more light, thanks, although I'm still not confident I=
=20
> > fully understand the whole setup. AFAICS that patch looks to me like=20
> > it's putting a fixed limit on the size of the usable address space. Tha=
t=20
> > in turn implies that "free some IOVAs and try again" might be a red=20
> > herring and never going to work; for your current implementation, what=
=20
> > that presumably means in reality is "free some IOVAs, resetting the=20
> > allocator to start allocating lower down in the address space where it=
=20
> > will happen to be below that limit, and try again", but the iommu-dma=20
> > allocator won't do that. If it doesn't know that some arbitrary range=20
> > below the top of the driver-advertised aperture is unusable, it will=20
> > just keep allocating IOVAs up there and mappings will always fail.
> >=20
> > If the driver can't accurately represent the usable IOVA space via the=
=20
> > aperture and/or reserved regions, then this whole approach seems doomed=
.=20
> > If on the other hand I've misunderstood and you can actually still use=
=20
> > any address, just not all of them at the same time,
>=20
>=20
> This is exactly it, the problem is a limit on the number of IOVAs that
> are concurrently mapped. In QEMU pass-through the tightest limit is
> usually the one set by the host kernel parameter
> vfio_iommu_type1.dma_entry_limit which defaults to 65535 mappings. With
> IOMMU_DOMAIN_DMA we stay under this limit without extra action but once
> there is a flush queue (including the existing per-CPU one) where each
> entry may keep many pages lazily unmapped this is easly hit with fio
> bandwidth tests on an NVMe. For this case this patch works reliably
> because of course the number of actually active mappings without the
> lazily freed ones is similar to the number of active ones with
> IOMMU_DOMAIN_DMA.
>=20
> >  then it might in=20
> > fact be considerably easier to skip the flush queue mechanism entirely=
=20
> > and implement this internally to the driver - basically make .iotlb_syn=
c=20
> > a no-op for non-strict DMA domains,
>=20
> I'm assuming you mean .iotlb_sync_map above.
>=20
> >  put the corresponding RPCIT flush=20
> > and retry in .sync_map, then allow that to propagate an error back to=20
> > iommu_map() if the new mapping still hasn't taken.
> >=20
> > Thanks,
> > Robin.
>=20
> Hmm, interesting. This would leave the IOVAs in the flush queue lazily
> unmapped and thus still block their re-use but free their host
> resources via a global RPCIT allowing the guest to use a different
> porition of the IOVA space with those resources. It could work, though
> I need to test it, but it feels a bit clunky.
>=20
> Maybe we can go cleaner while using this idea of not having to flush
> the queue but just freeing their host side resources. If we allowed
> .iotlb_sync_map to return an error that fails the mapping operation,
> then we could do it all in there. In the normal case it just does the
> RPCIT but if that returns that the hypervisor ran out of resources it
> does another global RPCIT allowing the hypervisor to free IOVAs that
> were lazily unmapped. If the latter succeeds all is good if not then
> the mapping operation failed. Logically it makes sense too,
> .iotlb_sync_map is the final step of syncing the mapping to the host
> which can fail just like the mapping operation itself.
>=20
> Apart from the out of active IOVAs case this would also handle the
> other useful error case when using .iotlb_sync_map for shadowing where
> it fails because the host ran against a pinned pages limit or out of
> actual memory. Not by fixing it but at least we would get a failed
> mapping operation.
>=20
> The other callbacks .flush_iotlb_all and .iotlb_sync
> could stay the same as they are only used for unmapped pages where we
> can't reasonably run out of resources in the host neither active IOVAs
> nor pinned pages.
>=20

Ok, I've done some testing with the above idea and this seems to work
great. I've verified that my version of QEMU (without Matt's IOVA
aperture resrtriction patch) creates the RPCIT out of resource
indications and then the global flush in .iotlb_sync_map is triggered
and allows QEMU to unpin pages and free IOVAs while the guest still has
them lazily unpapeg (sitting in the flush queue) and thus uses
different IOVAs.

@Robin @Joerg, if you are open to changing .iotlb_sync_map such that it
can return and error and then failing the mapping operation I think
this is a great approach. One advantage over the previous approach of
flushing the queue isthat this should work for the pure IOMMU API too.

If you don't want to change the signature of .iotlb_sync_map I think we
can do Robin's idea and have .iotlb_sync_map as a no-op and do the
RPCIT sync as part of the s390_iommu_map_pages(). This would hide what
really is our variant of .iotlb_sync_map in the mapping code though
which I don't super like. Besides that it would also cause more RPCITs
in __iommu_map_sg() as we could no longer use a single RPCIT for the
entire range.

Thanks,
Niklas
