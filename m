Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0B662B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjAIQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjAIQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F460E0DC;
        Mon,  9 Jan 2023 08:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLzQsmTOJHEjshDLjVXy+hC5X4tr+MXpLffPtbAeq6wpxg3R/PTQUBzMruJK49jysAZXfZUtaXHiD10BBQviCCwoLXVdxZioAtl4E/8r39o+DWuJR0h4pxN0souNW/we5XANlUJukdD2r9VLf+8Ds096Fln0n5WMPYHHLKR3dgvTQIy8xp9iyfQBUlxJkKPpLfzKAjq2hRLO25Oi2FT1ieY2xktCeAUlyHWQz0lnxzfgCaQKS+GFHRjKOKGETnLFmfc0YLtbzY1UkaBBbpEDbgxiiiY7tv7BBOrV2DMqg/+bvfpLhm1hh69BsKsV++KVwOB7HmJOa7gwW/f0yjJyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtXYbPQC0+WYlbNB5AV7iBoCSOE0PPHNoDawc9whwaQ=;
 b=oZC3spDmwjukt9fy0KxwokSlsCpAUYTHUOHc/WvPyaJhUaEtZkZByAVMCaGb9R//XPc86k14q6Vy5cdE4JmpkUm8nI1Es273on3bYdVVn+7qYPNeBRHuxJ/I9xUqDY3xDKSgS3alOzOvkapt/zqazAn5TU18EkCWPt7ikOspihIlvdt69f84lBTte3Dn1ZuM2hgi5xKqbOW1K/dO6kyfscmbUrro6xVyVVQWYcE6JpyWkNHLSMD55yrdL3UQhvLjFHq6bPcJ7KId1+5oz74/EErLu0i96rvOA/++NYTdr/qMw6pgqy2UXN9jxgSr5CxJ9ydKaYl8nugj6W5L4cE9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtXYbPQC0+WYlbNB5AV7iBoCSOE0PPHNoDawc9whwaQ=;
 b=0WsmewxKu3ccPxTStSGV/nLrMhNwS+PGewjSshb1Y3S0qpQ/sqrdGP1O3Us+COXQ106eLDYexuR5s4AgEvdOzNEc0mBgyH4zPF/qWMxHmLI0qKavwmPJvGAMSE6GHgG84ZzvEQzkBr9c2W3ighgSdvxDEd/cUaIIo+UIOrsWSfo=
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:32 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::f2) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:29 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v11 11/13] x86/resctrl: Add interface to write mbm_total_bytes_config
Date:   Mon, 9 Jan 2023 10:44:03 -0600
Message-ID: <20230109164405.569714-12-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 797f044c-ff5b-4b1e-7352-08daf260c891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thk8hh+ETzNEsy5wA2Ydo2iSrbaFibE3vDdE6WyUOoAmUjKtfXP8NQpHXWFnWDMOsTQ9K0ReMMkFcMIgILp6EBcYD4mkXv0HZNIPqdQLz9CBVDVXUqlgv85iE7ZrkhV5N2zmJ+NGqPFyNHh54Jhf2hXV8F54UM5Uz2q2LoZnCGYLSISrgsQRSQbGDdT5QDGCK5+opDiBDvDmCWMHJPtxe5fdyAsf/MpIgLPYu2/eb3+t2+EFZy6LpQ/ETk3Wnz1aVDgVqAyZmhn3sxxykdvR2NvbsroTUNGPCTD7X6UqnXYjGPskZaf2E9cpeBHbuTS+Hkc6MWX29RsQSh0kF1RJFGPxtwjhdtotpN2sBY07jWg0yVd0EHqUQI68XkZnczMC+lmE6UAqZg68MVOuQ4phHHotc5fZ5AHa0W1XUrqgo7m7uP8k506M4ZT5BiFeJGXD31v0AG64N9xbxHDoBAQIsddy3cTqkNCyIlqP7ctIKrUGwG6BeySxyfDADo6XNCIeSer61K06HVzWoW4sbErYAmhQNvFaAvxP+dFZNi2OqGfwSCn2d/uujqWiv2vUR51mQjY57aARPLsf3m0ybkrv6B+ZHkussGijjuZUfFLuHjZrkP4JUATFHsyHiLOZgiYag12h+Y4XjRuIyYhPU9/3BY63cHkX0KLrWxQ3JHnGA7LpNxoOytzshDmC9cUIwIn+KX/iYLfp+HmPmIbVfzYr+bE78q16kKeTczqhGGN2Hq0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(356005)(2906002)(478600001)(44832011)(2616005)(7406005)(186003)(1076003)(7696005)(16526019)(26005)(316002)(5660300002)(40480700001)(7416002)(82310400005)(83380400001)(8936002)(36756003)(86362001)(426003)(41300700001)(47076005)(40460700003)(336012)(8676002)(70586007)(70206006)(110136005)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:32.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f044c-ff5b-4b1e-7352-08daf260c891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
command.
        $echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config

To change the mbm_total_bytes to count all the slow memory reads on
domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
Run the command.
        $echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  17 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 124 ++++++++++++++++++++++++-
 include/linux/resctrl.h                |  11 +++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7c8a3a745041..c50c43656bdb 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -176,6 +176,23 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
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
index 43e2a866e8e0..21fdb4a48a11 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1515,6 +1515,127 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
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
@@ -1615,9 +1736,10 @@ static struct rftype res_common_files[] = {
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
index 0cee154abc9f..8334eeacfec5 100644
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
 
-- 
2.34.1

