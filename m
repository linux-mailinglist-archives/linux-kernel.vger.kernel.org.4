Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6649B5E8166
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiIWSDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiIWSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB513E7EA;
        Fri, 23 Sep 2022 11:01:55 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwifcW4PviJc47RkQ2Fzmc15pVkzUTA3ppAL/PWr/wE=;
        b=J0ZCEbu9qJHJZkASPIHbgmSCeBdUSJIr/FrKiY182RwPGUZ4f6Fxn7GVJu3W3LcyKYzDqs
        7kXbIMO84abt9I3hPiJf5BobGWMT4MQ85SAbk/lZmZqPzOGyQ0334rf5suK8FmkLYA1G2A
        kiSMChP4UtUCiKOwIs3g78zQgH+bjxxjBGr5eBkQbE0SauFatoSJiUdUlE+j1Zw4ArzL/s
        PVe07j01rbd1gPmDm4sBaGEl1w+krFpGRiSNJWAywbgTP5Ipz8Te7EkrHs13JF9eySY9yo
        hzAI+QwWmWlaINvbX6IPN7Au7yPdWECqqEdK/tfKuJDgdJHYvAgUavL138/7SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwifcW4PviJc47RkQ2Fzmc15pVkzUTA3ppAL/PWr/wE=;
        b=Y/FgYHSkqXhwiF1z/bxLF9TGjbwnobM2SfC6hbP78lOVXkqb9BYs6fBNn37Dwjp073vVlK
        3FToE+Dr15WD+VCg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Switch over to the resctrl mbps_val list
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-10-james.morse@arm.com>
References: <20220902154829.30399-10-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611268.401.15600386610380507547.tip-bot2@tip-bot2>
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

Commit-ID:     6ce1560d35f63a458fead11ac865bc39cea9bc46
Gitweb:        https://git.kernel.org/tip/6ce1560d35f63a458fead11ac865bc39cea9bc46
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:17 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:34:08 +02:00

x86/resctrl: Switch over to the resctrl mbps_val list

Updates to resctrl's software controller follow the same path as
other configuration updates, but they don't modify the hardware state.
rdtgroup_schemata_write() uses parse_line() and the resource's
parse_ctrlval() function to stage the configuration.
resctrl_arch_update_domains() then updates the mbps_val[] array
instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
call that would update hardware.

This complicates the interface between resctrl's filesystem parts
and architecture specific code. It should be possible for mba_sc
to be completely implemented by the filesystem parts of resctrl. This
would allow it to work on a second architecture with no additional code.
resctrl_arch_update_domains() using the mbps_val[] array prevents this.

Change parse_bw() to write the configuration value directly to the
mbps_val[] array in the domain structure. Change rdtgroup_schemata_write()
to skip the call to resctrl_arch_update_domains(), meaning all the
mba_sc specific code in resctrl_arch_update_domains() can be removed.
On the read-side, show_doms() and update_mba_bw() are changed to read
the mbps_val[] array from the domain structure. With this,
resctrl_arch_get_config() no longer needs to consider mba_sc resources.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-10-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 44 +++++++++++++---------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 27 ++++++++++----
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 8766627..bf9d73c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -61,6 +61,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
 	struct resctrl_staged_config *cfg;
+	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
@@ -72,6 +73,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
+
+	if (is_mba_sc(r)) {
+		d->mbps_val[closid] = bw_val;
+		return 0;
+	}
+
 	cfg->new_ctrl = bw_val;
 	cfg->have_new_ctrl = true;
 
@@ -261,14 +268,13 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 
 static bool apply_config(struct rdt_hw_domain *hw_dom,
 			 struct resctrl_staged_config *cfg, u32 idx,
-			 cpumask_var_t cpu_mask, bool mba_sc)
+			 cpumask_var_t cpu_mask)
 {
 	struct rdt_domain *dom = &hw_dom->d_resctrl;
-	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[idx]) {
+	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[idx] = cfg->new_ctrl;
+		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
 
 		return true;
 	}
@@ -284,14 +290,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	bool mba_sc;
 	int cpu;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	mba_sc = is_mba_sc(r);
 	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
@@ -301,7 +305,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
+			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
 				continue;
 
 			if (!msr_param.res) {
@@ -315,11 +319,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		}
 	}
 
-	/*
-	 * Avoid writing the control msr with control values when
-	 * MBA software controller is enabled
-	 */
-	if (cpumask_empty(cpu_mask) || mba_sc)
+	if (cpumask_empty(cpu_mask))
 		goto done;
 	cpu = get_cpu();
 	/* Update resource control msr on this CPU if it's in cpu_mask. */
@@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
+
+		/*
+		 * Writes to mba_sc resources update the software controller,
+		 * not the control MSR.
+		 */
+		if (is_mba_sc(r))
+			continue;
+
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -433,9 +441,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, type);
 
-	if (!is_mba_sc(r))
-		return hw_dom->ctrl_val[idx];
-	return hw_dom->mbps_val[idx];
+	return hw_dom->ctrl_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
@@ -450,8 +456,12 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = resctrl_arch_get_config(r, dom, closid,
-						   schema->conf_type);
+		if (is_mba_sc(r))
+			ctrl_val = dom->mbps_val[closid];
+		else
+			ctrl_val = resctrl_arch_get_config(r, dom, closid,
+							   schema->conf_type);
+
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 497cadf..16028b2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -447,13 +447,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
+	user_bw = dom_mba->mbps_val[closid];
 	delta_bw = pmbm_data->delta_bw;
-	/*
-	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
-	 * based on is_mba_sc(). For now, reach into the hw_dom.
-	 */
-	cur_msr_val = hw_dom_mba->ctrl_val[closid];
+
+	/* MBA resource doesn't support CDP */
+	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f7ebd01..55d8a12 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1356,11 +1356,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
+	enum resctrl_conf_type type;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
 	int ret = 0;
+	u32 closid;
 	bool sep;
 	u32 ctrl;
 
@@ -1386,8 +1388,11 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		goto out;
 	}
 
+	closid = rdtgrp->closid;
+
 	list_for_each_entry(schema, &resctrl_schema_all, list) {
 		r = schema->res;
+		type = schema->conf_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -1396,9 +1401,12 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				ctrl = resctrl_arch_get_config(r, d,
-							       rdtgrp->closid,
-							       schema->conf_type);
+				if (is_mba_sc(r))
+					ctrl = d->mbps_val[closid];
+				else
+					ctrl = resctrl_arch_get_config(r, d,
+								       closid,
+								       type);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2818,14 +2826,19 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 }
 
 /* Initialize MBA resource with default values. */
-static void rdtgroup_init_mba(struct rdt_resource *r)
+static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
+		if (is_mba_sc(r)) {
+			d->mbps_val[closid] = MBA_MAX_MBPS;
+			continue;
+		}
+
 		cfg = &d->staged_config[CDP_NONE];
-		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		cfg->new_ctrl = r->default_ctrl;
 		cfg->have_new_ctrl = true;
 	}
 }
@@ -2840,7 +2853,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA) {
-			rdtgroup_init_mba(r);
+			rdtgroup_init_mba(r, rdtgrp->closid);
+			if (is_mba_sc(r))
+				continue;
 		} else {
 			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
