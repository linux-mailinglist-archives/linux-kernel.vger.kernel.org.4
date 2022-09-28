Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CC5ED854
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiI1I6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiI1I6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:58:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689A026AF9;
        Wed, 28 Sep 2022 01:58:45 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S811H4031360;
        Wed, 28 Sep 2022 08:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FsRgbWQXFcfgM8eZUdskc6+blLFC+RSC50HFPlyGQCI=;
 b=PyJDtWr6n0YW3eGZr0tkN+oIV6fxMbKi+6Nzb1Kz3vWJgMCZcvS5uLQCdY8Hf0q0zdP7
 NWwJAPV2bBbhpTFjr2IEEidqxFa6lWx6tSBD2kUudcdvWoUeUw8Ev2HLVEyIcFavKKXu
 qdKK61X5m9lDEhp3cBRrbPgjvm9qfTCQVVntPIYqB1hgtMSupoLFeW1tSmIVIIXDyrJ/
 yuhun3dTbQe7gaMK7GprtENLRlE+New7/Zj/X7+SXad6QWjXH6B00Tq+Bo8ka9dtiLiM
 /pkxusSnnwDFTslUiVfbZvKSTYuJIV+3bDxGABpHuBVaglWL7oAzBVxRF6WgQ/f7N6C0 zQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvg35wmre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:58:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28S8pXwX014398;
        Wed, 28 Sep 2022 08:58:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j4ys9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:58:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28S8wNqN39977534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 08:58:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470E7AE051;
        Wed, 28 Sep 2022 08:58:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D68AE04D;
        Wed, 28 Sep 2022 08:58:22 +0000 (GMT)
Received: from sig-9-145-173-198.de.ibm.com (unknown [9.145.173.198])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Sep 2022 08:58:22 +0000 (GMT)
Message-ID: <a4005a4ae804f852656ff2a6f2f994958b0b02e3.camel@linux.ibm.com>
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
Date:   Wed, 28 Sep 2022 10:58:22 +0200
In-Reply-To: <YzMrSIGMPSgJ94sG@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
         <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
         <YzGtQY+uw4ZzZoSH@nvidia.com>
         <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
         <YzMrSIGMPSgJ94sG@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lx9oSVER93bUljVWUuAzuQXOiWrkDvvN
X-Proofpoint-ORIG-GUID: lx9oSVER93bUljVWUuAzuQXOiWrkDvvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_03,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=675 lowpriorityscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-27 at 13:56 -0300, Jason Gunthorpe wrote:
> On Tue, Sep 27, 2022 at 06:33:48PM +0200, Niklas Schnelle wrote:
>  
> > Not sure what the non-MSI reservation is for? It does seem like x86_64
> > also uses this for quite large ranges.
> 
> There are lots of things that are unsuitable for DMA on x86 platforms,
> unfortunately.. But yeah, I'm not sure either.
> 
> > This is because I'm getting a map request for an IOVA in the reserved
> > region.
> 
> How come? iova_reserve_iommu_regions() reads the reserved regions and
> loads them as reserved into the iovad which should cause
> iommu_dma_alloc_iova() and alloc_iova_fast() to not return values in
> those ranges.
> 
> It all looks like it is supposed to work
> 
> Did something go wrong in the initialization order perhaps?
> 
> Jason

It was of course a classic off-by-one, the table size is a number of
entries but geometry.aperture_end seems to be the largest allowed IOVA.
So we need:

s390_domain->domain.geometry.force_aperture = true;
s390_domain->domain.geometry.aperture_start = 0;
s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;

Otherwise the first IOVA allocated is ZPCI_TABLE_SIZE_RT itself.
Similarly we need the second reserved region if (zdev->end_dma <
ZPCI_TABLE_SIZE_RT - 1). In your patch I think you had the
MAX_DMA_TABLE_ADDR name right but would have also calculated the number
of entries.

On the other hand with the dma-iommu.c conversion it no longer makes
sense to lower zdev->end_dma artificially, so at least on current
machine LPARs we would end up with just a lower reserved region
0x0000000000000000 to 0x00000000ffffffff and can use IOVAs up to
aperture_end.

