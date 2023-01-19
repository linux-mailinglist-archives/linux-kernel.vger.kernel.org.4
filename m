Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A69673E26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjASQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:04:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B584ED23;
        Thu, 19 Jan 2023 08:04:20 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG32m4000764;
        Thu, 19 Jan 2023 16:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vI09iik1gVyiw2fBWCJOHgL3a85i2rSQfxTjFOaXBak=;
 b=GOqZkwL3yfct0WivdyJcy4EPJZyCFSf+SgjenLHlXYuntODDlQjv1aX1DH8PmzPjqeM0
 9y050PDIdn2x5jToyKI3Yd55WPxAHbYFlmdHgyLbCGqZMiiMi/RKBoHFWESTPgYA0+XN
 QZpqEVDQceWWihQ0as/FwpfZqO2nsuhVLqUCFbUAlQsNibia4ADkyldSs2NXe9CDhl1k
 CEOKNmqdM4008C/wyLfE+fz2LLgbI7iTPtgahI24PuHtT6O3NfB58wcM6w6/S+SzJOiO
 F3q1igdWG8yHjPVCA7ZshFRXTHqbe44dxibo+dXdTlunyKdpPjrL02ltMjady+GozRyT Tg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78vyrdj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:04:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J643dh023792;
        Thu, 19 Jan 2023 16:04:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16pw8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:04:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JG44qD25428620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 16:04:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD362004B;
        Thu, 19 Jan 2023 16:04:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9AE20043;
        Thu, 19 Jan 2023 16:04:03 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 16:04:03 +0000 (GMT)
Message-ID: <0ce7d96b8447a293b147976e5993cb053feb9c52.camel@linux.ibm.com>
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
Date:   Thu, 19 Jan 2023 17:04:03 +0100
In-Reply-To: <50c22529-e0f4-9124-fdc0-c8da49300b18@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-5-schnelle@linux.ibm.com>
         <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
         <a623049fb595480ffdf1130bbe800d79705cef03.camel@linux.ibm.com>
         <50c22529-e0f4-9124-fdc0-c8da49300b18@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mBCQhlILT8uXKEsgqOidgLiNpHkowUih
X-Proofpoint-GUID: mBCQhlILT8uXKEsgqOidgLiNpHkowUih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=709 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 at 10:59 -0500, Matthew Rosato wrote:
> On 1/19/23 6:03 AM, Niklas Schnelle wrote:
> > > > > > > > > > > > > > > > > > =C2=A0
> > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > =C2=A0static char *pci_sw_names[] =3D {
> > > > > > > > > > > > > > > > > > - "Allocated pages",
> > > > > > > > > > > > > > > > > > +/* TODO "Allocated pages", */
> > > > > > > > > >=20
> > > > > > > > > > ? Forgot to finish this?
> >=20
> > Definitely forgot to remove the TODO. I think my latest plan was to
> > just remove this counter. With the DMA API conversion the
> > dma_map_ops.alloc and dma_map_ops.free move to common code and I don't
> > see how we could differentiate these from map/unmap on our side. I'm
> > not sure how helpful this counter really is either. If you're
> > interested in how many pages are mapped long term I think it makes more
> > sense to look at the difference between mapped and unmapped pages. What
> > do you think?
> > > > > > > > >=20
>=20
> Sounds reasonable to me, but I also note that without this series, when v=
iewing statistics for a device, mapped - unmapped !=3D allocated.  Maybe al=
located pages was already broken, or is it taking into account something el=
se that mapped - unmapped would not (maybe mapping the same page multiple t=
imes)?
>=20
>=20

Allocated Pages only counts the memory allocated via dma_map_ops.alloc
so it would not count long term mappings of memory the driver allocated
differently and then mapped for long term use.
