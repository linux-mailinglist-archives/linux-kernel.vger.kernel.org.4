Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931D5EF925
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiI2PgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiI2PeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:34:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62831BBEDD;
        Thu, 29 Sep 2022 08:33:44 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TFBwAb020173;
        Thu, 29 Sep 2022 15:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eLv+D7E8TNLHVkQrCKbusJgnQTi60vyDaamF+hWxM/0=;
 b=OiIDS+rT1BTETDRpGmcRbG3bpE9+mTkZBQrd9gAM9K7shw05Y5hxHZatEkk7zcYGM3Sp
 dotpuvgp5QjD7eGgZ9IJA+l3k7ik3z1TNArovTiQvrCqPdH49u638/MCEZt7egJwbupA
 7CUK5Opj6RoGnBSFonFdSzKEwGcXMOvDmQiEB0Gxc5zIYqQ0FSRyybNbg3PhY2hG0Kbl
 U2NnzJtJZOs1OSVaoYpWzWcs9enJgNvw4wxueH3H+MpXsefAG/4waqkjX8AI7w9+vvd/
 tJjg6bM7FK+fhMwOvt45wv8T0+wem4CAj1kLCsY71udhx7aB1GN0TI1wZJ4DI29zmJ+t qg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwdsrgnua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 15:33:08 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TFKElW031819;
        Thu, 29 Sep 2022 15:33:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3jss5hw676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 15:33:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TFX3wG066250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 15:33:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314FCAE045;
        Thu, 29 Sep 2022 15:33:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B901DAE051;
        Thu, 29 Sep 2022 15:33:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 15:33:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iommu/s390: Fix duplicate domain attachments
Date:   Thu, 29 Sep 2022 17:32:58 +0200
Message-Id: <20220929153302.3195115-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153302.3195115-1-schnelle@linux.ibm.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sHZNOoCo4o5zp6QeOrVzaFqtjxRB2PgQ
X-Proofpoint-GUID: sHZNOoCo4o5zp6QeOrVzaFqtjxRB2PgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_08,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=865 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209290097
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
Changes since v2:
- Make __s390_iommu_detach_device() return void (Jason)
- Remove superfluous locking when we're freeing anyway (Jason)
- Remove the re-attach on failure dance as it is unlikely to help
  and complicates debug and recovery (Jason)
- Ignore attempts to detach from domain that the device is no longer
  attached to.

 drivers/iommu/s390-iommu.c | 77 +++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..6fcb64e4b5e6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -79,10 +79,36 @@ static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 
+	WARN_ON(!list_empty(&s390_domain->devices));
 	dma_cleanup_tables(s390_domain->dma_table);
 	kfree(s390_domain);
 }
 
+static void __s390_iommu_detach_device(struct s390_domain *s390_domain,
+				       struct zpci_dev *zdev)
+{
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
+
+	if (!zdev || zdev->s390_domain != s390_domain)
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
+		__s390_iommu_detach_device(zdev->s390_domain, zdev);
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
@@ -129,7 +149,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		   domain->geometry.aperture_end != zdev->end_dma) {
 		rc = -EINVAL;
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
+		goto out_free;
 	}
 	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
@@ -138,14 +158,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	return 0;
 
-out_restore:
-	if (!zdev->s390_domain) {
-		zpci_dma_init_device(zdev);
-	} else {
-		zdev->dma_table = zdev->s390_domain->dma_table;
-		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				   virt_to_phys(zdev->dma_table));
-	}
 out_free:
 	kfree(domain_device);
 
@@ -157,30 +169,9 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device, *tmp;
-	unsigned long flags;
-	int found = 0;
-
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
 
-	if (found && (zdev->s390_domain == s390_domain)) {
-		zdev->s390_domain = NULL;
-		zpci_unregister_ioat(zdev, 0);
-		zpci_dma_init_device(zdev);
-	}
+	__s390_iommu_detach_device(s390_domain, zdev);
+	zpci_dma_init_device(zdev);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
-- 
2.34.1

