Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8255E816C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiIWSDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiIWSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42513EEB1;
        Fri, 23 Sep 2022 11:02:01 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tngDgJXtM1s4FtbZmPcrzF4trxX2thrHI+85DbCcVYU=;
        b=bhhaljwfQOexuIlalZzZjcKdcYrLewbVNd6X5NQ5/byNm8BpPInj8ALg2JilgNy/vZIoBw
        9bJkPoBwr9HvD4CtfFIY3X/8hBTcGRRh5GSr9S7jLHTWIUgVnquWpkpQtBf0FQvaKd/ZY/
        yeSrSUeF0EBF4aPXsJMetRIOCn75AZho8eZXGe6uP4DTBDYUx9JeR1Mge2B/xiGsLs/y2s
        SRgD0p31KK7s4NY2wQKSAxJtoHnNLHFq2urwxKoWzN2IdJyy79rm1G9qTrS81QcOvWAyp/
        MfHmQUKnBbDvJRrZ30EUAgRCDKFQg+HQXrQ1GlWZUUgMzzPWRkbgLzvlywZZvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tngDgJXtM1s4FtbZmPcrzF4trxX2thrHI+85DbCcVYU=;
        b=w9zc/Lcw7Z3buyk6zqvq3dkT2uIDMAuVxygBS9bw61YnbxqIfLDbVsXjdqJTjd1zPwyVpO
        kJUuSdiF1lFiuzDw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add domain online callback for resctrl work
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-4-james.morse@arm.com>
References: <20220902154829.30399-4-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611895.401.13347771402133648689.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3a7232cdf19e39e7f24c493117b373788b348af2
Gitweb:        https://git.kernel.org/tip/3a7232cdf19e39e7f24c493117b373788b348af2
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:11 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 15:13:27 +02:00

x86/resctrl: Add domain online callback for resctrl work

Because domains are exposed to user-space via resctrl, the filesystem
must update its state when CPU hotplug callbacks are triggered.

Some of this work is common to any architecture that would support
resctrl, but the work is tied up with the architecture code to
allocate the memory.

Move domain_setup_mon_state(), the monitor subdir creation call and the
mbm/limbo workers into a new resctrl_online_domain() call. These bits
are not specific to the architecture. Grouping them in one function
allows that code to be moved to /fs/ and re-used by another architecture.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-4-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 53 ++------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 +++++++++++++++++++++++--
 include/linux/resctrl.h                |  1 +-
 4 files changed, 67 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2f87177..25f3014 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -443,42 +443,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
-{
-	size_t tsize;
-
-	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
-		if (!d->rmid_busy_llc)
-			return -ENOMEM;
-		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
-	}
-	if (is_mbm_total_enabled()) {
-		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (is_mbm_local_enabled()) {
-		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
-	}
-
-	if (is_mbm_enabled()) {
-		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
-	}
-
-	return 0;
-}
-
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -498,6 +462,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
+	int err;
 
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
@@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && domain_setup_mon_state(r, d)) {
+	list_add_tail(&d->list, add_pos);
+
+	err = resctrl_online_domain(r, d);
+	if (err) {
+		list_del(&d->list);
 		kfree(hw_dom->ctrl_val);
 		kfree(hw_dom->mbps_val);
 		kfree(hw_dom);
-		return;
 	}
-
-	list_add_tail(&d->list, add_pos);
-
-	/*
-	 * If resctrl is mounted, add
-	 * per domain monitor data directories.
-	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
-		mkdir_mondata_subdir_allrdtgrp(r, d);
 }
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8828b5c..be48a68 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -524,8 +524,6 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index def7c66..030a703 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2565,16 +2565,13 @@ out_destroy:
  * Add all subdirectories of mon_data for "ctrl_mon" groups
  * and "monitor" groups with given domain id.
  */
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d)
+static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_domain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn = prgrp->mon.mon_data_kn;
 		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
@@ -3236,6 +3233,64 @@ out:
 	return ret;
 }
 
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+{
+	size_t tsize;
+
+	if (is_llc_occupancy_enabled()) {
+		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		if (!d->rmid_busy_llc)
+			return -ENOMEM;
+	}
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*d->mbm_total);
+		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_total) {
+			bitmap_free(d->rmid_busy_llc);
+			return -ENOMEM;
+		}
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*d->mbm_local);
+		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_local) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!r->mon_capable)
+		return 0;
+
+	err = domain_setup_mon_state(r, d);
+	if (err)
+		return err;
+
+	if (is_mbm_enabled()) {
+		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+	}
+
+	if (is_llc_occupancy_enabled())
+		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
+
+	/* If resctrl is mounted, add per domain monitor data directories. */
+	if (static_branch_unlikely(&rdt_mon_enable_key))
+		mkdir_mondata_subdir_allrdtgrp(r, d);
+
+	return 0;
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8180c53..d512455 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -192,5 +192,6 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
