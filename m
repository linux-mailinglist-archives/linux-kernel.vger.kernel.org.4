Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3B602ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJROwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJROv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:51:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A7CD5CF;
        Tue, 18 Oct 2022 07:51:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEb6uc020482;
        Tue, 18 Oct 2022 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y40TQkm/ZnRKoH3GsxCmsZ4syLt7ZMojVUT0PEPJfR8=;
 b=CI4tJXHyU23O7eUIjF11gg1Z4gqB9A33N4EUPiKzINnFMeoDAD9Ta+1T62SroJ73MRaa
 UYiOoTbDdqUkCyE07iFfCaTyruxv9rxGs4f0B2FXNINqSCFveh3d5SxtNsuoMiDXFc+F
 k+RNdMw/7Pkw6VmLLE+20prI2EK8VZt/l5nTkDArC+VkqJ+F1GGqSVDq98aSVAm2gnEw
 L4IxfQmAY05QldEKdRgdudcm2w7SLcLZJpxQSHVloR2s5Mt2hJSgCyYOLW/dQVS/xp3u
 sGiK4g4356JFOkcxEnvJV6JGvtD7RG/q+btCcqvNbjZR18iP9UNrl9wn51MXo0+LMoOj lw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9vt03n7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IEopsu013418;
        Tue, 18 Oct 2022 14:51:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jnfq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IEpXFY3408488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:51:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C4852051;
        Tue, 18 Oct 2022 14:51:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4240552050;
        Tue, 18 Oct 2022 14:51:33 +0000 (GMT)
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
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/s390: Add I/O TLB ops
Date:   Tue, 18 Oct 2022 16:51:29 +0200
Message-Id: <20221018145132.998866-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018145132.998866-1-schnelle@linux.ibm.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bdL_S_Al1h7BXiuZgr-CH-lo8Xih-SJ-
X-Proofpoint-ORIG-GUID: bdL_S_Al1h7BXiuZgr-CH-lo8Xih-SJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently s390-iommu does an I/O TLB flush (RPCIT) for every update of
the I/O translation table explicitly. For one this is wasteful since
RPCIT can be skipped after a mapping operation if zdev->tlb_refresh is
unset. Moreover we can do a single RPCIT for a range of pages including
whne doing lazy unmapping.

Thankfully both of these optimizations can be achieved by implementing
the IOMMU operations common code provides for the different types of I/O
tlb flushes:

 * flush_iotlb_all: Flushes the I/O TLB for the entire IOVA space
 * iotlb_sync:  Flushes the I/O TLB for a range of pages that can be
   gathered up, for example to implement lazy unmapping.
 * iotlb_sync_map: Flushes the I/O TLB after a mapping operation

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 76 ++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ee88e717254b..a4c2e9bc6d83 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -199,14 +199,72 @@ static void s390_iommu_release_device(struct device *dev)
 		__s390_iommu_detach_device(zdev);
 }
 
+static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
+					zdev->end_dma - zdev->start_dma + 1);
+		if (rc)
+			break;
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+}
+
+static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
+				  struct iommu_iotlb_gather *gather)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	size_t size = gather->end - gather->start + 1;
+	struct zpci_dev *zdev;
+	unsigned long flags;
+	int rc;
+
+	/* If gather was never added to there is nothing to flush */
+	if (gather->start == ULONG_MAX)
+		return;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
+					size);
+		if (rc)
+			break;
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+}
+
+static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		if (!zdev->tlb_refresh)
+			continue;
+		rc = zpci_refresh_trans((u64)zdev->fh << 32,
+					iova, size);
+		if (rc)
+			break;
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+}
+
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 				   phys_addr_t pa, dma_addr_t dma_addr,
 				   unsigned long nr_pages, int flags)
 {
 	phys_addr_t page_addr = pa & PAGE_MASK;
-	dma_addr_t start_dma_addr = dma_addr;
 	unsigned long irq_flags, i;
-	struct zpci_dev *zdev;
 	unsigned long *entry;
 	int rc = 0;
 
@@ -225,15 +283,6 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 		dma_addr += PAGE_SIZE;
 	}
 
-	spin_lock(&s390_domain->list_lock);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
-		rc = zpci_refresh_trans((u64)zdev->fh << 32,
-					start_dma_addr, nr_pages * PAGE_SIZE);
-		if (rc)
-			break;
-	}
-	spin_unlock(&s390_domain->list_lock);
-
 undo_cpu_trans:
 	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
 		flags = ZPCI_PTE_INVALID;
@@ -340,6 +389,8 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 	if (rc)
 		return 0;
 
+	iommu_iotlb_gather_add_range(gather, iova, size);
+
 	return size;
 }
 
@@ -384,6 +435,9 @@ static const struct iommu_ops s390_iommu_ops = {
 		.detach_dev	= s390_iommu_detach_device,
 		.map_pages	= s390_iommu_map_pages,
 		.unmap_pages	= s390_iommu_unmap_pages,
+		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
+		.iotlb_sync      = s390_iommu_iotlb_sync,
+		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
 		.iova_to_phys	= s390_iommu_iova_to_phys,
 		.free		= s390_domain_free,
 	}
-- 
2.34.1

