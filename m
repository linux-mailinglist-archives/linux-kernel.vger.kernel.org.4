Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E866B5EEF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiI2HsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiI2HsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:48:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF10139420;
        Thu, 29 Sep 2022 00:48:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T6SCCX032006;
        Thu, 29 Sep 2022 07:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=btqDUm0A3nwkG7m7OTMktqDeDAQjJKjm/ptN0wh19KA=;
 b=WyR18t/HRWbcJwXKmcVUHBWS6FEz1jHgxx5Kp8Oa+oJeeu1put7Qpbq6G3U6kWLFeac8
 3cvw/ZRBppUnWpTxbqfSy2WXtzzL52Z3vA21ibWdgz/kT4xN88LeGfk0ffp72RyRQQ9i
 vrNO3ypYDqLcFk39exi/U3069El4RB3VmYeV9fQanhM46Zb0R4tLTi/npqDZmqP7IBC8
 KO6pkMrDpeEb2Wv6qOyfd3/Pff590fa4m9GJq9dLft2XK1jsaLwqig9FS+TDiubE8KD7
 VShQtPB91eMFoEzS38RWI0Xil+qeTZj3MAV9N1ZbqmBrEp+6N2P6a12Bcizy4JSx/O4X cw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw64bj4u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 07:47:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28T7ZNj6017898;
        Thu, 29 Sep 2022 07:47:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8vqwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 07:47:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28T7lahD27722490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 07:47:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18EA2A405C;
        Thu, 29 Sep 2022 07:47:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AC3A4054;
        Thu, 29 Sep 2022 07:47:35 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 07:47:35 +0000 (GMT)
Message-ID: <a10424adbe01a0fd40372cbd0736d11e517951a1.camel@linux.ibm.com>
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
Date:   Thu, 29 Sep 2022 09:47:35 +0200
In-Reply-To: <YzRM5HG0t36KUAVC@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
         <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
         <YzGtQY+uw4ZzZoSH@nvidia.com>
         <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
         <YzMrSIGMPSgJ94sG@nvidia.com>
         <a4005a4ae804f852656ff2a6f2f994958b0b02e3.camel@linux.ibm.com>
         <YzRM5HG0t36KUAVC@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qLBEJvrW6Rj8AkdAI2LT-Ja8D_Km9d5s
X-Proofpoint-GUID: qLBEJvrW6Rj8AkdAI2LT-Ja8D_Km9d5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=723 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 10:32 -0300, Jason Gunthorpe wrote:
> On Wed, Sep 28, 2022 at 10:58:22AM +0200, Niklas Schnelle wrote:
> > On Tue, 2022-09-27 at 13:56 -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 27, 2022 at 06:33:48PM +0200, Niklas Schnelle wrote:
> > >  
> > > > Not sure what the non-MSI reservation is for? It does seem like x86_64
> > > > also uses this for quite large ranges.
> > > 
> > > There are lots of things that are unsuitable for DMA on x86 platforms,
> > > unfortunately.. But yeah, I'm not sure either.
> > > 
> > > > This is because I'm getting a map request for an IOVA in the reserved
> > > > region.
> > > 
> > > How come? iova_reserve_iommu_regions() reads the reserved regions and
> > > loads them as reserved into the iovad which should cause
> > > iommu_dma_alloc_iova() and alloc_iova_fast() to not return values in
> > > those ranges.
> > > 
> > > It all looks like it is supposed to work
> > > 
> > > Did something go wrong in the initialization order perhaps?
> > > 
> > > Jason
> > 
> > It was of course a classic off-by-one, the table size is a number of
> > entries but geometry.aperture_end seems to be the largest allowed IOVA.
> > So we need:
> 
> Right, I dislike this naming usually 'end' means "start + length" and
> 'last' means "start + length - 1"
> 
> > Otherwise the first IOVA allocated is ZPCI_TABLE_SIZE_RT itself.
> > Similarly we need the second reserved region if (zdev->end_dma <
> > ZPCI_TABLE_SIZE_RT - 1). In your patch I think you had the
> > MAX_DMA_TABLE_ADDR name right but would have also calculated the number
> > of entries.
> 
> Make sense..
> 
> > On the other hand with the dma-iommu.c conversion it no longer makes
> > sense to lower zdev->end_dma artificially, so at least on current
> > machine LPARs we would end up with just a lower reserved region
> > 0x0000000000000000 to 0x00000000ffffffff and can use IOVAs up to
> > aperture_end.
> 
> So zdev->end_dma == MAX_DMA_TABLE_ADDR?
> 
> (and is zdev->end_dma and 'end' or 'last' ?)

Basically yes though at least on LPARs the firmware interface that
gives us the initial zdev->end returns an even higher value but we
clamp it down to the aperture. It is "start + length - 1".

> 
> Can you include this patch once you are happy with it, it nicely
> tidies this series?
> 
> Thanks,
> Jason 

Yes will do. In the meantime I'm now close to sending an RFC version of
the conversion to dma-iommu. So my plan is to send out 3 series of
patches.

1. v3 of this series of IOMMU fixes including your suggestion to use
reserved ranges, the previously mentioned off-by-one fix and another
IOMMU issue I found (pgsize_bitmap is wrong).

2. A series of improvements to the s390 IOMMU code including
implementing map_pages() and lock-free page table updates

3. A series converting s390 to use dma-iommu plus changes against dma-
iommu.c common code to implement an alternative flushing scheme that
brings z/VM and KVM guest PCI performance back to the level of our
existing DMA API implementation.

