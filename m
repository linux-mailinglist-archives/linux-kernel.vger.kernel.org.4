Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA3679416
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjAXJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAXJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805030D5;
        Tue, 24 Jan 2023 01:26:37 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rm6gA2w9XdDWphFl1YcP9fSiFF3SKIi0cBfaZDeNRsM=;
        b=BD1tUPuumV+TEYbkdGLyp+UiNXrVsTAVCrCvNZF1LXnKFLK/osu0GTiG8j7ivJMEtgiYv+
        srFSpAqkke9a+wm0tIy1N0TRfmlfoSMklMAu9hlq1WXT604Tb53u1N5ymXT2ayuPSp5WDC
        fiUrWcyFUZFOyyu8Y+oH6Jpn3htfbPmPedOgGeFVnwkKuSFNhMocwHx8VZ7o6QQ5ul7Rdp
        FqdCfSp580Ruyko4uJFsw3jnmJUEB9YFy5MxuKDzdV8TIQ438eW24EjhuwfwbQiCkcEiEr
        HYg4lNWB64bcS+dRy50Ipyl0/Gfn/a62euxPsim1Miz90764oaspMbNPsd2y2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rm6gA2w9XdDWphFl1YcP9fSiFF3SKIi0cBfaZDeNRsM=;
        b=lLfhJ5nkvmHu395VqXcXZf8CVlM97SPRDeYyi5jB0WjKjmWERIfCAU/0lg2aehNuRC/5mA
        fZ+BlU5FKlxjIrBA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add interface to write mbm_total_bytes_config
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-12-babu.moger@amd.com>
References: <20230113152039.770054-12-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239604.4906.13914048239718392770.tip-bot2@tip-bot2>
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

Commit-ID:     92bd5a1390335bb3cc76bdf1b4356edbc94d408d
Gitweb:        https://git.kernel.org/tip/92bd5a1390335bb3cc76bdf1b4356edbc94d408d
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:37 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:30 +01:00

x86/resctrl: Add interface to write mbm_total_bytes_config

The event configuration for mbm_total_bytes can be changed by the user by
writing to the file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.

The event configuration settings are domain specific and affect all the
CPUs in the domain.

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

For example:

To change the mbm_total_bytes to count only reads on domain 0, the bits
0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33).
Run the command:

  $echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config

To change the mbm_total_bytes to count all the slow memory reads on domain 1,
the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
Run the command:

  $echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-12-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  17 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 124 +++++++++++++++++++++++-
 include/linux/resctrl.h                |  11 ++-
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 28c6500..7fe5148 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -204,6 +204,23 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 	}
 }
 
+/*
+ * Assumes that hardware counters are also reset and thus that there is
+ * no need to record initial non-zero counts.
+ */
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+	if (is_mbm_total_enabled())
+		memset(hw_dom->arch_mbm_total, 0,
+		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
+
+	if (is_mbm_local_enabled())
+		memset(hw_dom->arch_mbm_local, 0,
+		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
+}
+
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 {
 	u64 shift = 64 - width, chunks;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ad3c701..03284a6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1517,6 +1517,127 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void mon_event_config_write(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	unsigned int index;
+
+	index = mon_event_config_index_get(mon_info->evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		return;
+	}
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+}
+
+static int mbm_config_write_domain(struct rdt_resource *r,
+				   struct rdt_domain *d, u32 evtid, u32 val)
+{
+	struct mon_config_info mon_info = {0};
+	int ret = 0;
+
+	/* mon_config cannot be more than the supported set of events */
+	if (val > MAX_EVT_CONFIG_BITS) {
+		rdt_last_cmd_puts("Invalid event configuration\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Read the current config value first. If both are the same then
+	 * no need to write it again.
+	 */
+	mon_info.evtid = evtid;
+	mondata_config_read(d, &mon_info);
+	if (mon_info.mon_config == val)
+		goto out;
+
+	mon_info.mon_config = val;
+
+	/*
+	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
+	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
+	 * are scoped at the domain level. Writing any of these MSRs
+	 * on one CPU is observed by all the CPUs in the domain.
+	 */
+	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
+			      &mon_info, 1);
+
+	/*
+	 * When an Event Configuration is changed, the bandwidth counters
+	 * for all RMIDs and Events will be cleared by the hardware. The
+	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
+	 * every RMID on the next read to any event for every RMID.
+	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
+	 * cleared while it is tracked by the hardware. Clear the
+	 * mbm_local and mbm_total counts for all the RMIDs.
+	 */
+	resctrl_arch_reset_rmid_all(r, d);
+
+out:
+	return ret;
+}
+
+static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
+{
+	char *dom_str = NULL, *id_str;
+	unsigned long dom_id, val;
+	struct rdt_domain *d;
+	int ret = 0;
+
+next:
+	if (!tok || tok[0] == '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str = strim(strsep(&tok, ";"));
+	id_str = strsep(&dom_str, "=");
+
+	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
+		return -EINVAL;
+	}
+
+	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
+		rdt_last_cmd_puts("Non-numeric event configuration value\n");
+		return -EINVAL;
+	}
+
+	list_for_each_entry(d, &r->domains, list) {
+		if (d->id == dom_id) {
+			ret = mbm_config_write_domain(r, d, evtid, val);
+			if (ret)
+				return -EINVAL;
+			goto next;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] = '\0';
+
+	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1617,9 +1738,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_total_bytes_config",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= mbm_total_bytes_config_show,
+		.write		= mbm_total_bytes_config_write,
 	},
 	{
 		.name		= "mbm_local_bytes_config",
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0cee154..8334eea 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -250,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
+/**
+ * resctrl_arch_reset_rmid_all() - Reset all private state associated with
+ *				   all rmids and eventids.
+ * @r:		The resctrl resource.
+ * @d:		The domain for which all architectural counter state will
+ *		be cleared.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
