Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734395F6A02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJFOro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJFOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:47:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F113F27;
        Thu,  6 Oct 2022 07:47:27 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EiFuQ031381;
        Thu, 6 Oct 2022 14:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f1lP9+TFFJcVoiQtQiBe0qF76QG0WB9rE0zPyhG3o+M=;
 b=OT7bxv3RtqshsmnL/j+4RItTg7thzfgqvmM9O6sRHOPOthJpsYL2MjOVT6YGSkNE1o59
 Pvi50ikblCY2suQ7L1gFH9FWkOrFAqhSrzjOWHV+sMoD8X26EGYXQBK1+Voo3dZv78B2
 IktRcXGDWHGYYaSUHlNKskKOrM1e4cPXLofAQJj7LbhvO8Z1YVJW5NHj5uZMCozaY84I
 e9M1x7+yQeM9k2aU17y83wR/zByIzwXHKfqN6/Y1pGyggEJqw1yvqrspG2Ocf3e7J+EW
 PoasQCcof/FuK5uqXb12R0s1v//Za7bI3gkFFaZLx4xQdo/yIAJquVHXF5j1eCq+Rs1A aQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k208tsvjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:08 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296EalKM014425;
        Thu, 6 Oct 2022 14:47:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68wau0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296ElX9j53149990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 14:47:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14D11A404D;
        Thu,  6 Oct 2022 14:47:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99FBCA4053;
        Thu,  6 Oct 2022 14:47:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 14:47:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] iommu/s390: Fix potential s390_domain aperture shrinking
Date:   Thu,  6 Oct 2022 16:46:57 +0200
Message-Id: <20221006144700.3380098-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006144700.3380098-1-schnelle@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GIGcntRw0OuBT6cOD1k7jxGSiyeTC8Ic
X-Proofpoint-GUID: GIGcntRw0OuBT6cOD1k7jxGSiyeTC8Ic
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

As we then use the same aperture for all domains and it only depends on
the table properties we can already check zdev->start_dma/end_dma at
probe time and turn the check on attach into a WARN_ON().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v4->v5:
- Make aperture check in attach a WARN_ON() and fail in probe if
  zdev->start_dma/end_dma doesn't git in aperture  (Jason)

 drivers/iommu/s390-iommu.c | 65 +++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9b3ae4b14636..1f6c9bee9a80 100644
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
@@ -102,46 +105,32 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	unsigned long flags;
-	int cc, rc = 0;
+	int cc;
 
 	if (!zdev)
 		return -ENODEV;
 
+	WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
+		domain->geometry.aperture_end < zdev->start_dma);
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
-		rc = -EINVAL;
-		goto out_unregister;
-	}
+	zdev->dma_table = s390_domain->dma_table;
 	zdev->s390_domain = s390_domain;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_add(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
-
-out_unregister:
-	zpci_unregister_ioat(zdev, 0);
-	zdev->dma_table = NULL;
-
-	return rc;
 }
 
 static void s390_iommu_detach_device(struct iommu_domain *domain,
@@ -155,10 +144,41 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
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
 
+	if (zdev->start_dma > zdev->end_dma ||
+	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
+		return ERR_PTR(-EINVAL);
+
+	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
+		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
+
 	return &zdev->iommu_dev;
 }
 
@@ -337,6 +357,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
-- 
2.34.1

