Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874EB679892
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjAXMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjAXMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:52:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7D2CC5E;
        Tue, 24 Jan 2023 04:51:50 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OCfpT5006304;
        Tue, 24 Jan 2023 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d2HmQqHHKqjXGyOgiK/iBnWjLKr1vlBVmXL0wrUZgP0=;
 b=U0qDBR1a3+iOTh/6bHPLGluqnuqJsXGMlsK0I/PhPTtGeMktn3vpaVj65pTC4JltK6dC
 L6EJ1YGo2eRY0rX2P+4ZlOAs2LCAw76UUV+9S18N9ZVtnu1UayNQTK9LKlOhyBUhKO2u
 63wRBYiJat8Q8bfexQz51qkUYkB3eGtvTJ1NnVP2+/fpvzsyMA243vWnSeAU/QtCLAyi
 kUN554rwNj1nfep68FXSEE6SydxOrjKH17G2qa/74NIBlVOBkapvOWDwVPKdU/7U5Pog
 0Rqztq+meEovGsofOAo+8AT5TZBZNpeKJ+NdgmblHYrp2y59OuEh8BkQaueJFhf3tSlu kQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naaknqc5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OA5NXP015356;
        Tue, 24 Jan 2023 12:50:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afbt7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCofM845416956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:50:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C538920043;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 455BD2004D;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
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
Subject: [PATCH v5 6/7] iommu/dma: Enable variable queue size and use larger single queue
Date:   Tue, 24 Jan 2023 13:50:36 +0100
Message-Id: <20230124125037.3201345-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124125037.3201345-1-schnelle@linux.ibm.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u2VxQrIjKNvE3vPFR90cUdg9AFu_KXlK
X-Proofpoint-GUID: u2VxQrIjKNvE3vPFR90cUdg9AFu_KXlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush queues currently use a fixed compile time size of 256 entries.
This being a power of 2 allows the compiler to use shifts and mask
instead of more expensive modulo operations. With per-CPU flush queues
larger queue sizes would hit per-CPU allocation limits, with
a single flush queue these limits do not apply however. As single flush
queue mode is intended for environments with epensive IOTLB flushes it
then makes sense to use a larger queue size and timeout.

To this end re-order struct iova_fq so we can use a dynamic array and
make the flush queue size and timeout variable. So as not to lose the
shift and mask optimization, check that the variable length is a power
of 2 and use explicit shift and mask instead of letting the compiler
optimize this.

For now use a large fixed queue size and timeout for single flush queues
that brings its performance on s390 paged memory guests on par with the
previous s390 specific DMA API implementation. In the future the flush
queue size can then be turned into a config option or kernel parameter.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d13ca6db0012..58394cc81d68 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -61,6 +61,8 @@ struct iommu_dma_cookie {
 			struct timer_list	fq_timer;
 			/* 1 when timer is active, 0 when not */
 			atomic_t		fq_timer_on;
+			/* timeout in ms */
+			unsigned long fq_timer_timeout;
 		};
 		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
 		dma_addr_t		msi_iova;
@@ -86,10 +88,16 @@ static int __init iommu_dma_forcedac_setup(char *str)
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 /* Number of entries per flush queue */
-#define IOVA_FQ_SIZE	256
+#define IOVA_DEFAULT_FQ_SIZE	256
+
+/* Number of entries for a single queue */
+#define IOVA_SINGLE_FQ_SIZE	32768
 
 /* Timeout (in ms) after which entries are flushed from the queue */
-#define IOVA_FQ_TIMEOUT	10
+#define IOVA_DEFAULT_FQ_TIMEOUT	10
+
+/* Timeout (in ms) for a single queue */
+#define IOVA_SINGLE_FQ_TIMEOUT	1000
 
 /* Flush queue entry for deferred flushing */
 struct iova_fq_entry {
@@ -101,18 +109,19 @@ struct iova_fq_entry {
 
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
@@ -121,7 +130,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 
 	assert_spin_locked(&fq->lock);
 
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+	fq->tail = (idx + 1) & fq->mod_mask;
 
 	return idx;
 }
@@ -143,7 +152,7 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+		fq->head = (fq->head + 1) & fq->mod_mask;
 	}
 }
 
@@ -241,7 +250,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+			  jiffies + msecs_to_jiffies(cookie->fq_timer_timeout));
 }
 
 static void iommu_dma_free_fq_single(struct iova_fq *fq)
@@ -283,43 +292,45 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 }
 
 
-static void iommu_dma_init_one_fq(struct iova_fq *fq)
+static void iommu_dma_init_one_fq(struct iova_fq *fq, unsigned int fq_size)
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
 
-static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
+static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie, unsigned int fq_size)
 {
 	struct iova_fq *queue;
 
-	queue = vzalloc(sizeof(*queue));
+	queue = vzalloc(struct_size(queue, entries, fq_size));
 	if (!queue)
 		return -ENOMEM;
-	iommu_dma_init_one_fq(queue);
+	iommu_dma_init_one_fq(queue, fq_size);
 	cookie->single_fq = queue;
 
 	return 0;
 }
 
-static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
+static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie, unsigned int fq_size)
 {
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
@@ -328,18 +339,27 @@ static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
 int iommu_dma_init_fq(struct iommu_domain *domain, int type)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	unsigned int fq_size = IOVA_DEFAULT_FQ_SIZE;
 	int rc;
 
 	if (cookie->fq_domain)
 		return 0;
 
+	if (domain->type == IOMMU_DOMAIN_DMA_SQ)
+		fq_size = IOVA_SINGLE_FQ_SIZE;
+
+	if (!is_power_of_2(fq_size)) {
+		pr_err("FQ size must be a power of 2\n");
+		return -EINVAL;
+	}
+
 	atomic64_set(&cookie->fq_flush_start_cnt,  0);
 	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
 
 	if (type == IOMMU_DOMAIN_DMA_FQ)
-		rc = iommu_dma_init_fq_percpu(cookie);
+		rc = iommu_dma_init_fq_percpu(cookie, fq_size);
 	else
-		rc = iommu_dma_init_fq_single(cookie);
+		rc = iommu_dma_init_fq_single(cookie, fq_size);
 
 	if (rc) {
 		pr_warn("iova flush queue initialization failed\n");
@@ -349,6 +369,8 @@ int iommu_dma_init_fq(struct iommu_domain *domain, int type)
 	}
 
 	domain->type = type;
+	cookie->fq_timer_timeout = (type == IOMMU_DOMAIN_DMA_SQ) ?
+			IOVA_SINGLE_FQ_TIMEOUT : IOVA_DEFAULT_FQ_TIMEOUT;
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
-- 
2.34.1

