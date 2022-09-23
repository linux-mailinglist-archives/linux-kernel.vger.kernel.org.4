Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436665E8163
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiIWSCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiIWSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438013D1F5;
        Fri, 23 Sep 2022 11:01:53 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQisyJdSmcWvo2Xaq8oC7WtjzDiyBUJ2LbnuZZ+gyqA=;
        b=SQewCYx0PcmKefWP3V/z1ABCXtRJ3MqBzbEgNxFiiL7cQI14uZ16rRBjawYRU5HDZHzP68
        LbxVNsq5wxE7U0HUvsb8BTARBqj7mmXUIx/nzKo/hAe24zCi2ZPJNc94h/LiCVl/xJL891
        VA3Ijrws5MGdT9s41yDGrca0edjKhicL5XP0d1to/Ao1ZpbouwqqzLwns2XHhdHl13ZUtg
        ayn8PcFYkVXub0KXXOiLmcGJdOmk6TBb+ebrU6aw93XjAjDARyXL8WmGVzhZLn0K73xBmo
        rmfC9oqzNWGt9WnYMp/saAWpcCj/EJUBil+iExm8z3f66c7dMpoFOvPR3SDwJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQisyJdSmcWvo2Xaq8oC7WtjzDiyBUJ2LbnuZZ+gyqA=;
        b=tUDIbJpWXGiW+dSqOh7HaTyqYXhzr5oTGWrEpQB94Q6e73w4/dFINM5Xwg/1sEfcpYJeq8
        FUcyYJfSqoswwFCg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allow update_mba_bw() to update
 controls directly
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-12-james.morse@arm.com>
References: <20220902154829.30399-12-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611058.401.2420168455987298880.tip-bot2@tip-bot2>
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

Commit-ID:     ff6357bb50023af2a1dc8f113930082c5252c753
Gitweb:        https://git.kernel.org/tip/ff6357bb50023af2a1dc8f113930082c5252c753
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:19 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:43:44 +02:00

x86/resctrl: Allow update_mba_bw() to update controls directly

update_mba_bw() calculates a new control value for the MBA resource
based on the user provided mbps_val and the current measured
bandwidth. Some control values need remapping by delay_bw_map().

It does this by calling wrmsrl() directly. This needs splitting
up to be done by an architecture specific helper, so that the
remainder can eventually be moved to /fs/.

Add resctrl_arch_update_one() to apply one configuration value
to the provided resource and domain. This avoids the staging
and cross-calling that is only needed with changes made by
user-space. delay_bw_map() moves to be part of the arch code,
to maintain the 'percentage control' view of MBA resources
in resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-12-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 -
 arch/x86/kernel/cpu/resctrl/monitor.c     | 13 ++++---------
 include/linux/resctrl.h                   |  8 ++++++++
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f0e2820..90ebb7d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -296,7 +296,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
  * that can be written to QOS_MSRs.
  * There are currently no SKUs which support non linear delay values.
  */
-u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
+static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	if (r->membw.delay_linear)
 		return MAX_MBA_BW - bw;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index bf9d73c..0ab9232 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -282,6 +282,27 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
 	return false;
 }
 
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u32 idx = get_config_index(closid, t);
+	struct msr_param msr_param;
+
+	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
+		return -EINVAL;
+
+	hw_dom->ctrl_val[idx] = cfg_val;
+
+	msr_param.res = r;
+	msr_param.low = idx;
+	msr_param.high = idx + 1;
+	hw_res->msr_update(d, &msr_param, r);
+
+	return 0;
+}
+
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 373aaba..3b9e43b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -527,7 +527,6 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 16028b2..3e69386 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -420,10 +420,8 @@ void mon_event_count(void *info)
  */
 static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
-	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
+	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	struct rdt_hw_resource *hw_r_mba;
-	struct rdt_hw_domain *hw_dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -433,8 +431,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
-	r_mba = &hw_r_mba->r_resctrl;
+	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
@@ -444,7 +442,6 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
 	}
-	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
 	user_bw = dom_mba->mbps_val[closid];
@@ -486,9 +483,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	cur_msr = hw_r_mba->msr_base + closid;
-	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
-	hw_dom_mba->ctrl_val[closid] = new_msr_val;
+	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 
 	/*
 	 * Delta values are updated dynamically package wise for each
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 93dfe55..f4c9101 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -197,6 +197,14 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
+
+/*
+ * Update the ctrl_val and apply this config right now.
+ * Must be called on one of the domain's CPUs.
+ */
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
+
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
