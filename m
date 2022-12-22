Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7F65495C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiLVXcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLVXcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DAF598;
        Thu, 22 Dec 2022 15:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBJ0VnHpEnyOyCtbfCE1F/MS99PBYGhpMwibCLynWKlCpO8FvxFGe0jHSMzq4wn2A8gx0mJh9wtIojfP5KTX5KxAbKLi2Me5yS6qJb7bbYJU4ngWD6vkPoM0jD3rMXBynGEHx0TFNgZ6OVjj0Pp0MTVX8RAyw5P24upy2CwLy/nJXbDpH0/sY7AZmgKbX3nXr3VUZFQnreX6++yVFK3tO+mxzryHMT4P8JcmYuyiXqBU9Uw3oBLfG4Xd5UGLG/yZdOq05O7zTH1aQKVFpcdYUuu9VJ0V8+67q5HDSNVospwAjGjFdMxHi/qypCp0lYIfxhLkxlk1LrPoCV2bZirbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC6sD1fOiCpAa9nlTbL134B2teg2PGji/kCRbEoEM6E=;
 b=gkNjE7vZUQBfZuWerJYBvVR99dbUKWWKFquzHsVEVhFUiO9k/a4dfXuVRbxPvfQtnO9zM08QfOD3vZgXC0maCR3EtPbSIONPON2JN+HNXgHG/aW0rphdaPPk9uNw6LhHXGCVisozl2jGspQ2yZkbA7uBL3rPvt0ex09vXGCZEw2lfuoWLPTdSwCljnx0Dj1Qw/0ZCrLriP+V0xTGmUm6pu/Z+Ta+6uLPHkGAYbNs7WIu2XfdcN1M4kOPdszTwrxcI306RVvFk4NsbykL3OWhKBscqfSerBJ4rXdQ++XfqdqabvV0CX4Zc3IzwXHYf8+wWa4D+h8zCKEjBRI336ljVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC6sD1fOiCpAa9nlTbL134B2teg2PGji/kCRbEoEM6E=;
 b=5WPsFI+PIre7kZ2gpzWW8PAorlGVU4N+0h49D0FbmC8gXCUixToi4mIMsWfXvfwa/M8nAgr8Ye6Iz9Vmae113gNvRii2XRXGK8TM1VkZgxuRlb1xNhrBtqZTtKyDjMz67h/zHmuXVMp6ud+x7w30jOf2JYKlF6qUm7+GWmGa2f0=
Received: from CY5PR22CA0047.namprd22.prod.outlook.com (2603:10b6:930:1d::34)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:55 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::82) by CY5PR22CA0047.outlook.office365.com
 (2603:10b6:930:1d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:52 -0600
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
Subject: [PATCH v10 11/13] x86/resctrl: Add interface to write mbm_total_bytes_config
Date:   Thu, 22 Dec 2022 17:31:25 -0600
Message-ID: <20221222233127.910538-12-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c003c72-3896-4b17-c003-08dae474b671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYX3ZshIZbCi3zZyx+5DZGWGqio8HYNnIr3ZfgeNXXpul7WO/zGAVeyBTcinuY0fLc7lvkNFLvcCKlahzZnufgmnMtRIaxwJ91PT6TsTX8CG08k/uqE+k/ZmmdHj4QBV3bo885M7YA/jag2pHZdZrJyk5UkHEfxor64N+lGhLVbUoV80LdJkxK0khkm/q7wOdHJSola1nHeeDFD+n1UgkaWBfgaph7FTBfQXK/Dev+sKFwVbMQOtsd1JZ0eMAeKL4Gfo8g0AvNGFs4KQ46MdAD7vAVZExM/CMTcSgyHNW7aFd+Arwaw6GI4CGcEOF52GyusI9pzgtdx0MnBDE6Vmbm3PJc/dJYQmTYuJdapopbRBPidhjIz4MX4nO0M/7tMnkv3EMc+WrkjpOFuw7LgEHa17LqX69tdvAF57W+9YNM7oDj9yll78ukNUAq+nvBf5ki8LoVCt64VglxU3c9H4lOgGsDg/9c/LGc5v+LuRn+FhWWYcfcvzMrpCcZq8/wM9mN+jZ7wop2YTJo7yT79hvyDEbdnUA+9piK0KLERPOSwz4cV5qe3kBiVA3XTb8VR9vJ8387NMAZaR74WGiACCIWRz8iynofk3YJfW+DEt+3ONLXDK8qiyYb8SlMh7I4RWkbiauyUjsSZaNWlUrIW2Pho4f1AoFQfkzj8GxFc7zfvTWw6C4UxClLin+tEa8LUXxlOErpCisN8gD5OXp8DTq1hA8HBvFd1rsZZ9XEgCaxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(81166007)(356005)(36860700001)(336012)(47076005)(426003)(40480700001)(36756003)(16526019)(41300700001)(82740400003)(186003)(40460700003)(82310400005)(26005)(70206006)(7406005)(86362001)(5660300002)(110136005)(83380400001)(4326008)(44832011)(8676002)(316002)(7416002)(70586007)(2616005)(1076003)(8936002)(54906003)(478600001)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:55.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c003c72-3896-4b17-c003-08dae474b671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 126 ++++++++++++++++++++++++-
 include/linux/resctrl.h                |  11 +++
 3 files changed, 153 insertions(+), 1 deletion(-)

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
index 43e2a866e8e0..acaf19f5d65b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1515,6 +1515,129 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
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
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] = '\0';
+
+	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1615,9 +1738,10 @@ static struct rftype res_common_files[] = {
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

