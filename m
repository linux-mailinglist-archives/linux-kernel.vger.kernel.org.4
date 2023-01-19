Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADBE6736E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjASLcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjASLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:31:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A274EA2;
        Thu, 19 Jan 2023 03:31:44 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JBKPcT029702;
        Thu, 19 Jan 2023 11:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gW7Njcx6fhBoaFfE4jFbb8gaSEz5NLLBXcLB3pwFzbM=;
 b=RbhdUmwG4iDRhS0E/rePywC6ZBlDIAVtm+2fsfJVSRsGLqaRcjhpvfiVVNG9d90QjRg3
 wl5VkbyYJ7/zAZZiJd1OLQxRSaY2McGEyyR2KfE06RO+74eR1asIYac5e1sbCRdSNnNQ
 mu1NX/1uMYFPRv+gxsuFadDAk5rG00qn+XkQOUUo6cj4vhzktx6QTF1oqIZzwJ5sjXlf
 +e0ETJpLzLASb/KUZfbXiSCL2RVg8X1RM6Agbh/AZnmI8Va5qJBJvFk02q3bUYMvaHWA
 IqqJW7WO4YzvPoO7XNSiADVcV9Li4yCiIa6xURqkCSYWkcWmo9mslSXoQPHdfc/Ppkvi 1A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n74wdr6cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:31:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J9PNbs007302;
        Thu, 19 Jan 2023 11:31:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16mt7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:31:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JBVGXZ37552460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 11:31:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA50C2004E;
        Thu, 19 Jan 2023 11:31:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6840120040;
        Thu, 19 Jan 2023 11:31:15 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 11:31:15 +0000 (GMT)
Message-ID: <93d3397b1d0ec4e2ed24dfaccf4cafb0a9206907.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/7] iommu: Allow .iotlb_sync_map to fail and handle
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
Date:   Thu, 19 Jan 2023 12:31:15 +0100
In-Reply-To: <20230104120543.308933-3-schnelle@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nPReWujzTmOiExwTbtTzClco5PZpjCZg
X-Proofpoint-ORIG-GUID: nPReWujzTmOiExwTbtTzClco5PZpjCZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=690
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-04 at 13:05 +0100, Niklas Schnelle wrote:
> On s390 when using a paging hypervisor, .iotlb_sync_map is used to sync
> mappings by letting the hypervisor inspect the synced IOVA range and
> updating a shadow table. This however means that .iotlb_sync_map can
> fail as the hypervisor may run out of resources while doing the sync.
> This can be due to the hypervisor being unable to pin guest pages, due
> to a limit on mapped addresses such as vfio_iommu_type1.dma_entry_limit
> or lack of other resources. Either way such a failure to sync a mapping
> should result in a DMA_MAPPING_ERROR.
>=20
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings as well a retry creating the
> new mappings and only if that also fails report this error to callers.
>=20
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v3 -> v4:
> - Adapted signature of .iommu_tlb_sync mapo for sun50i IOMMU driver added=
 in
>   v6.2-rc1 (kernel test robot)
>=20
>=20

@Joerg, this patch, while being a prerequisite to the DMA API
conversion, is independent and in fact would also be needed for IOMMU
use in a nested KVM guest. With Baolu's and Matt's R-b's I think it
would make sense to pick this up for v6.3 even if the DMA API
conversion takes longer while we figure out details and the flush queue
changes. What do you think?

Thanks,
Niklas
