Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C4654338
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiLVOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiLVOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:34:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2E2B627;
        Thu, 22 Dec 2022 06:34:48 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMEFFCb027242;
        Thu, 22 Dec 2022 14:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KmdS9rUzjesq1B709Sm7Kwl2XLfu6My20QnZdfuetHQ=;
 b=Nm/IfUUYB+DVftRYd+L4Axspq8g/0dp6RuHTAla9V+LYjBXgkRY8QccT+NE6xdFyqxvp
 aBRb6cYXqN2QM5DWITT2d+Vu5chFm5/iZZZDzpEM4NCltNz/VPboYyQ0624NEOaZ85F2
 Ias06bzUVvjhkMjHN6PqUR2y86kasY4IxL3YhAlCeqUxgtyWLmEUW5pWewETt2q4T/Xy
 l6EEzg5jeviFrdEszqZiflMTaWtgptrADjFup8OD13ECQTEAU0leriynTjYDt/8m+ghd
 uTtwb36euPhF8TvRv4L5k3Zqud/vccc8BYYviEoED80DAfJi+0GTndfnu+/CylAZf7wC 9w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mmru5ggt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:34:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM4mMd0000918;
        Thu, 22 Dec 2022 14:34:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mh6ywq66d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:34:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BMEY3oV49086918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:34:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F0E20043;
        Thu, 22 Dec 2022 14:34:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C00C20040;
        Thu, 22 Dec 2022 14:34:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Dec 2022 14:34:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2] iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
Date:   Thu, 22 Dec 2022 15:34:03 +0100
Message-Id: <20221222143403.1732400-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r0L39jM9_IpaGLoCmU2_owM7I7ivmA5g
X-Proofpoint-ORIG-GUID: r0L39jM9_IpaGLoCmU2_owM7I7ivmA5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2:
- Add missing return in gart_iommu_sync_map() (Jason)

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
index d3b39d0416fa..35476eb389a1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2189,14 +2189,15 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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
index 48cdcd0a5cf3..8299517e0f8b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4699,8 +4699,8 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
-static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
-				       unsigned long iova, size_t size)
+static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long pages = aligned_nrpages(iova, size);
@@ -4710,6 +4710,7 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
+	return 0;
 }
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65a3b3d886dc..7e72ec9ab367 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2300,8 +2300,17 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
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
@@ -2449,8 +2458,11 @@ static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
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
index 16179a9a7283..415b7008dd2f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -484,12 +484,13 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
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
index 2ab2ecfe01f8..d437946231bf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -749,12 +749,13 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
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
index fadd2c907222..08c25f6e7157 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -329,8 +329,8 @@ static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static void sprd_iommu_sync_map(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+static int sprd_iommu_sync_map(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned int reg;
@@ -342,6 +342,7 @@ static void sprd_iommu_sync_map(struct iommu_domain *domain,
 
 	/* clear IOMMU TLB buffer after page table updated */
 	sprd_iommu_write(dom->sdev, reg, 0xffffffff);
+	return 0;
 }
 
 static void sprd_iommu_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e5ca3cf1a949..19b79150e459 100644
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
index 3c9da1f8979e..359f471f9ef8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -300,8 +300,8 @@ struct iommu_domain_ops {
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

