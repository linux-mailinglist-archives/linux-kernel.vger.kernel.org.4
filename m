Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DD5EF930
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiI2Pf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiI2PeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:34:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384201B85FF;
        Thu, 29 Sep 2022 08:33:36 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TEvdJg008199;
        Thu, 29 Sep 2022 15:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=19EenvoiR41cQ+1ka7jMc6VV5oYSjOaJebgHsdqZ2ts=;
 b=X9KpmFpaFh3XpTRpng6j0Tbxm5QnIXem9W28IwumtpVu4Ff08WZnj9Ew6cvOv8uGOqAA
 rQeJ/DNtI9rziUFLMI3osJprAfoQ3b+hqFII+24k4BG60occBDhJ9X1vqea+y6pDqKg7
 14a2G27gVt/oiKt6y5sCVnIZPlIzVTdZkeOvb9/FSlpq33wJEkn1Sd07u/2If9W7ftaM
 kZfm30aBhcAQ1j08wOf9lPwS02H4sKQefQFyL1bOakVjUrOnawTOy6wN4GyBsZnHZ5jO
 MOqKgzS6zaiVFzjmtSWqrSMhQgpGY6oVHtkFqze1pUjgBXe45wbT6JMEDD1+IuxVv3aN HA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwdk7s73j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 15:33:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TFLOQo013738;
        Thu, 29 Sep 2022 15:33:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8w5rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 15:33:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TFX45b3211962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 15:33:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E815AE045;
        Thu, 29 Sep 2022 15:33:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B6EAE051;
        Thu, 29 Sep 2022 15:33:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 15:33:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iommu/s390: Fix potential s390_domain aperture shrinking
Date:   Thu, 29 Sep 2022 17:33:00 +0200
Message-Id: <20220929153302.3195115-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153302.3195115-1-schnelle@linux.ibm.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bLMGWErvq7PeB-8I7uoMMMDK_N9aum3b
X-Proofpoint-ORIG-GUID: bLMGWErvq7PeB-8I7uoMMMDK_N9aum3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_08,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290097
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
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 50 +++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 8c4b180b3247..ed0e64f478cf 100644
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
 		__s390_iommu_detach_device(zdev->s390_domain, zdev);
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
 
@@ -147,6 +144,30 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
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
@@ -340,6 +361,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
-- 
2.34.1

