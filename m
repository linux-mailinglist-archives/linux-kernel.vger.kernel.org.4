Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FD679420
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjAXJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjAXJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A52D3A8A;
        Tue, 24 Jan 2023 01:26:38 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEzDdPgX5o2hfRb8dKWzzQH+7eun/vYgm0JP+74nGfg=;
        b=DH1U3Ank5dPLHScF2csgjFrm0HRtRqp1d8uxEB9EgYiRehI1FdKg8PhZ+BTg64NL38eC8R
        KxRrFBR0c8TlYxZ6rhjwCISpqctwj+DNEvCV7nvEBqhbWHTTDYZleFRCtqoZEurrpSX7fM
        /Z1GlyDWWDvLAhPeh0MiJAFoL4cfMObN+CSCN7jcPhW708naFJ0UyfIkG9zXcyF3KiehSR
        s3ZIk8QfuA0WdPi9rrYdlw1Trjoyc+UZz5rnCTGMmh+mT6/iaib3+hB3GoFIS0m1PqvMHz
        ZKWRp90Gm0YQAsHjWZyOa/FBbG0hEm6tqkn7UEzbN3cL2FdjEMwPceXwnerfrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEzDdPgX5o2hfRb8dKWzzQH+7eun/vYgm0JP+74nGfg=;
        b=H39WDH/p81mXw2qfFOgYCJFQZwopsU13gsWzzgmbig5zKnK+8qRaTKyAYUDK9pM08Tje0M
        wuS84NhofcGm5mCg==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add interface to read mbm_total_bytes_config
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-10-babu.moger@amd.com>
References: <20230113152039.770054-10-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239658.4906.13763940041630366550.tip-bot2@tip-bot2>
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

Commit-ID:     dc2a3e857981f859889933cf66ded117d74edff1
Gitweb:        https://git.kernel.org/tip/dc2a3e857981f859889933cf66ded117d74edff1
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:35 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:24 +01:00

x86/resctrl: Add interface to read mbm_total_bytes_config

The event configuration can be viewed by the user by reading the
configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.  The
event configuration settings are domain specific and will affect all the CPUs in
the domain.

Following are the types of events supported:

  ====  ===========================================================
  Bits   Description
  ====  ===========================================================
  6      Dirty Victims from the QOS domain to all types of memory
  5      Reads to slow memory in the non-local NUMA domain
  4      Reads to slow memory in the local NUMA domain
  3      Non-temporal writes to non-local NUMA domain
  2      Non-temporal writes to local NUMA domain
  1      Reads to memory in the non-local NUMA domain
  0      Reads to memory in the local NUMA domain
  ====  ===========================================================

By default, the mbm_total_bytes_config is set to 0x7f to count all the
event types.

For example:

  $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
  0=0x7f;1=0x7f;2=0x7f;3=0x7f

In this case, the event mbm_total_bytes is configured with 0x7f on
domains 0 to 3.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-10-babu.moger@amd.com
---
 arch/x86/include/asm/msr-index.h       |   1 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  24 ++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c  |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 102 ++++++++++++++++++++++++-
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e0a4002..2e5f57c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1062,6 +1062,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0605b04..8edecc5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -30,6 +30,29 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
+/* Reads to Local DRAM Memory */
+#define READS_TO_LOCAL_MEM		BIT(0)
+
+/* Reads to Remote DRAM Memory */
+#define READS_TO_REMOTE_MEM		BIT(1)
+
+/* Non-Temporal Writes to Local Memory */
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
+
+/* Non-Temporal Writes to Remote Memory */
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
+
+/* Reads to Local Memory the system identifies as "Slow Memory" */
+#define READS_TO_LOCAL_S_MEM		BIT(4)
+
+/* Reads to Remote Memory the system identifies as "Slow Memory" */
+#define READS_TO_REMOTE_S_MEM		BIT(5)
+
+/* Dirty Victims to All Types of Memory */
+#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
+
+/* Max event bits supported */
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
@@ -531,5 +554,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
+void __init mbm_config_rftype_init(const char *config);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index cf7b6e5..0ff45e3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -801,8 +801,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		return ret;
 
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
+			mbm_config_rftype_init("mbm_total_bytes_config");
+		}
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
 			mbm_local_event.configurable = true;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bf0bd43..cd4e668 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1420,6 +1420,93 @@ out:
 	return ret;
 }
 
+struct mon_config_info {
+	u32 evtid;
+	u32 mon_config;
+};
+
+#define INVALID_CONFIG_INDEX   UINT_MAX
+
+/**
+ * mon_event_config_index_get - get the hardware index for the
+ *                              configurable event
+ * @evtid: event id.
+ *
+ * Return: 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+ *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+ *         INVALID_CONFIG_INDEX for invalid evtid
+ */
+static inline unsigned int mon_event_config_index_get(u32 evtid)
+{
+	switch (evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return 0;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return 1;
+	default:
+		/* Should never reach here */
+		return INVALID_CONFIG_INDEX;
+	}
+}
+
+static void mon_event_config_read(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	unsigned int index;
+	u32 h;
+
+	index = mon_event_config_index_get(mon_info->evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		return;
+	}
+	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
+
+	/* Report only the valid event configuration bits */
+	mon_info->mon_config &= MAX_EVT_CONFIG_BITS;
+}
+
+static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+{
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
+}
+
+static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
+{
+	struct mon_config_info mon_info = {0};
+	struct rdt_domain *dom;
+	bool sep = false;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->domains, list) {
+		if (sep)
+			seq_puts(s, ";");
+
+		memset(&mon_info, 0, sizeof(struct mon_config_info));
+		mon_info.evtid = evtid;
+		mondata_config_read(dom, &mon_info);
+
+		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
+		sep = true;
+	}
+	seq_puts(s, "\n");
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
+static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1519,6 +1606,12 @@ static struct rftype res_common_files[] = {
 		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
+		.name		= "mbm_total_bytes_config",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= mbm_total_bytes_config_show,
+	},
+	{
 		.name		= "cpus",
 		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
@@ -1624,6 +1717,15 @@ void __init thread_throttle_mode_init(void)
 	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
 }
 
+void __init mbm_config_rftype_init(const char *config)
+{
+	struct rftype *rft;
+
+	rft = rdtgroup_get_rftype_by_name(config);
+	if (rft)
+		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
+}
+
 /**
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
  * @r: The resource group with which the file is associated.
