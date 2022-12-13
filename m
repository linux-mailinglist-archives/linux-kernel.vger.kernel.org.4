Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE664B60C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiLMNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiLMNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:25:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9211929B;
        Tue, 13 Dec 2022 05:25:07 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDD8Yfu028246;
        Tue, 13 Dec 2022 13:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uPsNjA/oTpRCmchDtLzsD1RJws/pLFpv11WZLH9VSsU=;
 b=dqJEIpko5w484cnb6ZuQM1yt5wVL1FmD14F2idIbn80k21s5L4G6Y6/WWMpZbL3ygR93
 hChVbxapOArKaNahy0F/rOvjt4x+D2q215j8rM2cb4weUnc/09bxf6N+BYDamjSQbR73
 hOt94tJNB2JQU6F3XBAUg6VS8mJQqGxtj6Mktgdb+HCOZCnpBIjsw4D0iKr09I2zqo18
 SVeXD4movUPR5Fvl3zGeXlTVXQAv8+Lxe9ucCSyWTPLYn9xSHfB3S8OIbEDnnycaCWGs
 N9g5M8gvaUNBNT2+A2HphhH/lmfPJ+JwpQUY6suRtl8zR17fWiiVDjEnIIFbNJYRDVS3 DA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mestnrmgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:24:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD5OgN5028342;
        Tue, 13 Dec 2022 13:24:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mchr647qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:24:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDDObY447382914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 13:24:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E9A520040;
        Tue, 13 Dec 2022 13:24:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41EE220043;
        Tue, 13 Dec 2022 13:24:37 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 13:24:37 +0000 (GMT)
Message-ID: <74be1d4fff25840b8be2b786263c37840e5cca4c.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu: Allow .iotlb_sync_map to fail and handle s390's
 -ENOMEM return
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sven Peter <sven@svenpeter.dev>
Date:   Tue, 13 Dec 2022 14:24:37 +0100
In-Reply-To: <Y5h6EuA+mx29pMCg@nvidia.com>
References: <20221213121104.1659412-1-schnelle@linux.ibm.com>
         <Y5h6EuA+mx29pMCg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XWihPLDDGZYuwgAMLGJT0o07dTHAqqsU
X-Proofpoint-GUID: XWihPLDDGZYuwgAMLGJT0o07dTHAqqsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=688 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-13 at 09:11 -0400, Jason Gunthorpe wrote:
> On Tue, Dec 13, 2022 at 01:11:04PM +0100, Niklas Schnelle wrote:
> > --- a/drivers/iommu/tegra-gart.c
> > +++ b/drivers/iommu/tegra-gart.c
> > @@ -252,8 +252,8 @@ static int gart_iommu_of_xlate(struct device *dev,
> >  	return 0;
> >  }
> > =20
> > -static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned =
long iova,
> > -				size_t size)
> > +static int gart_iommu_sync_map(struct iommu_domain *domain, unsigned l=
ong iova,
> > +			       size_t size)
> >  {
> >  	FLUSH_GART_REGS(gart_handle);
> >  }
>=20
> return 0 ?
>=20
> Jason

Stupid me for not at least compile testing on more platforms.
Will send a v2.
