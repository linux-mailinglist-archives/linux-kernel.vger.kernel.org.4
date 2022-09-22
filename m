Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7E5E5EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiIVJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIVJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0783D5751;
        Thu, 22 Sep 2022 02:53:08 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M9pFZA030921;
        Thu, 22 Sep 2022 09:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V/AKv34B1wYd1USNyD5bC30pUdajk7W8PfV5PBos2Gw=;
 b=oOfTuR8CN5UceRA2EWa87vP1k42rIZpq9xkxjcj42g/in1XcPIq5fwkhpmluTSoj2mup
 wvobg4GZnClLmKa5+ceGlDAi/8cTEfKbkbIVZks00OT+rHfVQid4ekveENr9eFUgbuGu
 0BrHV634xsEA9F2MwZ+QDqIPMmXnO3Te2Xh33D4VGNWEjc7EVsr7SmtN7YgHLmrIRvIT
 x5oR6tAanL+L68kQmr+gxvBQLm8P5Z8RDITC1yNA65d4ewM+LGITHNPqxHLeHJTuezGL
 m7NZEtuPcBDcF4Y3+9Pt35mdexYQFi3RjUE1DXDritMCd9qZF0XEIzrRU+2+hAlc9/he vA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrnek80v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28M9pKFi024355;
        Thu, 22 Sep 2022 09:52:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jn5v96eyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28M9r73741746796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 09:53:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214554C044;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A24274C046;
        Thu, 22 Sep 2022 09:52:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 09:52:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Date:   Thu, 22 Sep 2022 11:52:37 +0200
Message-Id: <20220922095239.2115309-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922095239.2115309-1-schnelle@linux.ibm.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iy3L1H_JV98y_a8kMtHrwj-ktAvEgCMF
X-Proofpoint-GUID: Iy3L1H_JV98y_a8kMtHrwj-ktAvEgCMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=989 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209220063
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
domain.

Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes since v1:
- WARN_ON() non-empty list in s390_domain_free()
- Drop the found flag and instead WARN_ON() if we're detaching
  from a domain that isn't the active domain for the device

 drivers/iommu/s390-iommu.c | 81 ++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..187d2c7ba9ff 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -78,19 +78,48 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
+	unsigned long flags;
 
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	WARN_ON(!list_empty(&s390_domain->devices));
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 	dma_cleanup_tables(s390_domain->dma_table);
 	kfree(s390_domain);
 }
 
+static int __s390_iommu_detach_device(struct s390_domain *s390_domain,
+				      struct zpci_dev *zdev)
+{
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
+
+	WARN_ON(zdev->s390_domain != s390_domain);
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
+	return 0;
+}
+
 static int s390_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain_device *domain_device;
+	struct s390_domain *prev_domain = NULL;
 	unsigned long flags;
-	int cc, rc;
+	int cc, rc = 0;
 
 	if (!zdev)
 		return -ENODEV;
@@ -99,16 +128,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!domain_device)
 		return -ENOMEM;
 
-	if (zdev->dma_table && !zdev->s390_domain) {
-		cc = zpci_dma_exit_device(zdev);
-		if (cc) {
+	if (zdev->s390_domain) {
+		prev_domain = zdev->s390_domain;
+		rc = __s390_iommu_detach_device(zdev->s390_domain, zdev);
+	} else if (zdev->dma_table) {
+		if (zpci_dma_exit_device(zdev))
 			rc = -EIO;
-			goto out_free;
-		}
 	}
-
-	if (zdev->s390_domain)
-		zpci_unregister_ioat(zdev, 0);
+	if (rc)
+		goto out_free;
 
 	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
@@ -129,7 +157,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		   domain->geometry.aperture_end != zdev->end_dma) {
 		rc = -EINVAL;
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
+		goto out_unregister_restore;
 	}
 	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
@@ -138,14 +166,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	return 0;
 
+out_unregister_restore:
+	zpci_unregister_ioat(zdev, 0);
 out_restore:
-	if (!zdev->s390_domain) {
+	zdev->dma_table = NULL;
+	if (prev_domain)
+		s390_iommu_attach_device(&prev_domain->domain,
+					 dev);
+	else
 		zpci_dma_init_device(zdev);
-	} else {
-		zdev->dma_table = zdev->s390_domain->dma_table;
-		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				   virt_to_phys(zdev->dma_table));
-	}
 out_free:
 	kfree(domain_device);
 
@@ -157,30 +186,12 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device, *tmp;
-	unsigned long flags;
-	int found = 0;
 
 	if (!zdev)
 		return;
 
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
+	if (!__s390_iommu_detach_device(s390_domain, zdev))
 		zpci_dma_init_device(zdev);
-	}
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
-- 
2.34.1

