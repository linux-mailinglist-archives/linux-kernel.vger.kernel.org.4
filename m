Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDF662B90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjAIQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAIQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA45F43;
        Mon,  9 Jan 2023 08:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3613rWvBufUnlEm/i8m0PHaawXiplogb7OHSh85/pVBPXqijxFgfBFAYYkNhE1tNt8BkkdhrnfgGTO9yIuWNd4IOel7Ar1hYSzQAt0JOPTIhegk4t4ruR8/YzC3NUOO8AWTumglGX/I49LlmocQakEGMH4utZZI/mCbbuiTd5f/O8ysxIOrw5+VyRebiYJuVonPnPvuYROWPPt59SH/dziwvWvhnMpu8MBQomTf3jjt75gMBWXtbX27d6Y2AhHmzBL6+E1jDov8n3Wd0t++hNfPrG1Tr58QqOLJZw8Pck6ED8lM0P7/X5Om8ZOxWUAU8MmwtiFbTTI6mj2XjUkeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5qSfmt/4x6sqre59VT3Cght4ETaTpvKxvi19PY27ro=;
 b=oWSUV2lbVs227DLWebA053XP6ypwMdrwsspZD4k5PqznzR1cillstBVcwLmN4jwYBrj1mlJjPIpQ50eOJNRchoitos1JiOAIivuwc5pdtpjO+860KQpDVNwNeohmuSMI1VvLBC7JhYLvDyffgykaL/rDJj6tI1MekMEEFxFRoMu18gxEslmhKqbneDNvnFLxi8sBblQWeaq8QkkbThwhk2AZPHymNsP+YgHynorl+Nj+jRGTwEwbMnm66S+ycZ9FFzZBU/AVhLH2IVp31/K8+Ms6fQ0HtZCzrR7HHjr4oIWKuwE8iXY+sgZNnAc95VPDezEVEItOQYSXJBCa7sn2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5qSfmt/4x6sqre59VT3Cght4ETaTpvKxvi19PY27ro=;
 b=EEBCGlMYIA1VY3Rox9eYQ70KBxefcfn9ibuCzx+Mo3ZeI75fQ7K9qy99PhXSlFXF2eujGOFygFqWaTjelPHqwYJf5oQ9TDvZgb6RiZnpiVe1+4YTB+BV66kSCfs/hcicupxAvD2aLM8chrEGee24a73M92ehwTmyUhlu3pbTUOc=
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:28 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::12) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Mon, 9 Jan 2023 16:44:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:26 -0600
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
Subject: [PATCH v11 09/13] x86/resctrl: Add interface to read mbm_total_bytes_config
Date:   Mon, 9 Jan 2023 10:44:01 -0600
Message-ID: <20230109164405.569714-10-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b468180-7028-411a-b456-08daf260c653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gidmvX8FeRKfMheP9lKuRL/ol7d1U/K2WyUQ9wxo8Pa+5oj4sSvyf8K9/V/XdgsQjtxPcz3orYTH3sjDpdulskXAoDejv218U9zHPWhTXVVQeVrdcKm1Tq567ury+XT1NNcKZxBdlW1tvZz3aL+G/rpRPhK+N6eNsZlFNPVgJyynFsYug9+Bsyuac8aoAb5hukHkGtgFVzY2gYAmH3q8aWTEowjuDqy/NNxH4s/1gNrr3YYCqzLK9jNYlVKB40n+myxYPrd5Zz5xPvWwXTRTYJIyR6W7bq3W6NmZFqjMUt5vOhVe99CvcqTt2rFveF2vr+KlvT/tPJwuxTFODMK6dL1gmSp8EVpK4vfZjNMYgauJkdp6tQ6Ze2ahCVk6NRUp4WmqDWJr7Kh09b66I1NBhmC+MB/OecQGeLECN9XlKmmgJiGpWsFvqXUv5LY2UmL+aZndmueGphbrpuSE7MtqNmqv6+Eekc5c43q4rhZ0tiujZqsiDTw0FrKI5tVuyv5pGm3GBRaMbWgk+eJBgC1G8iLoqy3kUR+CbJth0cN5UDv2vawdL9FXBl+QDk7o+Ib5nEDsZR7kP6u2xtlAwyFv64BrmM6xfI1SYHyvCEKvkAI7zL2JxARzdBKzK9aYno2lgAP83xXkn3YQ9dkJZ5VgXsAKXT834qNNHUKyOkSQL/MVfm9tggVVKLq2EE7tHIEfmHQwXT1NE0DTWJP0DmW2ogxiGKyu8U2wMXRhFM3uyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(426003)(47076005)(36756003)(86362001)(110136005)(82740400003)(54906003)(40460700003)(7416002)(5660300002)(4326008)(70586007)(70206006)(8676002)(7406005)(41300700001)(8936002)(356005)(81166007)(26005)(316002)(7696005)(83380400001)(36860700001)(2906002)(44832011)(186003)(16526019)(1076003)(2616005)(336012)(6666004)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:28.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b468180-7028-411a-b456-08daf260c653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event configuration can be viewed by the user by reading the
configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
The event configuration settings are domain specific and will affect all
the CPUs in the domain.

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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/msr-index.h       |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  24 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 102 +++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e0a40027aa62..2e5f57c93605 100644
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
index 0605b04f1b7a..8edecc5763d8 100644
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
index b39e0eca1879..2afddebc8636 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -784,8 +784,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
index f34c70c7a791..d47c675a856f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1418,6 +1418,93 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
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
@@ -1516,6 +1603,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= max_threshold_occ_show,
 		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name		= "mbm_total_bytes_config",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= mbm_total_bytes_config_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
@@ -1622,6 +1715,15 @@ void __init thread_throttle_mode_init(void)
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
-- 
2.34.1

