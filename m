Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208C65F42A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJDMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJDMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:07:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CD52823;
        Tue,  4 Oct 2022 05:07:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294Btg4V011808;
        Tue, 4 Oct 2022 12:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=50CrmorkhjAn9k8LF1NX/lIZ3fqBL2DGOnQTqbLNv2Q=;
 b=jU+kl2lLG/L3lF1Po0molWMfBuvVSHf977HqfivSahZgCBpPBuBIMXYvkwXE6TXzxKCq
 9h2GDl6D22G9Ij9AHIDeuPQtLg/9pDMt790u7O+zUu3WRCVAb6OXUvKFz0lBgE0FaNPx
 rxizXPajkUeV81/zTKeaYqYEure+XP0+Q2epeajBNJwQdKG1Sx932WvujpIrustTsL5L
 i/ksvtfqjxUht3vQjKscdxrAiHiXb28GeK4Hfx+eSjQad9PRcx2zu96izmB4saa+7wOJ
 C0aROCi3cgq3qqsx0WM618I8vugnisy42vQ94pO2raTAZu66KuhSGO/Jf+EefAO0iuPa ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0hka51b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 12:07:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294C6E1I022876;
        Tue, 4 Oct 2022 12:07:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68tyjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 12:07:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294C78Zm20382266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 12:07:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9CE2A4051;
        Tue,  4 Oct 2022 12:07:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7809CA4057;
        Tue,  4 Oct 2022 12:07:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 12:07:07 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] iommu/s390: Get rid of s390_domain_device
Date:   Tue,  4 Oct 2022 14:07:03 +0200
Message-Id: <20221004120706.2957492-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004120706.2957492-1-schnelle@linux.ibm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NvKnY4zGe-EDjDRKHU799dKd9PvtItHm
X-Proofpoint-GUID: NvKnY4zGe-EDjDRKHU799dKd9PvtItHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct s390_domain_device serves the sole purpose as list entry for
the devices list of a struct s390_domain. As it contains no additional
information besides a list_head and a pointer to the struct zpci_dev we
can simplify things and just thread the device list through struct
zpci_dev directly. This removes the need to allocate during domain
attach and gets rid of one level of indirection during mapping
operations.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 drivers/iommu/s390-iommu.c  | 45 ++++++++-----------------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 108e732d7b14..15f8714ca9b7 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -117,6 +117,7 @@ struct zpci_bus {
 struct zpci_dev {
 	struct zpci_bus *zbus;
 	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
+	struct list_head iommu_list;
 	struct kref kref;
 	struct hotplug_slot hotplug_slot;
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 0f58e897bc95..6f87dd4b85af 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -29,11 +29,6 @@ struct s390_domain {
 	spinlock_t		list_lock;
 };
 
-struct s390_domain_device {
-	struct list_head	list;
-	struct zpci_dev		*zdev;
-};
-
 static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct s390_domain, domain);
@@ -87,21 +82,13 @@ static void s390_domain_free(struct iommu_domain *domain)
 static void __s390_iommu_detach_device(struct zpci_dev *zdev)
 {
 	struct s390_domain *s390_domain = zdev->s390_domain;
-	struct s390_domain_device *domain_device, *tmp;
 	unsigned long flags;
 
 	if (!s390_domain)
 		return;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
-				 list) {
-		if (domain_device->zdev == zdev) {
-			list_del(&domain_device->list);
-			kfree(domain_device);
-			break;
-		}
-	}
+	list_del_init(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
@@ -114,17 +101,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device;
 	unsigned long flags;
-	int cc, rc = 0;
+	int cc;
 
 	if (!zdev)
 		return -ENODEV;
 
-	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
-	if (!domain_device)
-		return -ENOMEM;
-
 	if (zdev->s390_domain)
 		__s390_iommu_detach_device(zdev);
 	else if (zdev->dma_table)
@@ -133,10 +115,8 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(zdev->dma_table));
-	if (cc) {
-		rc = -EIO;
-		goto out_free;
-	}
+	if (cc)
+		return -EIO;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	/* First device defines the DMA range limits */
@@ -147,21 +127,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	/* Allow only devices with identical DMA range limits */
 	} else if (domain->geometry.aperture_start != zdev->start_dma ||
 		   domain->geometry.aperture_end != zdev->end_dma) {
-		rc = -EINVAL;
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_free;
+		return -EINVAL;
 	}
-	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
-	list_add(&domain_device->list, &s390_domain->devices);
+	list_add(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
-
-out_free:
-	kfree(domain_device);
-
-	return rc;
 }
 
 static void s390_iommu_detach_device(struct iommu_domain *domain,
@@ -198,10 +171,10 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 				   phys_addr_t pa, dma_addr_t dma_addr,
 				   size_t size, int flags)
 {
-	struct s390_domain_device *domain_device;
 	phys_addr_t page_addr = pa & PAGE_MASK;
 	dma_addr_t start_dma_addr = dma_addr;
 	unsigned long irq_flags, nr_pages, i;
+	struct zpci_dev *zdev;
 	unsigned long *entry;
 	int rc = 0;
 
@@ -226,8 +199,8 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	}
 
 	spin_lock(&s390_domain->list_lock);
-	list_for_each_entry(domain_device, &s390_domain->devices, list) {
-		rc = zpci_refresh_trans((u64) domain_device->zdev->fh << 32,
+	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+		rc = zpci_refresh_trans((u64)zdev->fh << 32,
 					start_dma_addr, nr_pages * PAGE_SIZE);
 		if (rc)
 			break;
-- 
2.34.1

