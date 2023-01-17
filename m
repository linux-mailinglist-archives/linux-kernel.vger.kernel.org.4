Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058B66E5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjAQSQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjAQSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:14:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B0D4F84D;
        Tue, 17 Jan 2023 09:54:59 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:54:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673978098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtHAhQr4A/WwrJR2xwohwLM8Ekb9akA5k1WMibZ9mvk=;
        b=CzgiQAutbbkGi9xTFOZ6FIguYiLiaSdKjcb9hvzJVOgoczp7CYJFPs45miUsHBska9cAvQ
        S6QlYGktEmZDrEmwtMUUqnckL6f3spj2pinJpAa3RyiHw2fpyRFwWF0IV29wvzrjsA5Ge1
        cuJ/TEJGc3mhicUDxnfvnq0RQPt0YyaycABZNZqcuZC4tCXySwESgQPTmoo2hNuUvV1JJY
        xH4oxh6MQ3ug9BJpIMSWCYSq7BvOr8glwI4tKKYGDyzbfW8BCRtIfY2L1ka+bCBURKbX0x
        hU/bfJCtflxCtL4EvBy5wvQjOd54dt3iOuMwbxwhWg/l3WKdGaE2rSWWHMg8Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673978098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtHAhQr4A/WwrJR2xwohwLM8Ekb9akA5k1WMibZ9mvk=;
        b=h71hnb21TlTIByfU6OkO0RYn2PPy3I/7Z6MJA5jd/ZNmH8/MoTSEQHWJiCWN1Z658FUr1T
        C1ehvV+zDZ5GtbAg==
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Don't pass irq_affinity_desc array
 to irq_build_affinity_masks
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221227022905.352674-4-ming.lei@redhat.com>
References: <20221227022905.352674-4-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <167397809771.4906.11909600068519788572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e7bdd7f0cbd1c001bb9b4d3313edc5ee094bc3f8
Gitweb:        https://git.kernel.org/tip/e7bdd7f0cbd1c001bb9b4d3313edc5ee094bc3f8
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Tue, 27 Dec 2022 10:29:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Jan 2023 18:50:06 +01:00

genirq/affinity: Don't pass irq_affinity_desc array to irq_build_affinity_masks

Prepare for abstracting irq_build_affinity_masks() into a public function
for assigning all CPUs evenly into several groups.

Don't pass irq_affinity_desc array to irq_build_affinity_masks, instead
return a cpumask array by storing each assigned group into one element of
the array.

This allows to provide a generic interface for grouping all CPUs evenly
from a NUMA and CPU locality viewpoint, and the cost is one extra allocation
in irq_build_affinity_masks(), which should be fine since it is done via
GFP_KERNEL and irq_build_affinity_masks() is a slow path anyway.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>                                                                                                                                                                                                    
Link: https://lore.kernel.org/r/20221227022905.352674-4-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index da6379c..00bba10 100644
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
