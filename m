Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551069B107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBQQfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:35:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73A212D;
        Fri, 17 Feb 2023 08:35:00 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HEXGjC015815;
        Fri, 17 Feb 2023 16:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WVmDyqoL2x31lTLvSI3i5tHZv8yFdzS5hZPtnpVo3Zc=;
 b=MoV7OZ5kamYco6O5h4/qOsqB7eTGz+GE7W36xQmJ9vuhdkowzqHA2UskcstDsMTdKWDj
 FbIbk/vg0ip/fB17jcs0IQO3pltm66xOKMCF1EuOXTxjVmEA3IwahTmH4z9be9hBAZkw
 6ktNinu5oUlw+OyWgFAYlxfG0IC1CnFqf1BJJPLkeWU7zo6gUARVke59uN5nUCIOfokQ
 ZjScrj3tee/3/mTYaqNiuOlm47i5WSHoG2YeBBq++te90jKU3wxIEINCQ0PFq6TF+Zrw
 YjszKTdl3o46GDBwkb2gcuWoo+N/fNog/fR30tYnH+2lAXf7j/DO6dDESH/N1vitidLi Ig== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntbesjytd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 16:34:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HBfXbw017758;
        Fri, 17 Feb 2023 16:34:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6r8pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 16:34:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HGYiAM43712812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 16:34:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C093220043;
        Fri, 17 Feb 2023 16:34:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 858C02004D;
        Fri, 17 Feb 2023 16:34:43 +0000 (GMT)
Received: from [9.171.12.102] (unknown [9.171.12.102])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 16:34:43 +0000 (GMT)
Message-ID: <d8656a67a875b72dfdf5826ec4ff7154022f1ef6.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] s390/pci: Use dma-iommu layer
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Fri, 17 Feb 2023 17:34:43 +0100
In-Reply-To: <7dc31552-1b7a-aeaa-eb88-a60d96e28f3c@linux.ibm.com>
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
         <20230215120327.947336-5-schnelle@linux.ibm.com>
         <4ad0d2b9-2465-b42d-c0f9-b48caadfd72c@linux.ibm.com>
         <59a61553a81282fed88c03af096b2a0830b94302.camel@linux.ibm.com>
         <7dc31552-1b7a-aeaa-eb88-a60d96e28f3c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 99dDQd0MGujpakVqZ3QqVbzPDiNxRP6c
X-Proofpoint-ORIG-GUID: 99dDQd0MGujpakVqZ3QqVbzPDiNxRP6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=581 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 09:56 -0500, Matthew Rosato wrote:
> On 2/17/23 3:51 AM, Niklas Schnelle wrote:
> > On Wed, 2023-02-15 at 13:00 -0500, Matthew Rosato wrote:
> > > On 2/15/23 7:03 AM, Niklas Schnelle wrote:
> > > > While s390 already has a standard IOMMU driver and previous changes=
 have
> > > > added I/O TLB flushing operations this driver is currently only use=
d for
> > > > user-space PCI access such as vfio-pci. For the DMA API s390 instea=
d
> > > > utilizes its own implementation in arch/s390/pci/pci_dma.c which dr=
ives
> > > > the same hardware and shares some code but requires a complex and
> > > > fragile hand over between DMA API and IOMMU API use of a device and
> > > > despite code sharing still leads to significant duplication and
> > > > maintenance effort. Let's utilize the common code DMAP API
> > > > implementation from drivers/iommu/dma-iommu.c instead allowing us t=
o
> > > > get rid of arch/s390/pci/pci_dma.c.
> > > >=20
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > >=20
> > > FYI, this patch doesn't fit on top of iommu-next, I'd guess at least =
due to baolu's 'Retire detach_dev callback' series, which removed .detach_d=
ev and added .set_platform_dma_ops for s390-iommu.  That's relevant here, b=
ecause now that this patch enables dma-iommu for s390 and removes the platf=
orm DMA ops it must now remove .set_platform_dma_ops/s390_iommu_set_platfor=
m_dma for s390-iommu.
> > >=20
> > > Matt
> >=20
> >=20
> > Ok, yes this series is currently against v6.2-rc8. Should I rebase
> > against iommu-next and send a v7 before further review or after?
> >=20
>=20
> So, overall I'm fine with the code in this patch (and this series) at thi=
s point; however I'd like to do one more pass of testing rebased on top of =
iommu-next / with the set_platform_dma collision handled, so I'm going to h=
old off on tagging my review of this one until v7.  That really only impact=
s this patch so if you want to give others a chance to review the rest of t=
he series before rolling out v7 that's OK by me. =20
>=20
> Thanks,
> Matt


Ok, I've got a version on top of iommu-next running locally and will
send that as v7 next week. Thankfully the conflict resolution is pretty
simple. We get rid of set_platform_dma() completely and the detach is
only used internally when attaching to a different domain. Also got rid
of a missed superfluous zdev->dma_table assignment that I missed as
feedback.

Thanks,
Niklas
