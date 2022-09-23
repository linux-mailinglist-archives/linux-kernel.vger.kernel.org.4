Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD55E8175
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiIWSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiIWSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77B13F2A4;
        Fri, 23 Sep 2022 11:02:03 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:02:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWCnCkgnXnQ1QFm5gHOD1n8FGl//INPyzvlMa1UZ2Gk=;
        b=ecGeCvBYebvIV2RAUHtl7StlCi7j7VGK+UOX8okTYELxqAVBrOT5amGfCEc/xq51UAQ5Kl
        nFQoFrH9PrZXL/q8pbXPkeAW32WTaGIYwtoGoRKepmvPv1wwYGw48a2Cbdz8/dgiYmZ6ST
        SAx6pRMdE6Z5eR5U36jyg3qOENWHBXz2J3Yn2bWq0F+unfbKeX5SetQYCc0HPbptGJvR2Z
        YWjEaBxDIa6rxZO8dRG+TMlCVuclbj8G1ClgPfvuQkSY85pV0bqHYOqOZp5+5xzRwXTgY5
        EAlxUQrGkQ1JNGWJtBlRClC7PbiS0PGBbuhmE1miv1lbd16Ul83mj7GPkpe4Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWCnCkgnXnQ1QFm5gHOD1n8FGl//INPyzvlMa1UZ2Gk=;
        b=HAuzYSzBdZghds57RIk8iaF6mcpK0I3/2fi29Ksmtmr5HFQfPhgkk4VZ9/FNrgMM8HZF4E
        mJCX3rTuTS38BwAA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Kill off alloc_enabled
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-2-james.morse@arm.com>
References: <20220902154829.30399-2-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395612107.401.8030282404908961714.tip-bot2@tip-bot2>
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

Commit-ID:     4d269ed485298e8a09485a664e7b35b370ab4ada
Gitweb:        https://git.kernel.org/tip/4d269ed485298e8a09485a664e7b35b370ab4ada
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:09 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 14:34:33 +02:00

x86/resctrl: Kill off alloc_enabled

rdt_resources_all[] used to have extra entries for L2CODE/L2DATA.
These were hidden from resctrl by the alloc_enabled value.

Now that the L2/L2CODE/L2DATA resources have been merged together,
alloc_enabled doesn't mean anything, it always has the same value as
alloc_capable which indicates allocation is supported by this resource.

Remove alloc_enabled and its helpers.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-2-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 4 ----
 arch/x86/kernel/cpu/resctrl/internal.h    | 4 ----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 6 +++---
 include/linux/resctrl.h                   | 2 --
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb1c3f5..2f87177 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -147,7 +147,6 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	rdt_alloc_capable = true;
 }
@@ -211,7 +210,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	thread_throttle_mode_init();
 
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	return true;
 }
@@ -242,7 +240,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->data_width = 4;
 
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	return true;
 }
@@ -261,7 +258,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.shareable_bits = ebx & r->default_ctrl;
 	r->data_width = (r->cache.cbm_len + 3) / 4;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 }
 
 static void rdt_get_cdp_config(int level)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1d64718..53f3d27 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,10 +459,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
-#define for_each_alloc_enabled_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_enabled)
-
 #define for_each_mon_enabled_rdt_resource(r)				      \
 	for_each_rdt_resource(r)					      \
 		if (r->mon_enabled)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 4d83989..d961ae3 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -837,7 +837,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * First determine which cpus have pseudo-locked regions
 	 * associated with them.
 	 */
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		list_for_each_entry(d_i, &r->domains, list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f276aff..526eb93 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1756,7 +1756,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	/* loop over enabled controls, these are all alloc_enabled */
+	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
@@ -2106,7 +2106,7 @@ static int schemata_list_create(void)
 	struct rdt_resource *r;
 	int ret = 0;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		if (resctrl_arch_get_cdp_enabled(r->rid)) {
 			ret = schemata_list_add(r, CDP_CODE);
 			if (ret)
@@ -2452,7 +2452,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	set_mba_sc(false);
 
 	/*Put everything back to default values. */
-	for_each_alloc_enabled_rdt_resource(r)
+	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 21deb52..386ab3a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -130,7 +130,6 @@ struct resctrl_schema;
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
- * @alloc_enabled:	Is allocation enabled on this machine
  * @mon_enabled:	Is monitoring enabled for this feature
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
@@ -150,7 +149,6 @@ struct resctrl_schema;
  */
 struct rdt_resource {
 	int			rid;
-	bool			alloc_enabled;
 	bool			mon_enabled;
 	bool			alloc_capable;
 	bool			mon_capable;
