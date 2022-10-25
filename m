Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EA60CB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJYL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiJYL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D375CED;
        Tue, 25 Oct 2022 04:57:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PB80Ho023008;
        Tue, 25 Oct 2022 11:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u+bp7DIW9VjPoZwaAFrgJMmr83Aha+pCvl3ztX85Qzk=;
 b=VCysFadJhZewhwUfmz3VoksrEQ690Ts2WboKacEpAJ5DrolOL8wFoky5YucyYkfmbe6/
 BBgcfl522JcLtP6QLLoY/pfkgyHbkqPzwanjW6KMVT1Mrtflsw3wnWzf/l7hmnUJWwdb
 YHdHpZrXJtbP8Avkak+Jk5FozFLnqZs0QtWua7LNXC80VelcuwOhaiD5bGCfD3PG2V/v
 nTMhVnSgkGS8sZ0goc3ie2tWmB412zfO5HlHB7HnypcyxBtEJ8QNAHIKASmPjj1PFf90
 M8Uqo4t/HC99ObQ5KgPwSxtM3a675Rpx66H5/egpSJZaRfsln6/8NqFkze0wZukfkAYe lA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmp3njv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PBosVw013634;
        Tue, 25 Oct 2022 11:57:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3kc859m0da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PBuxS42491072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 11:56:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FB334203F;
        Tue, 25 Oct 2022 11:56:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F75442041;
        Tue, 25 Oct 2022 11:56:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 11:56:59 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v8 3/6] iommu/s390: Fix potential s390_domain aperture shrinking
Date:   Tue, 25 Oct 2022 13:56:54 +0200
Message-Id: <20221025115657.1666860-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025115657.1666860-1-schnelle@linux.ibm.com>
References: <20221025115657.1666860-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OkyfhYi4kw4dTh827ZrXMUZB7LNiJIq-
X-Proofpoint-ORIG-GUID: OkyfhYi4kw4dTh827ZrXMUZB7LNiJIq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250067
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v7->v8:
- Added Jason's R-b
- Added GFP_KERNEL param to iommu_alloc_resv_region()
v5->v6:
- Return -EINVAL after WARN_ON() in attach
v4->v5:
- Make aperture check in attach a WARN_ON() and fail in probe if
  zdev->start_dma/end_dma doesn't git in aperture  (Jason)

 drivers/iommu/s390-iommu.c | 63 ++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index af83ccde16a4..9b3adc61005c 100644
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
@@ -102,11 +105,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	unsigned long flags;
-	int cc, rc = 0;
+	int cc;
 
 	if (!zdev)
 		return -ENODEV;
 
+	if (WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
+		domain->geometry.aperture_end < zdev->start_dma))
+		return -EINVAL;
+
 	if (zdev->s390_domain)
 		__s390_iommu_detach_device(zdev);
 	else if (zdev->dma_table)
@@ -118,30 +125,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		return -EIO;
 	zdev->dma_table = s390_domain->dma_table;
 
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
@@ -155,6 +146,30 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
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
+						 IOMMU_RESV_RESERVED, GFP_KERNEL);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+
+	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
+		region = iommu_alloc_resv_region(zdev->end_dma + 1,
+						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
+						 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+}
+
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev;
@@ -164,6 +179,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 
 	zdev = to_zpci_dev(dev);
 
+	if (zdev->start_dma > zdev->end_dma ||
+	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
+		return ERR_PTR(-EINVAL);
+
+	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
+		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
+
 	return &zdev->iommu_dev;
 }
 
@@ -342,6 +364,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
-- 
2.34.1

