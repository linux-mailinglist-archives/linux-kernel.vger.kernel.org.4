Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFD60CB61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJYL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJYL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF394C01D;
        Tue, 25 Oct 2022 04:57:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PB7x7b022968;
        Tue, 25 Oct 2022 11:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6ap+xyTxqShdrg/o9l0PjSEFOFh+Z/FYE9NvPzet1+8=;
 b=bqvxn1fPwOKaWqHY1RuYSqOI3wat9c6dg4MNETjPmty/60I+dnVnAW+i4o9YPtRmF1+T
 YretLXBFd5AYTitzMCeIIr/BVajKHBK8A/CwKATR+wk8AmNfGJJ3Hjw+W41V53YF1C7H
 fIEK/MCCNb7uOnRy6KbYAK+9vehmbq1vk1rWAf6jLwTFG+4K9XiYqPmTu83If1yBQ6Nr
 +RIIAvwq2hSPso8apWn2pj26gf/8IZOec7UPrkF1R352M+/tLuWhsVblIGD/f9IjQ9SI
 WvmdmFy/viyNgJQWl4ZFgf/V6RSl0Vgf7Uz5fU8KS/HVobd3h0uisbDT6d9/MiplwXZ0 7g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmp3njb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PBppgo005336;
        Tue, 25 Oct 2022 11:57:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kc859dj64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PBuwaU459512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 11:56:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78FD04203F;
        Tue, 25 Oct 2022 11:56:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA95842041;
        Tue, 25 Oct 2022 11:56:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 11:56:57 +0000 (GMT)
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
Subject: [PATCH v8 1/6] iommu/s390: Fix duplicate domain attachments
Date:   Tue, 25 Oct 2022 13:56:52 +0200
Message-Id: <20221025115657.1666860-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025115657.1666860-1-schnelle@linux.ibm.com>
References: <20221025115657.1666860-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: weZxKZLm9eW69ZSesfCHehuoAzthYaYj
X-Proofpoint-ORIG-GUID: weZxKZLm9eW69ZSesfCHehuoAzthYaYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250067
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v7->v8:
- Added Jason's R-b
v6->v7:
- Added Matt's R-b
v5->v6:
- Only set zdev->dma_table once zpci_register_ioat() succeeded (Matt)
v4->v5:
- Unregister IOAT and set zdev->dma_table on error (Matt)

 drivers/iommu/s390-iommu.c | 106 ++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3c071782f6f1..c2e5e81d609e 100644
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
@@ -99,24 +125,18 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
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
 
-	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				virt_to_phys(zdev->dma_table));
+				virt_to_phys(s390_domain->dma_table));
 	if (cc) {
 		rc = -EIO;
-		goto out_restore;
+		goto out_free;
 	}
+	zdev->dma_table = s390_domain->dma_table;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	/* First device defines the DMA range limits */
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
+	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
 
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
-
-	if (found && (zdev->s390_domain == s390_domain)) {
-		zdev->s390_domain = NULL;
-		zpci_unregister_ioat(zdev, 0);
-		zpci_dma_init_device(zdev);
-	}
+	__s390_iommu_detach_device(zdev);
+	zpci_dma_init_device(zdev);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
@@ -198,24 +193,13 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
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

