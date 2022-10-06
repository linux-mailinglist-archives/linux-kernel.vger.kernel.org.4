Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BDF5F6A00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiJFOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJFOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:47:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF31D32C;
        Thu,  6 Oct 2022 07:47:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EfigW031385;
        Thu, 6 Oct 2022 14:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+eqGyc5+lrsVFliv/gThTMTvnR8r005YDiYq5MGQBXA=;
 b=TBUD85knHfsbnlIHt6dApHyY6OHl+Q7heie37OS8yPb5kHqKmbe8lE5xbfS549E95XPK
 aQuE3+RzVkF9lFIQ1QksY3YKH6HDtiE4AhTXaO7m1MxnLqMhOo9bGmAKr3H/BS2hhOzP
 G3ovIxjYxV43UEAJD7q5GeHRKPSEyEOecIw6ud8zl4awrfvG4341MJTb8qHsQK8q6Avl
 vL46lRF3bVVCPSWZL/IjqJ0DTaTz3vsyuh9tP+gcrMTuOYFxRdxribEoXyTRcgl9KM21
 0xYf6lAcicp6wYrDqWMOK0AfcMdjly/cAEUqX38pQ5lKDTQYR1tjp1qxxE2ySr9Yi/0+ VA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k208tsvka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:09 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296EaT6H014398;
        Thu, 6 Oct 2022 14:47:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68wau3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296EgVMK48824604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 14:42:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C29BA4051;
        Thu,  6 Oct 2022 14:47:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A305AA404D;
        Thu,  6 Oct 2022 14:47:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 14:47:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] iommu/s390: Fix incorrect pgsize_bitmap
Date:   Thu,  6 Oct 2022 16:46:59 +0200
Message-Id: <20221006144700.3380098-6-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006144700.3380098-1-schnelle@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CSDdLlojLoxoBGNG7DFwkmphXVOYzzT1
X-Proofpoint-GUID: CSDdLlojLoxoBGNG7DFwkmphXVOYzzT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .pgsize_bitmap property of struct iommu_ops is not a page mask but
rather has a bit set for each size of pages the IOMMU supports. As the
comment correctly pointed out at this moment the code only support 4K
pages so simply use SZ_4K here.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index a89fd0256f99..ac200f0b81fa 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -12,13 +12,6 @@
 #include <linux/sizes.h>
 #include <asm/pci_dma.h>
 
-/*
- * Physically contiguous memory regions can be mapped with 4 KiB alignment,
- * we allow all page sizes that are an order of 4KiB (no special large page
- * support so far).
- */
-#define S390_IOMMU_PGSIZES	(~0xFFFUL)
-
 static const struct iommu_ops s390_iommu_ops;
 
 struct s390_domain {
@@ -356,7 +349,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.probe_device = s390_iommu_probe_device,
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
-	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
-- 
2.34.1

