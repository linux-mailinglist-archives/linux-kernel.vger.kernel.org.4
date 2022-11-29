Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44263C2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiK2Okz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiK2Okv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:40:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BAF3E0A7;
        Tue, 29 Nov 2022 06:40:49 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATEQY7l022494;
        Tue, 29 Nov 2022 14:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HOkQWb+x8UPCLOglKlyE8rK38gqJM8ateEUvob46HOU=;
 b=b7olsfNv0rBGNU/p1yLqJCBLInNlIus3PShYz5vviSYohWJOEwYfvZscN6YRdmGwmTof
 zD643HRcOHLozLH7UDlNsbf5iZIch6l+XiyHfjqQXTeLOhyHB2sDw0zoeJ6Ukl5DvuuR
 bTOTf2E7vw2S76JJEcGMV+/bofpyXyguYU4SPpj8KNRtokky0WOOux6W+jPc9BDJwvIP
 yxuI3ScmP2/LOPZMVolx8zHuqOXxD2glKCb/1JtqCXQpo1o9F71r7wPcwMpioDiw5j3n
 DYPkRVMSPa9pBpecsWHzFVfVtU2yWCWYK4GvmCbdd4re/GpMShZfJACoIH6cj65JGNbR VA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5kb2hjg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:40:30 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATE5kaY021312;
        Tue, 29 Nov 2022 14:40:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9c6my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:40:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATEXvrT2556530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 14:33:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50AF25204F;
        Tue, 29 Nov 2022 14:40:25 +0000 (GMT)
Received: from sig-9-145-33-31.uk.ibm.com (unknown [9.145.33.31])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 871A952052;
        Tue, 29 Nov 2022 14:40:24 +0000 (GMT)
Message-ID: <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
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
Date:   Tue, 29 Nov 2022 15:40:24 +0100
In-Reply-To: <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-8-schnelle@linux.ibm.com>
         <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
         <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
         <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HE3cpPACOYufXFHDz55fKArkTp730kuB
X-Proofpoint-ORIG-GUID: HE3cpPACOYufXFHDz55fKArkTp730kuB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 12:53 +0000, Robin Murphy wrote:
> On 2022-11-29 12:00, Niklas Schnelle wrote:
> > On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
> > > On 2022-11-16 17:16, Niklas Schnelle wrote:
> > > > When RPCIT indicates that the underlying hypervisor has run out of
> > > > resources it often means that its IOVA space is exhausted and IOVAs need
> > > > to be freed before new ones can be created. By triggering a flush of the
> > > > IOVA queue we can get the queued IOVAs freed and also get the new
> > > > mapping established during the global flush.
> > > 
> > > Shouldn't iommu_dma_alloc_iova() already see that the IOVA space is
> > > exhausted and fail the DMA API call before even getting as far as
> > > iommu_map(), though? Or is there some less obvious limitation like a
> > > maximum total number of distinct IOVA regions regardless of size?
> > 
> > Well, yes and no. Your thinking is of course correct if the advertised
> > available IOVA space can be fully utilized without exhausting
> > hypervisor resources we won't trigger this case. However sadly there
> > are complications. The most obvious being that in QEMU/KVM the
> > restriction of the IOVA space to what QEMU can actually have mapped at
> > once was just added recently[0] prior to that we would regularly go
> > through this "I'm out of resources free me some IOVAs" dance with our
> > existing DMA API implementation where this just triggers an early cycle
> > of freeing all unused IOVAs followed by a global flush. On z/VM I know
> > of no situations where this is triggered. That said this signalling is
> > architected so z/VM may have corner cases where it does this. On our
> > bare metal hypervisor (no paging) this return code is unused and IOTLB
> > flushes are simply hardware cache flushes as on bare metal platforms.
> > 
> > [0]
> > https://lore.kernel.org/qemu-devel/20221028194758.204007-4-mjrosato@linux.ibm.com/
> 
> That sheds a bit more light, thanks, although I'm still not confident I 
> fully understand the whole setup. AFAICS that patch looks to me like 
> it's putting a fixed limit on the size of the usable address space. That 
> in turn implies that "free some IOVAs and try again" might be a red 
> herring and never going to work; for your current implementation, what 
> that presumably means in reality is "free some IOVAs, resetting the 
> allocator to start allocating lower down in the address space where it 
> will happen to be below that limit, and try again", but the iommu-dma 
> allocator won't do that. If it doesn't know that some arbitrary range 
> below the top of the driver-advertised aperture is unusable, it will 
> just keep allocating IOVAs up there and mappings will always fail.
> 
> If the driver can't accurately represent the usable IOVA space via the 
> aperture and/or reserved regions, then this whole approach seems doomed. 
> If on the other hand I've misunderstood and you can actually still use 
> any address, just not all of them at the same time,


This is exactly it, the problem is a limit on the number of IOVAs that
are concurrently mapped. In QEMU pass-through the tightest limit is
usually the one set by the host kernel parameter
vfio_iommu_type1.dma_entry_limit which defaults to 65535 mappings. With
IOMMU_DOMAIN_DMA we stay under this limit without extra action but once
there is a flush queue (including the existing per-CPU one) where each
entry may keep many pages lazily unmapped this is easly hit with fio
bandwidth tests on an NVMe. For this case this patch works reliably
because of course the number of actually active mappings without the
lazily freed ones is similar to the number of active ones with
IOMMU_DOMAIN_DMA.

>  then it might in 
> fact be considerably easier to skip the flush queue mechanism entirely 
> and implement this internally to the driver - basically make .iotlb_sync 
> a no-op for non-strict DMA domains,

I'm assuming you mean .iotlb_sync_map above.

>  put the corresponding RPCIT flush 
> and retry in .sync_map, then allow that to propagate an error back to 
> iommu_map() if the new mapping still hasn't taken.
> 
> Thanks,
> Robin.

Hmm, interesting. This would leave the IOVAs in the flush queue lazily
unmapped and thus still block their re-use but free their host
resources via a global RPCIT allowing the guest to use a different
porition of the IOVA space with those resources. It could work, though
I need to test it, but it feels a bit clunky.

Maybe we can go cleaner while using this idea of not having to flush
the queue but just freeing their host side resources. If we allowed
.iotlb_sync_map to return an error that fails the mapping operation,
then we could do it all in there. In the normal case it just does the
RPCIT but if that returns that the hypervisor ran out of resources it
does another global RPCIT allowing the hypervisor to free IOVAs that
were lazily unmapped. If the latter succeeds all is good if not then
the mapping operation failed. Logically it makes sense too,
.iotlb_sync_map is the final step of syncing the mapping to the host
which can fail just like the mapping operation itself.

Apart from the out of active IOVAs case this would also handle the
other useful error case when using .iotlb_sync_map for shadowing where
it fails because the host ran against a pinned pages limit or out of
actual memory. Not by fixing it but at least we would get a failed
mapping operation.

The other callbacks .flush_iotlb_all and .iotlb_sync
could stay the same as they are only used for unmapped pages where we
can't reasonably run out of resources in the host neither active IOVAs
nor pinned pages.


