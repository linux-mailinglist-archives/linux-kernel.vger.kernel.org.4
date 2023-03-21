Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA036C33D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCUOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCUOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:14:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B4B472;
        Tue, 21 Mar 2023 07:14:18 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7dOBYYvWovvTIcx3n//qMjf14xrEZD3Qbs9nBmk6yg=;
        b=tiQo5s4PE/yG295PMdti6ktTc/6/tijFiwksZPHdgx8THy/xy1CNy/b9APS373XW+1Pdoc
        6zdb7mq+Z71yIaZEg3rj/wuKJlPTYkSvq/GstSjW84m3jYXzZSy4NjaUjBieg9ow4WPYO6
        /Qzs3ny8BWtyRDB5IxAg3S9jmHj0d7uX7FSmtyv92Rfmco3KDl0qiDWZVUgHA4yyDWWhdn
        XW6GuGz6zXQUUSWQdl+DLmvqO8wnZyifGAqFq1wlJ+oO6oMcFm/A/XAV7m9HZT2V4wCeB0
        2+6YMsCNT0SoZPjzmI+kUgxtlGFdnAVc3E2CCF4AI2DKsc1W1i9Sc7FgmjcEnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7dOBYYvWovvTIcx3n//qMjf14xrEZD3Qbs9nBmk6yg=;
        b=qD39ofHJLO8FeWcRO6j507XtEBTXn8CO0Gy5v+vAXWHwb883PN8uupjfwHdI4SJfODCBtP
        OVD0d6uWd+fmw7Bw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/x2apic: Allow CPU cluster_mask to be
 populated in parallel
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316222109.1940300-2-usama.arif@bytedance.com>
References: <20230316222109.1940300-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Message-ID: <167940805630.5837.17701232751500761197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     cefad862f23874174136a48d91cb4a6ac3b1c5ce
Gitweb:        https://git.kernel.org/tip/cefad862f23874174136a48d91cb4a6ac3b1c5ce
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 16 Mar 2023 22:20:58 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Mar 2023 13:35:53 +01:00

x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel

Each of the sibling CPUs in a cluster uses the same clustermask. The first
CPU in a cluster will need a new clustermask allocated, while subsequent
siblings will use the same clustermask as the first.

However, the CPU being brought up cannot yet perform memory allocations
at the point that this occurs in init_x2apic_ldr().

So at present, the alloc_clustermask() function allocates a clustermask
just in case it's needed, storing it in the global cluster_hotplug_mask.
A CPU which is the first sibling of a cluster will "take" it from there
and set cluster_hotplug_mask to NULL, in order for alloc_clustermask()
to allocate a new one before bringing up the next CPU.

To facilitate parallel bringup of CPUs in future, switch to a model
where alloc_clustermask() prepopulates the clustermask in the per_cpu
data for each present CPU in the cluster in advance. All that the CPU
needs to do for itself in init_x2apic_ldr() is set its own bit in that
mask.

The 'node' and 'clusterid' members of struct cluster_mask are thus
redundant, and it can become a simple struct cpumask instead.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Link: https://lore.kernel.org/r/20230316222109.1940300-2-usama.arif@bytedance.com

---
 arch/x86/kernel/apic/x2apic_cluster.c | 126 ++++++++++++++++---------
 1 file changed, 82 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22..b2b2b7f 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -9,11 +9,7 @@
 
 #include "local.h"
 
-struct cluster_mask {
-	unsigned int	clusterid;
-	int		node;
-	struct cpumask	mask;
-};
+#define apic_cluster(apicid) ((apicid) >> 4)
 
 /*
  * __x2apic_send_IPI_mask() possibly needs to read
@@ -23,8 +19,7 @@ struct cluster_mask {
 static u32 *x86_cpu_to_logical_apicid __read_mostly;
 
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
-static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
-static struct cluster_mask *cluster_hotplug_mask;
+static DEFINE_PER_CPU_READ_MOSTLY(struct cpumask *, cluster_masks);
 
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
@@ -60,10 +55,10 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
-		struct cluster_mask *cmsk = per_cpu(cluster_masks, cpu);
+		struct cpumask *cmsk = per_cpu(cluster_masks, cpu);
 
 		dest = 0;
-		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
+		for_each_cpu_and(clustercpu, tmpmsk, cmsk)
 			dest |= x86_cpu_to_logical_apicid[clustercpu];
 
 		if (!dest)
@@ -71,7 +66,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 
 		__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 		/* Remove cluster CPUs from tmpmask */
-		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
+		cpumask_andnot(tmpmsk, tmpmsk, cmsk);
 	}
 
 	local_irq_restore(flags);
@@ -105,55 +100,98 @@ static u32 x2apic_calc_apicid(unsigned int cpu)
 
 static void init_x2apic_ldr(void)
 {
-	struct cluster_mask *cmsk = this_cpu_read(cluster_masks);
-	u32 cluster, apicid = apic_read(APIC_LDR);
-	unsigned int cpu;
+	struct cpumask *cmsk = this_cpu_read(cluster_masks);
 
-	x86_cpu_to_logical_apicid[smp_processor_id()] = apicid;
+	BUG_ON(!cmsk);
 
-	if (cmsk)
-		goto update;
-
-	cluster = apicid >> 16;
-	for_each_online_cpu(cpu) {
-		cmsk = per_cpu(cluster_masks, cpu);
-		/* Matching cluster found. Link and update it. */
-		if (cmsk && cmsk->clusterid == cluster)
-			goto update;
+	cpumask_set_cpu(smp_processor_id(), cmsk);
+}
+
+/*
+ * As an optimisation during boot, set the cluster_mask for all present
+ * CPUs at once, to prevent each of them having to iterate over the others
+ * to find the existing cluster_mask.
+ */
+static void prefill_clustermask(struct cpumask *cmsk, unsigned int cpu, u32 cluster)
+{
+	int cpu_i;
+
+	for_each_present_cpu(cpu_i) {
+		struct cpumask **cpu_cmsk = &per_cpu(cluster_masks, cpu_i);
+		u32 apicid = apic->cpu_present_to_apicid(cpu_i);
+
+		if (apicid == BAD_APICID || cpu_i == cpu || apic_cluster(apicid) != cluster)
+			continue;
+
+		if (WARN_ON_ONCE(*cpu_cmsk == cmsk))
+			continue;
+
+		BUG_ON(*cpu_cmsk);
+		*cpu_cmsk = cmsk;
 	}
-	cmsk = cluster_hotplug_mask;
-	cmsk->clusterid = cluster;
-	cluster_hotplug_mask = NULL;
-update:
-	this_cpu_write(cluster_masks, cmsk);
-	cpumask_set_cpu(smp_processor_id(), &cmsk->mask);
 }
 
-static int alloc_clustermask(unsigned int cpu, int node)
+static int alloc_clustermask(unsigned int cpu, u32 cluster, int node)
 {
+	struct cpumask *cmsk = NULL;
+	unsigned int cpu_i;
+
+	/*
+	 * At boot time, the CPU present mask is stable. The cluster mask is
+	 * allocated for the first CPU in the cluster and propagated to all
+	 * present siblings in the cluster. If the cluster mask is already set
+	 * on entry to this function for a given CPU, there is nothing to do.
+	 */
 	if (per_cpu(cluster_masks, cpu))
 		return 0;
+
+	if (system_state < SYSTEM_RUNNING)
+		goto alloc;
+
 	/*
-	 * If a hotplug spare mask exists, check whether it's on the right
-	 * node. If not, free it and allocate a new one.
+	 * On post boot hotplug for a CPU which was not present at boot time,
+	 * iterate over all possible CPUs (even those which are not present
+	 * any more) to find any existing cluster mask.
 	 */
-	if (cluster_hotplug_mask) {
-		if (cluster_hotplug_mask->node == node)
-			return 0;
-		kfree(cluster_hotplug_mask);
+	for_each_possible_cpu(cpu_i) {
+		u32 apicid = apic->cpu_present_to_apicid(cpu_i);
+
+		if (apicid != BAD_APICID && apic_cluster(apicid) == cluster) {
+			cmsk = per_cpu(cluster_masks, cpu_i);
+			/*
+			 * If the cluster is already initialized, just store
+			 * the mask and return. There's no need to propagate.
+			 */
+			if (cmsk) {
+				per_cpu(cluster_masks, cpu) = cmsk;
+				return 0;
+			}
+		}
 	}
-
-	cluster_hotplug_mask = kzalloc_node(sizeof(*cluster_hotplug_mask),
-					    GFP_KERNEL, node);
-	if (!cluster_hotplug_mask)
+	/*
+	 * No CPU in the cluster has ever been initialized, so fall through to
+	 * the boot time code which will also populate the cluster mask for any
+	 * other CPU in the cluster which is (now) present.
+	 */
+alloc:
+	cmsk = kzalloc_node(sizeof(*cmsk), GFP_KERNEL, node);
+	if (!cmsk)
 		return -ENOMEM;
-	cluster_hotplug_mask->node = node;
+	per_cpu(cluster_masks, cpu) = cmsk;
+	prefill_clustermask(cmsk, cpu, cluster);
+
 	return 0;
 }
 
 static int x2apic_prepare_cpu(unsigned int cpu)
 {
-	if (alloc_clustermask(cpu, cpu_to_node(cpu)) < 0)
+	u32 phys_apicid = apic->cpu_present_to_apicid(cpu);
+	u32 cluster = apic_cluster(phys_apicid);
+	u32 logical_apicid = (cluster << 16) | (1 << (phys_apicid & 0xf));
+
+	x86_cpu_to_logical_apicid[cpu] = logical_apicid;
+
+	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
 		return -ENOMEM;
 	if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
 		return -ENOMEM;
@@ -162,10 +200,10 @@ static int x2apic_prepare_cpu(unsigned int cpu)
 
 static int x2apic_dead_cpu(unsigned int dead_cpu)
 {
-	struct cluster_mask *cmsk = per_cpu(cluster_masks, dead_cpu);
+	struct cpumask *cmsk = per_cpu(cluster_masks, dead_cpu);
 
 	if (cmsk)
-		cpumask_clear_cpu(dead_cpu, &cmsk->mask);
+		cpumask_clear_cpu(dead_cpu, cmsk);
 	free_cpumask_var(per_cpu(ipi_mask, dead_cpu));
 	return 0;
 }
