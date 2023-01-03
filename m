Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685BA65C37F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjACQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjACQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:04:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB112628;
        Tue,  3 Jan 2023 08:04:03 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303F6dY7007140;
        Tue, 3 Jan 2023 16:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KPIltgXLcHbMrQ52Lpe9AnY3EOsSgDqPWtgU38MSmuA=;
 b=Wvje720BtmDRxaBaFTG4WI2s7O8GUwyEAllmpNHFRat0EtXvcTMs/HmDclcIxfSD4low
 qR4Zpu9wEa4/za4wgVv+gLsmGaBGvVptWxjOzJ9GnQ8xq8WAzW7bF5R3hO5STbETkmL4
 YTgqEJ/Shh7K4Ko/tm+kEbxFQdhN9dfL6Yvv5Oh4fBWT8bMEMp+p6gEKDWnZ0I9jWlll
 fLMGSK016qyVW68O7fMzzAEvxj0t9Bp3h7qbgjIgJ7jHbRHdh5omVEtLdKIarCVKBAR7
 mmP01DupO5JONdbk+9aGGNNywS0VNGAzEytFTO9G5Ub9DeITM/E8FAMhQIm591HfWpbn TQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvmb7n9v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:03:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302N0mkG006506;
        Tue, 3 Jan 2023 16:03:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6ay3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:03:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303G3PPh41157076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 16:03:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B473720040;
        Tue,  3 Jan 2023 16:03:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25A420049;
        Tue,  3 Jan 2023 16:03:24 +0000 (GMT)
Received: from [9.179.26.205] (unknown [9.179.26.205])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jan 2023 16:03:24 +0000 (GMT)
Message-ID: <310913b0a92bd06b93ede9e01e3f99cb5bce4e7a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
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
Date:   Tue, 03 Jan 2023 17:03:23 +0100
In-Reply-To: <20230102115619.2088685-3-schnelle@linux.ibm.com>
References: <20230102115619.2088685-1-schnelle@linux.ibm.com>
         <20230102115619.2088685-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c3genIMIgTmUDXTYXgiTkNQddLTb2SxI
X-Proofpoint-GUID: c3genIMIgTmUDXTYXgiTkNQddLTb2SxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=754 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-02 at 12:56 +0100, Niklas Schnelle wrote:
> On s390 .iotlb_sync_map is used to sync mappings to an underlying
> hypervisor by letting the hypervisor inspect the synced IOVA range and
> updating its shadow table. This however means that it can fail as the
> hypervisor may run out of resources. This can be due to the hypervisor
> being unable to pin guest pages, due to a limit on concurrently mapped
> addresses such as vfio_iommu_type1.dma_entry_limit or other resources.
> Either way such a failure to sync a mapping should result in
> a DMA_MAPPING_EROR.
>=20
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings and only if that also fails
> report this error to callers.
>=20
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/amd/iommu.c   |  5 +++--
>  drivers/iommu/apple-dart.c  |  5 +++--
>  drivers/iommu/intel/iommu.c |  5 +++--
>  drivers/iommu/iommu.c       | 20 ++++++++++++++++----
>  drivers/iommu/msm_iommu.c   |  5 +++--
>  drivers/iommu/mtk_iommu.c   |  5 +++--
>  drivers/iommu/s390-iommu.c  | 29 ++++++++++++++++++++++++-----
>  drivers/iommu/sprd-iommu.c  |  5 +++--
>  drivers/iommu/tegra-gart.c  |  5 +++--
>  include/linux/iommu.h       |  4 ++--
>  10 files changed, 63 insertions(+), 25 deletions(-)

Ok kernel test robot reported that I missed an implementation of
.iotlb_sync_map in drivers/iommu/sun50i-iommu.c during rebase as that
was only added in v6.2-rc1 by commit e563cc0c787c85 ("iommu/sun50i:
Implement .iotlb_sync_map"). Will add and send a v4 including the
proposed commit message rewording too.

>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cbeaab55c0db..3df7d20e0e52 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2180,14 +2180,15 @@ static int amd_iommu_attach_device(struct iommu_d=
omain *dom,
>  	return ret;
>  }
> =20
> -static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
> -				     unsigned long iova, size_t size)
---8<---
