Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CC5E8174
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiIWSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiIWSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014AA13EEB7;
        Fri, 23 Sep 2022 11:02:02 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lH/wU8qKai82u9onQ/8vIrAKuz/6rH0e9hId46dJGZY=;
        b=c5EP/xDVIs1GUne7Za/h113RTj45h69yLPJRe9oGqpmetLi8j27hb2PGclVYsJq7Qne74m
        VRxjKQlJxzlw67MkDAUMwbPpWrDMraD6ILA6IxmwlxiAHzlk/7ceZvrfdr6kDMGkgHbElM
        FanGDKtuXX/iCneE0G8T5XIMGvcdWgmhetLqAfmcXv85/GRh7W57wDjOSncd0WHEtE0yXt
        9FymVMWWXnlqDJ7yMjgiwdpZURhPgJ5T9ApZgqmK9/Ff+4/IOjvTaSUlQiS8/LAp0egXS/
        hv23OyMBiRfx0DNDQo+aSuoJxE4vSLlVVFpbY2W7LqAyxv5Q9hX7d2XEZa8cMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lH/wU8qKai82u9onQ/8vIrAKuz/6rH0e9hId46dJGZY=;
        b=zBJJ0sNy2WF6UL3FTBEKqrWz9s/r92l+HNmXklVh8rnIYjJqsx0bYMXT/5qeXqc0mjhOIT
        CIgNmOe66M0pVQBA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Merge mon_capable and mon_enabled
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-3-james.morse@arm.com>
References: <20220902154829.30399-3-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611999.401.11964148666220209989.tip-bot2@tip-bot2>
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

Commit-ID:     bab6ee736873becc0216ba5fd159394e272d01b2
Gitweb:        https://git.kernel.org/tip/bab6ee736873becc0216ba5fd159394e272d01b2
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:10 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 14:43:08 +02:00

x86/resctrl: Merge mon_capable and mon_enabled

mon_enabled and mon_capable are always set as a pair by
rdt_get_mon_l3_config().

There is no point having two values.

Merge them together.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-3-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ----
 arch/x86/kernel/cpu/resctrl/monitor.c  | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 2 --
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 53f3d27..8828b5c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,10 +459,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
-#define for_each_mon_enabled_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->mon_enabled)
-
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index eaf25a2..497cadf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -717,7 +717,6 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
-	r->mon_enabled = true;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 526eb93..def7c66 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1765,7 +1765,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 			goto out_destroy;
 	}
 
-	for_each_mon_enabled_rdt_resource(r) {
+	for_each_mon_capable_rdt_resource(r) {
 		fflags =  r->fflags | RF_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
@@ -2504,7 +2504,7 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
 	struct rdtgroup *prgrp, *crgrp;
 	char name[32];
 
-	if (!r->mon_enabled)
+	if (!r->mon_capable)
 		return;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -2572,7 +2572,7 @@ void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
-	if (!r->mon_enabled)
+	if (!r->mon_capable)
 		return;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -2642,7 +2642,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	 * Create the subdirectories for each domain. Note that all events
 	 * in a domain like L3 are grouped into a resource whose domain is L3
 	 */
-	for_each_mon_enabled_rdt_resource(r) {
+	for_each_mon_capable_rdt_resource(r) {
 		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
 		if (ret)
 			goto out_destroy;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 386ab3a..8180c53 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -130,7 +130,6 @@ struct resctrl_schema;
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
- * @mon_enabled:	Is monitoring enabled for this feature
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
@@ -149,7 +148,6 @@ struct resctrl_schema;
  */
 struct rdt_resource {
 	int			rid;
-	bool			mon_enabled;
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
