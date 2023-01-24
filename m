Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEB679895
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjAXMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjAXMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:52:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E745880;
        Tue, 24 Jan 2023 04:51:55 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBcfNa000782;
        Tue, 24 Jan 2023 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=zKsCqsryuqmTs7WJH9lz+vGmy2YilcZtyv3WqxIa/fI=;
 b=O43wCtEvvwbUp2a1VcbClXNJ/PB+BRx29Czz33poUgyhdaJKbDaTiv1z2S7Yq+DKFtkE
 osA7fK88X4d03oRrmbEzjIsoOgwzlKF7t7HEfJ6MyHAie4YSzEsw92eKnjR+OW/oC3vm
 B2FnRD5V0p7wrx6J1CkzINXwI6CJMLdP+yRruaNrhXwH4jhE1XlBxt/mOlq8XK+AWhOl
 4i8maHSutjSVhLSySsMbfWPQF4IHaxVaY3dW3W5bqS0TPzgUlc1yzkPNRYRjRdf+NvSn
 xUaIDIn/9j+cVUn9Gk/4qaE1KdfJ9LHmsbB8Qjz+l+DpgWGGBCRmlckqWmWeMyHlBDhi sg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac1ywct5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O9xdPt026731;
        Tue, 24 Jan 2023 12:50:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6btmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCofVj45416952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:50:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38C8E2004B;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A657120043;
        Tue, 24 Jan 2023 12:50:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:50:40 +0000 (GMT)
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
Subject: [PATCH v5 5/7] iommu/dma: Allow a single FQ in addition to per-CPU FQs
Date:   Tue, 24 Jan 2023 13:50:35 +0100
Message-Id: <20230124125037.3201345-6-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124125037.3201345-1-schnelle@linux.ibm.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -1hFMJegCS57Mr3Z8cb2fuj8Yp5ruF6p
X-Proofpoint-ORIG-GUID: -1hFMJegCS57Mr3Z8cb2fuj8Yp5ruF6p
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=915 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some virtualized environments, including s390 paged memory guests,
IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
are much more expensive than in typical bare metal environments or
non-paged s390 guests. In addition they may parallelize more poorly in
virtualized environments. This changes the trade off for flushing IOVAs
such that minimizing the number of IOTLB flushes trumps any benefit of
cheaper queuing operations or increased paralellism.

In this scenario per-CPU flush queues pose several problems. Firstly
per-CPU memory is often quite limited prohibiting larger queues.
Secondly collecting IOVAs per-CPU but flushing via a global timeout
reduces the number of IOVAs flushed for each timeout especially on s390
where PCI interrupts may not be bound to a specific CPU.

Thus let's introduce a single flush queue mode IOMMU_DOMAIN_DMA_SQ that
reuses the same queue logic but only allocates a single global queue
allowing larger batches of IOVAs to be freed at once and with larger
timeouts. This is to allow the common IOVA flushing code to more closely
resemble the global flush behavior used on s390's previous internal DMA
API implementation.

As we now support two different variants of flush queues rename the
existing __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to indicate
the general case of having a flush queue and introduce separate
__IOMMU_DOMAIN_DMA_PERCPU_Q and __IOMMU_DOMAIN_DMA_SINGLE_Q bits to
indicate the two queue variants.

Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v4 -> v5:
- Fixed iommu_group_store_type() mistakenly initializing DMA-SQ instead of
  DMA-FQ. This was caused by iommu_dma_init_fq() being called before
  domain->type is set, instead pass the type as paramater. This also closes
  a window where domain->type is still DMA while the FQ is already used. (Gerd)
v2 -> v3:
- Rename __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY to make it more clear
  that this bit indicates flush queue use independent of the exact queuing
  strategy

 drivers/iommu/dma-iommu.c  | 155 ++++++++++++++++++++++++++++---------
 drivers/iommu/dma-iommu.h  |   4 +-
 drivers/iommu/iommu.c      |  16 ++--
 drivers/iommu/s390-iommu.c |   1 +
 include/linux/iommu.h      |  14 +++-
 5 files changed, 142 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f798c44e0903..d13ca6db0012 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -48,8 +48,11 @@ struct iommu_dma_cookie {
 		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
 		struct {
 			struct iova_domain	iovad;
-
-			struct iova_fq __percpu *fq;	/* Flush queue */
+			/* Flush queue */
+			union {
+				struct iova_fq	*single_fq;
+				struct iova_fq	__percpu *percpu_fq;
+			};
 			/* Number of TLB flushes that have been started */
 			atomic64_t		fq_flush_start_cnt;
 			/* Number of TLB flushes that have been finished */
@@ -151,25 +154,44 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
 	atomic64_inc(&cookie->fq_flush_finish_cnt);
 }
 
-static void fq_flush_timeout(struct timer_list *t)
+static void fq_flush_percpu(struct iommu_dma_cookie *cookie)
 {
-	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
 	int cpu;
 
-	atomic_set(&cookie->fq_timer_on, 0);
-	fq_flush_iotlb(cookie);
-
 	for_each_possible_cpu(cpu) {
 		unsigned long flags;
 		struct iova_fq *fq;
 
-		fq = per_cpu_ptr(cookie->fq, cpu);
+		fq = per_cpu_ptr(cookie->percpu_fq, cpu);
 		spin_lock_irqsave(&fq->lock, flags);
 		fq_ring_free(cookie, fq);
 		spin_unlock_irqrestore(&fq->lock, flags);
 	}
 }
 
+static void fq_flush_single(struct iommu_dma_cookie *cookie)
+{
+	struct iova_fq *fq = cookie->single_fq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fq->lock, flags);
+	fq_ring_free(cookie, fq);
+	spin_unlock_irqrestore(&fq->lock, flags);
+}
+
+static void fq_flush_timeout(struct timer_list *t)
+{
+	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
+
+	atomic_set(&cookie->fq_timer_on, 0);
+	fq_flush_iotlb(cookie);
+
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		fq_flush_percpu(cookie);
+	else
+		fq_flush_single(cookie);
+}
+
 static void queue_iova(struct iommu_dma_cookie *cookie,
 		unsigned long pfn, unsigned long pages,
 		struct list_head *freelist)
@@ -187,7 +209,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	 */
 	smp_mb();
 
-	fq = raw_cpu_ptr(cookie->fq);
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		fq = raw_cpu_ptr(cookie->percpu_fq);
+	else
+		fq = cookie->single_fq;
+
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
@@ -218,31 +244,91 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
 
-static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
+static void iommu_dma_free_fq_single(struct iova_fq *fq)
 {
-	int cpu, idx;
+	int idx;
 
-	if (!cookie->fq)
+	if (!fq)
 		return;
+	fq_ring_for_each(idx, fq)
+		put_pages_list(&fq->entries[idx].freelist);
+	vfree(fq);
+}
+
+static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_fq)
+{
+	int cpu, idx;
 
-	del_timer_sync(&cookie->fq_timer);
 	/* The IOVAs will be torn down separately, so just free our queued pages */
 	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
+		struct iova_fq *fq = per_cpu_ptr(percpu_fq, cpu);
 
 		fq_ring_for_each(idx, fq)
 			put_pages_list(&fq->entries[idx].freelist);
 	}
 
-	free_percpu(cookie->fq);
+	free_percpu(percpu_fq);
+}
+
+static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
+{
+	if (!cookie->fq_domain)
+		return;
+
+	del_timer_sync(&cookie->fq_timer);
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		iommu_dma_free_fq_percpu(cookie->percpu_fq);
+	else
+		iommu_dma_free_fq_single(cookie->single_fq);
+}
+
+
+static void iommu_dma_init_one_fq(struct iova_fq *fq)
+{
+	int i;
+
+	fq->head = 0;
+	fq->tail = 0;
+
+	spin_lock_init(&fq->lock);
+
+	for (i = 0; i < IOVA_FQ_SIZE; i++)
+		INIT_LIST_HEAD(&fq->entries[i].freelist);
+}
+
+static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
+{
+	struct iova_fq *queue;
+
+	queue = vzalloc(sizeof(*queue));
+	if (!queue)
+		return -ENOMEM;
+	iommu_dma_init_one_fq(queue);
+	cookie->single_fq = queue;
+
+	return 0;
+}
+
+static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
+{
+	struct iova_fq __percpu *queue;
+	int cpu;
+
+	queue = alloc_percpu(struct iova_fq);
+	if (!queue)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu)
+		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
+	cookie->percpu_fq = queue;
+	return 0;
 }
 
 /* sysfs updates are serialised by the mutex of the group owning @domain */
-int iommu_dma_init_fq(struct iommu_domain *domain)
+int iommu_dma_init_fq(struct iommu_domain *domain, int type)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_fq __percpu *queue;
-	int i, cpu;
+	int rc;
 
 	if (cookie->fq_domain)
 		return 0;
@@ -250,26 +336,19 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	atomic64_set(&cookie->fq_flush_start_cnt,  0);
 	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
 
-	queue = alloc_percpu(struct iova_fq);
-	if (!queue) {
-		pr_warn("iova flush queue initialization failed\n");
-		return -ENOMEM;
-	}
-
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
-
-		fq->head = 0;
-		fq->tail = 0;
-
-		spin_lock_init(&fq->lock);
+	if (type == IOMMU_DOMAIN_DMA_FQ)
+		rc = iommu_dma_init_fq_percpu(cookie);
+	else
+		rc = iommu_dma_init_fq_single(cookie);
 
-		for (i = 0; i < IOVA_FQ_SIZE; i++)
-			INIT_LIST_HEAD(&fq->entries[i].freelist);
+	if (rc) {
+		pr_warn("iova flush queue initialization failed\n");
+		/* fall back to strict mode */
+		domain->type = IOMMU_DOMAIN_DMA;
+		return rc;
 	}
 
-	cookie->fq = queue;
-
+	domain->type = type;
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
@@ -582,9 +661,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (ret)
 		goto done_unlock;
 
-	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
-		domain->type = IOMMU_DOMAIN_DMA;
+	/* If the FQ fails we fall back to strict mode */
+	if (domain->type & __IOMMU_DOMAIN_DMA_LAZY)
+		iommu_dma_init_fq(domain, domain->type);
 
 	ret = iova_reserve_iommu_regions(dev, domain);
 
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 942790009292..2e037fc6074c 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -12,7 +12,7 @@
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
-int iommu_dma_init_fq(struct iommu_domain *domain);
+int iommu_dma_init_fq(struct iommu_domain *domain, int type);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
@@ -20,7 +20,7 @@ extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
 
-static inline int iommu_dma_init_fq(struct iommu_domain *domain)
+static inline int iommu_dma_init_fq(struct iommu_domain *domain, int type)
 {
 	return -EINVAL;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5565e510f7d2..b58c4313851b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -145,6 +145,7 @@ static const char *iommu_domain_type_str(unsigned int t)
 		return "Unmanaged";
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
+	case IOMMU_DOMAIN_DMA_SQ:
 		return "Translated";
 	default:
 		return "Unknown";
@@ -477,7 +478,7 @@ early_param("iommu.strict", iommu_dma_setup);
 void iommu_set_dma_strict(void)
 {
 	iommu_dma_strict = true;
-	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
+	if (!!(iommu_def_domain_type & __IOMMU_DOMAIN_DMA_LAZY))
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
@@ -678,6 +679,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 		case IOMMU_DOMAIN_DMA_FQ:
 			type = "DMA-FQ\n";
 			break;
+		case IOMMU_DOMAIN_DMA_SQ:
+			type = "DMA-SQ\n";
+			break;
 		}
 	}
 	mutex_unlock(&group->mutex);
@@ -2896,10 +2900,8 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* We can bring up a flush queue without tearing down the domain */
-	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
-		ret = iommu_dma_init_fq(prev_dom);
-		if (!ret)
-			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+	if (!!(type & __IOMMU_DOMAIN_DMA_LAZY) && prev_dom->type == IOMMU_DOMAIN_DMA) {
+		ret = iommu_dma_init_fq(prev_dom, type);
 		goto out;
 	}
 
@@ -2970,6 +2972,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		req_type = IOMMU_DOMAIN_DMA;
 	else if (sysfs_streq(buf, "DMA-FQ"))
 		req_type = IOMMU_DOMAIN_DMA_FQ;
+	else if (sysfs_streq(buf, "DMA-SQ"))
+		req_type = IOMMU_DOMAIN_DMA_SQ;
 	else if (sysfs_streq(buf, "auto"))
 		req_type = 0;
 	else
@@ -3021,7 +3025,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
+	if (device_is_bound(dev) && !((req_type & __IOMMU_DOMAIN_DMA_LAZY) &&
 	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 73144ea0adfc..ff73b75be886 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -332,6 +332,7 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 	switch (domain_type) {
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
+	case IOMMU_DOMAIN_DMA_SQ:
 	case IOMMU_DOMAIN_UNMANAGED:
 		break;
 	default:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7f76599f09e..74cee59516aa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -62,10 +62,13 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
-#define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_DMA_LAZY	(1U << 3)  /* DMA-API uses flush queue    */
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_DMA_PERCPU_Q	(1U << 5)  /* Per-CPU flush queue */
+#define __IOMMU_DOMAIN_DMA_SINGLE_Q	(1U << 6)  /* Single flush queue */
+
 /*
  * This are the possible domain-types
  *
@@ -79,6 +82,8 @@ struct iommu_domain_geometry {
  *				  certain optimizations for these domains
  *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
  *				  invalidation.
+ *	IOMMU_DOMAIN_DMA_SQ	- As IOMMU_DOMAIN_DMA_FQ, but batched TLB
+ *				  validations use single global queue
  *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process addresses
  *				  represented by mm_struct's.
  */
@@ -89,7 +94,12 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API)
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
-				 __IOMMU_DOMAIN_DMA_FQ)
+				 __IOMMU_DOMAIN_DMA_LAZY |	\
+				 __IOMMU_DOMAIN_DMA_PERCPU_Q)
+#define IOMMU_DOMAIN_DMA_SQ	(__IOMMU_DOMAIN_PAGING |	\
+				 __IOMMU_DOMAIN_DMA_API |	\
+				 __IOMMU_DOMAIN_DMA_LAZY |	\
+				 __IOMMU_DOMAIN_DMA_SINGLE_Q)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 
 struct iommu_domain {
-- 
2.34.1

