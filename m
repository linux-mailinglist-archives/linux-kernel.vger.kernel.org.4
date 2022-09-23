Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE305E816A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiIWSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIWSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6213B000;
        Fri, 23 Sep 2022 11:01:56 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PozVHeRlEbyftI9eGGQqdQOK98BnHcZj/+uHPGlx0qY=;
        b=zKRlMF8hG0wRHt7MBVxMB1vtcU6p/f5m2ONtv+VmAQCgbTLUcQ977pn5MTIbuoEihHPWdk
        rAuaM65OQzYW2ZPr+goKTBI5nfMSeMxMcGezVsJBH1Av3QKBbiwIe14ctESjSly4XPUUxr
        CNdKrZbM0efmVIxFyNzkGM4AV6bKHtqTMUMgXXDm92e7w8ZtP9BwiCdDAt7RJtlT74K4Er
        BRMLH7uzN1NCCHz8/h8VyK+6iTmL/bX7/kOc71i7+u8exP1og9+VSMfsecNh2LXoKEL/aP
        3OuMbohXb2BpPsNo2LkZgvBxzSMX1qjcHQpKTwjGazDI3XXad4hJvJXSIRo5Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PozVHeRlEbyftI9eGGQqdQOK98BnHcZj/+uHPGlx0qY=;
        b=gXcGml5rUJlZHhxWj4dtmgynrH/GId5vzAT7HZW9utjnsm94wAZk+oqSsKnSKxcj0tO+5Z
        8mK2RqADtDrSK7Aw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Create mba_sc configuration in the rdt_domain
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-9-james.morse@arm.com>
References: <20220902154829.30399-9-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611376.401.15584699122360639669.tip-bot2@tip-bot2>
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

Commit-ID:     781096d971dfe3c5f9401a300bdb0b148a600584
Gitweb:        https://git.kernel.org/tip/781096d971dfe3c5f9401a300bdb0b148a600584
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:16 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:17:59 +02:00

x86/resctrl: Create mba_sc configuration in the rdt_domain

To support resctrl's MBA software controller, the architecture must provide
a second configuration array to hold the mbps_val[] from user-space.

This complicates the interface between the architecture specific code and
the filesystem portions of resctrl that will move to /fs/, to allow
multiple architectures to support resctrl.

Make the filesystem parts of resctrl create an array for the mba_sc
values. The software controller can be changed to use this, allowing
the architecture code to only consider the values configured in hardware.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-9-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 +++++++++++++++++++++++++-
 include/linux/resctrl.h                |  7 ++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e12b55f..a7e2cbc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -36,7 +36,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4ee2626..f7ebd01 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1889,6 +1889,30 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
+{
+	u32 num_closid = resctrl_arch_get_num_closid(r);
+	int cpu = cpumask_any(&d->cpu_mask);
+	int i;
+
+	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!d->mbps_val)
+		return -ENOMEM;
+
+	for (i = 0; i < num_closid; i++)
+		d->mbps_val[i] = MBA_MAX_MBPS;
+
+	return 0;
+}
+
+static void mba_sc_domain_destroy(struct rdt_resource *r,
+				  struct rdt_domain *d)
+{
+	kfree(d->mbps_val);
+	d->mbps_val = NULL;
+}
+
 /*
  * MBA software controller is supported only if
  * MBM is supported and MBA is in linear scale.
@@ -1908,12 +1932,20 @@ static bool supports_mba_mbps(void)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	u32 num_closid = resctrl_arch_get_num_closid(r);
+	struct rdt_domain *d;
+	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
 
+	list_for_each_entry(d, &r->domains, list) {
+		for (i = 0; i < num_closid; i++)
+			d->mbps_val[i] = MBA_MAX_MBPS;
+	}
+
 	return 0;
 }
 
@@ -3247,6 +3279,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
+		mba_sc_domain_destroy(r, d);
+
 	if (!r->mon_capable)
 		return;
 
@@ -3311,6 +3346,10 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
+		/* RDT_RESOURCE_MBA is never mon_capable */
+		return mba_sc_domain_allocate(r, d);
+
 	if (!r->mon_capable)
 		return 0;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5d283bd..93dfe55 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+/* max value for struct rdt_domain's mbps_val */
+#define MBA_MAX_MBPS   U32_MAX
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
@@ -53,6 +56,9 @@ struct resctrl_staged_config {
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		When mba_sc is enabled, this holds the array of user
+ *			specified control values for mba_sc in MBps, indexed
+ *			by closid
  */
 struct rdt_domain {
 	struct list_head		list;
@@ -67,6 +73,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
 };
 
 /**
