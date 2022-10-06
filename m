Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCE5F656A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJFLxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJFLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437697D7B;
        Thu,  6 Oct 2022 04:53:09 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296A2UCj021015;
        Thu, 6 Oct 2022 11:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FFMyAF2ih0yrDKtSHNIrvOYSUF3xXFKUqMWiKlqB7Hs=;
 b=IDZLNK+Gbm/UyNbnmn2C1rGKrearmPvbOBIvS8THySYcUipfriOF/5Fk/pbvZcLpwMzu
 Sjv6OpuRvab2/YTR5panlYOQ2l1b85EJNG84J9Z8Q4inzIwSXUzERlJM9OWSy//7N25d
 JGdSkxGoIfLlfpWEJru00JFLgFtm7AVCVjeRaaVGcMamQTToM+cBImYQbIO27HRRUNOn
 Z3ukABOdT2+66lm+kzUZM8B9/uVUMiYjLGswjoF4ynayZACjYa3pGH0nftsj+b/pd9ek
 vbApWK8xyi5HqJkOI1jGNHpT4X9kcI2e9C9JoJmMZpRa5U70IOR0RZhlpBwJJG9dpt4K fQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1u9xx3qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:52:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296BqBbd007767;
        Thu, 6 Oct 2022 11:52:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd696yp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:52:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296Bqj7S61604158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 11:52:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5942B42042;
        Thu,  6 Oct 2022 11:52:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 952B04203F;
        Thu,  6 Oct 2022 11:52:44 +0000 (GMT)
Received: from sig-9-145-19-232.uk.ibm.com (unknown [9.145.19.232])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 11:52:44 +0000 (GMT)
Message-ID: <8c01ad419e91c0ce06bec8700d960c57f1a7c436.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Thu, 06 Oct 2022 13:52:44 +0200
In-Reply-To: <Yz1vF7B0FLvLVvE0@nvidia.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
         <20221004120706.2957492-2-schnelle@linux.ibm.com>
         <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
         <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
         <Yz1vF7B0FLvLVvE0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TguLCkZriMIoccLABPqGNsntuQ8vnyKF
X-Proofpoint-ORIG-GUID: TguLCkZriMIoccLABPqGNsntuQ8vnyKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=766 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-05 at 08:48 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 05, 2022 at 09:58:58AM +0200, Niklas Schnelle wrote:
> 
> > A failed aperture test leaving the IOAT registered would indeed be bad.
> > I guess I focused too much on the failure scenarios at the state after
> > these patches where this can't happen. I think this would leave us in a
> > bad state because zpci_register_ioat() succeeded with the domain's DMA
> > table but we won't have attached leading to the wrong decisions in
> > recovery paths (see below).
> 
> Domain attach should either completely move to the new domain and
> succeed, or it should leave everything as is and fail.
> 
> So it looks OK to me.
> 
> > Recovery (via zpci_hot_reset_device()) should then be able to deal with
> > these situations as long as zdev->dma_table matches the IOAT
> > registration state.
> 
> If you are doing reset the s390 driver should keep track of what
> domain is supposed to be attached and fix it when the reset is
> completed. In this case it should not fail attach here for the
> mandatory success domain types.

Our reset/recovery code won't do a detach/attach, it directly re-
establishes the DMA table that was previously in use with firmware. If
that fails the reset fails and one will have to "power cyle"* the
device.

Also automatic recovery is blocked while the IOMMU API is in use.
Though "echo 1 > /sys/bus/pci/../reset" is available and does re-
register the DMA table if the device was in an error state.

> 
> The core code does not reasonably handle failures from this routine,
> it must be avoided if you want it to be robust.
> 
> Jason

Makes sense. I see the following failure cases:

1. After patch 3 failure in the aperture check leaves
   everything as it is. Before that my proposal would
   leave it with DMA blocked and no domain attached
   so it will need to be "power cycled"*.

2. If zpci_register_ioat() fails the device is left detached
   from all domains. This however only happens in one of two cases:

   2a. The device was surprise unplugged. This seems fine as
       we tear things down and the calling code just needs to
       back off which from what I can see it does.
   2b. The device has entered an error state.

In case 2b the device is going to need recovery and will not be usable
until that succeeded (DMA and MMIO access is blocked). In automatic
recovery if zdev->dma_table == NULL the device will re-initialized for
use with the DMA API while if the IOMMU API is in use we currently
don't attempt recovery and the user needs to "power cycle"* the device
manually. The "re-initalized for DMA API" part of course doesn't work
for the upcoming DMA API conversion.

One option I see would be to ignore the error return from
zpci_register_ioat() if it indicates case 2b. Then we would still add
the device to the IOMMU's devices list and return success despite
knowing that the device is inaccessible (DMA and MMIO blocked).

Then the recovery/reset code will register the new domain once the
device comes out of the error state. At least from an IOMMU API point
of view that would make the attachment always succeed for all
zpci_register_ioat() error cases that aren't programming bugs and can
conceivably be recovered from.

If you agree I would propose adding this as a robustness improvement as
part of my upcoming series of IOMMU improvements needed for the DMA API
conversion. As stated above before the DMA API conversion any error
that would cause zpci_register_ioat() to fail while the IOMMU API is
being used will need a "power cycle" anyway so postponing this doesn't
hurt.

* I say "power cycle" but this isn't usually a real power cycle rather
an architecture specific low level disabled/enable but from Linux
driver point of view the device is completely unplugged and re-plugged.

Niklas

