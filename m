Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C169A77B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBQIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBQIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:52:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D44233;
        Fri, 17 Feb 2023 00:52:19 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H63Dbw015429;
        Fri, 17 Feb 2023 08:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nsaYQXNgH2rVl32gKAfvOrfr7P7WiyR42lIu9o5373E=;
 b=b2AwyBFJV600sYEpnQwajdxXzOcv/tBy5593N3YYNMtb+feT3PdBF6EIgmAhzCe6RMO7
 KuO88jM547LgUBzcojhiYcVIqL9Gbu0Mi3K0PyDURD+w7y2CiSYBU8q4Vv0FRLRqa+ga
 xnXHaw/c40GnQwXKZcOnMPiwLu/oZ8aQXU2NwSZbEx5dC3n+Rf6AqosMuG9Rx0b23bwS
 btFFSmE/SF9aFW62s0ZjfFjMircgAhNIU4zvZi84Cpr8TYTHxUourdSNS3hpW++OL5f2
 ExMv/xObmBnNqMS0VqZ0/MO274UfHZ8iToi8giF+OaYX8axAugsnxSYM5gjgq7lBJQf4 DA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt15wpvmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:51:57 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GJkaWd006567;
        Fri, 17 Feb 2023 08:51:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n6dqsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:51:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31H8ppaE23855704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 08:51:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D6120043;
        Fri, 17 Feb 2023 08:51:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA90320040;
        Fri, 17 Feb 2023 08:51:50 +0000 (GMT)
Received: from [9.171.12.102] (unknown [9.171.12.102])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 08:51:50 +0000 (GMT)
Message-ID: <59a61553a81282fed88c03af096b2a0830b94302.camel@linux.ibm.com>
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
Date:   Fri, 17 Feb 2023 09:51:50 +0100
In-Reply-To: <4ad0d2b9-2465-b42d-c0f9-b48caadfd72c@linux.ibm.com>
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
         <20230215120327.947336-5-schnelle@linux.ibm.com>
         <4ad0d2b9-2465-b42d-c0f9-b48caadfd72c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w3KPuegSdxg3SnnJVL_x_u3UmxgLOgZz
X-Proofpoint-GUID: w3KPuegSdxg3SnnJVL_x_u3UmxgLOgZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=502 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-15 at 13:00 -0500, Matthew Rosato wrote:
> On 2/15/23 7:03 AM, Niklas Schnelle wrote:
> > While s390 already has a standard IOMMU driver and previous changes hav=
e
> > added I/O TLB flushing operations this driver is currently only used fo=
r
> > user-space PCI access such as vfio-pci. For the DMA API s390 instead
> > utilizes its own implementation in arch/s390/pci/pci_dma.c which drives
> > the same hardware and shares some code but requires a complex and
> > fragile hand over between DMA API and IOMMU API use of a device and
> > despite code sharing still leads to significant duplication and
> > maintenance effort. Let's utilize the common code DMAP API
> > implementation from drivers/iommu/dma-iommu.c instead allowing us to
> > get rid of arch/s390/pci/pci_dma.c.
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
>=20
> FYI, this patch doesn't fit on top of iommu-next, I'd guess at least due =
to baolu's 'Retire detach_dev callback' series, which removed .detach_dev a=
nd added .set_platform_dma_ops for s390-iommu.  That's relevant here, becau=
se now that this patch enables dma-iommu for s390 and removes the platform =
DMA ops it must now remove .set_platform_dma_ops/s390_iommu_set_platform_dm=
a for s390-iommu.
>=20
> Matt


Ok, yes this series is currently against v6.2-rc8. Should I rebase
against iommu-next and send a v7 before further review or after?

Thanks,
Niklas
