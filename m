Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC96669CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjAMPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAMPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02282727A3;
        Fri, 13 Jan 2023 07:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSBPIS3VFkZxHTf4SmP+zj9txAQAwYgQTswurPnxaWwBAwTIJKorJonPE1vmI5SNtjh07/z2JGbuHmk8SHJhOIjgBqolmS93zru7w2klV9/vuHTyya4+w4Mo25KSn8iF58ncJ1G7zzV0Ewz4brNFrrmpwGFwgwCnPpI58tKwgrt29Ie9bo1zJs+WdaLDUtbVJo8Ldn9mtCBzAD/EQS1fLzw3btwJcef1Ex3Vy/ikwZUAMXdJKb83wjtsH1jON0ZFge/2p0wZnI4WCeiTCV713apksuk0DjYiqWzuHeTbElIQpg0e5qD+ddYhLQ8ijjIoyef0cH+2+gGTtSDqQIV6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUMDDpsVQcPoPnCXldW2QX1LhTDRJWpdhLgmYDWInFY=;
 b=mezXCo2KrSG+mh4pErb7dCeJVZHjfufC22bSIIsBGqxpcnGQuMCv47YrJpKnrdxdaFAhaYdWFOcstRy5y6p4UWB2fXb8ReH+s4yaZ1smtCVVvRwDPRC0cByZdWK461nFIKuAPGtU7brem3Z5Mt/rgPX1YX6wvnXwVsFax9vtlGjYJQbJs6pMhb+IFzwxwSW/4KidUh42DPquBnW48AYh9YfD7j5tishqnjIOEObI7/VXMqHQ8GHAp0FZe0HBFMXkdwykDG/jVumtoE9qkA4ksJDKmlWfoSn0eu9qtYnjKXK5nnbcNCg9FGQbzLE4KG3HXwBrgVlTA4xbM666fHFe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUMDDpsVQcPoPnCXldW2QX1LhTDRJWpdhLgmYDWInFY=;
 b=PQDCyR9c6ZF92aXlOm+V9yZrVm2MtRvFMdPweXE8t7QC5Nm8JqjmjUBiOi/q9uhcN3nq3Lr5zmOEnb8CZ0uzOtxitAL0oRlCeMvlcVm/g6kDhqQBDDctZrDsN4ywpyNSCnXiAuOLXIsPyEO+NR3xe6YirBqf/DvgqeahtcnNU/g=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 15:42:53 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::28) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:10 -0600
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
Subject: [PATCH v12 09/13] x86/resctrl: Add interface to read mbm_total_bytes_config
Date:   Fri, 13 Jan 2023 09:20:35 -0600
Message-ID: <20230113152039.770054-10-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 057eee94-457e-4af4-a72e-08daf57cd559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YweNs/MyUlg0rRqAfiVeNPxICL2/7EZll1ZUQh9eURJ6jEpcF1snvXLezQk9IL9wD1FwB47XLpmzQ4g6Q1RSJ6M2mNYUbkeXghMeH36EALdm4D65+737QnhkQHJ1Z+7Vd/ayPdvWFtggA7sNxIDaLpF7mbs4yXFamOc9NbHoinNMsbSJrnrm/xUpd3CnpgQSy8SxFVtW+CAKGriZFOPDlhP1RYjZQzO6f/RFOUsNVTUqNbePqU2JfiEGrxQ/E5N4atG1GSX2Y4OhTwrNWax1xJHVNJMOpxMeHdwTI9m5ixf/ZXZsqy0qmt/or+g25Bxya6WDUO7TozLRzNd+Bb5gb8m0juFhYqsFnzrGpDna5gpLs73KkTNMRYiBQ6DSsT3LiD4vnleNtY6lXSHgS3UAhPNDkvlc2PgfTUHD24NT44z6EHoPXRd6d6sWcEVFty9dHOnsk5CsR3KT8F1qaoMzzBp8q/rWCXtE4glhWgatfhi+X1gRWMLeB/Rzf0qIS/rRUi7j49KVx9myK1bY+huofWgAqo1nAjMFr52OOXeqC/lslcK1o2lDL9UEtwkuZSj6Qi9nHKOjoVSBa13Sl9Nr7UTrTRM+nHPVnjn67y05kKpgdvE4cAgYmtUB59mQvx6/f27q0+8XYbrHK9+qSTXq3iDu7LwN0/MsXge4Sew9JnhMJE5ffYbtN3d/kTiCQQSNoVu0d0uvUja+PuGaOdN7L79vcsdvh0T7DM2RAtjUpC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(426003)(47076005)(36860700001)(82740400003)(81166007)(86362001)(356005)(2906002)(44832011)(40480700001)(41300700001)(7416002)(7406005)(5660300002)(8936002)(82310400005)(40460700003)(6666004)(478600001)(2616005)(336012)(1076003)(16526019)(186003)(26005)(316002)(8676002)(4326008)(70586007)(70206006)(7696005)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:52.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057eee94-457e-4af4-a72e-08daf57cd559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
index eaeeb7b415d6..06b64f4050ae 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1069,6 +1069,7 @@
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
index cf7b6e59fa29..0ff45e34d83c 100644
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
index bf0bd4378e13..cd4e668e5019 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1420,6 +1420,93 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
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
@@ -1518,6 +1605,12 @@ static struct rftype res_common_files[] = {
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
-- 
2.34.1

