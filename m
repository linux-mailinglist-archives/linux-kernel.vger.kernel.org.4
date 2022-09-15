Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A455B9E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIOPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIOPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:19:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CA90C77;
        Thu, 15 Sep 2022 08:14:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FF2GHm018031;
        Thu, 15 Sep 2022 15:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9g9fTZ+qsfNqdsQyxDmdlflS+F/f6ED2oz+Ff2v70a4=;
 b=DtoGrrkk92pe91uSlNikrdkjjOnGiwFEicd0leW0XjaUN2AbQCq4+VINdT4X/33KQArd
 xGH25xLwX5o8hCQP9cjT7iEBEfBnuxrdoJzkTTVmcXtfvB5aFwLC9NZX981qBQADcdwF
 LAusByI5UoKUWDx9aa2UMvjkLkK3/ZP6gzTU6nDvvwO8wJFpYhoupm5aN2I8WK5xGOUn
 qaRlu2XCiwPnw7t3nCQwiGRM+J19JF3R96J1iv9zPCf2YJWUdtCYBhe1PdETCm6TqE7G
 EBP639euDAZrBuUpYDVbbfleVGcz5ET8rn9NTiQDlqI1AAiKecRTY+6evkEw8Tq7IxHf og== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm6b9rjpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FF7JoM004731;
        Thu, 15 Sep 2022 15:14:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3jjy95tk18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FFE3cb39911928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 15:14:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A03F52050;
        Thu, 15 Sep 2022 15:14:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BD67452051;
        Thu, 15 Sep 2022 15:14:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/s390: Fix duplicate domain attachments
Date:   Thu, 15 Sep 2022 17:14:00 +0200
Message-Id: <20220915151402.121032-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915151402.121032-1-schnelle@linux.ibm.com>
References: <20220915151402.121032-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 13gusAirV4Hokwh3nn92iFuH2lqGk5bn
X-Proofpoint-ORIG-GUID: 13gusAirV4Hokwh3nn92iFuH2lqGk5bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=980 clxscore=1011 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150085
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
This also makes the restore behavior analogous between IOMMU and DMA API
control.

Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 82 ++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..de8f76775240 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -83,14 +83,41 @@ static void s390_domain_free(struct iommu_domain *domain)
 	kfree(s390_domain);
 }
 
+static bool __s390_iommu_detach_device(struct s390_domain *s390_domain,
+				     struct zpci_dev *zdev)
+{
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
+				 list) {
+		if (domain_device->zdev == zdev) {
+			list_del(&domain_device->list);
+			kfree(domain_device);
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+
+	if (found) {
+		zdev->s390_domain = NULL;
+		zpci_unregister_ioat(zdev, 0);
+	}
+	return found;
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
@@ -99,16 +126,16 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!domain_device)
 		return -ENOMEM;
 
-	if (zdev->dma_table && !zdev->s390_domain) {
-		cc = zpci_dma_exit_device(zdev);
-		if (cc) {
+	if (zdev->s390_domain) {
+		prev_domain = zdev->s390_domain;
+		if (!__s390_iommu_detach_device(zdev->s390_domain, zdev))
+			rc = -EIO;
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
@@ -129,7 +156,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		   domain->geometry.aperture_end != zdev->end_dma) {
 		rc = -EINVAL;
 		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
+		goto out_unregister_restore;
 	}
 	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
@@ -138,14 +165,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
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
 
@@ -157,30 +185,14 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device, *tmp;
-	unsigned long flags;
-	int found = 0;
+	bool detached;
 
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
+	detached = __s390_iommu_detach_device(s390_domain, zdev);
+	if (detached)
 		zpci_dma_init_device(zdev);
-	}
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
-- 
2.34.1

