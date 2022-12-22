Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259EE65495F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiLVXdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiLVXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5826134;
        Thu, 22 Dec 2022 15:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDfsSj0K/bkp0UF9pnLt/oxlhXazpHA1iupxAFuvL2mM0QaRW0pBV7hz5sIbjcxenWhQySWTEonVsPNoRyUpp3dwNzhgMDspltWEygdxUhB8JYgJBk/27eX9h2xz0h8yCEZaCQZWSzFeQEuhdErER0CguBMe8CpjTk/qTcR1MYbgKiB8sjAlcdcBDUKlDdQkYOOgdpSKQrrjeNxMnBNRi6r7mmHjcP8S6mdSHe01GdtEdbIuet1Z0On8LXYuGGNnIlPN1eHfni+vyvh/PQmFIdTBiD0H01TjHLES9SJPrUdFKXgw6onUX32mLVWOrA5WrOOejzZmh0eO5wjS7glvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsCivQcGv4JLPLz7jgxt10bk+C/gCXTn2LGSP1mxvEQ=;
 b=I4E7+Nos4xVdB284i1u5/+XAn52pQkFZEjl5fjib0h1DwZnj/oScs3Uef/xsN2nFr0VIydRylUnBslZlFd7OHDY0yUlmrLY3Kmv5i1L5rLb81MgZCg4me9hpCo8D/5Xh7qAtbE8VmbJ9ecjbBLmJgokEBRhtyRklFPchv49MCSzartBdOAMTedgpFRnfDxtghNxr9qY/y3h7PFJiCIrbVz0HSWwQwvYpJdARsIQHBIEX+gv6XwEBjx0YZZctD8RJ4T1/yWSsHQgO1xdn0DhSLY0RqmN4Tdy92Jab/fT3JlBQ+00GrB9cpUp+J7+/m2kOJKl7FmM/OfE5wWulBMxkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsCivQcGv4JLPLz7jgxt10bk+C/gCXTn2LGSP1mxvEQ=;
 b=UDOIPtn6inXjHeVDTaEPzGU2bDf83WL22PW33HuEvu9+fuK8jy0sBw0HPmNvmimccdYWtqkjx+agJnf9x+N06iOCLXwxULs60Y5l9PlK+Q315wdQ5KB+/2T+KBnuw25nZFGIgYXaQskxL5a1HNTH26W4cbePAnmN4Fa7IEoD8+k=
Received: from CY5PR22CA0058.namprd22.prod.outlook.com (2603:10b6:930:1d::9)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:53 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::84) by CY5PR22CA0058.outlook.office365.com
 (2603:10b6:930:1d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:49 -0600
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
Subject: [PATCH v10 09/13] x86/resctrl: Add interface to read mbm_total_bytes_config
Date:   Thu, 22 Dec 2022 17:31:23 -0600
Message-ID: <20221222233127.910538-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: deb7707c-4d3a-40b6-5cc4-08dae474b507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqggHbmcVzM0F8BdzgWo26na5NyDVVsEyF/+V7hYhrwuXOoZLKN8FO5bkvXdNo4qPB1Z0xoMuyAGDVtkxzWgo/eKEx95CK1SAwes/hFhLa60fFBIFUzh6qlaRNvLres8cXC7ANcR0m4qsWIIDzpJ1md9kRl+BaYjkqs5/e+l+hfbxmQTdv+B27cMvFWacN6SO59/QyG9LQJzv21lSxeYC1hGx+fkLGwcUPmVy7FGTZNL2mZzhAInM4NHstXZRmPq0ZucwRl+L8l3GGQ3+N6xCJNwibyPTQSNqFXCGhqJi0EmdBjiXPpdj9xmU5+buX7WG/fQF40tf5Kps34Rj3YXgQCZujSSybqdBwpILNQL/cpkr4+xLKEzT6laCEvBuBsM7c4MsKilB6PE7mcau/ccqmA0qz/9A9zv7upy+IYjJ/nDc0r1ltrcOVj8RP9ipeph2kIR1euKBkOxj5eAnKMQhpenTsJ+6sfMeiqGErCqfTCHI5mD3FtzS6j27jAkArLRo/zfmq6XXsROrFn5XpCOFO0FFSXVzoJ801N4Q60RgSysz9SRF00NfVgKrMujLo7am4eWnZ2AqrsUjKgSE6yTH9Chma6EHOekk9p3pqnKh+5z0qHQ8jS3M4CD83FQtPr/YtZ1kxo0xcLNEsl42v+ZlTFQMEqsL4D6AlhUXhAbk2n7bJo+QToHGrtY7rBZdxU2ULfWnWh68/IPDR/Gjetnb9DItHNwwSeM/Att3T3Kcsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(36860700001)(41300700001)(70586007)(8676002)(4326008)(82310400005)(336012)(54906003)(70206006)(40480700001)(6666004)(83380400001)(356005)(7696005)(81166007)(82740400003)(26005)(186003)(426003)(36756003)(40460700003)(86362001)(110136005)(16526019)(316002)(1076003)(2616005)(47076005)(44832011)(7406005)(5660300002)(7416002)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:52.9281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7707c-4d3a-40b6-5cc4-08dae474b507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
index 0605b04f1b7a..b2fb09d54f16 100644
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
+#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
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

