Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8C736236
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFTDha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFTDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:37:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAA10CB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687232232; x=1718768232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKH1pqAWneRkf6TbhNWYl8q3mAZnVaK9Hx9fQnJwfoc=;
  b=OVIt8tNnKtXeGHfBqudET45ivF5GqMXvwHo6ZI0naHalqq3qMa13OYgn
   mEoSWJCojzfTdas6rbw6YeVRNcLHbqkTzLyWMuDWxVltQzjAn9EpnQtj7
   LargTyujnUiFDI9dQjF5EoE5iNeow31/T3vFcenkvZTo4WrmrdI4ICfN6
   V+ORZM7AcQwp8H+WsAu2AnAYt9QBDZqNESdm/0SJAG5x9rydQ2W/vJZ59
   10Y71iUcGvbdbH799mB1Du2ILq4iSEqb7jVBT3YIit9YerwTo0BXE5qUP
   K09f9lA52cwMoIn8XbNc/gk4B2h+pvoSo/Xdn69L4zrBvQ5leTzQixsLJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="344501412"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="344501412"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="717079121"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="717079121"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 2/2] resctrl2: Arch x86 modules for most of the legacy control/monitor functions
Date:   Mon, 19 Jun 2023 20:37:02 -0700
Message-Id: <20230620033702.33344-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620033702.33344-1-tony.luck@intel.com>
References: <20230620033702.33344-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing:
1) "mba_MBps" feedback from MBM
2) Pseudo-locking
3) AMD SMBA/BMEC
4) Fixes and additions after v6.4-rc6
5) Other stuff I haven't noticed

N.B. This is proof-of-concept code ... the locking (or lack thereof)
for most of the files controlled by modules needs to be addressed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/resctrl.h             |  38 ++
 fs/resctrl2/arch/x86/rdt.h                 |  22 +
 arch/x86/kernel/cpu/amd.c                  |   3 +
 arch/x86/kernel/cpu/intel.c                |   3 +
 arch/x86/kernel/process_32.c               |   1 +
 arch/x86/kernel/process_64.c               |   3 +
 fs/resctrl2/arch/x86/alloc.c               | 119 +++++
 fs/resctrl2/arch/x86/rdt_l2_cat.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l2_cdp.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l3_cat.c          | 349 +++++++++++++++
 fs/resctrl2/arch/x86/rdt_l3_cdp.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l3_mba.c          | 251 +++++++++++
 fs/resctrl2/arch/x86/rdt_llc_occupancy.c   | 100 +++++
 fs/resctrl2/arch/x86/rdt_mbm_adjust.c      |  91 ++++
 fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_local_rate.c  |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_total_rate.c  |   1 +
 fs/resctrl2/arch/x86/rdt_monitor.c         | 491 +++++++++++++++++++++
 arch/x86/Kconfig                           |  81 +++-
 fs/resctrl2/arch/x86/Makefile              |  29 ++
 21 files changed, 1586 insertions(+), 2 deletions(-)
 create mode 100644 fs/resctrl2/arch/x86/rdt.h
 create mode 100644 fs/resctrl2/arch/x86/alloc.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l2_cat.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l2_cdp.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_l3_cat.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l3_cdp.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_l3_mba.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_llc_occupancy.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_mbm_adjust.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_local_rate.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_total_rate.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_monitor.c
 create mode 100644 fs/resctrl2/arch/x86/Makefile

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 255a78d9d906..efbad3175680 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -96,6 +96,44 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
+#elif defined(CONFIG_X86_CPU_RESCTRL2)
+
+bool arch_alloc_resctrl_ids(struct resctrl_group *rg);
+void arch_free_resctrl_ids(struct resctrl_group *rg);
+bool arch_init_alloc_ids(struct resctrl_resource *r);
+int rmid_alloc(int prmid);
+void rmid_free(int rmid);
+void arch_add_monitor(int mon_event);
+void arch_del_monitor(int mon_event);
+u64 rdt_rmid_read(int domain_id, int rmid, int event);
+void rdt_mbm_apply_quirk(int num_rmids);
+u64 get_corrected_mbm_count(u32 rmid, unsigned long val);
+
+static inline bool is_closid_match(struct task_struct *t, struct resctrl_group *rg)
+{
+	return (t->resctrl_ids >> 32) == (rg->resctrl_ids >> 32);
+}
+
+static inline bool arch_is_resctrl_id_match(struct task_struct *t, struct resctrl_group *rg)
+{
+	if (rg->type == DIR_MON)
+		return t->resctrl_ids == rg->resctrl_ids;
+	return is_closid_match(t, rg);
+}
+
+static inline bool arch_set_task_ids(struct task_struct *t, struct resctrl_group *rg)
+{
+	if (rg->type == DIR_MON) {
+		if (!is_closid_match(t, rg)) {
+			//rdt_last_cmd_puts("Can't move task to different control group\n");
+			return false;
+		}
+	}
+
+	WRITE_ONCE(t->resctrl_ids, rg->resctrl_ids);
+
+	return true;
+}
 #else
 
 static inline void resctrl_sched_in(struct task_struct *tsk) {}
diff --git a/fs/resctrl2/arch/x86/rdt.h b/fs/resctrl2/arch/x86/rdt.h
new file mode 100644
index 000000000000..98c8147bac8e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2023 Intel Corporation. */
+
+/* H/W supported RDT monitor events */
+#define EV_LLC		1
+#define EV_TOT		2
+#define EV_LOC		3
+#define EV_MAX		4
+
+/* S/W events */
+#define EV_TOTRATE	4
+#define EV_LOCRATE	5
+
+#define RESCTRL_FILE_DEF(X, fmt)			\
+static int X##_show(struct seq_file *sf, void *v)	\
+{							\
+	seq_printf(sf, fmt, X);				\
+	return 0;					\
+}							\
+static struct kernfs_ops X##_ops = {			\
+	.seq_show	= X##_show			\
+};
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 571abf808ea3..fbd95edcd75b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,6 +9,7 @@
 #include <linux/sched/clock.h>
 #include <linux/random.h>
 #include <linux/topology.h>
+#include <linux/resctrl.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
@@ -19,7 +20,9 @@
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
 #include <asm/debugreg.h>
+#ifndef CONFIG_RESCTRL2_FS
 #include <asm/resctrl.h>
+#endif
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1c4639588ff9..66829e06b01f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/cpuhotplug.h>
+#include <linux/resctrl.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -26,7 +27,9 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
 #include <asm/traps.h>
+#ifndef CONFIG_RESCTRL2_FS
 #include <asm/resctrl.h>
+#endif
 #include <asm/numa.h>
 #include <asm/thermal.h>
 
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 708c87b88cc1..8cf70973a331 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/kdebug.h>
 #include <linux/syscalls.h>
+#include <linux/resctrl.h>
 
 #include <asm/ldt.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d181c16a2f6..7df3cf1dbcaa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -40,6 +40,7 @@
 #include <linux/ftrace.h>
 #include <linux/syscalls.h>
 #include <linux/iommu.h>
+#include <linux/resctrl.h>
 
 #include <asm/processor.h>
 #include <asm/pkru.h>
@@ -53,7 +54,9 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
+#ifndef CONFIG_RESCTRL2_FS
 #include <asm/resctrl.h>
+#endif
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
diff --git a/fs/resctrl2/arch/x86/alloc.c b/fs/resctrl2/arch/x86/alloc.c
new file mode 100644
index 000000000000..d39f93150180
--- /dev/null
+++ b/fs/resctrl2/arch/x86/alloc.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <asm/cpufeatures.h>
+
+#include "../../internal.h"
+
+DEFINE_STATIC_KEY_FALSE(resctrl_enable_key);
+DEFINE_PER_CPU(struct resctrl_per_cpu_state, resctrl_per_cpu_state);
+
+/*
+ * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
+ * we can keep a bitmap of free CLOSIDs in a single integer.
+ *
+ * Using a global CLOSID across all resources has some advantages and
+ * some drawbacks:
+ * + We can simply use a field in the task structure to assign a task to a resource
+ *   group.
+ * + Context switch code can avoid extra memory references deciding which
+ *   CLOSID to load into the PQR_ASSOC MSR
+ * - We give up some options in configuring resource groups across multi-socket
+ *   systems.
+ * - Our choices on how to configure each resource become progressively more
+ *   limited as the number of resources grows.
+ */
+static int arch_ids;
+static int closid_free_map;
+u64 arch_resctrl_default_ids;
+
+void arch_resctrl_apply_ids(u64 resctrl_ids)
+{
+	wrmsrl(MSR_IA32_PQR_ASSOC, resctrl_ids);
+}
+
+static void closid_init(void)
+{
+	closid_free_map = BIT_MASK(arch_ids) - 1;
+
+	/* CLOSID 0 is always reserved for the default group */
+	closid_free_map &= ~1;
+}
+
+static int closid_alloc(void)
+{
+	u32 closid = ffs(closid_free_map);
+
+	if (closid == 0)
+		return -ENOSPC;
+	closid--;
+	closid_free_map &= ~(1 << closid);
+
+	return closid;
+}
+
+void closid_free(int closid)
+{
+	closid_free_map |= 1 << closid;
+}
+
+#define RESCTRL_ID(c, r) (((u64)(c) << 32) | (r))
+
+bool arch_check_resctrl_support(void)
+{
+	return boot_cpu_has(X86_FEATURE_CQM) || boot_cpu_has(X86_FEATURE_RDT_A);
+}
+
+bool arch_init_alloc_ids(struct resctrl_resource *r)
+{
+	if (r->num_alloc_ids < arch_ids)
+		return false;
+	if (arch_ids != 0) {
+		if (r->num_alloc_ids > arch_ids)
+			r->num_alloc_ids = arch_ids;
+		return true;
+	}
+	arch_ids = r->num_alloc_ids;
+
+	closid_init();
+
+	return true;
+}
+
+bool arch_alloc_resctrl_ids(struct resctrl_group *rg)
+{
+	int c, r;
+
+	switch (rg->type) {
+	case DIR_CTRL_MON:
+		c = closid_alloc();
+		if (c < 0)
+			return false;
+		r = rmid_alloc(-1);
+		if (r < 0) {
+			closid_free(c);
+			return false;
+		}
+		rg->resctrl_ids = RESCTRL_ID(c, r);
+		return true;
+
+	case DIR_MON:
+		/* monitor groups have same CLOSID as parent */
+		c = rg->parent->resctrl_ids >> 32;
+		r = rmid_alloc(rg->parent->resctrl_ids & 0xffff);
+		if (r < 0)
+			return false;
+		rg->resctrl_ids = RESCTRL_ID(c, r);
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+void arch_free_resctrl_ids(struct resctrl_group *rg)
+{
+	closid_free(rg->resctrl_ids >> 32);
+
+	rmid_free(rg->resctrl_ids & 0xffff);
+}
diff --git a/fs/resctrl2/arch/x86/rdt_l2_cat.c b/fs/resctrl2/arch/x86/rdt_l2_cat.c
new file mode 120000
index 000000000000..d25679af550e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_l2_cat.c
@@ -0,0 +1 @@
+rdt_l3_cat.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_l2_cdp.c b/fs/resctrl2/arch/x86/rdt_l2_cdp.c
new file mode 120000
index 000000000000..d25679af550e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_l2_cdp.c
@@ -0,0 +1 @@
+rdt_l3_cat.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_l3_cat.c b/fs/resctrl2/arch/x86/rdt_l3_cat.c
new file mode 100644
index 000000000000..1cb9a99e93b4
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_l3_cat.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+/*
+ *  X86 Resource Control Driver For L2 and L3 cache allocation
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/resctrl.h>
+#include <linux/seq_file.h>
+
+#include "rdt.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#ifdef CDP
+#define SUFFIX_D	"DATA"
+#define SUFFIX_C	"CODE"
+#define MULDIV		2
+#else
+#define SUFFIX_D	""
+#define SUFFIX_C	""
+#define MULDIV		1
+#endif
+
+#if CACHE_LEVEL == 3
+#define NAME		"L3"
+#define MSR		MSR_IA32_L3_CBM_BASE
+#define MSRCDP		MSR_IA32_L3_QOS_CFG
+#define LEAF_BIT	1
+#define SCOPE		RESCTRL_L3CACHE
+#elif CACHE_LEVEL == 2
+#define NAME		"L2"
+#define MSR		MSR_IA32_L2_CBM_BASE
+#define MSRCDP		MSR_IA32_L2_QOS_CFG
+#define LEAF_BIT	2
+#define SCOPE		RESCTRL_L2CACHE
+#else
+#error "CACHE_LEVEL not defined"
+#endif
+
+struct cbm_masks {
+	u64	now;
+	u64	staged;
+	bool	need_update;
+};
+
+struct mydomain {
+	int			cbm_len;
+	struct cbm_masks	cbm_masks[];
+};
+#define get_mydomain(d) ((struct mydomain *)&d[1])
+
+static struct resctrl_resource cat;
+
+static u32 cbm_mask;
+static int min_cbm_bits = 1;
+static int num_closids;
+static u32 shareable_bits;
+static bool arch_has_sparse_bitmaps;
+
+static void show(struct resctrl_resource *r, struct seq_file *m, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct cbm_masks *cbm;
+	char *sep = "";
+
+	list_for_each_entry(d, &r->domains, list) {
+		cbm = get_mydomain(d)->cbm_masks;
+		seq_printf(m, "%s%d=%llx", sep, d->id, cbm[closid].now);
+		sep = ";";
+	}
+	seq_puts(m, "\n");
+}
+
+static void resetstaging(struct resctrl_resource *r, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct cbm_masks *cbm;
+
+	list_for_each_entry(d, &r->domains, list) {
+		cbm = get_mydomain(d)->cbm_masks;
+		cbm[closid].need_update = false;
+	}
+}
+
+static bool validate_mask(struct resctrl_domain *d, char *buf, struct cbm_masks *c)
+{
+	unsigned long first_bit, last_bit, val;
+	struct mydomain *m = get_mydomain(d);
+	int ret;
+
+	ret = kstrtoul(buf, 16, &val);
+	if (ret) {
+		// rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
+		return false;
+	}
+
+	/* User didn't change this value */
+	if (val == c->now)
+		return true;
+
+	if ((min_cbm_bits > 0 && val == 0) || val > (1u << (m->cbm_len + 1)) - 1) {
+		// rdt_last_cmd_puts("Mask out of range\n");
+		return false;
+	}
+	if (val == 0)
+		goto ok;
+	first_bit = __ffs(val);
+	last_bit = __fls(val);
+	if ((last_bit - first_bit) + 1 < min_cbm_bits) {
+		// rdt_last_cmd_printf("Need at least %d bits in the mask\n", min_cbm_bits);
+		return false;
+	}
+	if (!arch_has_sparse_bitmaps && val != (((1u << (last_bit + 1)) - 1) & ~((1u << first_bit) - 1))) {
+		// rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
+		return false;
+	}
+
+ok:
+	c->need_update = true;
+	c->staged = val;
+
+	return true;
+}
+
+static int parse(struct resctrl_resource *r, char *line, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct cbm_masks *cbm;
+	char *dom = NULL, *id;
+	struct resctrl_domain *d;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] == '\0')
+		return 0;
+	dom = strsep(&line, ";");
+	id = strsep(&dom, "=");
+	id = strim(id);
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		// rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
+		return -EINVAL;
+	}
+	dom = strim(dom);
+	list_for_each_entry(d, &r->domains, list) {
+		if (d->id != dom_id)
+			continue;
+		cbm = get_mydomain(d)->cbm_masks;
+		if (!validate_mask(d, dom, cbm + closid))
+			return -EINVAL;
+		goto next;
+	}
+	return -EINVAL;
+}
+
+struct rdt_msr_info {
+	int	msr_base;
+	struct cbm_masks *cbm;
+};
+
+static void update_msrs(void *info)
+{
+	struct rdt_msr_info *mi = info;
+
+	for (int i = 0; i < cat.num_alloc_ids; i++) {
+		if (mi->cbm[i].need_update) {
+			mi->cbm[i].now = mi->cbm[i].staged;
+			mi->cbm[i].need_update = false;
+			wrmsrl(mi->msr_base + i * MULDIV, mi->cbm[i].now);
+		}
+	}
+}
+
+static void applychanges(struct resctrl_resource *r, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct cbm_masks *cbm;
+	struct rdt_msr_info mi;
+
+	list_for_each_entry(d, &r->domains, list) {
+		cbm = get_mydomain(d)->cbm_masks;
+		if (!cbm[closid].need_update)
+			continue;
+		mi.msr_base = r->archtag;
+		mi.cbm = cbm;
+		smp_call_function_single(cpumask_first(&d->cpu_mask), update_msrs, &mi, 1);
+	}
+}
+
+	u64 val;
+
+#ifdef CDP
+static void update_cdp(void *info)
+{
+	u64 val;
+
+	rdmsrl(MSRCDP, val);
+	if (info)
+		val |= BIT(0);
+	else
+		val &= ~BIT(0);
+	wrmsrl(MSRCDP, val);
+}
+#endif
+
+/*
+ * On domain discovery (duing module load, or CPU hotplug) set
+ * all controls to allow full access to all of cache. Ditto on
+ * module unload or domain removal.
+ */
+static void domain_update(struct resctrl_resource *r, int what, int cpu, struct resctrl_domain *d)
+{
+	struct mydomain *m = get_mydomain(d);
+	unsigned int eax, ebx, ecx, edx;
+	struct rdt_msr_info mi;
+	struct cbm_masks *cbm;
+
+	cbm = (struct cbm_masks *)(m + 1);
+	if (what == RESCTRL_DOMAIN_ADD || what == RESCTRL_DOMAIN_DELETE) {
+		cpuid_count(0x10, LEAF_BIT, &eax, &ebx, &ecx, &edx);
+		shareable_bits = ebx;
+		m->cbm_len = eax & 0x1f;
+		cbm_mask = (1u << (m->cbm_len + 1)) - 1;
+		for (int i = 0; i < cat.num_alloc_ids; i++) {
+			cbm[i].staged = cbm_mask;
+			cbm[i].need_update = true;
+		}
+		mi.msr_base = r->archtag;
+		mi.cbm = cbm;
+		smp_call_function_single(cpu, update_msrs, &mi, 1);
+	}
+#ifdef CDP
+	if (what == RESCTRL_DOMAIN_ADD)
+		smp_call_function_single(cpu, update_cdp, (void *)1, 1);
+	else if (what == RESCTRL_DOMAIN_DELETE)
+		smp_call_function_single(cpu, update_cdp, NULL, 1);
+#endif
+}
+
+RESCTRL_FILE_DEF(cbm_mask, "%x\n")
+RESCTRL_FILE_DEF(min_cbm_bits, "%d\n")
+RESCTRL_FILE_DEF(num_closids, "%d\n")
+RESCTRL_FILE_DEF(shareable_bits, "%x\n")
+
+static struct resctrl_fileinfo cat_files[] = {
+	{ .name = "cbm_mask", .ops = &cbm_mask_ops },
+	{ .name = "min_cbm_bits", .ops = &min_cbm_bits_ops },
+	{ .name = "num_closids", .ops = &num_closids_ops },
+	{ .name = "shareable_bits", .ops = &shareable_bits_ops },
+	{ }
+};
+
+static struct resctrl_resource cat = {
+	.name		= NAME SUFFIX_D,
+	.archtag	= MSR,
+	.type		= RESCTRL_CONTROL,
+	.show		= show,
+	.resetstaging	= resetstaging,
+	.parse		= parse,
+	.applychanges	= applychanges,
+	.scope		= SCOPE,
+	.domain_size	= sizeof(struct resctrl_domain) + sizeof(struct mydomain),
+	.domains	= LIST_HEAD_INIT(cat.domains),
+	.domain_update	= domain_update,
+	.infodir	= "L3",
+	.infofiles	= cat_files,
+};
+
+#ifdef CDP
+static struct resctrl_resource cat_code = {
+	.name		= NAME SUFFIX_C,
+	.archtag	= MSR + 1,
+	.type		= RESCTRL_CONTROL,
+	.show		= show,
+	.resetstaging	= resetstaging,
+	.parse		= parse,
+	.applychanges	= applychanges,
+	.scope		= SCOPE,
+	.domain_size	= sizeof(struct resctrl_domain) + sizeof(struct mydomain),
+	.domains	= LIST_HEAD_INIT(cat_code.domains),
+	.domain_update	= domain_update,
+};
+#endif
+
+static int __init cat_init(void)
+{
+	unsigned int eax, ebx, ecx, edx, cat_features;
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_RDT_A)) {
+		pr_debug("No RDT allocation support\n");
+		return -ENODEV;
+	}
+
+	cat_features = cpuid_ebx(0x10);
+
+	if (!(cat_features & BIT(LEAF_BIT))) {
+		pr_debug("No RDT allocation for L%d cache\n", CACHE_LEVEL);
+		return -ENODEV;
+	}
+
+	cpuid_count(0x10, LEAF_BIT, &eax, &ebx, &ecx, &edx);
+#ifdef CDP
+	if (!(ecx & BIT(2))) {
+		pr_debug("No CDP mode for L%d cache\n", CACHE_LEVEL);
+		return -ENODEV;
+	}
+#endif
+	num_closids = (edx + 1) / MULDIV;
+
+	cat.domain_size += num_closids * sizeof(struct cbm_masks);
+	cat.num_alloc_ids = num_closids;
+#ifdef CDP
+	cat_code.domain_size += num_closids * sizeof(struct cbm_masks);
+	cat_code.num_alloc_ids = num_closids;
+#endif
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		min_cbm_bits = 0;
+		arch_has_sparse_bitmaps = true;
+	}
+
+	ret = resctrl_register_ctrl_resource(&cat);
+#ifdef CDP
+	if (!ret)
+		ret = resctrl_register_ctrl_resource(&cat_code);
+	if (ret)
+		resctrl_unregister_ctrl_resource(&cat);
+#endif
+	return ret;
+}
+
+static void __exit cat_cleanup(void)
+{
+	resctrl_unregister_ctrl_resource(&cat);
+#ifdef CDP
+	resctrl_unregister_ctrl_resource(&cat_code);
+#endif
+}
+
+module_init(cat_init);
+module_exit(cat_cleanup);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/resctrl2/arch/x86/rdt_l3_cdp.c b/fs/resctrl2/arch/x86/rdt_l3_cdp.c
new file mode 120000
index 000000000000..d25679af550e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_l3_cdp.c
@@ -0,0 +1 @@
+rdt_l3_cat.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_l3_mba.c b/fs/resctrl2/arch/x86/rdt_l3_mba.c
new file mode 100644
index 000000000000..f937fb02697e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_l3_mba.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+/*
+ *  X86 Resource Control Driver For L2 and L3 cache allocation
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/resctrl.h>
+#include <linux/seq_file.h>
+
+#include "rdt.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+struct throttle_values {
+	u64	now;
+	u64	staged;
+	bool	need_update;
+};
+
+struct mydomain {
+	int			max_throttle;
+	struct throttle_values	throttle_values[];
+};
+#define get_mydomain(d) ((struct mydomain *)(&d[1]))
+
+static struct resctrl_resource mba;
+
+static int bandwidth_gran, delay_linear, min_bandwidth, num_closids;
+
+static void show(struct resctrl_resource *r, struct seq_file *m, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct throttle_values *tvalues;
+	char *sep = "";
+
+	list_for_each_entry(d, &r->domains, list) {
+		tvalues = get_mydomain(d)->throttle_values;
+		seq_printf(m, "%s%d=%lld", sep, d->id, tvalues[closid].now);
+		sep = ";";
+	}
+	seq_puts(m, "\n");
+}
+
+static void resetstaging(struct resctrl_resource *r, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct throttle_values *tvalues;
+
+	list_for_each_entry(d, &r->domains, list) {
+		tvalues = get_mydomain(d)->throttle_values;
+		tvalues[closid].need_update = false;
+	}
+}
+
+static bool validate_throttle(struct resctrl_domain *d, char *buf, struct throttle_values *c)
+{
+	unsigned long val;
+	struct mydomain *m = get_mydomain(d);
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret) {
+		// rdt_last_cmd_printf("Non-decimal character in the value %s\n", buf);
+		return false;
+	}
+
+	/* User didn't change this value */
+	if (val == c->now)
+		return true;
+
+	if (val > m->max_throttle) {
+		// rdt_last_cmd_puts("Throttle value out of range\n");
+		return false;
+	}
+	if (val % bandwidth_gran) {
+		// rdt_last_cmd_printf("Throttle must be multiple of %lld\n", bandwidth_gran);
+		return false;
+	}
+
+	c->need_update = true;
+	c->staged = val;
+
+	return true;
+}
+
+static int parse(struct resctrl_resource *r, char *line, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct throttle_values *tvalues;
+	char *dom = NULL, *id;
+	struct resctrl_domain *d;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] == '\0')
+		return 0;
+	dom = strsep(&line, ";");
+	id = strsep(&dom, "=");
+	id = strim(id);
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		// rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
+		return -EINVAL;
+	}
+	dom = strim(dom);
+	list_for_each_entry(d, &r->domains, list) {
+		if (d->id != dom_id)
+			continue;
+		tvalues = get_mydomain(d)->throttle_values;
+		if (!validate_throttle(d, dom, tvalues + closid))
+			return -EINVAL;
+		goto next;
+	}
+	return -EINVAL;
+}
+
+struct rdt_msr_info {
+	int	msr_base;
+	struct throttle_values *tvalues;
+};
+
+static void update_msrs(void *info)
+{
+	struct rdt_msr_info *mi = info;
+
+	for (int i = 0; i < mba.num_alloc_ids; i++) {
+		if (mi->tvalues[i].need_update) {
+			mi->tvalues[i].now = mi->tvalues[i].staged;
+			mi->tvalues[i].need_update = false;
+			wrmsrl(mi->msr_base + i, mi->tvalues[i].now);
+		}
+	}
+}
+
+static void applychanges(struct resctrl_resource *r, u64 resctrl_ids)
+{
+	int closid = (resctrl_ids >> 32);
+	struct resctrl_domain *d;
+	struct throttle_values *tvalues;
+	struct rdt_msr_info mi;
+
+	list_for_each_entry(d, &r->domains, list) {
+		tvalues = get_mydomain(d)->throttle_values;
+		if (!tvalues[closid].need_update)
+			continue;
+		mi.msr_base = r->archtag;
+		mi.tvalues = tvalues;
+		smp_call_function_single(cpumask_first(&d->cpu_mask), update_msrs, &mi, 1);
+	}
+}
+
+	u64 val;
+
+/*
+ * On domain discovery (duing module load, or CPU hotplug) set
+ * all controls to allow full access to all of cache. Ditto on
+ * module unload or domain removal.
+ */
+static void domain_update(struct resctrl_resource *r, int what, int cpu, struct resctrl_domain *d)
+{
+	struct mydomain *m = get_mydomain(d);
+	unsigned int eax, ebx, ecx, edx;
+	struct rdt_msr_info mi;
+	struct throttle_values *tvalues;
+
+	tvalues = (struct throttle_values *)(m + 1);
+	if (what == RESCTRL_DOMAIN_ADD || what == RESCTRL_DOMAIN_DELETE) {
+		cpuid_count(0x10, 3, &eax, &ebx, &ecx, &edx);
+		m->max_throttle = (eax & 0xfff) + 1;
+		bandwidth_gran = 100 - m->max_throttle;
+		min_bandwidth = 100 - m->max_throttle;
+		for (int i = 0; i < mba.num_alloc_ids; i++) {
+			tvalues[i].staged = 0;
+			tvalues[i].need_update = true;
+		}
+		mi.msr_base = r->archtag;
+		mi.tvalues = tvalues;
+		smp_call_function_single(cpu, update_msrs, &mi, 1);
+	}
+}
+
+RESCTRL_FILE_DEF(bandwidth_gran, "%d\n")
+RESCTRL_FILE_DEF(delay_linear, "%d\n")
+RESCTRL_FILE_DEF(min_bandwidth, "%d\n")
+RESCTRL_FILE_DEF(num_closids, "%d\n")
+
+static struct resctrl_fileinfo mb_files[] = {
+	{ .name = "bandwidth_gran", .ops = &bandwidth_gran_ops },
+	{ .name = "delay_linear", .ops = &delay_linear_ops },
+	{ .name = "min_bandwidth", .ops = &min_bandwidth_ops },
+	{ .name = "num_closids", .ops = &num_closids_ops },
+	{ }
+};
+
+static struct resctrl_resource mba = {
+	.name		= "MB",
+	.archtag	= MSR_IA32_MBA_THRTL_BASE,
+	.type		= RESCTRL_CONTROL,
+	.show		= show,
+	.resetstaging	= resetstaging,
+	.parse		= parse,
+	.applychanges	= applychanges,
+	.scope		= RESCTRL_L3CACHE,
+	.domain_size	= sizeof(struct resctrl_domain) + sizeof(struct mydomain),
+	.domains	= LIST_HEAD_INIT(mba.domains),
+	.domain_update	= domain_update,
+	.infodir	= "MB",
+	.infofiles	= mb_files,
+};
+
+static int __init mba_init(void)
+{
+	unsigned int eax, ebx, ecx, edx, mba_features;
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_RDT_A)) {
+		pr_debug("No RDT allocation support\n");
+		return -ENODEV;
+	}
+
+	mba_features = cpuid_ebx(0x10);
+
+	if (!(mba_features & BIT(3))) {
+		pr_debug("No RDT MBA allocation\n");
+		return -ENODEV;
+	}
+
+	cpuid_count(0x10, 3, &eax, &ebx, &ecx, &edx);
+	num_closids = edx + 1;
+	delay_linear = !!(ecx & BIT(2));
+
+	mba.domain_size += num_closids * sizeof(struct throttle_values);
+	mba.num_alloc_ids = num_closids;
+
+	ret = resctrl_register_ctrl_resource(&mba);
+	return ret;
+}
+
+static void __exit mba_cleanup(void)
+{
+	resctrl_unregister_ctrl_resource(&mba);
+}
+
+module_init(mba_init);
+module_exit(mba_cleanup);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/resctrl2/arch/x86/rdt_llc_occupancy.c b/fs/resctrl2/arch/x86/rdt_llc_occupancy.c
new file mode 100644
index 000000000000..e2f96776c2f2
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_llc_occupancy.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <asm/cpufeatures.h>
+
+#include "../../internal.h"
+
+#include "rdt.h"
+
+#ifndef EVENT
+#error "Need definition of which EVENT this module tracks"
+#endif
+
+static int mon_show(struct seq_file *sf, void *v)
+{
+	struct kernfs_open_file *of = sf->private;
+	struct kernfs_node *kn = of->kn;
+	long resctrl_ids = (long)kn->priv;
+	long domain_id = (long)kn->parent->priv;
+
+	seq_printf(sf, "%llu\n", rdt_rmid_read(domain_id, resctrl_ids & 0xffff, EVENT));
+
+	return 0;
+}
+
+static void domain_update(struct resctrl_resource *r, int what, int cpu, struct resctrl_domain *d)
+{
+}
+
+static struct kernfs_ops ops = {
+	.seq_show	= mon_show,
+};
+
+static struct resctrl_resource mon = {
+	.name		= "L3",
+	.archtag	= MSR_IA32_QM_EVTSEL,
+	.type		= RESCTRL_MONITOR,
+	.scope		= RESCTRL_L3CACHE,
+	.domain_size	= sizeof(struct resctrl_domain),
+	.domains	= LIST_HEAD_INIT(mon.domains),
+	.domain_update	= domain_update,
+	.mon_domain_dir	= "mon_L3_%02d",
+#if EVENT == EV_LLC
+	.mon_domain_file= "llc_occupancy",
+#elif EVENT == EV_TOT
+	.mon_domain_file= "mbm_total_bytes",
+#elif EVENT == EV_LOC
+	.mon_domain_file= "mbm_local_bytes",
+#elif EVENT == EV_TOTRATE
+	.mon_domain_file= "mbm_total_rate",
+#elif EVENT == EV_LOCRATE
+	.mon_domain_file= "mbm_local_rate",
+#else
+#error "Unknown EVENT type"
+#endif
+	.mod_domain_ops	= &ops,
+	.mon_event	= EVENT,
+};
+
+static int rdt_monitor_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+	int bit;
+
+	switch (EVENT) {
+	case EV_LLC: case EV_TOT: case EV_LOC:
+		bit = EVENT - 1;
+		break;
+	case EV_TOTRATE:
+		bit = EV_TOT - 1;
+		break;
+	case EV_LOCRATE:
+		bit = EV_LOC - 1;
+		break;
+	}
+	if (!boot_cpu_has(X86_FEATURE_CQM))
+		return -ENODEV;
+
+	cpuid_count(0xf, 0, &eax, &ebx, &ecx, &edx);
+	if (!(edx & BIT(1)))
+		return -ENODEV;
+
+	cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+	if (!(edx & BIT(bit)))
+		return -ENODEV;
+
+	resctrl_register_ctrl_resource(&mon);
+
+	return 0;
+}
+
+static void rdt_monitor_exit(void)
+{
+	resctrl_unregister_ctrl_resource(&mon);
+}
+
+module_init(rdt_monitor_init);
+module_exit(rdt_monitor_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/resctrl2/arch/x86/rdt_mbm_adjust.c b/fs/resctrl2/arch/x86/rdt_mbm_adjust.c
new file mode 100644
index 000000000000..430cce257f32
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_mbm_adjust.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <asm/cpufeatures.h>
+#include <asm/intel-family.h>
+
+#include "../../internal.h"
+
+#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
+
+/*
+ * The correction factor table is documented in Documentation/arch/x86/resctrl.rst.
+ * If rmid > rmid threshold, MBM total and local values should be multiplied
+ * by the correction factor.
+ *
+ * The original table is modified for better code:
+ *
+ * 1. The threshold 0 is changed to rmid count - 1 so don't do correction
+ *    for the case.
+ * 2. MBM total and local correction table indexed by core counter which is
+ *    equal to (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
+ * 3. The correction factor is normalized to 2^20 (1048576) so it's faster
+ *    to calculate corrected value by shifting:
+ *    corrected_value = (original_value * correction_factor) >> 20
+ */
+static const struct mbm_correction_factor_table {
+	u32 rmidthreshold;
+	u64 cf;
+} mbm_cf_table[] __initconst = {
+	{7,	CF(1.000000)},
+	{15,	CF(1.000000)},
+	{15,	CF(0.969650)},
+	{31,	CF(1.000000)},
+	{31,	CF(1.066667)},
+	{31,	CF(0.969650)},
+	{47,	CF(1.142857)},
+	{63,	CF(1.000000)},
+	{63,	CF(1.185115)},
+	{63,	CF(1.066553)},
+	{79,	CF(1.454545)},
+	{95,	CF(1.000000)},
+	{95,	CF(1.230769)},
+	{95,	CF(1.142857)},
+	{95,	CF(1.066667)},
+	{127,	CF(1.000000)},
+	{127,	CF(1.254863)},
+	{127,	CF(1.185255)},
+	{151,	CF(1.000000)},
+	{127,	CF(1.066667)},
+	{167,	CF(1.000000)},
+	{159,	CF(1.454334)},
+	{183,	CF(1.000000)},
+	{127,	CF(0.969744)},
+	{191,	CF(1.280246)},
+	{191,	CF(1.230921)},
+	{215,	CF(1.000000)},
+	{191,	CF(1.143118)},
+};
+
+static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
+static u64 mbm_cf __read_mostly;
+
+u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
+{
+	/* Correct MBM value. */
+	if (rmid > mbm_cf_rmidthreshold)
+		val = (val * mbm_cf) >> 20;
+
+	return val;
+}
+
+void __init rdt_mbm_apply_quirk(int num_rmids)
+{
+	int cf_index;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86 != 6)
+		return;
+	if (boot_cpu_data.x86_model != INTEL_FAM6_BROADWELL_X &&
+	    boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X)
+		return;
+
+	cf_index = num_rmids / 8 - 1;
+	if (cf_index >= ARRAY_SIZE(mbm_cf_table)) {
+		pr_info("No MBM correction factor available\n");
+		return;
+	}
+
+	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
+	mbm_cf = mbm_cf_table[cf_index].cf;
+}
diff --git a/fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c b/fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c
new file mode 120000
index 000000000000..e15bfdd4143e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c
@@ -0,0 +1 @@
+rdt_llc_occupancy.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_mbm_local_rate.c b/fs/resctrl2/arch/x86/rdt_mbm_local_rate.c
new file mode 120000
index 000000000000..e15bfdd4143e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_mbm_local_rate.c
@@ -0,0 +1 @@
+rdt_llc_occupancy.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c b/fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c
new file mode 120000
index 000000000000..e15bfdd4143e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c
@@ -0,0 +1 @@
+rdt_llc_occupancy.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_mbm_total_rate.c b/fs/resctrl2/arch/x86/rdt_mbm_total_rate.c
new file mode 120000
index 000000000000..e15bfdd4143e
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_mbm_total_rate.c
@@ -0,0 +1 @@
+rdt_llc_occupancy.c
\ No newline at end of file
diff --git a/fs/resctrl2/arch/x86/rdt_monitor.c b/fs/resctrl2/arch/x86/rdt_monitor.c
new file mode 100644
index 000000000000..66523bcdffc8
--- /dev/null
+++ b/fs/resctrl2/arch/x86/rdt_monitor.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <asm/cpufeatures.h>
+
+#include "../../internal.h"
+#include "rdt.h"
+
+#define MBM_POLL_DELAY	1000	// milliseconds
+
+char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
+
+struct rmid {
+	struct list_head	list;
+	struct list_head	child_list;
+	bool			is_parent;
+	u64			llc_busy_domains;
+};
+
+struct mbm_event_state {
+	u64	chunks;
+	u64	prev_msr;
+	u64	prev_jiffies;
+	u64	rate;
+};
+
+struct arch_mbm_state {
+	struct mbm_event_state state[2];
+};
+
+struct mydomain {
+	int			cpu;
+	spinlock_t		msr_lock;
+	struct delayed_work	worker;
+	struct arch_mbm_state	state[];
+};
+#define get_mydomain(d) ((struct mydomain *)&d[1])
+
+struct rmid_info {
+	struct mydomain *mydomain;
+	u32	eventmap;
+	bool	init;
+};
+
+static LIST_HEAD(active_rmids);
+static LIST_HEAD(free_rmids);
+static LIST_HEAD(limbo_rmids);
+
+static struct rmid *rmid_array;
+static int num_rmids;
+static int upscale;
+static int max_threshold_occupancy;
+static int mbm_width = 24;
+static char mon_features[64];
+static struct resctrl_resource monitor;
+static int active_events[EV_MAX];
+
+static void init_rmids(int mon_event);
+static void update_rmids(void *info);
+static bool rmid_polling;
+static u64 llc_busy_threshold;
+unsigned int resctrl_rmid_realloc_limit;
+
+static void check_limbo(struct resctrl_domain *d)
+{
+	struct rmid *r, *tmp;
+
+	list_for_each_entry_safe(r, tmp, &limbo_rmids, list) {
+		u64 rmid = r - rmid_array;
+		u64 chunks;
+
+		if (!(r->llc_busy_domains & BIT(d->id)))
+			continue;
+		wrmsrl(MSR_IA32_QM_EVTSEL, (rmid << 32) | EV_LLC);
+		rdmsrl(MSR_IA32_QM_CTR, chunks);
+
+		if (chunks <= llc_busy_threshold) {
+			r->llc_busy_domains &= ~BIT(d->id);
+			if (!r->llc_busy_domains)
+				list_move_tail(&r->list, &free_rmids);
+		}
+	}
+}
+
+static bool mbm_is_active(void)
+{
+	return (active_events[EV_TOT] + active_events[EV_LOC]) > 0;
+}
+
+static void mbm_poll(struct work_struct *work)
+{
+	struct resctrl_domain *d;
+	struct rmid_info ri;
+	unsigned long flags;
+	struct mydomain *m;
+
+	m = container_of(work, struct mydomain, worker.work);
+	d = (struct resctrl_domain *)m - 1;
+	ri.mydomain = m;
+	ri.eventmap = 0;
+	if (active_events[EV_TOT])
+		ri.eventmap |= BIT(EV_TOT);
+	if (active_events[EV_LOC])
+		ri.eventmap |= BIT(EV_LOC);
+	ri.init = false;
+
+	spin_lock_irqsave(&m->msr_lock, flags);
+	update_rmids(&ri);
+
+	if (!list_empty(&limbo_rmids))
+		check_limbo(d);
+
+	if (!list_empty(&limbo_rmids) || mbm_is_active())
+		schedule_delayed_work_on(m->cpu, &m->worker, msecs_to_jiffies(MBM_POLL_DELAY));
+	else
+		rmid_polling = false;
+	spin_unlock_irqrestore(&m->msr_lock, flags);
+}
+
+static void init_rmid_polling(void)
+{
+	struct resctrl_domain *d;
+	struct mydomain *m;
+
+	rmid_polling = true;
+	list_for_each_entry(d, &monitor.domains, list) {
+		m = get_mydomain(d);
+		INIT_DELAYED_WORK(&m->worker, mbm_poll);
+		m->cpu = cpumask_any(&d->cpu_mask);
+		schedule_delayed_work_on(m->cpu, &m->worker, msecs_to_jiffies(MBM_POLL_DELAY));
+	}
+}
+
+void arch_add_monitor(int mon_event)
+{
+	switch (mon_event) {
+	case EV_LOCRATE:
+		mon_event = EV_LOC;
+		break;
+	case EV_TOTRATE:
+		mon_event = EV_TOT;
+		break;
+	}
+
+	active_events[mon_event]++;
+
+	if (mon_event == EV_TOT || mon_event == EV_LOC) {
+		if (active_events[mon_event] == 1)
+			init_rmids(mon_event);
+		if (!rmid_polling && mbm_is_active())
+			init_rmid_polling();
+	}
+}
+
+void arch_del_monitor(int mon_event)
+{
+	switch (mon_event) {
+	case EV_LOCRATE:
+		mon_event = EV_LOC;
+		break;
+	case EV_TOTRATE:
+		mon_event = EV_TOT;
+		break;
+	}
+
+	active_events[mon_event]--;
+}
+
+int rmid_alloc(int prmid)
+{
+	struct rmid *r;
+
+	if (!num_rmids)
+		return 0;
+
+	if (list_empty(&free_rmids))
+		return list_empty(&limbo_rmids) ? -ENOSPC : -EBUSY;
+
+	r = list_first_entry(&free_rmids, struct rmid, list);
+
+	if (prmid < 0) {
+		r->is_parent = true;
+		INIT_LIST_HEAD(&r->child_list);
+	} else {
+		r->is_parent = false;
+		list_add(&r->child_list, &rmid_array[prmid].child_list);
+	}
+
+	list_move(&r->list, &active_rmids);
+
+	return r - rmid_array;
+}
+
+void rmid_free(int rmid)
+{
+	struct rmid *r = &rmid_array[rmid];
+	struct resctrl_domain *d;
+
+	if (active_events[EV_LLC]) {
+		list_for_each_entry(d, &monitor.domains, list)
+			r->llc_busy_domains |= BIT(d->id);
+		list_move_tail(&r->list, &limbo_rmids);
+		if (!rmid_polling)
+			init_rmid_polling();
+	} else {
+		list_move_tail(&r->list, &free_rmids);
+	}
+	if (r->is_parent)
+		WARN_ON(!list_empty(&r->child_list));
+	else
+		list_del(&r->child_list);
+}
+
+static u64 wrap(u64 old, u64 new)
+{
+	u64 shift = 64 - mbm_width, chunks;
+
+	chunks = (new << shift) - (old << shift);
+
+	return chunks >> shift;
+}
+
+static u64 adjust(struct mydomain *m, u64 rmid, u64 event, u64 chunks)
+{
+	struct mbm_event_state *s;
+	u64 rawchunks;
+
+
+	switch (event) {
+	case EV_LLC:
+		rawchunks = chunks;
+		break;
+	case EV_TOT:
+		s = &m->state[rmid].state[0];
+		rawchunks = get_corrected_mbm_count(rmid, s->chunks + wrap(s->prev_msr, chunks));
+		break;
+	case EV_LOC:
+		s = &m->state[rmid].state[1];
+		rawchunks = get_corrected_mbm_count(rmid, s->chunks + wrap(s->prev_msr, chunks));
+		break;
+	case EV_TOTRATE:
+		s = &m->state[rmid].state[0];
+		rawchunks = get_corrected_mbm_count(rmid, s->rate);
+		break;
+	case EV_LOCRATE:
+		s = &m->state[rmid].state[0];
+		rawchunks = get_corrected_mbm_count(rmid, s->rate);
+		break;
+	}
+	return rawchunks;
+}
+
+struct rrmid_info {
+	struct resctrl_domain	*domain;
+	u64			rmid;
+	u64			event;
+	u64			chunks;
+};
+
+static void __rdt_rmid_read(void *info)
+{
+	struct rrmid_info *rr = info;
+	unsigned long flags;
+	struct rmid *cr, *r;
+	struct mydomain *m;
+	u64 chunks;
+
+	m = get_mydomain(rr->domain);
+
+	if (rr->event <= EV_LOC) {
+		spin_lock_irqsave(&m->msr_lock, flags);
+		wrmsrl(MSR_IA32_QM_EVTSEL, (rr->rmid << 32) | rr->event);
+		rdmsrl(MSR_IA32_QM_CTR, chunks);
+	} else {
+		chunks = 0;
+	}
+
+	rr->chunks = adjust(m, rr->rmid, rr->event, chunks);
+
+	r = &rmid_array[rr->rmid];
+	if (r->is_parent && !list_empty(&r->child_list)) {
+		list_for_each_entry(cr, &r->child_list, child_list) {
+			u64 crmid = cr - rmid_array;
+
+			if (rr->event <= EV_LOC) {
+				wrmsrl(MSR_IA32_QM_EVTSEL, (crmid << 32) | rr->event);
+				rdmsrl(MSR_IA32_QM_CTR, chunks);
+			} else {
+				chunks = 0;
+			}
+
+			rr->chunks += adjust(m, crmid, rr->event, chunks);
+		}
+	}
+
+	if (rr->event <= EV_LOC)
+		spin_unlock_irqrestore(&m->msr_lock, flags);
+}
+
+u64 rdt_rmid_read(int domain_id, int rmid, int event)
+{
+	struct resctrl_domain *d;
+	struct rrmid_info rr;
+	struct mydomain *m;
+
+	list_for_each_entry(d, &monitor.domains, list)
+		if (d->id == domain_id)
+			goto found;
+	return ~0ull;
+found:
+	m = get_mydomain(d);
+
+	rr.domain = d;
+	rr.rmid = rmid;
+	rr.event = event;
+
+	if (event <= EV_LOC)
+		smp_call_function_any(&d->cpu_mask, __rdt_rmid_read, &rr, 1);
+	else
+		__rdt_rmid_read(&rr);
+
+	return rr.chunks * upscale;
+}
+EXPORT_SYMBOL_GPL(rdt_rmid_read);
+
+static void update_rmids(void *info)
+{
+	struct rmid_info *ri = info;
+	struct mbm_event_state *s;
+	u64 addchunks, now;
+	u32 map, event;
+	struct rmid *r;
+
+	list_for_each_entry(r, &active_rmids, list) {
+		u64 msr, rmid = r - rmid_array;
+
+		for (map = ri->eventmap; map; map &= ~BIT(event)) {
+			event = __ffs(map);
+
+			if (event == EV_TOT)
+				s = &ri->mydomain->state[rmid].state[0];
+			else
+				s = &ri->mydomain->state[rmid].state[1];
+			wrmsrl(MSR_IA32_QM_EVTSEL, (rmid << 32) | event);
+			rdmsrl(MSR_IA32_QM_CTR, msr);
+			now = jiffies;
+			addchunks = wrap(s->prev_msr, msr);
+			if (ri->init) {
+				s->chunks = 0;
+				s->rate = 0;
+			} else {
+				s->chunks += addchunks;
+				s->rate = addchunks * HZ / (now - s->prev_jiffies);
+			}
+			s->prev_jiffies = now;
+			s->prev_msr = msr;
+		}
+	}
+}
+
+static void init_rmids(int mon_event)
+{
+	struct resctrl_domain *d;
+	struct rmid_info ri;
+
+	ri.init = true;
+
+	list_for_each_entry(d, &monitor.domains, list) {
+		ri.mydomain = get_mydomain(d);
+		ri.eventmap = BIT(mon_event);
+		smp_call_function_any(&d->cpu_mask, update_rmids, &ri, 1);
+	}
+}
+
+static void domain_update(struct resctrl_resource *r, int what, int cpu, struct resctrl_domain *d)
+{
+	struct mydomain *m = get_mydomain(d);
+
+	if (what == RESCTRL_DOMAIN_ADD ||
+	    (what == RESCTRL_DOMAIN_DELETE_CPU && cpu == m->cpu)) {
+		if (what == RESCTRL_DOMAIN_DELETE_CPU)
+			cancel_delayed_work(&m->worker);
+		spin_lock_init(&m->msr_lock);
+		INIT_DELAYED_WORK(&m->worker, mbm_poll);
+		m->cpu = cpumask_any(&d->cpu_mask);
+		schedule_delayed_work_on(m->cpu, &m->worker, msecs_to_jiffies(MBM_POLL_DELAY));
+	}
+}
+
+static ssize_t max_threshold_occupancy_write(struct kernfs_open_file *of, char *buf,
+					     size_t nbytes, loff_t off)
+{
+	unsigned int bytes;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &bytes);
+	if (ret)
+		return ret;
+
+	if (bytes > resctrl_rmid_realloc_limit)
+		return -EINVAL;
+
+	llc_busy_threshold = bytes / upscale;
+	max_threshold_occupancy = llc_busy_threshold * upscale;
+
+	return nbytes;
+}
+
+RESCTRL_FILE_DEF(max_threshold_occupancy, "%d\n")
+RESCTRL_FILE_DEF(mon_features, "%s")
+RESCTRL_FILE_DEF(num_rmids, "%d\n")
+
+static struct resctrl_fileinfo monitor_files[] = {
+	{ .name = "max_threshold_occupancy", .ops = &max_threshold_occupancy_ops },
+	{ .name = "mon_features", .ops = &mon_features_ops },
+	{ .name = "num_rmids", .ops = &num_rmids_ops },
+	{ }
+};
+
+static struct resctrl_resource monitor = {
+	.name		= "L3",
+	.archtag	= MSR_IA32_QM_EVTSEL,
+	.type		= RESCTRL_MONITOR,
+	.scope		= RESCTRL_L3CACHE,
+	.domain_size	= sizeof(struct resctrl_domain),
+	.domains	= LIST_HEAD_INIT(monitor.domains),
+	.domain_update	= domain_update,
+	.infodir	= "L3_MON",
+	.infofiles	= monitor_files,
+};
+
+static int __init rdt_monitor_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+	char *s;
+
+	if (!boot_cpu_has(X86_FEATURE_CQM))
+		return -ENODEV;
+
+	cpuid_count(0xf, 0, &eax, &ebx, &ecx, &edx);
+	if (!(edx & BIT(1)))
+		return -ENODEV;
+
+	cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+	mbm_width += eax & 0xff;
+	upscale = ebx;
+	num_rmids = ecx + 1;
+	rdt_mbm_apply_quirk(num_rmids);
+
+	monitor.domain_size += num_rmids * sizeof(struct arch_mbm_state);
+
+	max_threshold_occupancy_ops.write = max_threshold_occupancy_write;
+
+	/*
+	 * A reasonable upper limit on the max threshold is the number
+	 * of lines tagged per RMID if all RMIDs have the same number of
+	 * lines tagged in the LLC.
+	 *
+	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
+	 */
+	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
+	llc_busy_threshold = (resctrl_rmid_realloc_limit / num_rmids) / upscale;
+	max_threshold_occupancy = llc_busy_threshold * upscale;
+
+	s = mon_features;
+	if (edx & BIT(0))
+		s = stpcpy(s, "llc_occupancy\n");
+	if (edx & BIT(1))
+		s = stpcpy(s, "mbm_total_bytes\n");
+	if (edx & BIT(2))
+		s = stpcpy(s, "mbm_local_bytes\n");
+
+	rmid_array = kzalloc(sizeof *rmid_array * num_rmids, GFP_KERNEL);
+	if (!rmid_array)
+		return -ENOMEM;
+
+	rmid_array[0].is_parent = true;
+	INIT_LIST_HEAD(&rmid_array[0].child_list);
+	list_add(&rmid_array[0].list, &active_rmids);
+
+	for (int i = 1; i < num_rmids; i++)
+		list_add_tail(&rmid_array[i].list, &free_rmids);
+
+	resctrl_register_ctrl_resource(&monitor);
+
+	return 0;
+}
+
+late_initcall(rdt_monitor_init);
+
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..1b7bea469334 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -480,9 +480,16 @@ config GOLDFISH
 	def_bool y
 	depends on X86_GOLDFISH
 
+choice
+	prompt "Resource Control"
+	default X86_CPU_RESCTRL_OFF
+	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
+
+config X86_CPU_RESCTRL_OFF
+	bool "No support for x86 CPU resource control"
+
 config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
-	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	select PROC_CPU_RESCTRL		if PROC_FS
 	help
@@ -499,7 +506,77 @@ config X86_CPU_RESCTRL
 	  More information about AMD QoS can be found in the AMD64 Technology
 	  Platform Quality of Service Extensions manual.
 
-	  Say N if unsure.
+config X86_CPU_RESCTRL2
+	bool "resctrl2 filesystem support"
+	select KERNFS
+	select RESCTRL2_FS
+	help
+	  Enable x86 CPU resource control support.
+
+	  Experimental software loadable module driven version
+	  of support for resource control.
+
+endchoice
+
+config X86_RDT_L3_CAT
+	tristate "RDT L3 cache control"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 cache allocation
+
+config X86_RDT_L2_CAT
+	tristate "RDT L2 cache control"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L2 cache allocation
+
+config X86_RDT_L3_CDP
+	tristate "RDT L3 CDP cache control"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 CDP cache allocation
+
+config X86_RDT_L2_CDP
+	tristate "RDT L2 CDP cache control"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L2 CDP cache allocation
+
+config X86_RDT_L3_MBA
+	tristate "RDT L3 Memory bandwidth allocation"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 memory bandwidth allocation
+
+config X86_RDT_LLC_OCCUPANCY
+	tristate "RDT L3 cache occupancy monitor"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 cache occupancy monitor
+
+config X86_RDT_MBM_TOTAL_BYTES
+	tristate "RDT L3 total memory bandwidth monitor"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 total memory bandwidth monitor
+
+config X86_RDT_MBM_LOCAL_BYTES
+	tristate "RDT L3 local memory bandwidth monitor"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 local memory bandwidth monitor
+
+config X86_RDT_MBM_TOTAL_RATE
+	tristate "RDT L3 total memory bandwidth rate monitor"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 total memory bandwidth rate monitor
+
+config X86_RDT_MBM_LOCAL_RATE
+	tristate "RDT L3 local memory bandwidth rate monitor"
+	depends on X86_CPU_RESCTRL2
+	help
+	  Loadable module for RDT L3 local memory bandwidth rate monitor
 
 if X86_32
 config X86_BIGSMP
diff --git a/fs/resctrl2/arch/x86/Makefile b/fs/resctrl2/arch/x86/Makefile
new file mode 100644
index 000000000000..393a9412f151
--- /dev/null
+++ b/fs/resctrl2/arch/x86/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_X86_CPU_RESCTRL2) += alloc.o
+obj-$(CONFIG_X86_CPU_RESCTRL2) += rdt_monitor.o
+obj-$(CONFIG_X86_CPU_RESCTRL2) += rdt_mbm_adjust.o
+
+CFLAGS_rdt_l3_cat.o += -DCACHE_LEVEL=3
+CFLAGS_rdt_l2_cat.o += -DCACHE_LEVEL=2
+CFLAGS_rdt_l3_cdp.o += -DCACHE_LEVEL=3 -DCDP
+CFLAGS_rdt_l2_cdp.o += -DCACHE_LEVEL=2 -DCDP
+
+obj-$(CONFIG_X86_RDT_L3_CAT)		+= rdt_l3_cat.o
+obj-$(CONFIG_X86_RDT_L2_CAT)		+= rdt_l2_cat.o
+obj-$(CONFIG_X86_RDT_L3_CDP)		+= rdt_l3_cdp.o
+obj-$(CONFIG_X86_RDT_L2_CDP)		+= rdt_l2_cdp.o
+
+CFLAGS_rdt_llc_occupancy.o		+= -DEVENT=1
+CFLAGS_rdt_mbm_total_bytes.o		+= -DEVENT=2
+CFLAGS_rdt_mbm_local_bytes.o		+= -DEVENT=3
+CFLAGS_rdt_mbm_total_rate.o		+= -DEVENT=4
+CFLAGS_rdt_mbm_local_rate.o		+= -DEVENT=5
+
+obj-$(CONFIG_X86_RDT_LLC_OCCUPANCY)	+= rdt_llc_occupancy.o
+obj-$(CONFIG_X86_RDT_MBM_TOTAL_BYTES)	+= rdt_mbm_total_bytes.o
+obj-$(CONFIG_X86_RDT_MBM_LOCAL_BYTES)	+= rdt_mbm_local_bytes.o
+obj-$(CONFIG_X86_RDT_MBM_TOTAL_RATE)	+= rdt_mbm_total_rate.o
+obj-$(CONFIG_X86_RDT_MBM_LOCAL_RATE)	+= rdt_mbm_local_rate.o
+
+obj-$(CONFIG_X86_RDT_L3_MBA)		+= rdt_l3_mba.o
-- 
2.40.1

