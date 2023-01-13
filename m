Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3518A669CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAMPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAMPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:59 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789077AE8;
        Fri, 13 Jan 2023 07:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwSM2RY4InuhR2crlwyeKJpD67djAJNmf5WaAnFT7/wVDtwWKujT178cP+CfYME9BTKZzJ5nqdakZjpzzOkgdzNZCvDMstgL0cZRqMLI0Qi+fZsTBlyTgg6d1WIwT8bKFglnR7++Oy7hXhur7Zt342O1zC/4nwil/oM8KB7PVbxiHLmeN6dS0/NVT8tGV6XqupE57I3i60Q8bJlwhqOx1jwo0daeK5nfmxQ8/HNZEezkFEH8bxYPmXiNwRhS/ejjN1Qf2fKfW19Tn12/cd0c/GoX/zjRuabO2B1MNlsc00VzjfgWyub34YKd6YH68gp9Uz3CUn7vcL3CagjMCeDPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQNTH4Z2Sw0lgrMlDRMmOQNP2fkgpMeiK7taVTU/oGc=;
 b=O8t3eMXgGldQ+fJ0ozIyKaQ+76excW2tZcoSQVGrhBeOMbr7jX+rvevZCSL/M7pkj7ShpWOOPVPuQjZKPEP+cOyFmHv3N2M1g6y6ci+nZbGodWhF0aWBpZh4fzmPE2a6e2Ec04aOYJ0EFAMxFj3AMwk7nmz/aAUraFPz3hmYNT2JfziuWw6tOQWE6O8POJZowLzSwlKxTKEQTM+GuIUlvDOaSi9kAJVEnoQVlcY6dVMlizsWJjf6hi6ajXXEX/40tobxbqnMAC63GhfUvGr9NXxmjKBdSBUb1025qSRfXkwZPgxHnCNQO+KKcsdikkkUPQBs6lK7h2QJ00QhQ9DwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQNTH4Z2Sw0lgrMlDRMmOQNP2fkgpMeiK7taVTU/oGc=;
 b=cMczKoWvKc3U6ruVh5fgpzi8hVxcxHwYqw9jZl68DkacdDymt5aevWxDG8CuUaksFFZ+bU6nMrmcUAnOBCKHI1Q8R84+XKYngb13cSyJaShrD4Q9ar8fu+cboVbogAgI+6oBhRDBsNjd4+eamxDVjbVOh76O6v49tSNn+3MawTQ=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 15:42:53 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::e3) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:11 -0600
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
Subject: [PATCH v12 10/13] x86/resctrl: Add interface to read mbm_local_bytes_config
Date:   Fri, 13 Jan 2023 09:20:36 -0600
Message-ID: <20230113152039.770054-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f04a65d-55d6-4861-e0e7-08daf57cd584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ci42xNTibkAgEkpqf5nnV1k2YzT1QZ1UtIgu4rcpE3R/ocqG/lW9XYUnFlY6W1t3I/nm67k5rPu+nkS1OmCxY2wfOuWy1v46UEDuk56WNytX9SoL3BwK0sJelOBIFA9FPbvsQqBTjENmqzt5g/VC+5rCbXThwkWqSYB93zVlhEoTAoFIOLUWUd/oFVtWBIYSQRnpOW2KexUpfR4QO0ZrWc1lDwxHU11gB8P2b/6x1X4NQSXAbuuxzzCysqtcV5lYl2KKjZISn6HZPZZFttbQ4dM1/IGIt8Ifj8DQN6PVc8ez5Gmare2k0OS3baRObDaMeSztTmfhdvwiWcJlZxdh9zUu8TJ79gectXfqVLfvldx1Yla0J5RI+TfscfGyXKtpyNwT1Lp48Q+Px2PyoNOvV0N7Eob3FjpssrzcoyO3lqWZwA1mJYCBGaaH39dF9HqqYHtvWU2dX5L8xtCGlHIEtCXrg8H+9pwsxsf6XZXN+z4OhRCas+b14sS021KZ5lQmLRT2sTjJvjpwQ3mzZPJmCYYO6KrKoME6IdJsYsy9/xMXgRf4QjOX3Kk/+R/9ri5rGyoaPtFT/NhgDmiNAyRo4IxfZkQxnIqEc03ECC4VL5s4yLNdj/maf8cjYy70aOi+d9wcunh4x4j41K5PhhGrO87pQK/ZvPp6/taotCld2HtL3uTOU3iBEOXFA9om106pQwTghWuaSd3GIv9VvoFnzTN9W0tqVBhkI6ZvkJ7TTDE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(110136005)(40460700003)(5660300002)(7416002)(7406005)(316002)(54906003)(44832011)(36756003)(2616005)(1076003)(82310400005)(36860700001)(336012)(83380400001)(426003)(47076005)(7696005)(86362001)(26005)(40480700001)(16526019)(81166007)(356005)(186003)(82740400003)(478600001)(8936002)(8676002)(6666004)(70206006)(70586007)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:53.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f04a65d-55d6-4861-e0e7-08daf57cd584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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
configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.
The event configuration settings are domain specific and will affect
all the CPUs in the domain.

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

By default, the mbm_local_bytes_config is set to 0x15 to count all the
local event types.

For example:
    $cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
    0=0x15;1=0x15;2=0x15;3=0x15

    In this case, the event mbm_local_bytes is configured with 0x15 on
    domains 0 to 3.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0ff45e34d83c..28c65008fce1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -805,8 +805,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
 		}
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 			mbm_local_event.configurable = true;
+			mbm_config_rftype_init("mbm_local_bytes_config");
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cd4e668e5019..ad3c7014adf6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1507,6 +1507,16 @@ static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1611,6 +1621,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= mbm_total_bytes_config_show,
 	},
+	{
+		.name		= "mbm_local_bytes_config",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= mbm_local_bytes_config_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1

