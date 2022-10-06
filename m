Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AD5F6A75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJFPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJFPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:22:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16CB514B;
        Thu,  6 Oct 2022 08:22:15 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296FFOXJ028174;
        Thu, 6 Oct 2022 15:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fdvKRZW+6B4bc/tizp2EF3gOSKbpufdFOY0utqO1Gp8=;
 b=cY587duxvs+hNdora+fHf1J8osepd9fY+jG152jJtfcmYBSh8q2ROB9JZi99vzoMWI1G
 M4IpJwLws43mO/hJYGNK+NxWH3wv9/SED5RnGvDFiuN895NV1vK0mWK+QXlh+g2wNcIn
 ulSrGj//84zJk3aKXVy4wGodWY5ba3eBvM7G9P/cpto3TllswUVx36SaEWAEarj8ac6t
 lvX+q9z3znc3N4bF5PvHA1Z3+EK+wq7pop6QoZY25keOGWkkBYnIhxV9a6XAUxCxnr/M
 KFXtsCJ3V5L+EEKBmJOllsPqyAvGmj3t5nadLu1qjP+4l6nSkxfRuo7MrK5BSc2WIBA+ Ig== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k20p8247n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 15:22:03 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296FB84c017152;
        Thu, 6 Oct 2022 15:22:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3jxd68wcfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 15:22:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296FLvr28127070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 15:21:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFFA052051;
        Thu,  6 Oct 2022 15:21:57 +0000 (GMT)
Received: from sig-9-145-19-232.uk.ibm.com (unknown [9.145.19.232])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 275545204F;
        Thu,  6 Oct 2022 15:21:57 +0000 (GMT)
Message-ID: <ed96bbb5b2af7cbf8e41f5aa36d31d3f5aae50d5.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] iommu/s390: Fix potential s390_domain aperture
 shrinking
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Thu, 06 Oct 2022 17:21:56 +0200
In-Reply-To: <20221006144700.3380098-4-schnelle@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
         <20221006144700.3380098-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iZCr9ndK0jR3uH7V9SvHBl0MnjzGGL4P
X-Proofpoint-ORIG-GUID: iZCr9ndK0jR3uH7V9SvHBl0MnjzGGL4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 16:46 +0200, Niklas Schnelle wrote:
> The s390 IOMMU driver currently sets the IOMMU domain's aperture to
> match the device specific DMA address range of the device that is first
> attached. This is not ideal. For one if the domain has no device
> attached in the meantime the aperture could be shrunk allowing
> translations outside the aperture to exist in the translation tables.
> Also this is a bit of a misuse of the aperture which really should
> describe what addresses can be translated and not some device specific
> limitations.
> 
> Instead of misusing the aperture like this we can instead create
> reserved ranges for the ranges inaccessible to the attached devices
> allowing devices with overlapping ranges to still share an IOMMU domain.
> This also significantly simplifies s390_iommu_attach_device() allowing
> us to move the aperture check to the beginning of the function and
> removing the need to hold the device list's lock to check the aperture.
> 
> As we then use the same aperture for all domains and it only depends on
> the table properties we can already check zdev->start_dma/end_dma at
> probe time and turn the check on attach into a WARN_ON().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

@Matt, @Jason I did drop the R-b's here because the change Jason
suggested of changing the aperture check on attach to a WARN_ON() and
checking zdev->start_dma/end_dma on probe is a behavioral change.

> ---
> v4->v5:
> - Make aperture check in attach a WARN_ON() and fail in probe if
>   zdev->start_dma/end_dma doesn't git in aperture  (Jason)
> 
>  drivers/iommu/s390-iommu.c | 65 +++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 9b3ae4b14636..1f6c9bee9a80 100644
> --- a/drivers/iommu/s390-iommu.c
---8<---

