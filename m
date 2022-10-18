Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB0602ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJROwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJROv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:51:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197FCC832;
        Tue, 18 Oct 2022 07:51:58 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEb502020402;
        Tue, 18 Oct 2022 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PdqIZHpAB6x58Yr67htvefM7oXxERTQQ63QZKd9bejA=;
 b=Ffyx+inSRtFOBesEPMzR1n7pYWuAmr+zdTWg4+D8xgIdYQLtmyzWWU6O7chENsCUYvgs
 riV3WZop2YnfjSjv1yE5C3b3gX9Ep0Oe/ZuwHxxMJNt5Duh6mp/W0yIJHr73nODZ8dIY
 hpotqq5qoxu1yw8bEubhwsZ36c5RPC9YGZYxjjJqtN+6XQ31eed81zSpr+HMSfsVb05I
 XIsY7A4Ifzp7Apqoomi/L9Fd9J8xTNCIvh8UnPyUIqZlQ+2DmCL5nqeKVbr1+4mEd/IH
 OZ3AHYI01NOksDyDgoy0p4OpFTYNDT39qxkxH48D7EngZA5T6Zyq6ARPUSXFWAJUv3Hs eg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9vt03n83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IEpEQC001544;
        Tue, 18 Oct 2022 14:51:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg95fc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IEq7S250200846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:52:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F33E52051;
        Tue, 18 Oct 2022 14:51:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B42E152054;
        Tue, 18 Oct 2022 14:51:33 +0000 (GMT)
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
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list iteration
Date:   Tue, 18 Oct 2022 16:51:30 +0200
Message-Id: <20221018145132.998866-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018145132.998866-1-schnelle@linux.ibm.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7hRy3bXDF6ctmnw4xCQcCRPUXE74SKq9
X-Proofpoint-ORIG-GUID: 7hRy3bXDF6ctmnw4xCQcCRPUXE74SKq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390_domain->devices list is only added to when new devices are
attached but is iterated through in read-only fashion for every mapping
operation as well as for I/O TLB flushes and thus in performance
critical code causing contention on the s390_domain->list_lock.
Fortunately such a read-mostly linked list is a standard use case for
RCU. This change closely follows the example fpr RCU protected list
given in Documentation/RCU/listRCU.rst.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         |  2 +-
 drivers/iommu/s390-iommu.c  | 31 ++++++++++++++++---------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 07361e2fd8c5..e4c3e4e04d30 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -119,6 +119,7 @@ struct zpci_dev {
 	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
 	struct list_head iommu_list;
 	struct kref kref;
+	struct rcu_head rcu;
 	struct hotplug_slot hotplug_slot;
 
 	enum zpci_state state;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index a703dcd94a68..ef38b1514c77 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -996,7 +996,7 @@ void zpci_release_device(struct kref *kref)
 		break;
 	}
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
-	kfree(zdev);
+	kfree_rcu(zdev, rcu);
 }
 
 int zpci_report_error(struct pci_dev *pdev,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index a4c2e9bc6d83..4e90987be387 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -10,6 +10,8 @@
 #include <linux/iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/sizes.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <asm/pci_dma.h>
 
 static const struct iommu_ops s390_iommu_ops;
@@ -61,7 +63,7 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 
 	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
-	INIT_LIST_HEAD(&s390_domain->devices);
+	INIT_LIST_HEAD_RCU(&s390_domain->devices);
 
 	return &s390_domain->domain;
 }
@@ -70,7 +72,9 @@ static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 
+	rcu_read_lock();
 	WARN_ON(!list_empty(&s390_domain->devices));
+	rcu_read_unlock();
 	dma_cleanup_tables(s390_domain->dma_table);
 	kfree(s390_domain);
 }
@@ -84,7 +88,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
 		return;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_del_init(&zdev->iommu_list);
+	list_del_rcu(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
@@ -127,7 +131,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	zdev->s390_domain = s390_domain;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_add(&zdev->iommu_list, &s390_domain->devices);
+	list_add_rcu(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
@@ -203,17 +207,16 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
-	unsigned long flags;
 	int rc;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
 					zdev->end_dma - zdev->start_dma + 1);
 		if (rc)
 			break;
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -222,21 +225,20 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	size_t size = gather->end - gather->start + 1;
 	struct zpci_dev *zdev;
-	unsigned long flags;
 	int rc;
 
 	/* If gather was never added to there is nothing to flush */
 	if (gather->start == ULONG_MAX)
 		return;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
 					size);
 		if (rc)
 			break;
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
@@ -244,11 +246,10 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
-	unsigned long flags;
 	int rc;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		if (!zdev->tlb_refresh)
 			continue;
 		rc = zpci_refresh_trans((u64)zdev->fh << 32,
@@ -256,7 +257,7 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		if (rc)
 			break;
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
-- 
2.34.1

