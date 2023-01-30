Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89656815B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjA3P6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjA3P6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:58:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF61287E;
        Mon, 30 Jan 2023 07:58:17 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UFuUHN016154;
        Mon, 30 Jan 2023 15:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DzCFf31liEnJkW9Xw8x3a1M1MvPxqDhF5FHxXmHBWpE=;
 b=USFQUQk+5TxxWb0dtdgZeXTcTdPvO3qMfO7DdcTBfLEzdn8KzE5utbLmaEuCha77mpm3
 aFu7U1TJF7Taya3bWnC2PxKflHHrxamx7BuAlSA3QEQzbWRbsUMJtoJOr2epsu+ukeub
 1rq2L6EZsxM5r0OWqHHprVEVZDs/qoUlKuuyDZDh89tBECSFprrzpGpmJXNv2cLhC1U8
 xezYoZp1LYV4npyEDKub2R1M2A33ba0TBHkYw1mC9U1o/ltIFVlVYGLno9rZeluFgDqr
 nFwBoBeR+WtuQ/zg7Kapii46tkPiPZPenSNJtOPP/eP3W9+Dp2vZhApIia1Ozjlos2g5 lg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nebxf0gjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:58:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U5KK5Z012873;
        Mon, 30 Jan 2023 15:58:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtyaefc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:58:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UFvwtI16319196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 15:57:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD722004B;
        Mon, 30 Jan 2023 15:57:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3654920040;
        Mon, 30 Jan 2023 15:57:57 +0000 (GMT)
Received: from [9.171.38.212] (unknown [9.171.38.212])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 15:57:57 +0000 (GMT)
Message-ID: <8209c172aaa415eace9dcd4b5675ef8506a34538.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Mon, 30 Jan 2023 16:57:56 +0100
In-Reply-To: <Y9ficPosWtGqbDit@nvidia.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
         <20230124125037.3201345-6-schnelle@linux.ibm.com>
         <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
         <Y9ficPosWtGqbDit@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9rPIUMDXBzv6yaFTQkv6a_30SpWJWZQP
X-Proofpoint-ORIG-GUID: 9rPIUMDXBzv6yaFTQkv6a_30SpWJWZQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=1 impostorscore=0 mlxscore=1 mlxlogscore=213
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 11:29 -0400, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 03:13:22PM +0000, Robin Murphy wrote:
>=20
> > Either way, the more I think about this the more I'm starting to agree =
that
> > adding more domain types for iommu-dma policy is a step in the wrong
> > direction. If I may, I'd like to fall back on the "or at least some def=
inite
> > internal flag" part of my original suggestion :)
>=20
> Yes please, lets try to remove IOMMU_DOMAIN_DMA, not add more :)
>=20
> At this point we should probably just sort of hackily add a ops flag
> to indicate single queue and when we fixup the policy logic we can
> make it a user selectable policy as well.
>=20
> Jason

Ok yeah I did like the policy idea you brought up a while back. If we
want to do the conversion to dma-iommu before that we do need an
interim solution though. So if I'm reading your ops flag idea right I
think it could even re-use much of the logic in this series and just
not introduce a new domain type.

I'm wondering if maybe instead of plain flag bits it makes more sense
to have a dma_iommu_options struct that contains the queue size and a
flags value which indicates whether a single or per-CPU queue is used.
Then I could add an iommu_ops callback that takes a device and a
pointer to the dma_iommu_options. That way we can still set the options
per device but don't need a whole extra domain type. This callback
would then just be called during initialization of the DMA-FQ domain
and not having the callback just leaves the defaults unchanged. Does
that go in the right direction?

Thanks,
Niklas
