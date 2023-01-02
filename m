Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361765B1A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjABL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjABL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:56:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930060E7;
        Mon,  2 Jan 2023 03:56:44 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30299CMO000376;
        Mon, 2 Jan 2023 11:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gA2loGumSUyLAMES3RNGJI9wmReWefsXlmYtbplv7Cc=;
 b=TZ2vLwTbyamW9GlQOaB2g1IDll8VsqqstrfMuh9MOPj7I7H++n6SySbz+O4FVHWVsYHl
 Oocuo6YCzlP3+2vCSv4t0nGDpyZpaFeB+aus1YHSBtXcL7qLnJ8oeDMb6hpnh9enzKe6
 LLheDSLLK+ZAELnDiDMyHaVuCkuRHZnkI6fE77olCoQcq/OpFtz5+Erot5J3lYXkG+44
 bm6FXxVCtdZu47tO3RZ7d0c4TXADB0oSdY25Xd8pQIr9eu3WopEq7KPaClJKvRFEWLzn
 SYFhwsThTuu5qZ2TWDtor8grCO/DIRr1dMCdYixI68oZbaQmIvrVEyT1HxtJBcp6MZ77 lw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxvt7sm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 11:56:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3029OvXF004235;
        Mon, 2 Jan 2023 11:56:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6hrtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 11:56:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302BuLCv19399198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 11:56:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F22E620040;
        Mon,  2 Jan 2023 11:56:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92CD920049;
        Mon,  2 Jan 2023 11:56:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 11:56:20 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v3 2/7] iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
Date:   Mon,  2 Jan 2023 12:56:14 +0100
Message-Id: <20230102115619.2088685-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102115619.2088685-1-schnelle@linux.ibm.com>
References: <20230102115619.2088685-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YpKuK7iC2HBR0H1OZX5n6IUgxU01CmWT
X-Proofpoint-ORIG-GUID: YpKuK7iC2HBR0H1OZX5n6IUgxU01CmWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=917 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 .iotlb_sync_map is used to sync mappings to an underlying
hypervisor by letting the hypervisor inspect the synced IOVA range and
updating its shadow table. This however means that it can fail as the
hypervisor may run out of resources. This can be due to the hypervisor
being unable to pin guest pages, due to a limit on concurrently mapped
addresses such as vfio_iommu_type1.dma_entry_limit or other resources.
Either way such a failure to sync a mapping should result in
a DMA_MAPPING_EROR.

Now especially when running with batched IOTLB flushes for unmap it may
be that some IOVAs have already been invalidated but not yet synced via
.iotlb_sync_map. Thus if the hypervisor indicates running out of
resources, first do a global flush allowing the hypervisor to free
resources associated with these mappings and only if that also fails
report this error to callers.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/amd/iommu.c   |  5 +++--
 drivers/iommu/apple-dart.c  |  5 +++--
 drivers/iommu/intel/iommu.c |  5 +++--
 drivers/iommu/iommu.c       | 20 ++++++++++++++++----
 drivers/iommu/msm_iommu.c   |  5 +++--
 drivers/iommu/mtk_iommu.c   |  5 +++--
 drivers/iommu/s390-iommu.c  | 29 ++++++++++++++++++++++++-----
 drivers/iommu/sprd-iommu.c  |  5 +++--
 drivers/iommu/tegra-gart.c  |  5 +++--
 include/linux/iommu.h       |  4 ++--
 10 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..3df7d20e0e52 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2180,14 +2180,15 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				     unsigned long iova, size_t size)
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
 	if (ops->map_pages)
 		domain_flush_np_cache(domain, iova, size);
+	return 0;
 }
 
 static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..4a76f4d95459 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -344,10 +344,11 @@ static void apple_dart_iotlb_sync(struct iommu_domain *domain,
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
 }
 
-static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
-				      unsigned long iova, size_t size)
+static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
 {
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
+	return 0;
 }
 
 static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..3b36a544c8fa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4725,8 +4725,8 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
-static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
-				       unsigned long iova, size_t size)
+static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long pages = aligned_nrpages(iova, size);
@@ -4736,6 +4736,7 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
+	return 0;
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..8f97ed81b123 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2367,8 +2367,17 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 
 	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
-	if (ret == 0 && ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain, iova, size);
+	if (ret == 0 && ops->iotlb_sync_map) {
+		ret = ops->iotlb_sync_map(domain, iova, size);
+		if (ret)
+			goto out_err;
+	}
+
+	return ret;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, size);
 
 	return ret;
 }
@@ -2516,8 +2525,11 @@ static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
-	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain, iova, mapped);
+	if (ops->iotlb_sync_map) {
+		ret = ops->iotlb_sync_map(domain, iova, mapped);
+		if (ret)
+			goto out_err;
+	}
 	return mapped;
 
 out_err:
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c60624910872..62fc52765554 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -486,12 +486,13 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static void msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+static int msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			      size_t size)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
 
 	__flush_iotlb_range(iova, size, SZ_4K, false, priv);
+	return 0;
 }
 
 static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2badd6acfb23..76d413aef1ef 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -758,12 +758,13 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->bank);
 }
 
-static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+static int mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			      size_t size)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
 	mtk_iommu_tlb_flush_range_sync(iova, size, dom->bank);
+	return 0;
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ed33c6cce083..6ba38b4f5b37 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -210,6 +210,14 @@ static void s390_iommu_release_device(struct device *dev)
 		__s390_iommu_detach_device(zdev);
 }
 
+
+static int zpci_refresh_all(struct zpci_dev *zdev)
+{
+	return zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
+				  zdev->end_dma - zdev->start_dma + 1);
+
+}
+
 static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
@@ -217,8 +225,7 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
-		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
-				   zdev->end_dma - zdev->start_dma + 1);
+		zpci_refresh_all(zdev);
 	}
 	rcu_read_unlock();
 }
@@ -242,20 +249,32 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
+static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
+	int ret = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		if (!zdev->tlb_refresh)
 			continue;
-		zpci_refresh_trans((u64)zdev->fh << 32,
-				   iova, size);
+		ret = zpci_refresh_trans((u64)zdev->fh << 32,
+					 iova, size);
+		/*
+		 * let the hypervisor disover invalidated entries
+		 * allowing it to free IOVAs and unpin pages
+		 */
+		if (ret == -ENOMEM) {
+			ret = zpci_refresh_all(zdev);
+			if (ret)
+				break;
+		}
 	}
 	rcu_read_unlock();
+
+	return ret;
 }
 
 static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 219bfa11f7f4..9e590829992c 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -330,8 +330,8 @@ static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
-static void sprd_iommu_sync_map(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+static int sprd_iommu_sync_map(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned int reg;
@@ -343,6 +343,7 @@ static void sprd_iommu_sync_map(struct iommu_domain *domain,
 
 	/* clear IOMMU TLB buffer after page table updated */
 	sprd_iommu_write(dom->sdev, reg, 0xffffffff);
+	return 0;
 }
 
 static void sprd_iommu_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ed53279d1106..a59966290e46 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -252,10 +252,11 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
-static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
-				size_t size)
+static int gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			       size_t size)
 {
 	FLUSH_GART_REGS(gart_handle);
+	return 0;
 }
 
 static void gart_iommu_sync(struct iommu_domain *domain,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..e7f76599f09e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -332,8 +332,8 @@ struct iommu_domain_ops {
 			      struct iommu_iotlb_gather *iotlb_gather);
 
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
-			       size_t size);
+	int (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
+			      size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
 
-- 
2.34.1

