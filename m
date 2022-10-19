Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57B6049F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJSOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiJSOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:53:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C39A3A89;
        Wed, 19 Oct 2022 07:44:56 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEcFpZ018253;
        Wed, 19 Oct 2022 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+qhlNFZf7wMfnyek/HyGUhEtAQVwDLah2w1h2OTPdtI=;
 b=ORXZ9KSsxQoB5LbVPoUrNGC4TSkTc83t4GcP20yjoizsSJw8L6HsWF2SfCgHutvn0bph
 N/HDc1d98OF6fC1F73KPnpbwgc3oszfd6fpWZA1tor+CQcSA4Gfez6uZCG2E0f7Z9eCW
 W+0YJeQK3pGDnD+f3vGYbxHEJ29DT8uvMtSRYMxSaUdVo+iD2DBoZe8kkAtGyix7MZtI
 PGVeJVWcifm4/UCEiSqACrpSSGBT7L4UATzijOhaCsOgunCdz9RkLIWhfCxnFdjh4vYN
 RdeQn9TYnWfWy8IQJ39rFE0Oqu8C3beT5gqB89Rhihz8/JBKIZTfr0ilYJNeyIazqslu 4g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaj58bmmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:43 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEZWkk008990;
        Wed, 19 Oct 2022 14:44:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3k7mg8wfyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEdcJG43188652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:39:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA9D54C04E;
        Wed, 19 Oct 2022 14:44:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4150E4C044;
        Wed, 19 Oct 2022 14:44:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 14:44:38 +0000 (GMT)
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
Subject: [RFC 4/6] iommu/dma: Prepare for multiple flush queue implementations
Date:   Wed, 19 Oct 2022 16:44:33 +0200
Message-Id: <20221019144435.369902-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019144435.369902-1-schnelle@linux.ibm.com>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -PJiRFsdg3uhKOxxyqwGqf0ScFeMw4OH
X-Proofpoint-ORIG-GUID: -PJiRFsdg3uhKOxxyqwGqf0ScFeMw4OH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma-iommu currently only supports a per CPU, highly parallelized
flush queue that depends on relatively cheap global flushes. Especially
in virtualized environments these assumptions may not hold true which in
the past lead to the need to resort to strict mode. Instead prepare the
dma-iommu code for alternative flushing schemes that optimize for
different needs.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c | 164 ++++++++++++++++++++++----------------
 1 file changed, 97 insertions(+), 67 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9297b741f5e8..77d969f5aad7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -44,12 +44,13 @@ enum iommu_dma_cookie_type {
 
 struct iommu_dma_cookie {
 	enum iommu_dma_cookie_type	type;
+
 	union {
 		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
 		struct {
-			struct iova_domain	iovad;
-
-			struct iova_fq __percpu *fq;	/* Flush queue */
+			struct iova_domain		iovad;
+			/* Flush queue */
+			struct iova_percpu __percpu *percpu_fq;
 			/* Number of TLB flushes that have been started */
 			atomic64_t		fq_flush_start_cnt;
 			/* Number of TLB flushes that have been finished */
@@ -83,13 +84,13 @@ static int __init iommu_dma_forcedac_setup(char *str)
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 /* Number of entries per flush queue */
-#define IOVA_FQ_SIZE	256
+#define IOVA_PERCPU_SIZE	256
 
 /* Timeout (in ms) after which entries are flushed from the queue */
-#define IOVA_FQ_TIMEOUT	10
+#define IOVA_PERCPU_TIMEOUT	10
 
 /* Flush queue entry for deferred flushing */
-struct iova_fq_entry {
+struct iova_percpu_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
 	struct list_head freelist;
@@ -97,40 +98,40 @@ struct iova_fq_entry {
 };
 
 /* Per-CPU flush queue structure */
-struct iova_fq {
-	struct iova_fq_entry entries[IOVA_FQ_SIZE];
+struct iova_percpu {
+	struct iova_percpu_entry entries[IOVA_PERCPU_SIZE];
 	unsigned int head, tail;
 	spinlock_t lock;
 };
 
-#define fq_ring_for_each(i, fq) \
-	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
+#define ring_for_each_percpu(i, fq) \
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_PERCPU_SIZE)
 
-static inline bool fq_full(struct iova_fq *fq)
+static inline bool is_full_percpu(struct iova_percpu *fq)
 {
 	assert_spin_locked(&fq->lock);
-	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
+	return (((fq->tail + 1) % IOVA_PERCPU_SIZE) == fq->head);
 }
 
-static inline unsigned int fq_ring_add(struct iova_fq *fq)
+static inline unsigned int ring_add_percpu(struct iova_percpu *fq)
 {
 	unsigned int idx = fq->tail;
 
 	assert_spin_locked(&fq->lock);
 
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+	fq->tail = (idx + 1) % IOVA_PERCPU_SIZE;
 
 	return idx;
 }
 
-static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
+static void ring_free_percpu(struct iommu_dma_cookie *cookie, struct iova_percpu *fq)
 {
 	u64 counter = atomic64_read(&cookie->fq_flush_finish_cnt);
 	unsigned int idx;
 
 	assert_spin_locked(&fq->lock);
 
-	fq_ring_for_each(idx, fq) {
+	ring_for_each_percpu(idx, fq) {
 
 		if (fq->entries[idx].counter >= counter)
 			break;
@@ -140,69 +141,66 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+		fq->head = (fq->head + 1) % IOVA_PERCPU_SIZE;
 	}
 }
 
-static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
+static void flush_iotlb_percpu(struct iommu_dma_cookie *cookie)
 {
 	atomic64_inc(&cookie->fq_flush_start_cnt);
 	cookie->fq_domain->ops->flush_iotlb_all(cookie->fq_domain);
 	atomic64_inc(&cookie->fq_flush_finish_cnt);
 }
 
-static void fq_flush_timeout(struct timer_list *t)
+static void flush_percpu(struct iommu_dma_cookie *cookie)
 {
-	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
 	int cpu;
 
-	atomic_set(&cookie->fq_timer_on, 0);
-	fq_flush_iotlb(cookie);
+	flush_iotlb_percpu(cookie);
 
 	for_each_possible_cpu(cpu) {
 		unsigned long flags;
-		struct iova_fq *fq;
+		struct iova_percpu *fq;
 
-		fq = per_cpu_ptr(cookie->fq, cpu);
+		fq = per_cpu_ptr(cookie->percpu_fq, cpu);
 		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(cookie, fq);
+		ring_free_percpu(cookie, fq);
 		spin_unlock_irqrestore(&fq->lock, flags);
 	}
 }
 
-static void queue_iova(struct iommu_dma_cookie *cookie,
-		unsigned long pfn, unsigned long pages,
-		struct list_head *freelist)
+static void fq_flush_timeout(struct timer_list *t)
 {
-	struct iova_fq *fq;
+	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
+
+	atomic_set(&cookie->fq_timer_on, 0);
+	flush_percpu(cookie);
+}
+
+static void queue_iova_percpu(struct iommu_dma_cookie *cookie,
+			      unsigned long pfn, unsigned long pages,
+			      struct list_head *freelist)
+{
+	struct iova_percpu *fq;
 	unsigned long flags;
 	unsigned int idx;
 
-	/*
-	 * Order against the IOMMU driver's pagetable update from unmapping
-	 * @pte, to guarantee that fq_flush_iotlb() observes that if called
-	 * from a different CPU before we release the lock below. Full barrier
-	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
-	 * written fq state here.
-	 */
-	smp_mb();
-
-	fq = raw_cpu_ptr(cookie->fq);
+	fq = raw_cpu_ptr(cookie->percpu_fq);
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
 	 * First remove all entries from the flush queue that have already been
-	 * flushed out on another CPU. This makes the fq_full() check below less
+	 * flushed out on another CPU. This makes the fullness check below less
 	 * likely to be true.
 	 */
-	fq_ring_free(cookie, fq);
+	ring_free_percpu(cookie, fq);
 
-	if (fq_full(fq)) {
-		fq_flush_iotlb(cookie);
-		fq_ring_free(cookie, fq);
+	if (is_full_percpu(fq)) {
+		flush_iotlb_percpu(cookie);
+		ring_free_percpu(cookie, fq);
 	}
 
-	idx = fq_ring_add(fq);
+	idx = ring_add_percpu(fq);
 
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
@@ -210,65 +208,97 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	list_splice(freelist, &fq->entries[idx].freelist);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
+}
+
+static void queue_iova(struct iommu_dma_cookie *cookie,
+		       unsigned long pfn, unsigned long pages,
+		struct list_head *freelist)
+{
+	/*
+	 * Order against the IOMMU driver's pagetable update from unmapping
+	 * @pte, to guarantee that flush_iotlb_percpu() observes that if called
+	 * from a different CPU before we release the lock below. Full barrier
+	 * so it also pairs with iommu_dma_init_fq() to avoid seeing
+	 * partially written queue state here.
+	 */
+	smp_mb();
+
+	queue_iova_percpu(cookie, pfn, pages, freelist);
 
 	/* Avoid false sharing as much as possible. */
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+			  jiffies + msecs_to_jiffies(IOVA_PERCPU_TIMEOUT));
 }
 
-static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
+static void iommu_dma_free_percpu(struct iommu_dma_cookie *cookie)
 {
 	int cpu, idx;
 
-	if (!cookie->fq)
+	if (!cookie->percpu_fq)
 		return;
 
-	del_timer_sync(&cookie->fq_timer);
-	/* The IOVAs will be torn down separately, so just free our queued pages */
 	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
+		struct iova_percpu *fq = per_cpu_ptr(cookie->percpu_fq, cpu);
 
-		fq_ring_for_each(idx, fq)
+		ring_for_each_percpu(idx, fq)
 			put_pages_list(&fq->entries[idx].freelist);
 	}
 
-	free_percpu(cookie->fq);
+	free_percpu(cookie->percpu_fq);
 }
 
-/* sysfs updates are serialised by the mutex of the group owning @domain */
-int iommu_dma_init_fq(struct iommu_domain *domain)
+static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 {
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_fq __percpu *queue;
-	int i, cpu;
+	del_timer_sync(&cookie->fq_timer);
+	/* The IOVAs will be torn down separately, so just free our queued pages */
+	iommu_dma_free_percpu(cookie);
+}
 
-	if (cookie->fq_domain)
-		return 0;
+static int iommu_dma_init_percpu(struct iommu_dma_cookie *cookie)
+{
+	struct iova_percpu __percpu *queue;
+	int i, cpu;
 
 	atomic64_set(&cookie->fq_flush_start_cnt,  0);
 	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
 
-	queue = alloc_percpu(struct iova_fq);
-	if (!queue) {
-		pr_warn("iova flush queue initialization failed\n");
+	queue = alloc_percpu(struct iova_percpu);
+	if (!queue)
 		return -ENOMEM;
-	}
 
 	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
+		struct iova_percpu *fq = per_cpu_ptr(queue, cpu);
 
 		fq->head = 0;
 		fq->tail = 0;
 
 		spin_lock_init(&fq->lock);
 
-		for (i = 0; i < IOVA_FQ_SIZE; i++)
+		for (i = 0; i < IOVA_PERCPU_SIZE; i++)
 			INIT_LIST_HEAD(&fq->entries[i].freelist);
 	}
 
-	cookie->fq = queue;
+	cookie->percpu_fq = queue;
+
+	return 0;
+}
+
+/* sysfs updates are serialised by the mutex of the group owning @domain */
+int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	int rc;
+
+	if (cookie->fq_domain)
+		return 0;
+
+	rc = iommu_dma_init_percpu(cookie);
+	if (rc) {
+		pr_warn("iova flush queue initialization failed\n");
+		return rc;
+	}
 
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
-- 
2.34.1

