Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448885F6A01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiJFOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJFOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:47:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B683847A;
        Thu,  6 Oct 2022 07:47:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EiDQs032370;
        Thu, 6 Oct 2022 14:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=05aFAD1ZDT2gSF1os1+1F9Nh7pQ0X+OlYUZkQzo7VPI=;
 b=FWmCrCuHv7RrzJwo7a9TGgHcgfTW7oBgFtZ03FSfLqCyoRCcUV0vWLDQw0gs/EXnJC8L
 xP3mT0YhEK6q9z3uGVb6xt4xPbnExB1SHAWTKMn/4rS2lEdRLkYVUy9bdJ/n/XU8KoD4
 p0w15ueD2Ia31jb3nv0HR5TScyePwdUbYIZPGEy9OZIcKGoreYGp34THeC0+SEC6Vi0W
 LXJlzhP/GhR2lSpNpCVIryjA4GWSs3dLMVWIU1I/xMKRHpGmfbUU/q7tddJSFlLoyk66
 8lENDiCfh5F0d2fQJ3Ni1hZYIdEut6rlZFUplseFgLSAyL0tNbpGLJTgkXzhVnhXH7B/ vg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k208tsvjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296Ea7Hb012461;
        Thu, 6 Oct 2022 14:47:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3jxctj793x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296El2N455968158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 14:47:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12939A4051;
        Thu,  6 Oct 2022 14:47:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984F8A4055;
        Thu,  6 Oct 2022 14:47:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 14:47:01 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] iommu/s390: Fix duplicate domain attachments
Date:   Thu,  6 Oct 2022 16:46:55 +0200
Message-Id: <20221006144700.3380098-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006144700.3380098-1-schnelle@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B8neDfbAVPahAPzQ9YoBSp0XKhMrAA8o
X-Proofpoint-GUID: B8neDfbAVPahAPzQ9YoBSp0XKhMrAA8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
calls") we can end up with duplicates in the list of devices attached to
a domain. This is inefficient and confusing since only one domain can
actually be in control of the IOMMU translations for a device. Fix this
by detaching the device from the previous domain, if any, on attach.
Add a WARN_ON() in case we still have attached devices on freeing the
domain. While here remove the re-attach on failure dance as it was
determined to be unlikely to help and may confuse debug and recovery.

Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v4->v5:
- Unregister IOAT and set zdev->dma_table on error (Matt)

 drivers/iommu/s390-iommu.c | 102 ++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..938998c46bd3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -79,10 +79,36 @@ static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 
+	WARN_ON(!list_empty(&s390_domain->devices));
 	dma_cleanup_tables(s390_domain->dma_table);
 	kfree(s390_domain);
 }
 
+static void __s390_iommu_detach_device(struct zpci_dev *zdev)
+{
+	struct s390_domain *s390_domain = zdev->s390_domain;
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
+
+	if (!s390_domain)
+		return;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
+				 list) {
+		if (domain_device->zdev == zdev) {
+			list_del(&domain_device->list);
+			kfree(domain_device);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+
+	zpci_unregister_ioat(zdev, 0);
+	zdev->s390_domain = NULL;
+	zdev->dma_table = NULL;
+}
+
 static int s390_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
@@ -90,7 +116,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain_device *domain_device;
 	unsigned long flags;
-	int cc, rc;
+	int cc, rc = 0;
 
 	if (!zdev)
 		return -ENODEV;
@@ -99,23 +125,17 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!domain_device)
 		return -ENOMEM;
 
-	if (zdev->dma_table && !zdev->s390_domain) {
-		cc = zpci_dma_exit_device(zdev);
-		if (cc) {
-			rc = -EIO;
-			goto out_free;
-		}
-	}
-
 	if (zdev->s390_domain)
-		zpci_unregister_ioat(zdev, 0);
+		__s390_iommu_detach_device(zdev);
+	else if (zdev->dma_table)
+		zpci_dma_exit_device(zdev);
 
 	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(zdev->dma_table));
 	if (cc) {
 		rc = -EIO;
-		goto out_restore;
+		goto out_free;
 	}
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
@@ -127,9 +147,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	/* Allow only devices with identical DMA range limits */
 	} else if (domain->geometry.aperture_start != zdev->start_dma ||
 		   domain->geometry.aperture_end != zdev->end_dma) {
-		rc = -EINVAL;
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
+		rc = -EINVAL;
+		goto out_unregister;
 	}
 	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
@@ -138,14 +158,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	return 0;
 
-out_restore:
-	if (!zdev->s390_domain) {
-		zpci_dma_init_device(zdev);
-	} else {
-		zdev->dma_table = zdev->s390_domain->dma_table;
-		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				   virt_to_phys(zdev->dma_table));
-	}
+out_unregister:
+	zpci_unregister_ioat(zdev, 0);
+	zdev->dma_table = NULL;
 out_free:
 	kfree(domain_device);
 
@@ -155,32 +170,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 static void s390_iommu_detach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device, *tmp;
-	unsigned long flags;
-	int found = 0;
 
-	if (!zdev)
-		return;
-
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
-				 list) {
-		if (domain_device->zdev == zdev) {
-			list_del(&domain_device->list);
-			kfree(domain_device);
-			found = 1;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
 
-	if (found && (zdev->s390_domain == s390_domain)) {
-		zdev->s390_domain = NULL;
-		zpci_unregister_ioat(zdev, 0);
-		zpci_dma_init_device(zdev);
-	}
+	__s390_iommu_detach_device(zdev);
+	zpci_dma_init_device(zdev);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
@@ -193,24 +188,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 static void s390_iommu_release_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct iommu_domain *domain;
 
 	/*
-	 * This is a workaround for a scenario where the IOMMU API common code
-	 * "forgets" to call the detach_dev callback: After binding a device
-	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
-	 * the attach_dev), removing the device via
-	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
-	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
-	 * notifier.
-	 *
-	 * So let's call detach_dev from here if it hasn't been called before.
+	 * release_device is expected to detach any domain currently attached
+	 * to the device, but keep it attached to other devices in the group.
 	 */
-	if (zdev && zdev->s390_domain) {
-		domain = iommu_get_domain_for_dev(dev);
-		if (domain)
-			s390_iommu_detach_device(domain, dev);
-	}
+	if (zdev)
+		__s390_iommu_detach_device(zdev);
 }
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
-- 
2.34.1

