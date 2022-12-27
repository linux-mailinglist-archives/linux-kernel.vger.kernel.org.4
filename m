Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEF6566D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiL0Ca0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiL0CaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5856460
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOpPDdJYfnKmifqA1VNKd/d9z12/7/aNV7k1KeSJt4w=;
        b=Ka+Rt3t3uHJk4atCav6OUB+5AIfPtXUg9+NXnuqwkIelRCzYi3g3HjWUjWTOLa0f7OQe97
        8A+qAg58SvnU9WWdGNTffFApHE3xjQtTS0HC8nXInyoZH6DAm86mmMXvFTW7SFis54mDyC
        SFoRMHGjbwNOyRDoHsg2rQronxAxqWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-nyGOiGg3Mqyxp3eB5EUzpw-1; Mon, 26 Dec 2022 21:29:26 -0500
X-MC-Unique: nyGOiGg3Mqyxp3eB5EUzpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22227101A52E;
        Tue, 27 Dec 2022 02:29:26 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E305492B00;
        Tue, 27 Dec 2022 02:29:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/6] genirq/affinity: Don't pass irq_affinity_desc array to irq_build_affinity_masks
Date:   Tue, 27 Dec 2022 10:29:02 +0800
Message-Id: <20221227022905.352674-4-ming.lei@redhat.com>
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for abstracting irq_build_affinity_masks() into one public helper
for assigning all CPUs evenly into several groups. Don't pass
irq_affinity_desc array to irq_build_affinity_masks, instead return
a cpumask array by storing each assigned group into one element of
the array.

This way helps us to provide generic interface for grouping all CPUs
evenly from NUMA and CPU locality viewpoint, and the cost is one extra
allocation in irq_build_affinity_masks(), which should be fine since
it is done via GFP_KERNEL and irq_build_affinity_masks() is called very
less.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index da6379cd27fd..00bba1020ecb 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -249,7 +249,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
-				      struct irq_affinity_desc *masks)
+				      struct cpumask *masks)
 {
 	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	unsigned int last_affv = numvecs;
@@ -270,7 +270,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		for_each_node_mask(n, nodemsk) {
 			/* Ensure that only CPUs which are in both masks are set */
 			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-			cpumask_or(&masks[curvec].mask, &masks[curvec].mask, nmsk);
+			cpumask_or(&masks[curvec], &masks[curvec], nmsk);
 			if (++curvec == last_affv)
 				curvec = 0;
 		}
@@ -321,7 +321,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			 */
 			if (curvec >= last_affv)
 				curvec = 0;
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
+			irq_spread_init_one(&masks[curvec], nmsk,
 						cpus_per_vec);
 		}
 		done += nv->nvectors;
@@ -335,16 +335,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(unsigned int numvecs,
-				    struct irq_affinity_desc *masks)
+static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 {
 	unsigned int curvec = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return ret;
+		return NULL;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
@@ -353,6 +353,10 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
+	masks = kcalloc(numvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
 	/* Stabilize the cpumasks */
 	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
@@ -386,6 +390,7 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+ fail_node_to_cpumask:
 	free_node_to_cpumask(node_to_cpumask);
 
  fail_npresmsk:
@@ -393,7 +398,11 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
@@ -457,13 +466,18 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
-		int ret;
+		int j;
+		struct cpumask *result = irq_build_affinity_masks(this_vecs);
 
-		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
-		if (ret) {
+		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
+
+		for (j = 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		kfree(result);
+
 		curvec += this_vecs;
 		usedvecs += this_vecs;
 	}
-- 
2.31.1

