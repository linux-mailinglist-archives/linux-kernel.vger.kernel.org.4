Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658E62C624
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiKPRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiKPRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:17:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1625B591;
        Wed, 16 Nov 2022 09:17:25 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGGg24V031453;
        Wed, 16 Nov 2022 17:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tvO5QRhnZQNwwKCc2yWc5VgfQdhcmKr/lkbJbaWChko=;
 b=G57pzugsozEV35YcVL6LNsPFWKSHx4/WhveKRFpulayy74ZY2OriAJ3LPTbipmuf0uG/
 Nz4YpAxRS8X8IhFbO1yK1ZIWusLa3fzdqjyPfbd/RMjyooUKbdknjRPeZS1v1PCTgBq8
 q+ouHeR419B2EpmfO9UyRPt76p5lYQir0zBXZhpFvBaNCNgjVvZ6Mwi42G08/9jRpwEk
 VrV6spQfX97ET6QmaF5NjJQtl6lMTWdP+fM1kdW7bw+HizZQfQBjo7MaRDZOmDIan56M
 XfbGLSY7BoTpFrxrPLWOMx3ny4b/mW34x5O0/nfbwJjKp4GFQ1PNyntj52z5NiGB5Rtl WQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3m50w66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGH4kwp006968;
        Wed, 16 Nov 2022 17:17:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3kt3494qum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGHH02G60490164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 17:17:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D40D552054;
        Wed, 16 Nov 2022 17:17:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 54A0D52050;
        Wed, 16 Nov 2022 17:17:00 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of resource indication
Date:   Wed, 16 Nov 2022 18:16:56 +0100
Message-Id: <20221116171656.4128212-8-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116171656.4128212-1-schnelle@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3urLWCGZdldKrrByunqB7bPZQSfeAO4S
X-Proofpoint-ORIG-GUID: 3urLWCGZdldKrrByunqB7bPZQSfeAO4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RPCIT indicates that the underlying hypervisor has run out of
resources it often means that its IOVA space is exhausted and IOVAs need
to be freed before new ones can be created. By triggering a flush of the
IOVA queue we can get the queued IOVAs freed and also get the new
mapping established during the global flush.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c  | 14 +++++++++-----
 drivers/iommu/dma-iommu.h  |  1 +
 drivers/iommu/s390-iommu.c |  7 +++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3801cdf11aa8..54e7f63fd0d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -188,19 +188,23 @@ static void fq_flush_single(struct iommu_dma_cookie *cookie)
 	spin_unlock_irqrestore(&fq->lock, flags);
 }
 
-static void fq_flush_timeout(struct timer_list *t)
+void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
 {
-	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
-
-	atomic_set(&cookie->fq_timer_on, 0);
 	fq_flush_iotlb(cookie);
-
 	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
 		fq_flush_percpu(cookie);
 	else
 		fq_flush_single(cookie);
 }
 
+static void fq_flush_timeout(struct timer_list *t)
+{
+	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
+
+	atomic_set(&cookie->fq_timer_on, 0);
+	iommu_dma_flush_fq(cookie);
+}
+
 static void queue_iova(struct iommu_dma_cookie *cookie,
 		unsigned long pfn, unsigned long pages,
 		struct list_head *freelist)
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 942790009292..cac06030aa26 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -13,6 +13,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
+void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 087bb2acff30..9c2782c4043e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -538,14 +538,17 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
+	int rc;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		if (!zdev->tlb_refresh)
 			continue;
 		atomic64_inc(&s390_domain->ctrs.sync_map_rpcits);
-		zpci_refresh_trans((u64)zdev->fh << 32,
-				   iova, size);
+		rc = zpci_refresh_trans((u64)zdev->fh << 32,
+					iova, size);
+		if (rc == -ENOMEM)
+			iommu_dma_flush_fq(domain->iova_cookie);
 	}
 	rcu_read_unlock();
 }
-- 
2.34.1

