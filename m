Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A8673E03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjASP4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:56:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA983A9D;
        Thu, 19 Jan 2023 07:56:14 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JFtQro004492;
        Thu, 19 Jan 2023 15:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SKoKjezuRUpE8QqitDy7L0+4qpiJpPKUTSPtiyu4Kgk=;
 b=oBtf0sRwUx1VD7RFOxzrH6XKrWe+8XCEK9B8ExViTeNDkSokhEhdnibtpiNWP0+sY4UH
 JAv2u/CJf4vCOnuBSd56ETgWewQOlj8nGrayUfZ5QFAnBCQW6EM3xTpkL850rd3W4xJP
 pgSyROYswCgPLWZqi7SpP0EqjAz0phVXEGzLfU48o+I5taYZQRnLludW9CVs0cEWJ1a8
 o2XCna+s1KkWgxpyKdIv7+/18BJR1c05vqbheNf0B88eIgnzqYCFkTiBPCcFJqrA7gfp
 G4ps/n+19N7TrkPOh+OS4ECuwfZV6q+J1cFxGQupO4gjd9WTJzkdiv14k6sOLTA+UKIR dA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78qs8cth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 15:56:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5X3Ha023782;
        Thu, 19 Jan 2023 15:55:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16pvwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 15:55:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JFttRu45023556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 15:55:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CB9F20043;
        Thu, 19 Jan 2023 15:55:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1468220040;
        Thu, 19 Jan 2023 15:55:54 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 15:55:53 +0000 (GMT)
Message-ID: <5692d7fbc3d4bd2ac624c82a77f642c36a2cf04e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/7] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Thu, 19 Jan 2023 16:55:53 +0100
In-Reply-To: <20230104120543.308933-6-schnelle@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 32Y_g2cJL13woYx4FV75o6tdk8YdLotJ
X-Proofpoint-ORIG-GUID: 32Y_g2cJL13woYx4FV75o6tdk8YdLotJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=658
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-04 at 13:05 +0100, Niklas Schnelle wrote:
> In some virtualized environments, including s390 paged memory guests,
> IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> are much more expensive than in typical bare metal environments or
> non-paged s390 guests. In addition they may parallelize more poorly in
> virtualized environments. This changes the trade off for flushing IOVAs
> such that minimizing the number of IOTLB flushes trumps any benefit of
> cheaper queuing operations or increased paralellism.
>=20
> In this scenario per-CPU flush queues pose several problems. Firstly
> per-CPU memory is often quite limited prohibiting larger queues.
> Secondly collecting IOVAs per-CPU but flushing via a global timeout
> reduces the number of IOVAs flushed for each timeout especially on s390
> where PCI interrupts may not be bound to a specific CPU.
>=20
> Thus let's introduce a single flush queue mode IOMMU_DOMAIN_DMA_SQ that
> reuses the same queue logic but only allocates a single global queue
> allowing larger batches of IOVAs to be freed at once and with larger
> timeouts. This is to allow the common IOVA flushing code to more closely
> resemble the global flush behavior used on s390's previous internal DMA
> API implementation.
>=20
> As we now support two different variants of flush queues rename the
> existing __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to indicate
> the general case of having a flush queue and introduce separate
> __IOMMU_DOMAIN_DMA_PERCPU_Q and __IOMMU_DOMAIN_DMA_SINGLE_Q bits to
> indicate the two queue variants.
>=20
> Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde0062=
57b6f@arm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v2 -> v3:
> - Rename __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to make it more=
 clear
>   that this bit indicates flush queue use independent of the exact queuing
>   strategy
>=20
---8<---
>=20=20
>  /* sysfs updates are serialised by the mutex of the group owning @domain=
 */
>  int iommu_dma_init_fq(struct iommu_domain *domain)
>  {
>  	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> -	struct iova_fq __percpu *queue;
> -	int i, cpu;
> +	int rc;
>=20=20
>  	if (cookie->fq_domain)
>  		return 0;
> @@ -250,26 +336,16 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
>  	atomic64_set(&cookie->fq_flush_start_cnt,  0);
>  	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
>=20=20
>=20
---8<---
> +	if (domain->type =3D=3D IOMMU_DOMAIN_DMA_FQ)
> +		rc =3D iommu_dma_init_fq_percpu(cookie);
> +	else
> +		rc =3D iommu_dma_init_fq_single(cookie);

Found out in testing that the above doesn't work for the "echo XYZ >
/sys/../iommu_group/type" interface as domain->type is not set before
calling iommu_dma_init_fq() so it would always init for DMA-SQ which is
of course the case that I used during earlier testing. I think the
easiest fix is to add a type parameter to iommu_dma_init_fq().

>=20=20
> -		for (i =3D 0; i < IOVA_FQ_SIZE; i++)
> -			INIT_LIST_HEAD(&fq->entries[i].freelist);
> +	if (rc) {
> +		pr_warn("iova flush queue initialization failed\n");
> +		return rc;
>  	}
>=20
---8<---=20
>=20
>  	mutex_unlock(&group->mutex);
> @@ -2896,10 +2900,10 @@ static int iommu_change_dev_def_domain(struct iom=
mu_group *group,
>  	}
>=20=20
>  	/* We can bring up a flush queue without tearing down the domain */
> -	if (type =3D=3D IOMMU_DOMAIN_DMA_FQ && prev_dom->type =3D=3D IOMMU_DOMA=
IN_DMA) {
> +	if (!!(type & __IOMMU_DOMAIN_DMA_LAZY) && prev_dom->type =3D=3D IOMMU_D=
OMAIN_DMA) {
>  		ret =3D iommu_dma_init_fq(prev_dom);
>  		if (!ret)
> -			prev_dom->type =3D IOMMU_DOMAIN_DMA_FQ;
> +			prev_dom->type =3D type;

Here domain->type is set only after calling iommu_dma_init_fq().

>  		goto out;
>  	}
>=20=20

