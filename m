Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7160CB64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiJYL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiJYL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:57:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C610EE65;
        Tue, 25 Oct 2022 04:57:30 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PB7tYT030375;
        Tue, 25 Oct 2022 11:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k5TWJEbnOa4d5XGxqWCqQIGLk27m8XCdjUeE9UlhQCQ=;
 b=YqZt5WByh/ZkjjbhsxfeRNMSLtddSCvQf6o4el7KbgJCDHAgzI24ua5CUcMeyBMI8wp1
 2yPhnQB4bu+q5C2UC/S8/jaSmb60Ggvf1bxQ6tqQW1mUxLgnwh11lhAofIZy+ufXCMR/
 xvMHo+a2LbjEWtYrRpjVB9iHcWMSL9LVXcXZnO9TeXLEIoMK7iQb4edP9FfLBACCjnN3
 uW0PldRh/HiEaAIedNVGTyEnnbx9uyFsZbVFpWLTM5XefNUEorfdDqJIrxT/4llbZV8r
 A6sW1ftb5VMD9vgXhyqcX5DX07Q03+kr6vXJPXJCT33clanz/GJv1yx9fwnpw030ZBlT AQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedu336ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:07 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PBoAn7027204;
        Tue, 25 Oct 2022 11:57:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3kc7sj40pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PBvZbd41550316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 11:57:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C9942047;
        Tue, 25 Oct 2022 11:57:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAF5442041;
        Tue, 25 Oct 2022 11:57:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 11:57:00 +0000 (GMT)
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
Subject: [PATCH v8 6/6] iommu/s390: Implement map_pages()/unmap_pages() instead of map()/unmap()
Date:   Tue, 25 Oct 2022 13:56:57 +0200
Message-Id: <20221025115657.1666860-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025115657.1666860-1-schnelle@linux.ibm.com>
References: <20221025115657.1666860-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SMs0Bc3OlKoJABiuRJjLU3w0MKYhvKLu
X-Proofpoint-ORIG-GUID: SMs0Bc3OlKoJABiuRJjLU3w0MKYhvKLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While s390-iommu currently implements the map_page()/unmap_page()
operations which only map/unmap a single page at a time the internal
s390_iommu_update_trans() API already supports mapping/unmapping a range
of pages at once. Take advantage of this by implementing the
map_pages()/unmap_pages() operations instead thus allowing users of the
IOMMU drivers to map multiple pages in a single call followed by
a single I/O TLB flush if needed.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v7->v8:
- Added Jason's R-b

 drivers/iommu/s390-iommu.c | 48 +++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 104dfbec1037..7fb512bece9a 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -196,20 +196,15 @@ static void s390_iommu_release_device(struct device *dev)
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 				   phys_addr_t pa, dma_addr_t dma_addr,
-				   size_t size, int flags)
+				   unsigned long nr_pages, int flags)
 {
 	phys_addr_t page_addr = pa & PAGE_MASK;
 	dma_addr_t start_dma_addr = dma_addr;
-	unsigned long irq_flags, nr_pages, i;
+	unsigned long irq_flags, i;
 	struct zpci_dev *zdev;
 	unsigned long *entry;
 	int rc = 0;
 
-	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
-	    (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end)
-		return -EINVAL;
-
-	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	if (!nr_pages)
 		return 0;
 
@@ -252,11 +247,24 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	return rc;
 }
 
-static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int s390_iommu_map_pages(struct iommu_domain *domain,
+				unsigned long iova, phys_addr_t paddr,
+				size_t pgsize, size_t pgcount,
+				int prot, gfp_t gfp, size_t *mapped)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	int flags = ZPCI_PTE_VALID, rc = 0;
+	size_t size = pgcount << __ffs(pgsize);
+
+	if (pgsize != SZ_4K)
+		return -EINVAL;
+
+	if (iova < s390_domain->domain.geometry.aperture_start ||
+	    (iova + size - 1) > s390_domain->domain.geometry.aperture_end)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(iova | paddr, pgsize))
+		return -EINVAL;
 
 	if (!(prot & IOMMU_READ))
 		return -EINVAL;
@@ -265,7 +273,9 @@ static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		flags |= ZPCI_TABLE_PROTECTED;
 
 	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
-				     size, flags);
+				     pgcount, flags);
+	if (!rc)
+		*mapped = size;
 
 	return rc;
 }
@@ -301,21 +311,27 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static size_t s390_iommu_unmap(struct iommu_domain *domain,
-			       unsigned long iova, size_t size,
-			       struct iommu_iotlb_gather *gather)
+static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
+				     unsigned long iova,
+				     size_t pgsize, size_t pgcount,
+				     struct iommu_iotlb_gather *gather)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
+	size_t size = pgcount << __ffs(pgsize);
 	int flags = ZPCI_PTE_INVALID;
 	phys_addr_t paddr;
 	int rc;
 
+	if (WARN_ON(iova < s390_domain->domain.geometry.aperture_start ||
+	    (iova + size - 1) > s390_domain->domain.geometry.aperture_end))
+		return 0;
+
 	paddr = s390_iommu_iova_to_phys(domain, iova);
 	if (!paddr)
 		return 0;
 
 	rc = s390_iommu_update_trans(s390_domain, paddr, iova,
-				     size, flags);
+				     pgcount, flags);
 	if (rc)
 		return 0;
 
@@ -361,8 +377,8 @@ static const struct iommu_ops s390_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
-		.map		= s390_iommu_map,
-		.unmap		= s390_iommu_unmap,
+		.map_pages	= s390_iommu_map_pages,
+		.unmap_pages	= s390_iommu_unmap_pages,
 		.iova_to_phys	= s390_iommu_iova_to_phys,
 		.free		= s390_domain_free,
 	}
-- 
2.34.1

