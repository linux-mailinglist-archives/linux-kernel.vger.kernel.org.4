Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA669CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAMPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAMPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3597278D;
        Fri, 13 Jan 2023 07:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdVqV3wwYdp0rUhqxW46iPpGWu6I+0kI2mDap0hmYEVwYaACi80gO1CtnzDU+dMZ8x8bVJjiP5EdTa+I3xhp+YY5DvWiOC8UkhoNHqO+GDcd72PuiKSuthhHgzRSCNYv++5fbXYe7RwvCLG+E9HDnbC86W+UEpWdYQPOkbgI55loJbCvw/+R4WlBoWYtPgz1+7ho1AvBassK9k/SatQBUBTce525RGuZJYTlLFnlAn01FeFtUol3Zx4NmLa9qcZehrqwyVBiwCXJU8ODFKrJujd6PDzWhQPKTWcLyuYIDU7aco4vHVctxRPhYd9T3PNoXZTCY3j7yLRoMzmS9Ca57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRQTDxcaZV9G3e8WvLWHgvElYZj0LabsmmzMHSq3PAE=;
 b=gpSAKlVrHGxILw/op66zybs8uKPdVfxH1lgqvhEeim6CQ+KX9m/24SjFbbdsWd4pKfmFgGP5FqE/8uk8kd4mAG3m5O+3wIFXa6U3Es34zx1APtL/I/xsheFAztYPSg0T8c/E5Vz0cs5p/ZS5I7+fxNel/EPRqk0+Q8zktKA0TWz+DvFYVafTlLxtE3dAL9I/4XJ4T2dnvw6M5pQxwvvUbUahN+KtIoX3CEuZ6cLRDo73bzGTP2m9NjapN0zEF55V31Eve6HzVZnfpyGtFZ6wRaNZNfmtqcymtNOO6EKYrAbLFPEDEWSSNkuGxFvB3BlzJJS8bGY/KO++cXOGSY+1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRQTDxcaZV9G3e8WvLWHgvElYZj0LabsmmzMHSq3PAE=;
 b=Pw7aBDdp8i4/KhtEK82cguG9TSgqQ8RNlgHSTSViEbyBtmx4F2y3aisqXlNv5SE8FMz7g5Pg0R0Zxr/N/05rVSPNY0V3fk0ZRh1X52SLsS3YXUCqZd1RGSTTDfJEL4mpN0lfbRnqa3v0uazLWXSG0g5gX6TvJlls4tJzq3IoOgI=
Received: from DM6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:5:190::33)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 15:42:54 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::9d) by DM6PR11CA0020.outlook.office365.com
 (2603:10b6:5:190::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:13 -0600
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
Subject: [PATCH v12 11/13] x86/resctrl: Add interface to write mbm_total_bytes_config
Date:   Fri, 13 Jan 2023 09:20:37 -0600
Message-ID: <20230113152039.770054-12-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6c40ce-fc21-4a7e-8c93-08daf57cd5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKbidA9dOVqg2j8sWJ7Vd8ZXNkbL7RyUmy39Nll0XNTVDqwvBu06EVkBYWn6FAXSGwBo31oKiCpWjatridFak0107rOEnC0q8YNVu9CaoIZCCRnUQLukbiqcxZWbeBk4d3FlvO3LvCRSw2z29syDiTVcPSp2En+Ag0trnTnDoMl51/ZjbKs/03lU5btNy/l1D4/Md2IqrqC1zX4ksT9atxSoIrWcsOhQItkgVhu2MV+5XTG7wubAfDbrB9tQ1I7MsAk2BzjB0BfNEhVLHM94beKQHa8Nsl5VD49gkvGN9DRmAjw/edkDiEI6OSc4Pvtr31CmW53mA0Qi+z6GY5UIVCgY6ZboI14/UA7AAznDRIcV7wV9w2oKGUQMHtehYBtri3o/NWybp1P/zOEooYPPdVCKzBjZv6QqK4e2K62expy6kXBq7wWaT3cUr+5Maf7tRCDIRJBJdJWUqhdJp5IxR2dI0PLWPip7zEGJ5/XL0SGt2x1ldPp9m18qYQyC/uoaenY7xVYQYosT3b6kPQ+uvKBLJNHd4HY/7KGaUNza3DKbYqsHfCSzRj1Y+4w0bC4q77vQZgW50pT3EbdmXmDcxVRhPsYwXRzENyYiUxdXE5LDVjEkihFLhgyCWNK96kJ0iBx14bWhgTdMmImEjzi94CJB4jxa6+iJ1Eja9LYt7tT8jUDle9dT3UtNEhFm2SlrKWj/MVR4AVnFLyKa5CnYjgYK2d80vAKZAA4z90TZIwE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(426003)(83380400001)(82740400003)(47076005)(36860700001)(81166007)(86362001)(356005)(2906002)(44832011)(40480700001)(41300700001)(7416002)(7406005)(5660300002)(8936002)(82310400005)(40460700003)(6666004)(478600001)(2616005)(336012)(1076003)(16526019)(186003)(26005)(316002)(8676002)(4326008)(70586007)(70206006)(7696005)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:53.6455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6c40ce-fc21-4a7e-8c93-08daf57cd5c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  17 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 124 ++++++++++++++++++++++++-
 include/linux/resctrl.h                |  11 +++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 28c65008fce1..7fe51488e136 100644
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
index ad3c7014adf6..03284a61c1a0 100644
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

