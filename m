Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D85E5EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiIVJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIVJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C2D4AB5;
        Thu, 22 Sep 2022 02:53:10 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M9l6rl004094;
        Thu, 22 Sep 2022 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iFPzyc+1zpfNBkQxlnUTKpOGKxYzWSgrTkAMFIFkP0M=;
 b=kXqoF+ylTtQKHUmiyTSfAD7BhHLNRXiHH74SETVPYLzop7Horzkku9llDA1Vvg6Ajo79
 c34nTb+j7yX+k9jidex3lTUWBKi/aqG95raZXuQfltZ96g4soBGadq/386RdD6cdcZR3
 pBi9kUIXfXU4CclFTIZ9y0v3IzROp8a/W8FauhA7vQb+A8X81qOOv3hpjx/Iy1gnEy6O
 d/3xn7QZR5YnoB22GO81MfNfFWa1FkL/AZP+tLaVNKq+2ecH49cerzYQgv84DcY0yDMR
 1JoyWfa4tUL/eUg+Ei/jpXrsPbdp1xzuXTK2GlHqoZN7dpm7CgHPsjMjnPNvmy+P2zdD sA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrk3t4ejr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:47 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28M9pICB031345;
        Thu, 22 Sep 2022 09:52:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3jn5v94u0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28M9mdx733620342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 09:48:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 311C44C04E;
        Thu, 22 Sep 2022 09:52:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B50D44C044;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/s390: Get rid of s390_domain_device
Date:   Thu, 22 Sep 2022 11:52:39 +0200
Message-Id: <20220922095239.2115309-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922095239.2115309-1-schnelle@linux.ibm.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zVi65bFWdXyqlcOAKOFoh6E3zjfsOLzU
X-Proofpoint-GUID: zVi65bFWdXyqlcOAKOFoh6E3zjfsOLzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an s390_domain is freed without previously detaching all devices
the corresponding s390_domain_device is leaked. Instead of fixing this
leak by freeing the s390_domain_devices in s390_domain_free() do one
better and just get rid of s390_domain_device entirely by threading the
domain's device list through struct zpci_dev. This also gets rid of
a level of indirection during operations but also the allocation of
the s390_domain_device during attach thus making it more reliable under
memory pressure.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes since v1:
- No need to iterate the devices list on detach just delete with
  the zpci_dev handle we have (Jason)
- Don't remove list entries on s390_domain_free() instead warn on
  non-empty list as part of patch 1

 arch/s390/include/asm/pci.h |  1 +
 drivers/iommu/s390-iommu.c  | 33 ++++++---------------------------
 2 files changed, 7 insertions(+), 27 deletions(-)

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
index 187d2c7ba9ff..e58b5d089418 100644
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
@@ -90,19 +85,11 @@ static void s390_domain_free(struct iommu_domain *domain)
 static int __s390_iommu_detach_device(struct s390_domain *s390_domain,
 				      struct zpci_dev *zdev)
 {
-	struct s390_domain_device *domain_device, *tmp;
 	unsigned long flags;
 
 	WARN_ON(zdev->s390_domain != s390_domain);
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
@@ -116,7 +103,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device;
 	struct s390_domain *prev_domain = NULL;
 	unsigned long flags;
 	int cc, rc = 0;
@@ -124,10 +110,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!zdev)
 		return -ENODEV;
 
-	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
-	if (!domain_device)
-		return -ENOMEM;
-
 	if (zdev->s390_domain) {
 		prev_domain = zdev->s390_domain;
 		rc = __s390_iommu_detach_device(zdev->s390_domain, zdev);
@@ -136,7 +118,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 			rc = -EIO;
 	}
 	if (rc)
-		goto out_free;
+		return rc;
 
 	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
@@ -159,9 +141,8 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 		goto out_unregister_restore;
 	}
-	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
-	list_add(&domain_device->list, &s390_domain->devices);
+	list_add(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
@@ -175,8 +156,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 					 dev);
 	else
 		zpci_dma_init_device(zdev);
-out_free:
-	kfree(domain_device);
 
 	return rc;
 }
@@ -228,10 +207,10 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
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
 
@@ -256,8 +235,8 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
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

