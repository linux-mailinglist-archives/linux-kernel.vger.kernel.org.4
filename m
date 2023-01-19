Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B4673E63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjASQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjASQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:16:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449B4ED2A;
        Thu, 19 Jan 2023 08:16:29 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG759v024225;
        Thu, 19 Jan 2023 16:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FoGQ6RKAc+vMV7rKgzbgW8PYfeuD9kMXhc9Q6nvdWeE=;
 b=OB7Y4DAUvP2cnaCL9r3/DFnOmFUbzyoUbloAatCBR02EIg/Wpqd+mnou6fRNBLAihoe5
 G9GDH423JkU9wLWV71gcUboVghDkpurnaIwlMCfBU5EbRXlwsTyDklAu5yY+8GGFBcEC
 cV27iJ7Lua+9tPLrAAkqZZF1sdvdhtC/ciC1vPDUQbVGvd7R0l9LXc1FIZM0Iz9CgTby
 rTYotkRx/atc6EVBZf0sjk/q8sbTLC3EF6ios36uhj3FlADP63/au+pcSxB97KMTUPNz
 qqvrXE+3jayGM0pVltkmwdms/Gk46X1A1eW26imyn7Hvm12axsTqI80Bo49jQKGjlfX7 Hg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78aqhvmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:16:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5o2WV007923;
        Thu, 19 Jan 2023 16:16:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfpwm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:16:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JGGDKh43188556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 16:16:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 527FE2004D;
        Thu, 19 Jan 2023 16:16:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAF920040;
        Thu, 19 Jan 2023 16:16:12 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 16:16:12 +0000 (GMT)
Message-ID: <6cb75bd724f45bca8371235fd51132e987fb0f8a.camel@linux.ibm.com>
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
Date:   Thu, 19 Jan 2023 17:16:11 +0100
In-Reply-To: <5692d7fbc3d4bd2ac624c82a77f642c36a2cf04e.camel@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-6-schnelle@linux.ibm.com>
         <5692d7fbc3d4bd2ac624c82a77f642c36a2cf04e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1VXH6vcfoXBdYwEcG0mshrkGkEKk-jTY
X-Proofpoint-GUID: 1VXH6vcfoXBdYwEcG0mshrkGkEKk-jTY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=475 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 at 16:55 +0100, Niklas Schnelle wrote:
> On Wed, 2023-01-04 at 13:05 +0100, Niklas Schnelle wrote:
> > In some virtualized environments, including s390 paged memory guests,
> > IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> > are much more expensive than in typical bare metal environments or
> > non-paged s390 guests. In addition they may parallelize more poorly in
> > virtualized environments. This changes the trade off for flushing IOVAs
> > such that minimizing the number of IOTLB flushes trumps any benefit of
> > cheaper queuing operations or increased paralellism.
> >=20
> > In this scenario per-CPU flush queues pose several problems. Firstly
> > per-CPU memory is often quite limited prohibiting larger queues.
> > Secondly collecting IOVAs per-CPU but flushing via a global timeout
> > reduces the number of IOVAs flushed for each timeout especially on s390
> > where PCI interrupts may not be bound to a specific CPU.
> >=20
> > Thus let's introduce a single flush queue mode IOMMU_DOMAIN_DMA_SQ that
> > reuses the same queue logic but only allocates a single global queue
> > allowing larger batches of IOVAs to be freed at once and with larger
> > timeouts. This is to allow the common IOVA flushing code to more closely
> > resemble the global flush behavior used on s390's previous internal DMA
> > API implementation.
> >=20
> > As we now support two different variants of flush queues rename the
> > existing __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to indicate
> > the general case of having a flush queue and introduce separate
> > __IOMMU_DOMAIN_DMA_PERCPU_Q and __IOMMU_DOMAIN_DMA_SINGLE_Q bits to
> > indicate the two queue variants.
> >=20
> > Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde00=
6257b6f@arm.com/
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > v2 -> v3:
> > - Rename __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to make it mo=
re clear
> >   that this bit indicates flush queue use independent of the exact queu=
ing
> >   strategy
>=20
---8<---
>=20
> >=20=20
> > -		for (i =3D 0; i < IOVA_FQ_SIZE; i++)
> > -			INIT_LIST_HEAD(&fq->entries[i].freelist);
> > +	if (rc) {
> > +		pr_warn("iova flush queue initialization failed\n");
> > +		return rc;
> >  	}
> >=20
> ---8<---=20
> >=20
> >  	mutex_unlock(&group->mutex);
> > @@ -2896,10 +2900,10 @@ static int iommu_change_dev_def_domain(struct i=
ommu_group *group,
> >  	}
> >=20=20
> >  	/* We can bring up a flush queue without tearing down the domain */
> > -	if (type =3D=3D IOMMU_DOMAIN_DMA_FQ && prev_dom->type =3D=3D IOMMU_DO=
MAIN_DMA) {
> > +	if (!!(type & __IOMMU_DOMAIN_DMA_LAZY) && prev_dom->type =3D=3D IOMMU=
_DOMAIN_DMA) {
> >  		ret =3D iommu_dma_init_fq(prev_dom);
> >  		if (!ret)
> > -			prev_dom->type =3D IOMMU_DOMAIN_DMA_FQ;
> > +			prev_dom->type =3D type;
>=20
> Here domain->type is set only after calling iommu_dma_init_fq().

Actually I think even in the current code the above and the similar
code in iommu.c isn't ideal. When going from DMA to DMA-FQ with a bound
driver the flush queue is used from the moment that WRITE_ONCE(cookie-
>fq_domain, domain) executes in iommu_dma_init_fq() so there is a
window where the flush queue is already used but domain->type is still
DMA. By adding a type parameter to iommu_dma_init_fq() we can set
domain->type before the WRITE_ONCE() and thus close this window and it
even makes the callsites of iommu_dma_init_fq() simpler.

>=20
> >  		goto out;
> >  	}
> >=20=20
>=20

