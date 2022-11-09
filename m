Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAD622DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKIO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKIO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:29:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7B140C9;
        Wed,  9 Nov 2022 06:29:27 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Ds3hl026270;
        Wed, 9 Nov 2022 14:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4kTuTBw92c/DytV/q7UcPXb4WIEHFMdb7d5jYFs1+yo=;
 b=NDB4UIwFj0VrrS3jsjV9Wq5FweZYFRlvToeLdcalhV5W3kY512T+3wUXahEWOFKrkYwD
 QXDe+I0PW2+AUsvRXkZvCw23hhT1TpnxEGwY8RPcrWofreeZwmrErPgYBHzITKHYLkdH
 u6G2nwrjRVMRtjvbPWM7so4/F2c4qlNWcE1kOkadgiqTTSyZYw+FLGIXrUd34xnReavN
 OxZY/oTrx8vw/iPzDbHlwDjFLyqoR+DIUyuxqUCA4tC7X0uzDgiJY+QoNv4AuTm9WJly
 t38wLpXVBj7x2DYP6kdbHrTWh9XM3WhRrswIjlWIok4UMF1KMJH7bABBqknUPvZncAOs wg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdg7h4sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9EK5Ql000631;
        Wed, 9 Nov 2022 14:29:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3kngs4m7qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9ET5da54985202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:29:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 978C0A4051;
        Wed,  9 Nov 2022 14:29:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2933EA4057;
        Wed,  9 Nov 2022 14:29:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 14:29:05 +0000 (GMT)
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
Subject: [PATCH v2 2/5] iommu/s390: Add I/O TLB ops
Date:   Wed,  9 Nov 2022 15:29:00 +0100
Message-Id: <20221109142903.4080275-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142903.4080275-1-schnelle@linux.ibm.com>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t-GWkEAdqw2b0yZIyQq-C-prvo5ZiU7U
X-Proofpoint-GUID: t-GWkEAdqw2b0yZIyQq-C-prvo5ZiU7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090107
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
v1->v2:
- Don't skip IOTLB flushes for other devices on IOTLB flush failure (Jason)

 drivers/iommu/s390-iommu.c | 67 +++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index e2c886bc4376..9771bce86e94 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -199,14 +199,63 @@ static void s390_iommu_release_device(struct device *dev)
 		__s390_iommu_detach_device(zdev);
 }
 
+static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
+				   zdev->end_dma - zdev->start_dma + 1);
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
+
+	/* If gather was never added to there is nothing to flush */
+	if (!gather->end)
+		return;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
+				   size);
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
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		if (!zdev->tlb_refresh)
+			continue;
+		zpci_refresh_trans((u64)zdev->fh << 32,
+				   iova, size);
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
 
@@ -225,15 +274,6 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
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
@@ -340,6 +380,8 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 	if (rc)
 		return 0;
 
+	iommu_iotlb_gather_add_range(gather, iova, size);
+
 	return size;
 }
 
@@ -384,6 +426,9 @@ static const struct iommu_ops s390_iommu_ops = {
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

