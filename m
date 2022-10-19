Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5EA6049E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiJSOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJSOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:53:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEEFEE8B1;
        Wed, 19 Oct 2022 07:44:59 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDnLaO001414;
        Wed, 19 Oct 2022 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=akekm9bDUfMZxwGQudd6My8JhpeoURSTUO+R48iuqfE=;
 b=CGkRrsQ9+Bf2iaL0IO5QdXCDwqrf0b7jNiim80FqG2J2fW8EoxFr/96jCjgakBXwj0Um
 +LCC7zQaOKj84SMA7eUpefL8OCvegDFDWLiG/cFGqFnzixUd9O+hkizlm4Mw49geYYu6
 pmvNr8V3Pvx7EiMYy7O+a1Ohk1fFh1n3wMGb9nAVmWL871lh2V4qWWXWc6iWdg6qQxbo
 /X6Cj+Ig7OOu+9LGqRwezBiEirvK295hJDDFeB3cRLwE7G5WEb8y3JIhd4GTsOSjVPyo
 vlAh6V2iR436yKQKWz7391Z6anl+P5kyyR1Ad9fW29jijHCN4/dRWMNLJ/rYNp5YJc2f Mw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kajf4jftg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEZDuN025252;
        Wed, 19 Oct 2022 14:44:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg978u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEid4P1245894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:44:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B2EF4C040;
        Wed, 19 Oct 2022 14:44:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C63B24C046;
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
Subject: [RFC 5/6] iommu/dma: Add simple batching flush queue implementation
Date:   Wed, 19 Oct 2022 16:44:34 +0200
Message-Id: <20221019144435.369902-6-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019144435.369902-1-schnelle@linux.ibm.com>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GWR1zCYnuPrgQzoIOmJDYp7XiwvC9EPQ
X-Proofpoint-GUID: GWR1zCYnuPrgQzoIOmJDYp7XiwvC9EPQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having dma-iommu prepared for alternative flush queue implementations we
add a simple per-domain flush queue that optimzes for scenarios where
global IOTLB flushes are used but are quite expensive and poorly
parallelized. This is for example the case when IOTLB flushes are used
to trigger updates to an underlying hypervisor's shadow tables and
approximates the global flushing scheme previously in use on s390.

This is achieved by having a per-domain global flush queue that allows
queuing a much large number of lazily freed IOVAs than the per-CPU flush
queues. While using a single queue reduces parallelism this is not
a problem when global IOTLB flushes are synchronized in the hypervisor
anyway. While this flush queue allows queuing a large number of IOVAs we
do limit the time a freed IOVA remains accessible by hardware to
1 second using a timeout that is reset on flush.

Enable this new flush queue implementation by default on s390 systems
which use IOTLB flushes to trigger shadowing namely z/VM and KVM guests.

Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c  | 157 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu.c      |  19 +++--
 drivers/iommu/s390-iommu.c |  11 +++
 include/linux/iommu.h      |   6 ++
 4 files changed, 180 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77d969f5aad7..427fb84f50c3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -49,8 +49,13 @@ struct iommu_dma_cookie {
 		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
 		struct {
 			struct iova_domain		iovad;
-			/* Flush queue */
-			struct iova_percpu __percpu *percpu_fq;
+			/* Flush queues */
+			union {
+				struct iova_percpu __percpu *percpu_fq;
+				struct iova_simple *simple_fq;
+			};
+			/* Queue timeout in milliseconds */
+			unsigned int		fq_timeout;
 			/* Number of TLB flushes that have been started */
 			atomic64_t		fq_flush_start_cnt;
 			/* Number of TLB flushes that have been finished */
@@ -104,6 +109,119 @@ struct iova_percpu {
 	spinlock_t lock;
 };
 
+/* Simplified batched flush queue for expensive IOTLB flushes */
+#define IOVA_SIMPLE_SIZE	32768
+/* Maximum time in milliseconds an IOVA can remain lazily freed */
+#define IOVA_SIMPLE_TIMEOUT	1000
+
+struct iova_simple_entry {
+	unsigned long iova_pfn;
+	unsigned long pages;
+};
+
+struct iova_simple {
+	/* Unlike iova_percpu we use a single queue lock */
+	spinlock_t lock;
+	unsigned int tail;
+	unsigned long total_pages;
+	struct list_head freelist;
+	struct iova_simple_entry entries[];
+};
+
+static bool is_full_simple(struct iommu_dma_cookie *cookie)
+{
+	struct iommu_domain *fq_domain = cookie->fq_domain;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iova_simple *sq = cookie->simple_fq;
+	unsigned long aperture_pages;
+
+	assert_spin_locked(&sq->lock);
+
+	/* If more than 7/8 the aperture is batched let's flush */
+	aperture_pages = ((fq_domain->geometry.aperture_end +  1) -
+		fq_domain->geometry.aperture_start) >> iova_shift(iovad);
+	aperture_pages -= aperture_pages >> 3;
+
+	return (sq->tail >= IOVA_SIMPLE_SIZE ||
+		sq->total_pages >= aperture_pages);
+}
+
+static void flush_simple(struct iommu_dma_cookie *cookie)
+{
+	struct iova_simple *sq = cookie->simple_fq;
+	unsigned int i;
+
+	assert_spin_locked(&sq->lock);
+	/* We're flushing so postpone timeout */
+	mod_timer(&cookie->fq_timer,
+		  jiffies + msecs_to_jiffies(cookie->fq_timeout));
+	cookie->fq_domain->ops->flush_iotlb_all(cookie->fq_domain);
+
+	put_pages_list(&sq->freelist);
+	for (i = 0; i < sq->tail; i++) {
+		free_iova_fast(&cookie->iovad,
+			       sq->entries[i].iova_pfn,
+			       sq->entries[i].pages);
+	}
+	sq->tail = 0;
+	sq->total_pages = 0;
+}
+
+static void flush_simple_lock(struct iommu_dma_cookie *cookie)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cookie->simple_fq->lock, flags);
+	flush_simple(cookie);
+	spin_unlock_irqrestore(&cookie->simple_fq->lock, flags);
+}
+
+static void queue_iova_simple(struct iommu_dma_cookie *cookie,
+			      unsigned long pfn, unsigned long pages,
+			      struct list_head *freelist)
+{
+	struct iova_simple *sq = cookie->simple_fq;
+	unsigned long flags;
+	unsigned int idx;
+
+	spin_lock_irqsave(&sq->lock, flags);
+	if (is_full_simple(cookie))
+		flush_simple(cookie);
+	idx = sq->tail++;
+
+	sq->entries[idx].iova_pfn = pfn;
+	sq->entries[idx].pages    = pages;
+	list_splice(freelist, &sq->freelist);
+	sq->total_pages += pages;
+	spin_unlock_irqrestore(&sq->lock, flags);
+}
+
+static int iommu_dma_init_simple(struct iommu_dma_cookie *cookie)
+{
+	struct iova_simple *queue;
+
+	queue = vzalloc(sizeof(*queue) +
+			IOVA_SIMPLE_SIZE * sizeof(struct iova_simple_entry));
+	if (!queue)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&queue->freelist);
+	cookie->fq_timeout = IOVA_SIMPLE_TIMEOUT;
+	cookie->simple_fq = queue;
+
+	return 0;
+}
+
+static void iommu_dma_free_simple(struct iommu_dma_cookie *cookie)
+{
+	if (!cookie->simple_fq)
+		return;
+
+	put_pages_list(&cookie->simple_fq->freelist);
+	vfree(cookie->simple_fq);
+	cookie->simple_fq = NULL;
+}
+
 #define ring_for_each_percpu(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_PERCPU_SIZE)
 
@@ -169,12 +287,23 @@ static void flush_percpu(struct iommu_dma_cookie *cookie)
 	}
 }
 
+static void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
+{
+	if (!cookie->fq_domain)
+		return;
+
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		flush_percpu(cookie);
+	else
+		flush_simple_lock(cookie);
+}
+
 static void fq_flush_timeout(struct timer_list *t)
 {
 	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
 
 	atomic_set(&cookie->fq_timer_on, 0);
-	flush_percpu(cookie);
+	iommu_dma_flush_fq(cookie);
 }
 
 static void queue_iova_percpu(struct iommu_dma_cookie *cookie,
@@ -223,13 +352,16 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	 */
 	smp_mb();
 
-	queue_iova_percpu(cookie, pfn, pages, freelist);
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		queue_iova_percpu(cookie, pfn, pages, freelist);
+	else
+		queue_iova_simple(cookie, pfn, pages, freelist);
 
 	/* Avoid false sharing as much as possible. */
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_PERCPU_TIMEOUT));
+			  jiffies + msecs_to_jiffies(cookie->fq_timeout));
 }
 
 static void iommu_dma_free_percpu(struct iommu_dma_cookie *cookie)
@@ -253,7 +385,10 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 {
 	del_timer_sync(&cookie->fq_timer);
 	/* The IOVAs will be torn down separately, so just free our queued pages */
-	iommu_dma_free_percpu(cookie);
+	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
+		iommu_dma_free_percpu(cookie);
+	else
+		iommu_dma_free_simple(cookie);
 }
 
 static int iommu_dma_init_percpu(struct iommu_dma_cookie *cookie)
@@ -280,6 +415,7 @@ static int iommu_dma_init_percpu(struct iommu_dma_cookie *cookie)
 			INIT_LIST_HEAD(&fq->entries[i].freelist);
 	}
 
+	cookie->fq_timeout = IOVA_PERCPU_TIMEOUT;
 	cookie->percpu_fq = queue;
 
 	return 0;
@@ -294,7 +430,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	rc = iommu_dma_init_percpu(cookie);
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ)
+		rc = iommu_dma_init_percpu(cookie);
+	else
+		rc = iommu_dma_init_simple(cookie);
 	if (rc) {
 		pr_warn("iova flush queue initialization failed\n");
 		return rc;
@@ -613,7 +752,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		goto done_unlock;
 
 	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
+	if ((domain->type == IOMMU_DOMAIN_DMA_FQ ||
+	     domain->type == IOMMU_DOMAIN_DMA_SQ) &&
+	    iommu_dma_init_fq(domain))
 		domain->type = IOMMU_DOMAIN_DMA;
 
 	ret = iova_reserve_iommu_regions(dev, domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..2b3a12799702 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -140,6 +140,7 @@ static const char *iommu_domain_type_str(unsigned int t)
 		return "Unmanaged";
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
+	case IOMMU_DOMAIN_DMA_SQ:
 		return "Translated";
 	default:
 		return "Unknown";
@@ -437,7 +438,8 @@ early_param("iommu.strict", iommu_dma_setup);
 void iommu_set_dma_strict(void)
 {
 	iommu_dma_strict = true;
-	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
+	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ ||
+	    iommu_def_domain_type == IOMMU_DOMAIN_DMA_SQ)
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
@@ -638,6 +640,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 		case IOMMU_DOMAIN_DMA_FQ:
 			type = "DMA-FQ\n";
 			break;
+		case IOMMU_DOMAIN_DMA_SQ:
+			type = "DMA-SQ\n";
+			break;
 		}
 	}
 	mutex_unlock(&group->mutex);
@@ -2908,10 +2913,11 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* We can bring up a flush queue without tearing down the domain */
-	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
+	if ((type == IOMMU_DOMAIN_DMA_FQ || type == IOMMU_DOMAIN_DMA_SQ) &&
+	    prev_dom->type == IOMMU_DOMAIN_DMA) {
 		ret = iommu_dma_init_fq(prev_dom);
 		if (!ret)
-			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+			prev_dom->type = type;
 		goto out;
 	}
 
@@ -2982,6 +2988,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		req_type = IOMMU_DOMAIN_DMA;
 	else if (sysfs_streq(buf, "DMA-FQ"))
 		req_type = IOMMU_DOMAIN_DMA_FQ;
+	else if (sysfs_streq(buf, "DMA-SQ"))
+		req_type = IOMMU_DOMAIN_DMA_SQ;
 	else if (sysfs_streq(buf, "auto"))
 		req_type = 0;
 	else
@@ -3033,8 +3041,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
+	if (device_is_bound(dev) &&
+	    !((req_type == IOMMU_DOMAIN_DMA_FQ || req_type == IOMMU_DOMAIN_DMA_SQ) &&
+	      group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
 		goto out;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c2b8a7b96b8e..506f8b92931f 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -324,6 +324,15 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static int s390_iommu_def_domain_type(struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+
+	if (zdev->tlb_refresh)
+		return IOMMU_DOMAIN_DMA_SQ;
+	return IOMMU_DOMAIN_DMA_FQ;
+}
+
 static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 {
 	struct s390_domain *s390_domain;
@@ -331,6 +340,7 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 	switch (domain_type) {
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
+	case IOMMU_DOMAIN_DMA_SQ:
 	case IOMMU_DOMAIN_UNMANAGED:
 		break;
 	default:
@@ -774,6 +784,7 @@ subsys_initcall(s390_iommu_init);
 
 static const struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
+	.def_domain_type = s390_iommu_def_domain_type,
 	.domain_alloc = s390_domain_alloc,
 	.probe_device = s390_iommu_probe_device,
 	.probe_finalize = s390_iommu_probe_finalize,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a325532aeab5..6c3fe62ec0df 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -63,6 +63,7 @@ struct iommu_domain_geometry {
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_DMA_SQ	(1U << 4)  /* DMA-API uses max fill queue */
 
 /*
  * This are the possible domain-types
@@ -77,6 +78,8 @@ struct iommu_domain_geometry {
  *				  certain optimizations for these domains
  *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
  *				  invalidation.
+ *	IOMMU_DOMAIN_DMA_SQ	- As above, but batched invalidations are only
+ *				  flushed when running out of queue space.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
@@ -86,6 +89,9 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_DMA_SQ	(__IOMMU_DOMAIN_PAGING |	\
+				 __IOMMU_DOMAIN_DMA_API |	\
+				 __IOMMU_DOMAIN_DMA_SQ)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.34.1

