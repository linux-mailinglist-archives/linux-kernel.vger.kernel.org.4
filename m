Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3C622DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiKIO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiKIO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:29:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA91D660;
        Wed,  9 Nov 2022 06:29:30 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9ES939006282;
        Wed, 9 Nov 2022 14:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+BistWnd4z+7A7K5tuip7U85T3+3GQn4XSKxpGUsq+Y=;
 b=GgxzX9u3+/yTAhAytmryq7bBadgpmDsleLlsa3zdJJS6/y8PgshW24B4ynlvBWjF7IaO
 FovsyRMBbtLYxASrLSitY3/VWAclQRbeGxMGTraa1RdctrpIxGhZ2dTh7ga6DRV5ZTKb
 iRWeJuJ0gXF/wj3WNI+xiA35QLRSk4OLTG795zH+XcD3XrvmsP+bncnIkLB9HXhEdOLC
 pcIuFrD6u3P1MTHntQnO3i4G7GcnedfNUeemJqupO1VbpBwlDHqnNZgZcUqSqaxHaZAV
 MzV+cper85wIFRjIw+DU4s/Hby8h/vcHIkkANK7bpxus4a60DdfijP8awdInN0q5kkFG vw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kre03g0j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:12 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9ELak8032332;
        Wed, 9 Nov 2022 14:29:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3kngpgm7y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9ET7Ok39125570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:29:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E243A4040;
        Wed,  9 Nov 2022 14:29:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EA5BA4053;
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
Subject: [PATCH v2 5/5] s390/pci: use lock-free I/O translation updates
Date:   Wed,  9 Nov 2022 15:29:03 +0100
Message-Id: <20221109142903.4080275-6-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142903.4080275-1-schnelle@linux.ibm.com>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -NJ252kKyB_6gvm23IRyInYhFsCRGi_E
X-Proofpoint-ORIG-GUID: -NJ252kKyB_6gvm23IRyInYhFsCRGi_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I/O translation tables on s390 use 8 byte page table entries and tables
which are allocated lazily but only freed when the entire I/O
translation table is torn down. Also each IOVA can at any time only
translate to one physical address Furthermore I/O table accesses by the
IOMMU hardware are cache coherent. With a bit of care we can thus use
atomic updates to manipulate the translation table without having to use
a global lock at all. This is done analogous to the existing I/O
translation table handling code used on Intel and AMD x86 systems.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 -
 arch/s390/pci/pci_dma.c     | 74 ++++++++++++++++++++++---------------
 drivers/iommu/s390-iommu.c  | 37 +++++++------------
 3 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index e4c3e4e04d30..b248694e0024 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -157,7 +157,6 @@ struct zpci_dev {
 
 	/* DMA stuff */
 	unsigned long	*dma_table;
-	spinlock_t	dma_table_lock;
 	int		tlb_refresh;
 
 	spinlock_t	iommu_bitmap_lock;
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index dee825ee7305..ea478d11fbd1 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -63,37 +63,55 @@ static void dma_free_page_table(void *table)
 	kmem_cache_free(dma_page_table_cache, table);
 }
 
-static unsigned long *dma_get_seg_table_origin(unsigned long *entry)
+static unsigned long *dma_get_seg_table_origin(unsigned long *rtep)
 {
+	unsigned long old_rte, rte;
 	unsigned long *sto;
 
-	if (reg_entry_isvalid(*entry))
-		sto = get_rt_sto(*entry);
-	else {
+	rte = READ_ONCE(*rtep);
+	if (reg_entry_isvalid(rte)) {
+		sto = get_rt_sto(rte);
+	} else {
 		sto = dma_alloc_cpu_table();
 		if (!sto)
 			return NULL;
 
-		set_rt_sto(entry, virt_to_phys(sto));
-		validate_rt_entry(entry);
-		entry_clr_protected(entry);
+		set_rt_sto(&rte, virt_to_phys(sto));
+		validate_rt_entry(&rte);
+		entry_clr_protected(&rte);
+
+		old_rte = cmpxchg(rtep, ZPCI_TABLE_INVALID, rte);
+		if (old_rte != ZPCI_TABLE_INVALID) {
+			/* Somone else was faster, use theirs */
+			dma_free_cpu_table(sto);
+			sto = get_rt_sto(old_rte);
+		}
 	}
 	return sto;
 }
 
-static unsigned long *dma_get_page_table_origin(unsigned long *entry)
+static unsigned long *dma_get_page_table_origin(unsigned long *step)
 {
+	unsigned long old_ste, ste;
 	unsigned long *pto;
 
-	if (reg_entry_isvalid(*entry))
-		pto = get_st_pto(*entry);
-	else {
+	ste = READ_ONCE(*step);
+	if (reg_entry_isvalid(ste)) {
+		pto = get_st_pto(ste);
+	} else {
 		pto = dma_alloc_page_table();
 		if (!pto)
 			return NULL;
-		set_st_pto(entry, virt_to_phys(pto));
-		validate_st_entry(entry);
-		entry_clr_protected(entry);
+		set_st_pto(&ste, virt_to_phys(pto));
+		validate_st_entry(&ste);
+		entry_clr_protected(&ste);
+
+		old_ste = cmpxchg(step, ZPCI_TABLE_INVALID, ste);
+		if (old_ste != ZPCI_TABLE_INVALID) {
+			/* Somone else was faster, use theirs */
+			dma_free_page_table(pto);
+			pto = get_st_pto(old_ste);
+		}
 	}
 	return pto;
 }
@@ -117,19 +135,24 @@ unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr)
 	return &pto[px];
 }
 
-void dma_update_cpu_trans(unsigned long *entry, phys_addr_t page_addr, int flags)
+void dma_update_cpu_trans(unsigned long *ptep, phys_addr_t page_addr, int flags)
 {
+	unsigned long pte;
+
+	pte = READ_ONCE(*ptep);
 	if (flags & ZPCI_PTE_INVALID) {
-		invalidate_pt_entry(entry);
+		invalidate_pt_entry(&pte);
 	} else {
-		set_pt_pfaa(entry, page_addr);
-		validate_pt_entry(entry);
+		set_pt_pfaa(&pte, page_addr);
+		validate_pt_entry(&pte);
 	}
 
 	if (flags & ZPCI_TABLE_PROTECTED)
-		entry_set_protected(entry);
+		entry_set_protected(&pte);
 	else
-		entry_clr_protected(entry);
+		entry_clr_protected(&pte);
+
+	xchg(ptep, pte);
 }
 
 static int __dma_update_trans(struct zpci_dev *zdev, phys_addr_t pa,
@@ -137,18 +160,14 @@ static int __dma_update_trans(struct zpci_dev *zdev, phys_addr_t pa,
 {
 	unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	phys_addr_t page_addr = (pa & PAGE_MASK);
-	unsigned long irq_flags;
 	unsigned long *entry;
 	int i, rc = 0;
 
 	if (!nr_pages)
 		return -EINVAL;
 
-	spin_lock_irqsave(&zdev->dma_table_lock, irq_flags);
-	if (!zdev->dma_table) {
-		rc = -EINVAL;
-		goto out_unlock;
-	}
+	if (!zdev->dma_table)
+		return -EINVAL;
 
 	for (i = 0; i < nr_pages; i++) {
 		entry = dma_walk_cpu_trans(zdev->dma_table, dma_addr);
@@ -173,8 +192,6 @@ static int __dma_update_trans(struct zpci_dev *zdev, phys_addr_t pa,
 			dma_update_cpu_trans(entry, page_addr, flags);
 		}
 	}
-out_unlock:
-	spin_unlock_irqrestore(&zdev->dma_table_lock, irq_flags);
 	return rc;
 }
 
@@ -558,7 +575,6 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 	WARN_ON(zdev->s390_domain);
 
 	spin_lock_init(&zdev->iommu_bitmap_lock);
-	spin_lock_init(&zdev->dma_table_lock);
 
 	zdev->dma_table = dma_alloc_cpu_table();
 	if (!zdev->dma_table) {
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 2b9a3e3bc606..ed33c6cce083 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -20,7 +20,6 @@ struct s390_domain {
 	struct iommu_domain	domain;
 	struct list_head	devices;
 	unsigned long		*dma_table;
-	spinlock_t		dma_table_lock;
 	spinlock_t		list_lock;
 	struct rcu_head		rcu;
 };
@@ -62,7 +61,6 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 	s390_domain->domain.geometry.aperture_start = 0;
 	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
 
-	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD_RCU(&s390_domain->devices);
 
@@ -265,14 +263,10 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 				     unsigned long nr_pages, int flags)
 {
 	phys_addr_t page_addr = pa & PAGE_MASK;
-	unsigned long irq_flags, i;
 	unsigned long *entry;
+	unsigned long i;
 	int rc;
 
-	if (!nr_pages)
-		return 0;
-
-	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
 	for (i = 0; i < nr_pages; i++) {
 		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr);
 		if (unlikely(!entry)) {
@@ -283,7 +277,6 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 		page_addr += PAGE_SIZE;
 		dma_addr += PAGE_SIZE;
 	}
-	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
 
 	return 0;
 
@@ -296,7 +289,6 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 			break;
 		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
 	}
-	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
 
 	return rc;
 }
@@ -304,14 +296,10 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
 				       dma_addr_t dma_addr, unsigned long nr_pages)
 {
-	unsigned long irq_flags, i;
 	unsigned long *entry;
+	unsigned long i;
 	int rc = 0;
 
-	if (!nr_pages)
-		return 0;
-
-	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
 	for (i = 0; i < nr_pages; i++) {
 		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr);
 		if (unlikely(!entry)) {
@@ -321,7 +309,6 @@ static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
 		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
 		dma_addr += PAGE_SIZE;
 	}
-	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
 
 	return rc;
 }
@@ -363,7 +350,8 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
-	unsigned long *sto, *pto, *rto, flags;
+	unsigned long *rto, *sto, *pto;
+	unsigned long ste, pte, rte;
 	unsigned int rtx, sx, px;
 	phys_addr_t phys = 0;
 
@@ -376,16 +364,17 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 	px = calc_px(iova);
 	rto = s390_domain->dma_table;
 
-	spin_lock_irqsave(&s390_domain->dma_table_lock, flags);
-	if (rto && reg_entry_isvalid(rto[rtx])) {
-		sto = get_rt_sto(rto[rtx]);
-		if (sto && reg_entry_isvalid(sto[sx])) {
-			pto = get_st_pto(sto[sx]);
-			if (pto && pt_entry_isvalid(pto[px]))
-				phys = pto[px] & ZPCI_PTE_ADDR_MASK;
+	rte = READ_ONCE(rto[rtx]);
+	if (reg_entry_isvalid(rte)) {
+		sto = get_rt_sto(rte);
+		ste = READ_ONCE(sto[sx]);
+		if (reg_entry_isvalid(ste)) {
+			pto = get_st_pto(ste);
+			pte = READ_ONCE(pto[px]);
+			if (pt_entry_isvalid(pte))
+				phys = pte & ZPCI_PTE_ADDR_MASK;
 		}
 	}
-	spin_unlock_irqrestore(&s390_domain->dma_table_lock, flags);
 
 	return phys;
 }
-- 
2.34.1

