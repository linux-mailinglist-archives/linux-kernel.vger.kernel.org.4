Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90107622DED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiKIO3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiKIO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:29:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601915723;
        Wed,  9 Nov 2022 06:29:27 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EMLwH016148;
        Wed, 9 Nov 2022 14:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v+m/PVmU2IZKQ9M47SlpOzQCxGsERfoxOf9GirUx1Pg=;
 b=VdpFaC9/fjW0iyKGUiYXQBV9JIT9DYVUFwXhCKN7B3u9Ef2C/dbGMQwF7xQqn/LqHPQR
 WUE9z9Zy8L7IBa1EWYIjOoxewX1luTpwWmy085NV3BqiPMn/M1LjTYseTRRCISO86sLY
 WBhvCXZrKcukS1I87p5huTOrUSuudn65PFTWFz6hNS45oan+wobjpWA6PxQOeAhqGlbz
 UiO9zyytm0zWKdYqNttpQCS2iuJXTPer0OIXErS5xtChq4/IvvJPfeKyNmiKiumVJg3K
 7NmgIAfMPEbFbpLxzX74RlKrcsStXv5ezxgre2iNnRi0lkuwUTCfoOpJXcLS90S6kz9r 9Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdwpg4qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9EK54F026865;
        Wed, 9 Nov 2022 14:29:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgdtqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9ET6FZ38470046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:29:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93541A4040;
        Wed,  9 Nov 2022 14:29:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25FF6A4051;
        Wed,  9 Nov 2022 14:29:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 14:29:06 +0000 (GMT)
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
Subject: [PATCH v2 4/5] iommu/s390: Optimize IOMMU table walking
Date:   Wed,  9 Nov 2022 15:29:02 +0100
Message-Id: <20221109142903.4080275-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142903.4080275-1-schnelle@linux.ibm.com>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3nqj8d6u60titnld1rHHy-oHqu1-xk-4
X-Proofpoint-ORIG-GUID: 3nqj8d6u60titnld1rHHy-oHqu1-xk-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=893 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
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

When invalidating existing table entries for unmap there is no need to
know the physical address beforehand so don't do an extra walk of the
IOMMU table to get it. Also when invalidating entries not finding an
entry indicates an invalid unmap and not a lack of memory we also don't
need to undo updates in this case. Implement this by splitting
s390_iommu_update_trans() in a variant for validating and one for
invalidating translations.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 69 ++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cf5dcbcea4e0..2b9a3e3bc606 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -260,14 +260,14 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-static int s390_iommu_update_trans(struct s390_domain *s390_domain,
-				   phys_addr_t pa, dma_addr_t dma_addr,
-				   unsigned long nr_pages, int flags)
+static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
+				     phys_addr_t pa, dma_addr_t dma_addr,
+				     unsigned long nr_pages, int flags)
 {
 	phys_addr_t page_addr = pa & PAGE_MASK;
 	unsigned long irq_flags, i;
 	unsigned long *entry;
-	int rc = 0;
+	int rc;
 
 	if (!nr_pages)
 		return 0;
@@ -275,7 +275,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
 	for (i = 0; i < nr_pages; i++) {
 		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr);
-		if (!entry) {
+		if (unlikely(!entry)) {
 			rc = -ENOMEM;
 			goto undo_cpu_trans;
 		}
@@ -283,19 +283,43 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 		page_addr += PAGE_SIZE;
 		dma_addr += PAGE_SIZE;
 	}
+	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
+
+	return 0;
 
 undo_cpu_trans:
-	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
-		flags = ZPCI_PTE_INVALID;
-		while (i-- > 0) {
-			page_addr -= PAGE_SIZE;
-			dma_addr -= PAGE_SIZE;
-			entry = dma_walk_cpu_trans(s390_domain->dma_table,
-						   dma_addr);
-			if (!entry)
-				break;
-			dma_update_cpu_trans(entry, page_addr, flags);
+	while (i-- > 0) {
+		dma_addr -= PAGE_SIZE;
+		entry = dma_walk_cpu_trans(s390_domain->dma_table,
+					   dma_addr);
+		if (!entry)
+			break;
+		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
+	}
+	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
+
+	return rc;
+}
+
+static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
+				       dma_addr_t dma_addr, unsigned long nr_pages)
+{
+	unsigned long irq_flags, i;
+	unsigned long *entry;
+	int rc = 0;
+
+	if (!nr_pages)
+		return 0;
+
+	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
+	for (i = 0; i < nr_pages; i++) {
+		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr);
+		if (unlikely(!entry)) {
+			rc = -EINVAL;
+			break;
 		}
+		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
+		dma_addr += PAGE_SIZE;
 	}
 	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
 
@@ -308,8 +332,8 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
 				int prot, gfp_t gfp, size_t *mapped)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
-	int flags = ZPCI_PTE_VALID, rc = 0;
 	size_t size = pgcount << __ffs(pgsize);
+	int flags = ZPCI_PTE_VALID, rc = 0;
 
 	if (pgsize != SZ_4K)
 		return -EINVAL;
@@ -327,8 +351,8 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
 	if (!(prot & IOMMU_WRITE))
 		flags |= ZPCI_TABLE_PROTECTED;
 
-	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
-				     pgcount, flags);
+	rc = s390_iommu_validate_trans(s390_domain, paddr, iova,
+				       pgcount, flags);
 	if (!rc)
 		*mapped = size;
 
@@ -373,20 +397,13 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	size_t size = pgcount << __ffs(pgsize);
-	int flags = ZPCI_PTE_INVALID;
-	phys_addr_t paddr;
 	int rc;
 
 	if (WARN_ON(iova < s390_domain->domain.geometry.aperture_start ||
 	    (iova + size - 1) > s390_domain->domain.geometry.aperture_end))
 		return 0;
 
-	paddr = s390_iommu_iova_to_phys(domain, iova);
-	if (!paddr)
-		return 0;
-
-	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
-				     pgcount, flags);
+	rc = s390_iommu_invalidate_trans(s390_domain, iova, pgcount);
 	if (rc)
 		return 0;
 
-- 
2.34.1

