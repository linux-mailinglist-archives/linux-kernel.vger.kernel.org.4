Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368B5EC96E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiI0Q0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiI0QZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C608048F;
        Tue, 27 Sep 2022 09:25:18 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RG6b6E014364;
        Tue, 27 Sep 2022 16:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2Jf4cLHEJz6cP+3bclMk1SyEciUpTiMBLFI+t+FRu3A=;
 b=BEMAdIn4CvdeIlQ51j9FFuykwhyrmpJNLumOU4/TQcUAAgZLCTAtw1waGXbedmNO8osy
 5AtQ4PMfhv7avp5cMc9yLyZUJe3gDskJkqvVA1H1DtiBs9z3u5Q1wnOFKO9nnCSwKMQ8
 aaDQ90322yTA/N3E475qchI+6opcNvqMnecEF0p6nBWGJ5xh5oGNnzarH3XD3xlYZ/N9
 PxQsCFZqmQ2Hd0z6GSPUrlHyEOKcdy3uIyZRT4ziXRT50NmWF9bRr31To3HgqsePmxgk
 smJ1BoWSv7Nbc3olU52w+erOnYSGTUTIT5fB5vKS1wrsEzzVuQ7zc3PfJ2nx9ebi91G7 rQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jv21567uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:25:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28RGJdHb022554;
        Tue, 27 Sep 2022 16:24:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9c33p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:24:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28RGOtZk34341520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 16:24:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A69A34C044;
        Tue, 27 Sep 2022 16:24:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 322964C046;
        Tue, 27 Sep 2022 16:24:55 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 16:24:55 +0000 (GMT)
Message-ID: <07d5527984912ef4c9174fad038ae951a79fd4dc.camel@linux.ibm.com>
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
Date:   Tue, 27 Sep 2022 18:24:54 +0200
In-Reply-To: <YzGuc7jVSvE2g91T@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-2-schnelle@linux.ibm.com>
         <YyxyMtKXyvgHt3Kp@nvidia.com>
         <b581d4f575b834831f8c17054f73b5b92a891d25.camel@linux.ibm.com>
         <YzGuc7jVSvE2g91T@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TnNKiZA_UasRIyZnaoA8DYpMofmm0q0x
X-Proofpoint-ORIG-GUID: TnNKiZA_UasRIyZnaoA8DYpMofmm0q0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_07,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 10:51 -0300, Jason Gunthorpe wrote:
> On Mon, Sep 26, 2022 at 03:29:49PM +0200, Niklas Schnelle wrote:
> > I did miss a problem in my initial answer. While zpci_register_ioat()
> > is indeed the actual "attach" operation, it assumes that at that point
> > no DMA address translations are registered. In that state DMA is
> > blocked of course. With that zpci_register_ioat() needs to come after
> > the zpci_unregister_ioat() that is part of __s390_iommu_detach_device()
> > and zpci_dma_exit_device(). If we do call those though we fundamentally
> > need to restore the previous domain / DMA API state on any subsequent
> > failure. If we don't restore we would leave the device detached from
> > any domain with DMA blocked. I wonder if this could be an acceptable
> > failure state though? It's safe as no DMA is possible and we could get
> > out of it with a successful attach.
> 
> Is this because of that FW call it does?
> 
> It seems like an FW API misdesign to not allow an unfailable change of
> translation, if the FW forces an unregister first then there are
> always error cases you can't correctly recover from.
> 
> IMHO if the FW fails an attach you are just busted, there is no reason
> to think it would suddenly accept attaching the old domain just
> because it has a different physical address, right?

While I can't come up with a case where an immediate retry would
actually help, there is at least one error case that one should be able
to recover from. The attach can fail if a firmware driven PCI device
recovery is in progress. Now if that happens during a switch between
domains I think one will have to do the equivalent of 

   echo 0 > /sys/bus/pci/slots/<dev>/power; echo 1 > /.../power

That of course tears down the whole PCI device so we don't have to
answer the question if the old or new domain is the active one.

So I think in the consequences you're still right, attempting to re-
attach is a lot of hassle for little or no gain.

> 
> So make it simple, leave it DMA blocked and throw a WARN_ON..

To me a WARN_ON() isn't appropriate here, as stated above there is at
least one error case that is recoverable and doesn't necessarily
indicate a progamming bug. Also while not recoverable the device having
been surprise unplugged is another case where the attach failing is not
necessarily a bug. It would also thus cause false panics for e.g. CI
systems with PANIC_ON_WARN.

That said yes I think leaving DMA blocked and the device detached from
any domain is reasonable. That way the above recover scenario will work
and the device is in a defined and isolated state. Maybe in the future
we could even make this explicit and attach to the blocking domain on
failed attach, does that make sense?

