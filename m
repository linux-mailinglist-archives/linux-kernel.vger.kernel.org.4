Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653EF642BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiLEPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiLEPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:34:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A0C48;
        Mon,  5 Dec 2022 07:34:30 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FIsUj001116;
        Mon, 5 Dec 2022 15:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vbmo28ZDDXC+hnndAKE8gpWRQOJ16yZkGqBoLdsO1/Y=;
 b=IdKSWx72MuNKHMwCNvvbK4Jru/fVNpVUJEFRSPYKFdiQvr6oNCImmDsR/nXPnHDQSzRB
 K5HyHxOM1l1rUS6JDFMJ310tuMzY9x39zlU4A3nh8vNPydYjsI+dMQqxd5r/BglNmN1d
 +R8qNfWvlPCN8DZziQikyFxvr+XUBEEb/O07eZmYuvOVUb2pIbvAWY0XUQyLpn4v/oEs
 fTYqP1Xs/BDPsrNVCJ+WxskpKm+fBjTwudOk3I/wEQ3x549qOrcSBzejr+MLVNtjh6iE
 Z6sRsB81ocfvyhH8K/KUW/l0KfgsLcKUxP5gsDsluGZdizUwmC2RvBJi4I0pFl8Wycff 0Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9qg4wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 15:34:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with ESMTP id 2B5FVSiV008515;
        Mon, 5 Dec 2022 15:34:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3m9kby004e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 15:34:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com ([9.149.105.59])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B5FY99W44892544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Dec 2022 15:34:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B297BA4053;
        Mon,  5 Dec 2022 15:34:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE61CA4040;
        Mon,  5 Dec 2022 15:34:08 +0000 (GMT)
Received: from [9.171.41.104] (unknown [9.171.41.104])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Dec 2022 15:34:08 +0000 (GMT)
Message-ID: <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Mon, 05 Dec 2022 16:34:08 +0100
In-Reply-To: <Y4Zm53o1ovdIAqr/@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-5-schnelle@linux.ibm.com>
         <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
         <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
         <Y4S3z6IpeDHmdUs/@nvidia.com>
         <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
         <Y4TjWOXYD+DK+d/B@nvidia.com>
         <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
         <Y4ZCVgLO9AHatwXe@nvidia.com>
         <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
         <Y4Zm53o1ovdIAqr/@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JaMdlU25etf6Mb6Q8UnN2XsCfrMgEpIM
X-Proofpoint-ORIG-GUID: JaMdlU25etf6Mb6Q8UnN2XsCfrMgEpIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 16:09 -0400, Jason Gunthorpe wrote:
> On Tue, Nov 29, 2022 at 06:41:22PM +0000, Robin Murphy wrote:
> > On 2022-11-29 17:33, Jason Gunthorpe wrote:
> > > On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:
> > >=20
> > > > I'm hardly an advocate for trying to save users from themselves, bu=
t I
> > > > honestly can't see any justifiable reason for not having sysfs resp=
ect
> > > > iommu_get_def_domain_type().
> > >=20
> > > We really need to rename this value if it is not actually just an
> > > advisory "default" but a functional requirement ..
> >=20
> > It represents a required default domain type. As in, the type for the
> > device's default domain. Not the default type for a domain. It's the
> > iommu_def_domain_type variable that holds the *default* default domain =
type
> > ;)
>=20
> I find the name "default domain" incredibly confusing at this point in
> time.

Yes it definitely confused me as evidenced by this patch.

>=20
> I would like to call that the "dma-api domain" - its primary purpose
> is to be the domain that the DMA API uses to operate the IOMMU, there
> is little "default" about it. This meshes better with our apis talking
> about ownership and so forth.
>=20
> So, if the op was called
>   get_dma_api_domain_type()
>=20
> It is pretty clear that it is the exact type of domain that should be
> created to support the DMA API, which is what I think you have been
> describing it is supposed to do?
>=20
> And with Lu's series we have the set_platform_dma() (Lu perhaps you
> should call this set_platform_dma_api() to re-enforce it is about the
> DMA API, not some nebulous DMA thing)
>=20
> Which is basically the other way to configure the DMA API for
> operation.
>=20
> And encapsulating more of the logic to setup and manage the DMA API's
> domain into dma-iommu.c would also be helpful to understanding.
>=20
> > Which reminds me I should finish that patch undoing my terrible
> > ops->default_domain_ops idea, not least because they are misleadingly
> > unrelated to default domains...
>=20
> :)
>=20
> > > It is close to being clear, once we get the last touches of dma-iommu
> > > stuff out of the drivers it should be quite clear
> >=20
> > Cool, some upheaval of .domain_alloc is next on my hitlist anyway, so t=
hat
> > might be a good excuse to upheave it a bit more and streamline the type
> > stuff along the way.
>=20
> Yes, I think so. I want to tidy things a bit so adding this "user
> space" domain concept is a little nicer
>=20
> Jason

Ok, so it sounds to me like there is going to be quite a bit of change
in this area. Thus I'm a little unsure however how to proceed here. I
think especially with the proposed multiple queue types in this series
it makes sense for an IOMMU driver to express its preference of a
particular domain type if it supports multiple which clearly isn't what
iommu_get_def_domain_type() is currently supposed to do.

Looking at the current code I don't see a trivial way to integrate this
especially with a lot of reworks going on.

At the moment the preference for IOMMU_DOMAIN_DMA_FQ over
IOMMU_DOMAIN_DMA during initial boot is hard coded in
iommu_subsys_init() before we even know what IOMMU driver will be used.
so can't really access its ops there. On the other hand this decision
may still be rolled back if iommu_dma_init_fq() fails in
iommu_dma_init_domain() so maybe it would make sense to assume a DMA
domain type of IOMMU_DOMAIN_DMA until that point and only then prefer
IOMMU_DOMAIN_DMA_FQ or something else if the driver has a preference.

Maybe it would also make sense not to mix the type of flush queue used
with the domain and maybe the queue type could be passed in via
iommu_setup_dma_ops() -> iommu_dma_init_domain() though I do remember
that there is also a planned rework for that. Any suggestions?

Thanks,
Niklas

