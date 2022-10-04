Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D211B5F45B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJDOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJDOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:39:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A542961B26;
        Tue,  4 Oct 2022 07:39:13 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294EbM7n015946;
        Tue, 4 Oct 2022 14:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NUhrQvumaVIGyNhuwTFUwARn0xvR7/iDRIXZqqIx84Q=;
 b=hlHxzZBIhiBO2pPHGkHb0Oeeb4ieYUaGtkQeBfYWZT7W8184fMsu+/pMFcDhLFoawm6k
 FJWUbHKloCFcRlWX9lm+Nx/s5k9pncZuy71NpxNCnGziMTmfsIlbxZ/nlWzlOQGOY7ln
 QRhNtivY3Kx6jeagjF64w0sA9aNjDdRpItsc79jlaU1P2lx2lTeKyLOq/3aOdZqXv7Io
 CPkC76I2JBJsINeYCxI+kUkfjGJ1G05wMVfHxVOPBSqac6A7Xh2Iyz3jKPYGPZzqaVDZ
 iORPkVZ8TkHzMpeaOjmf+Xsv+hdsLEzvy9SQaMblB6YmFxd0u12iLRqQJ6DDqdQf+Q9T RA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0bdskqmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 14:39:01 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294EZCc6007184;
        Tue, 4 Oct 2022 14:39:00 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3jxd69de3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 14:39:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294Ecxav16778228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 14:39:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 417A058061;
        Tue,  4 Oct 2022 14:38:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DBDE5805F;
        Tue,  4 Oct 2022 14:38:57 +0000 (GMT)
Received: from [9.77.144.104] (unknown [9.77.144.104])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 14:38:57 +0000 (GMT)
Message-ID: <7216693d-c354-fa0d-8f26-e2bcf76fd854@linux.ibm.com>
Date:   Tue, 4 Oct 2022 10:38:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 5/5] iommu/s390: Fix incorrect pgsize_bitmap
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-6-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221004120706.2957492-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xj3s3S3I9BiCXAU62VBtKDZC00XQpzco
X-Proofpoint-GUID: Xj3s3S3I9BiCXAU62VBtKDZC00XQpzco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040094
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 8:07 AM, Niklas Schnelle wrote:
> The .pgsize_bitmap property of struct iommu_ops is not a page mask but
> rather has a bit set for each size of pages the IOMMU supports. As the
> comment correctly pointed out at this moment the code only support 4K
> pages so simply use SZ_4K here.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/iommu/s390-iommu.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 94c444b909bd..6bf23e7830a2 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -12,13 +12,6 @@
>  #include <linux/sizes.h>
>  #include <asm/pci_dma.h>
>  
> -/*
> - * Physically contiguous memory regions can be mapped with 4 KiB alignment,
> - * we allow all page sizes that are an order of 4KiB (no special large page
> - * support so far).
> - */
> -#define S390_IOMMU_PGSIZES	(~0xFFFUL)
> -
>  static const struct iommu_ops s390_iommu_ops;
>  
>  struct s390_domain {
> @@ -350,7 +343,7 @@ static const struct iommu_ops s390_iommu_ops = {
>  	.probe_device = s390_iommu_probe_device,
>  	.release_device = s390_iommu_release_device,
>  	.device_group = generic_device_group,
> -	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.pgsize_bitmap = SZ_4K,
>  	.get_resv_regions = s390_iommu_get_resv_regions,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= s390_iommu_attach_device,

