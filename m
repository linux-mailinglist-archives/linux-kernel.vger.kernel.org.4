Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F166650E82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiLSPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiLSPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:17:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC763DE;
        Mon, 19 Dec 2022 07:17:42 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJFBYPI020632;
        Mon, 19 Dec 2022 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eyOmpbOALSStyNZnHuSf83ub6FXgjkkoBM7zGaC3LA4=;
 b=TG3AK010cEhX/690kvZm4KoSY+ler/pgTTZMARutTWXlZh0RH2AOsSEgedT0rwPe2dXT
 03Cs84NO41JHxRP2GlBNgbKOgfykJugl6QazyVuBSyyuwKZuvD1Il2JOXsPhtTYwv/9E
 CxJ4Nv7RbPliNLrpvOtQTqp/CzzPZ8DOj4TLDokp+a35ZrVa+2Nt277EMbITbpxWwI+l
 oBnIARz9H/p8+3iuofhGVAP+Qxpe1k4NbFUIVa2u9gXBj0cXjda1TbgLf2ycIMweiAYH
 FIt+icJhoLjnhkxf39B+/pMBlo+fbvrNN1CCI6dUsATVAaRpjjNm4Yexbo/9Q3WlQ0h5 Ug== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjtcn8a1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 15:17:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJEZtBg019071;
        Mon, 19 Dec 2022 15:17:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mh6yw2qy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 15:17:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJFHItg50332004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 15:17:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDCC2004E;
        Mon, 19 Dec 2022 15:17:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE2A2005A;
        Mon, 19 Dec 2022 15:17:18 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 15:17:18 +0000 (GMT)
Message-ID: <372ec042d8fe6eed055c354c561316f7670dfb40.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/7] s390/pci: Use dma-iommu layer
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Mon, 19 Dec 2022 16:17:18 +0100
In-Reply-To: <bc1e4fd5-bf96-f579-8190-fda9b41d1547@arm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-4-schnelle@linux.ibm.com>
         <bc1e4fd5-bf96-f579-8190-fda9b41d1547@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5LtMGJ-jgeMN73PYwU-pO1qrz3qjgpck
X-Proofpoint-ORIG-GUID: 5LtMGJ-jgeMN73PYwU-pO1qrz3qjgpck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=805 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-28 at 18:03 +0000, Robin Murphy wrote:
> On 2022-11-16 17:16, Niklas Schnelle wrote:
> [...]
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index dc5f7a156ff5..804fb8f42d61 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -93,7 +93,7 @@ config IOMMU_DEBUGFS
> >   choice
> >   	prompt "IOMMU default domain type"
> >   	depends on IOMMU_API
> > -	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64
> > +	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64 || S390
> >   	default IOMMU_DEFAULT_DMA_STRICT
> >   	help
> >   	  Choose the type of IOMMU domain used to manage DMA API usage by
> > @@ -412,6 +412,7 @@ config ARM_SMMU_V3_SVA
> >   config S390_IOMMU
> >   	def_bool y if S390 && PCI
> >   	depends on S390 && PCI
> > +	select IOMMU_DMA
>=20
> Please add S390 to the condition under config IOMMU_DMA instead.

Done, will be in v3

>=20
> >   	select IOMMU_API
> >   	help
> >   	  Support for the IOMMU API for s390 PCI devices.
> [...]
> > @@ -45,9 +329,14 @@ static struct iommu_domain *s390_domain_alloc(unsig=
ned domain_type)
> >   {
> >   	struct s390_domain *s390_domain;
> >  =20
> > -	if (domain_type !=3D IOMMU_DOMAIN_UNMANAGED)
> > +	switch (domain_type) {
> > +	case IOMMU_DOMAIN_DMA:
> > +	case IOMMU_DOMAIN_DMA_FQ:
>=20
> I was about to question adding this without any visible treatment of=20
> iommu_iotlb_gather_queued() or domain->type =3D=3D IOMMU_DOMAIN_DMA_FQ as=
 a=20
> whole, but I guess if you never actually free any pagetables it does=20
> work out OK. Bit of a timebomb if there's a chance of that ever changing=
=20
> in future, though.

Yes, as we're not freeing pagetables they will be reused simply by
reusing same IOVA. Restricting the range of IOVAs is then what keeps
the translation table from growing unbounded. This also makes the
pagetable handling easier=20

It will definitely need handling if we ever add freeing pagestables
yes. I'd hope though that if we do add this functionality it will be
through common code reuse such as io-pgtable.h that will deal with this
naturally. I'm still pondering to add a comment here but I also fear
that this part is going to be refactored soon and such a comment will
get lost before it could matter.

>=20
> > +	case IOMMU_DOMAIN_UNMANAGED:
> > +		break;
> > +	default:
> >   		return NULL;
> > -
> > +	}
> >   	s390_domain =3D kzalloc(sizeof(*s390_domain), GFP_KERNEL);
> >   	if (!s390_domain)
> >   		return NULL;
> [...]
> > @@ -397,12 +678,29 @@ static size_t s390_iommu_unmap_pages(struct iommu=
_domain *domain,
> >   		return 0;
> >  =20
> >   	iommu_iotlb_gather_add_range(gather, iova, size);
> > +	atomic64_add(pgcount, &s390_domain->ctrs.unmapped_pages);
> >  =20
> >   	return size;
> >   }
> >  =20
> > +static void s390_iommu_probe_finalize(struct device *dev)
> > +{
> > +	struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> > +
> > +	iommu_dma_forcedac =3D true;
> > +	iommu_setup_dma_ops(dev, domain->geometry.aperture_start, domain->geo=
metry.aperture_end);
>=20
> For consistency with all but one other caller now, just pass 0 and=20
> U64_MAX for base and size to make it clear that they're meaningless=20
> (they will eventually go away as part of a bigger refactoring).
>=20
> Thanks,
> Robin.

Done will be in v3.

Now I'm still trying to figure out how to prefer the proposed
IOMMU_DOMAIN_DMA_SQ when running with a hypervisor with expensive IOTLB
flush while IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_DMA_FQ both work but are
slower. Jason's patch idea of adding a DMA_API_POLICY sounds like a
good start but is also a rather big change and doesn't yet allow for a
preference by the IOMMU driver. Will see, if I can come up with
something minimal for that.
