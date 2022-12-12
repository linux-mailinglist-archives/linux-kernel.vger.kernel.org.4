Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16764A9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiLLVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiLLVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:52:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4E1AA2A;
        Mon, 12 Dec 2022 13:52:23 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCKv2WB002523;
        Mon, 12 Dec 2022 21:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/RzOpCPL4eZiVJddHN/KXGXNwmco06pBhZZ9D0pTebE=;
 b=pkpjReZ5dVdfjX+2Nnz1FKkQMvgmnwgrAUBfWeyK8AUhzijgFHhOXIr5j0B34Xe7xnUY
 cVtRkFs3QB/4YOpprNmoFb4j0eU/s7JEXo80luhNxLiIx49/Yh0H3X4DSweHpW7S2n2l
 ToFjoU6RW012Lz7oU/7diw5tFOQU0u4ZdfwvZ3niN6a6UwNVjPD1N9bI7H2w/eGNEfwz
 E69EkkkSxUpErCIK0mzMzgVqiDR3v5uNpE4a9JfRwxXqOvfXvK5T0Lyf0GlNXr7qUKeW
 AfOJ82QIwyxPqskz0bqR70M3bz70S0RRnoI4JjwcwKudZhPGi+QdrJ9u0dEYpvDYeG79 Zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mcffvdgcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:52:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCLq3HO008267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:52:04 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 13:52:03 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <djakov@kernel.org>
Subject: [RFC v2 2/2] iommu/iova: Add support for best-fit algorithm
Date:   Mon, 12 Dec 2022 13:51:38 -0800
Message-ID: <20221212215138.17897-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
References: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YcsA7Avi8EwkyfRhrEwCoovPLYRalZfM
X-Proofpoint-GUID: YcsA7Avi8EwkyfRhrEwCoovPLYRalZfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=976 clxscore=1015 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some multimedia use-cases that involve allocating buffers less than
PAGE_SIZE, combined with allocating ~400MB buffers, the IOVA space is
getting fragmented and allocation failures are observed.

In these scenarios, there are hundreds of randomly distributed non-power
of two allocations, which in some cases leave behind holes of up to 100MB
in the IOVA space.

To reduce the memory fragmentation in these use-cases, introduce the
"best-fit" algorithm, which can be enabled by individual devices with
a device-tree property. If the DT property is not present, the default
"first-fit" algorithm will be used.

Example usage:

	device {
		compatible = "example-device";
       		iommus = <&smmu 0x21 0>;
		iova-best-fit;
	};

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---

RFC v1: https://lore.kernel.org/r/1581721602-17010-1-git-send-email-isaacm@codeaurora.org/
- Use a DT property instead of an API to enable the best-fit algorithm for the device
- Rename __alloc_and_insert_iova_range() to __alloc_and_insert_iova_first_fit()


 drivers/iommu/dma-iommu.c |  5 +++
 drivers/iommu/iova.c      | 79 ++++++++++++++++++++++++++++++++++++---
 include/linux/iova.h      |  1 +
 3 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f798c44e0903..1be25e54d050 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -582,6 +582,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (ret)
 		goto done_unlock;
 
+	if (dev && dev->of_node) {
+		if (of_property_read_bool(dev->of_node, "iommu-best-fit"))
+			iovad->best_fit = true;
+	}
+
 	/* If the FQ fails we can simply fall back to strict mode */
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
 		domain->type = IOMMU_DOMAIN_DMA;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a44ad92fc5eb..34ad05a4095f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -64,6 +64,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->cached_node = &iovad->anchor.node;
 	iovad->cached32_node = &iovad->anchor.node;
 	iovad->granule = granule;
+	iovad->best_fit = false;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
@@ -175,9 +176,10 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 	rb_insert_color(&iova->node, root);
 }
 
-static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
-		unsigned long size, unsigned long limit_pfn,
-			struct iova *new, bool size_aligned)
+static int __alloc_and_insert_iova_first_fit(struct iova_domain *iovad,
+					     unsigned long size,
+					     unsigned long limit_pfn,
+					     struct iova *new, bool size_aligned)
 {
 	struct rb_node *curr, *prev;
 	struct iova *curr_iova;
@@ -236,6 +238,68 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static int __alloc_and_insert_iova_best_fit(struct iova_domain *iovad,
+					    unsigned long size,
+					    unsigned long limit_pfn,
+					    struct iova *new, bool size_aligned)
+{
+	struct rb_node *curr, *prev;
+	struct iova *curr_iova, *prev_iova;
+	unsigned long flags;
+	unsigned long align_mask = ~0UL;
+	struct rb_node *candidate_rb_parent;
+	unsigned long new_pfn, candidate_pfn = ~0UL;
+	unsigned long gap, candidate_gap = ~0UL;
+
+	if (size_aligned)
+		align_mask <<= fls_long(size - 1);
+
+	/* Walk the tree backwards */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	curr = &iovad->anchor.node;
+	prev = rb_prev(curr);
+	for (; prev; curr = prev, prev = rb_prev(curr)) {
+		curr_iova = rb_entry(curr, struct iova, node);
+		prev_iova = rb_entry(prev, struct iova, node);
+
+		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+		new_pfn = (limit_pfn - size) & align_mask;
+		gap = curr_iova->pfn_lo - prev_iova->pfn_hi - 1;
+		if (limit_pfn >= size && new_pfn > prev_iova->pfn_hi && gap < candidate_gap) {
+			candidate_gap = gap;
+			candidate_pfn = new_pfn;
+			candidate_rb_parent = curr;
+			if (gap == size)
+				goto insert;
+		}
+	}
+
+	curr_iova = rb_entry(curr, struct iova, node);
+	limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+	new_pfn = (limit_pfn - size) & align_mask;
+	gap = curr_iova->pfn_lo - iovad->start_pfn;
+	if (limit_pfn >= size && new_pfn >= iovad->start_pfn && gap < candidate_gap) {
+		candidate_gap = gap;
+		candidate_pfn = new_pfn;
+		candidate_rb_parent = curr;
+	}
+
+insert:
+	if (candidate_pfn == ~0UL) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* pfn_lo will point to size aligned address if size_aligned is set */
+	new->pfn_lo = candidate_pfn;
+	new->pfn_hi = new->pfn_lo + size - 1;
+
+	/* If we have 'prev', it's a valid place to start the insertion. */
+	iova_insert_rbtree(&iovad->rbroot, new, candidate_rb_parent);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return 0;
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -322,8 +386,13 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 	if (!new_iova)
 		return NULL;
 
-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
-			new_iova, size_aligned);
+	if (iovad->best_fit) {
+		ret = __alloc_and_insert_iova_best_fit(iovad, size, limit_pfn + 1,
+						       new_iova, size_aligned);
+	} else {
+		ret = __alloc_and_insert_iova_first_fit(iovad, size, limit_pfn + 1,
+							new_iova, size_aligned);
+	}
 
 	if (ret) {
 		free_iova_mem(new_iova);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 83c00fac2acb..c0c77f676e17 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -38,6 +38,7 @@ struct iova_domain {
 
 	struct iova_rcache	*rcaches;
 	struct hlist_node	cpuhp_dead;
+	bool best_fit;			/* best-fit algorithm is enabled */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
