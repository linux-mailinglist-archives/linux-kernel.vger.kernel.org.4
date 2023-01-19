Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7AA673EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjASQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjASQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:34:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0E273E;
        Thu, 19 Jan 2023 08:34:01 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG75kV030492;
        Thu, 19 Jan 2023 16:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gpBeZaKJVwURhx4wdQwWJGpYDQ3EKm5zWBTAAcoaczw=;
 b=XikSSdojukO+2TdXfcwv1yaBtAeTpzcl+zOPnyDG6vuOCQUtm9uGx4dFTA/vERPZrOD/
 Ie02vmMg8/Z2SUhxvE2YVWuV2qR8RNr/yssLeXa/TxONZdODCz+OJXQX0kIJv7atz49T
 PgwNLP9U3z8gE01T0L/YipW0klLqlyX6NLWzjGEwOyr63NoAqLSme+nPH7/3cWhFDuTF
 rKlfOqlAzLTxKkGu26V4+I4NtZl9SJf7hS+YCRFvDqoznR5d7U2wENhoEXkUNcBkALy2
 vVfYOSxHqHL+cs9Oq1A2L2oweziyRcpMEXDjlLP0dwKvZgwb2cbIMHe3k5MvpgtoheBS Ig== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78rwsf03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:33:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J0KLfg025743;
        Thu, 19 Jan 2023 16:33:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n3m16d2f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:33:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JGXi3K42467652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 16:33:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAF872004D;
        Thu, 19 Jan 2023 16:33:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E6620040;
        Thu, 19 Jan 2023 16:33:43 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 16:33:43 +0000 (GMT)
Message-ID: <69047c319c6cb2afd7331daeb7fc8459fdd34f80.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] s390/pci: Use dma-iommu layer
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
Date:   Thu, 19 Jan 2023 17:33:43 +0100
In-Reply-To: <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-5-schnelle@linux.ibm.com>
         <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YZOWeBdINlbx0f3T2Q9RjIaVgPDSFmo7
X-Proofpoint-ORIG-GUID: YZOWeBdINlbx0f3T2Q9RjIaVgPDSFmo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=726 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 10:09 -0500, Matthew Rosato wrote:
> On 1/4/23 7:05 AM, Niklas Schnelle wrote:
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
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index ef38b1514c77..6b0fe8761509 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -124,7 +124,11 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 d=
maas,
> > =20
> >  	WARN_ON_ONCE(iota & 0x3fff);
> >  	fib.pba =3D base;
> > -	fib.pal =3D limit;
> > +	/* Work around off by one in ISM virt device */
> > +	if (zdev->pft =3D=3D 0x5 && limit > base)
>=20
> Nit: maybe a named #define for the ISM pft rather than hard-coding 0x5 he=
re
>=20

Hmm, I agree in principle but not sure where to put this #define. Maybe
also important to mention that the off-by-one has actually been fixed
in current firmware but of course we still have to support broken
devices and the workaround still works with fixed ISM.
