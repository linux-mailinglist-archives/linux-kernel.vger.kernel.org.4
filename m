Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA6600F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJQMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJQMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEC4F181;
        Mon, 17 Oct 2022 05:46:19 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HC57pw020059;
        Mon, 17 Oct 2022 12:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NDfNIs/V5yOsnPnb7a+DInix+OEPhJc88G9erUaDEOU=;
 b=UwPJ5Qa9PFSwYmVbHGvvZ7y2Cm2rHAK/wj3/onW4uw+9ndlVwebdw2aB44FrKCyAfb2K
 XZzGVAWoT8fvkTY8V10dgzxpX1iLpifdu24BFRxNQU3wdeJgmjK4Eqto2kZ4fjOJjhQZ
 yUrDZmZfWDi01huNDDCs51El/35zjODh8haHTEU+IDZp4NYds+HLACTjtBVhYUN4Zcdq
 k4tFx5HENi8mBM+vIoHT4q+iGYNjgoZ2TTawfQpzmLHCtgXHicm51Ud7/+Q1nEOxD0LK
 3PGXsZQd/pzFIeXm/AUOH9XzX0Jkt1bSny20BK88hhyHod4hIuK+1HCow19dD7Ka8CCd 2w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k944bp15q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:46:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29HCZIVA023377;
        Mon, 17 Oct 2022 12:46:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg92yrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:46:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29HCk0lV262832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 12:46:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F18F11C05C;
        Mon, 17 Oct 2022 12:46:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F197E11C050;
        Mon, 17 Oct 2022 12:45:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Oct 2022 12:45:59 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] iommu/s390: Get rid of s390_domain_device
Date:   Mon, 17 Oct 2022 14:45:54 +0200
Message-Id: <20221017124558.1386337-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017124558.1386337-1-schnelle@linux.ibm.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z50lVSmMMxT5wGbXnOMrGlKvmqtpRcTI
X-Proofpoint-ORIG-GUID: Z50lVSmMMxT5wGbXnOMrGlKvmqtpRcTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_09,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170072
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

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v5->v6:
- On attach failure make sure the IOAT is not registered
  and zdev->dma_table == NULL
- Dropped Jason's R-b

 arch/s390/include/asm/pci.h |  1 +
 drivers/iommu/s390-iommu.c  | 37 +++++++------------------------------
 2 files changed, 8 insertions(+), 30 deletions(-)

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
index c2e5e81d609e..af83ccde16a4 100644
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
 	int cc, rc = 0;
 
 	if (!zdev)
 		return -ENODEV;
 
-	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
-	if (!domain_device)
-		return -ENOMEM;
-
 	if (zdev->s390_domain)
 		__s390_iommu_detach_device(zdev);
 	else if (zdev->dma_table)
@@ -132,10 +114,8 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(s390_domain->dma_table));
-	if (cc) {
-		rc = -EIO;
-		goto out_free;
-	}
+	if (cc)
+		return -EIO;
 	zdev->dma_table = s390_domain->dma_table;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
@@ -151,9 +131,8 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		rc = -EINVAL;
 		goto out_unregister;
 	}
-	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
-	list_add(&domain_device->list, &s390_domain->devices);
+	list_add(&zdev->iommu_list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	return 0;
@@ -161,8 +140,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 out_unregister:
 	zpci_unregister_ioat(zdev, 0);
 	zdev->dma_table = NULL;
-out_free:
-	kfree(domain_device);
 
 	return rc;
 }
@@ -206,10 +183,10 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
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
 
@@ -234,8 +211,8 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
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

