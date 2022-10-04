Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC45F42AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJDMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJDMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:07:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2852FC1;
        Tue,  4 Oct 2022 05:07:29 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294AV8wf028922;
        Tue, 4 Oct 2022 12:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cfg+rPxWIUGOIak/gDKQ8UpHd9dbgXs0f+KXi9R2r5Q=;
 b=OHGLmsrCrYm3A7WMwF2bm7dPM1WtLdowKGj7L36LlxTwgmA54xbf88qSdhJqXL4fXn/0
 OPtpjH1IUytB2dvcbKjeOc4MaGE4UG1Dlsbg5kzjGM1KeVMAFpDZ9o49Ht81eyfi53S/
 YQngRoXbpTYC35N5Xgyo25+ccI/AIH/ckRU7iuH6sWLINiVy8ueXMU/qiL0M4Bhhl6Yu
 Z4lq7iYHy0GgCgK3iZ3/+DeFDwys75i7Dd8bFBs4PU66v5OqTpxezfOo3c+2Rf+gkNXx
 BFpKTjFcDKOP88rRmG9mQ9bhbR2xnZTolbaFKfdP4ckvzXChetVr3wR3fdhrILSE3wBO 9w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fca96c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 12:07:13 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294C5Ddn000563;
        Tue, 4 Oct 2022 12:07:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3jxd68u007-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 12:07:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294C785X4653690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 12:07:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6742BA4051;
        Tue,  4 Oct 2022 12:07:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF875A404D;
        Tue,  4 Oct 2022 12:07:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 12:07:07 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iommu/s390: Fix potential s390_domain aperture shrinking
Date:   Tue,  4 Oct 2022 14:07:04 +0200
Message-Id: <20221004120706.2957492-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004120706.2957492-1-schnelle@linux.ibm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2-BwUP3DdtjH36yKNjaWL-0qGh6c7qNs
X-Proofpoint-ORIG-GUID: 2-BwUP3DdtjH36yKNjaWL-0qGh6c7qNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 IOMMU driver currently sets the IOMMU domain's aperture to
match the device specific DMA address range of the device that is first
attached. This is not ideal. For one if the domain has no device
attached in the meantime the aperture could be shrunk allowing
translations outside the aperture to exist in the translation tables.
Also this is a bit of a misuse of the aperture which really should
describe what addresses can be translated and not some device specific
limitations.

Instead of misusing the aperture like this we can instead create
reserved ranges for the ranges inaccessible to the attached devices
allowing devices with overlapping ranges to still share an IOMMU domain.
This also significantly simplifies s390_iommu_attach_device() allowing
us to move the aperture check to the beginning of the function and
removing the need to hold the device list's lock to check the aperture.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 50 +++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 6f87dd4b85af..762dc55aea1e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -62,6 +62,9 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 		kfree(s390_domain);
 		return NULL;
 	}
+	s390_domain->domain.geometry.force_aperture = true;
+	s390_domain->domain.geometry.aperture_start = 0;
+	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
 
 	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
@@ -107,30 +110,24 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!zdev)
 		return -ENODEV;
 
+	if (domain->geometry.aperture_start > zdev->end_dma ||
+	    domain->geometry.aperture_end < zdev->start_dma)
+		return -EINVAL;
+
 	if (zdev->s390_domain)
 		__s390_iommu_detach_device(zdev);
 	else if (zdev->dma_table)
 		zpci_dma_exit_device(zdev);
 
-	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				virt_to_phys(zdev->dma_table));
+				virt_to_phys(s390_domain->dma_table));
 	if (cc)
 		return -EIO;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	/* First device defines the DMA range limits */
-	if (list_empty(&s390_domain->devices)) {
-		domain->geometry.aperture_start = zdev->start_dma;
-		domain->geometry.aperture_end = zdev->end_dma;
-		domain->geometry.force_aperture = true;
-	/* Allow only devices with identical DMA range limits */
-	} else if (domain->geometry.aperture_start != zdev->start_dma ||
-		   domain->geometry.aperture_end != zdev->end_dma) {
-		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		return -EINVAL;
-	}
+	zdev->dma_table = s390_domain->dma_table;
 	zdev->s390_domain = s390_domain;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_add(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
@@ -148,6 +145,30 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	zpci_dma_init_device(zdev);
 }
 
+static void s390_iommu_get_resv_regions(struct device *dev,
+					struct list_head *list)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct iommu_resv_region *region;
+
+	if (zdev->start_dma) {
+		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
+						 IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+
+	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
+		region = iommu_alloc_resv_region(zdev->end_dma + 1,
+						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
+						 0, IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+}
+
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
@@ -330,6 +351,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
-- 
2.34.1

