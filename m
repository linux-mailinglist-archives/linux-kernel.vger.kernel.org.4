Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0467B697B62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjBOMEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBOMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:03:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A734C01;
        Wed, 15 Feb 2023 04:03:58 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F9oAr1018427;
        Wed, 15 Feb 2023 12:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nhBnWOY2zWzyv8vgk0aPHaDnIPWDkSu9F/OhjMYgg0s=;
 b=YOFX3pJ94psKwMTmD6aj1OctQ+kVWKU+3w/KRvPHEIRQpFb4SFOZNldvghaw+2Sst1kS
 FwI24Df+hNQl9QuQ5NdU/OygHlCrW959cC5S2K5zyigsiV48CEv5WBld5dNJEQCaTACF
 cz3fz3KUH+1kkHszx6UdKA1kcH95/WzOVzqzQZhtwAv0LjWkbm62d9X1MGkEHSsB1UHK
 LF9JCZ7NgFUFIO6jg38EcQwW3tVllfoTpE4euzARndKiYsTi4EyHITsJncj1wp9e12Ec
 AU3ikkGCuhrV4ecM0dZrKlVXJWcR0DGReEpJ9cV/nhNKZynowKnLBV2qWhrrvja/M+Rc xA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrw3w35nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 12:03:36 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31F3Qlgb008513;
        Wed, 15 Feb 2023 12:03:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6bwpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 12:03:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FC3U0K26149524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 12:03:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18FE20043;
        Wed, 15 Feb 2023 12:03:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6488F2004E;
        Wed, 15 Feb 2023 12:03:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 12:03:30 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v6 6/6] iommu/dma: Make flush queue sizes and timeout driver configurable
Date:   Wed, 15 Feb 2023 13:03:27 +0100
Message-Id: <20230215120327.947336-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215120327.947336-1-schnelle@linux.ibm.com>
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sXhHtALgLHFlwCvwZCBjEMr49YBuNerj
X-Proofpoint-GUID: sXhHtALgLHFlwCvwZCBjEMr49YBuNerj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush queues currently use a fixed compile time size of 256 entries.
This being a power of 2 allows the compiler to use shift and mask
instead of more expensive modulo operations. With per-CPU flush queues
larger queue sizes would hit per-CPU allocation limits, with a single
flush queue these limits do not apply however. Also with single queues
being particularly suitable for virtualized environments with expensive
IOTLB flushes these benefit especially from larger queues and thus fewer
flushes.

To this end re-order struct iova_fq so we can use a dynamic array and
introduce the flush queue size and timeouts as new options in the
dma_iommu_options struct. So as not to lose the shift and mask
optimization, check that the variable length is a power of 2 and use
explicit shift and mask instead of letting the compiler optimize this.

In the s390 IOMMU driver a large fixed queue size and timeout is then
set together with single queue mode bringing its performance on s390
paged memory guests on par with the previous s390 specific DMA API
implementation.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c  | 40 ++++++++++++++++++++++++--------------
 drivers/iommu/s390-iommu.c |  8 +++++++-
 include/linux/iommu.h      |  6 +++++-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8f15a89ed7ab..b16e1fc04802 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -88,10 +88,10 @@ static int __init iommu_dma_forcedac_setup(char *str)
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 /* Number of entries per flush queue */
-#define IOVA_FQ_SIZE	256
+#define IOVA_DEFAULT_FQ_SIZE	256
 
 /* Timeout (in ms) after which entries are flushed from the queue */
-#define IOVA_FQ_TIMEOUT	10
+#define IOVA_DEFAULT_FQ_TIMEOUT	10
 
 /* Flush queue entry for deferred flushing */
 struct iova_fq_entry {
@@ -103,18 +103,19 @@ struct iova_fq_entry {
 
 /* Per-CPU flush queue structure */
 struct iova_fq {
-	struct iova_fq_entry entries[IOVA_FQ_SIZE];
-	unsigned int head, tail;
 	spinlock_t lock;
+	unsigned int head, tail;
+	unsigned int mod_mask;
+	struct iova_fq_entry entries[];
 };
 
 #define fq_ring_for_each(i, fq) \
-	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) & (fq)->mod_mask)
 
 static inline bool fq_full(struct iova_fq *fq)
 {
 	assert_spin_locked(&fq->lock);
-	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
+	return (((fq->tail + 1) & fq->mod_mask) == fq->head);
 }
 
 static inline unsigned int fq_ring_add(struct iova_fq *fq)
@@ -123,7 +124,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 
 	assert_spin_locked(&fq->lock);
 
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+	fq->tail = (idx + 1) & fq->mod_mask;
 
 	return idx;
 }
@@ -145,7 +146,7 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+		fq->head = (fq->head + 1) & fq->mod_mask;
 	}
 }
 
@@ -243,7 +244,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+			  jiffies + msecs_to_jiffies(cookie->options.fq_timeout));
 }
 
 static void iommu_dma_free_fq_single(struct iova_fq *fq)
@@ -285,27 +286,29 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 }
 
 
-static void iommu_dma_init_one_fq(struct iova_fq *fq)
+static void iommu_dma_init_one_fq(struct iova_fq *fq, size_t fq_size)
 {
 	int i;
 
 	fq->head = 0;
 	fq->tail = 0;
+	fq->mod_mask = fq_size - 1;
 
 	spin_lock_init(&fq->lock);
 
-	for (i = 0; i < IOVA_FQ_SIZE; i++)
+	for (i = 0; i < fq_size; i++)
 		INIT_LIST_HEAD(&fq->entries[i].freelist);
 }
 
 static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
 {
+	size_t fq_size = cookie->options.fq_size;
 	struct iova_fq *queue;
 
-	queue = vzalloc(sizeof(*queue));
+	queue = vzalloc(struct_size(queue, entries, fq_size));
 	if (!queue)
 		return -ENOMEM;
-	iommu_dma_init_one_fq(queue);
+	iommu_dma_init_one_fq(queue, fq_size);
 	cookie->single_fq = queue;
 
 	return 0;
@@ -313,15 +316,17 @@ static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
 
 static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
 {
+	size_t fq_size = cookie->options.fq_size;
 	struct iova_fq __percpu *queue;
 	int cpu;
 
-	queue = alloc_percpu(struct iova_fq);
+	queue = __alloc_percpu(struct_size(queue, entries, fq_size),
+			       __alignof__(*queue));
 	if (!queue)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu)
-		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
+		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu), fq_size);
 	cookie->percpu_fq = queue;
 	return 0;
 }
@@ -339,6 +344,9 @@ int iommu_dma_init_fq(struct device *dev, struct iommu_domain *domain)
 	if (ops->tune_dma_iommu)
 		ops->tune_dma_iommu(dev, &cookie->options);
 
+	if (WARN_ON_ONCE(!is_power_of_2(cookie->options.fq_size)))
+		cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
+
 	atomic64_set(&cookie->fq_flush_start_cnt,  0);
 	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
 
@@ -381,6 +389,8 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
 		cookie->options.flags = IOMMU_DMA_OPTS_PER_CPU_QUEUE;
+		cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
+		cookie->options.fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;
 	}
 	return cookie;
 }
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ea7232922fc5..b6319ef573ce 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -458,13 +458,19 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 	}
 }
 
+#define S390_IOMMU_SINGLE_FQ_SIZE      32768
+#define S390_IOMMU_SINGLE_FQ_TIMEOUT   1000
+
 static void s390_iommu_tune_dma_iommu(struct device *dev,
 					     struct dma_iommu_options *options)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 
-	if (zdev->tlb_refresh)
+	if (zdev->tlb_refresh) {
 		options->flags |= IOMMU_DMA_OPTS_SINGLE_QUEUE;
+		options->fq_size = S390_IOMMU_SINGLE_FQ_SIZE;
+		options->fq_timeout = S390_IOMMU_SINGLE_FQ_TIMEOUT;
+	}
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 071ac01e24ff..b04b725cbc4f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -224,6 +224,8 @@ struct iommu_iotlb_gather {
  * struct dma_iommu_options - Options for dma-iommu
  *
  * @flags: Flag bits for enabling/disabling dma-iommu settings
+ * @fq_size: Size of the IOTLB flush queue(s), must be a power of two
+ * @fq_timeout: Timeout used for queued IOTLB flushes
  *
  * This structure is intended to provide IOMMU drivers a way to influence the
  * behavior of the dma-iommu DMA API implementation. This allows optimizing for
@@ -232,7 +234,9 @@ struct iommu_iotlb_gather {
 struct dma_iommu_options {
 #define IOMMU_DMA_OPTS_PER_CPU_QUEUE	(0L << 0)
 #define IOMMU_DMA_OPTS_SINGLE_QUEUE	(1L << 0)
-	u64	flags;
+	u64		flags;
+	size_t		fq_size;
+	unsigned int	fq_timeout;
 };
 
 /**
-- 
2.37.2

