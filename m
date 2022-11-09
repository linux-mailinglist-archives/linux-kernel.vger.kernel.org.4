Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B3622DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKIO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiKIO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:29:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793418384;
        Wed,  9 Nov 2022 06:29:25 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9DxYLZ006660;
        Wed, 9 Nov 2022 14:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=izBFDgbVKHNBefeE4boPFsbeLvNsC62xJH5EVEQLiiA=;
 b=QhMXisSfxp57kiOxT9hu41X9u4QUzFLS8mc9nNPI1kXijWBwfeOvTjhTDQtt/zls5Z4E
 TJV6nRrDTEWrquu4YYYwf88g86aM2I8r+iJmyI9I5SySf9HliOwJ1J9N481U4/bPorv/
 LFqhDsSvWAscGebIbP12Aac8sZSxSxmu+rCw+wnsCKjPNfsa+vqzoimCUphj4ILsIAni
 q/98kV98s0/C/EVEOKEpcAxK6n8lp7fNIRlylVpmEtmz6f7zMPBt9OeK68r8zeyd1ubQ
 0J7KrLGholQJnM6O0W06Y6nJmiyVkSBNPmI77tuIvDHlnYo2Eh+W5yWGokBSD9d3FLdY 5Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdjprye2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:12 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9EJtsV021709;
        Wed, 9 Nov 2022 14:29:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3krcbr03jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9ET6jO38470044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:29:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19E1EA404D;
        Wed,  9 Nov 2022 14:29:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2CD4A4040;
        Wed,  9 Nov 2022 14:29:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 14:29:05 +0000 (GMT)
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
Subject: [PATCH v2 3/5] iommu/s390: Use RCU to allow concurrent domain_list iteration
Date:   Wed,  9 Nov 2022 15:29:01 +0100
Message-Id: <20221109142903.4080275-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142903.4080275-1-schnelle@linux.ibm.com>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q_F5OMFiaz7D4I5FizMLr-E7pL5dVz2x
X-Proofpoint-GUID: q_F5OMFiaz7D4I5FizMLr-E7pL5dVz2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090107
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
v1->v2:
- Free domain tables via call_rcu() (Jason)

 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         |  2 +-
 drivers/iommu/s390-iommu.c  | 44 +++++++++++++++++++++++--------------
 3 files changed, 29 insertions(+), 18 deletions(-)

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
index 9771bce86e94..cf5dcbcea4e0 100644
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
@@ -20,6 +22,7 @@ struct s390_domain {
 	unsigned long		*dma_table;
 	spinlock_t		dma_table_lock;
 	spinlock_t		list_lock;
+	struct rcu_head		rcu;
 };
 
 static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
@@ -61,18 +64,28 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 
 	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
-	INIT_LIST_HEAD(&s390_domain->devices);
+	INIT_LIST_HEAD_RCU(&s390_domain->devices);
 
 	return &s390_domain->domain;
 }
 
+static void s390_iommu_rcu_free_domain(struct rcu_head *head)
+{
+	struct s390_domain *s390_domain = container_of(head, struct s390_domain, rcu);
+
+	dma_cleanup_tables(s390_domain->dma_table);
+	kfree(s390_domain);
+}
+
 static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 
+	rcu_read_lock();
 	WARN_ON(!list_empty(&s390_domain->devices));
-	dma_cleanup_tables(s390_domain->dma_table);
-	kfree(s390_domain);
+	rcu_read_unlock();
+
+	call_rcu(&s390_domain->rcu, s390_iommu_rcu_free_domain);
 }
 
 static void __s390_iommu_detach_device(struct zpci_dev *zdev)
@@ -84,7 +97,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
 		return;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_del_init(&zdev->iommu_list);
+	list_del_rcu(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
@@ -127,7 +140,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	zdev->s390_domain = s390_domain;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_add(&zdev->iommu_list, &s390_domain->devices);
+	list_add_rcu(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
@@ -203,14 +216,13 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
 				   zdev->end_dma - zdev->start_dma + 1);
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -219,18 +231,17 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	size_t size = gather->end - gather->start + 1;
 	struct zpci_dev *zdev;
-	unsigned long flags;
 
 	/* If gather was never added to there is nothing to flush */
 	if (!gather->end)
 		return;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
 				   size);
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
@@ -238,16 +249,15 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		if (!zdev->tlb_refresh)
 			continue;
 		zpci_refresh_trans((u64)zdev->fh << 32,
 				   iova, size);
 	}
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	rcu_read_unlock();
 }
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
-- 
2.34.1

