Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0265495B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiLVXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLVXcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEC303CD;
        Thu, 22 Dec 2022 15:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+f/LWTr1pE+R/j8XBKyQLeUA5fpTO/llOrTB9nniIAmgM6wOSFJxdzrFUzROOxXpSIZ3OT8UjQI0mYYCgMWHV1GwztIPyv+6HdE6I2685IXWRCV5HuV0ur+vS8PL2+oORs4ovQax8kY6zBmt6eaoMR3VNRPLhBBUTDMQBb4+xBwVIaoQgWOrQar/SsJfy/RjI4wGLskrRNiuL2kjxpnawzjEw5Vs+aO1cfkm6sTuU29Gcx+mJnM0rvRkdtEqNwEktad4u3gkanEbg2T6qAYQwy3ayeSzvT2tYmHq3mscwHMQImb3RQV1BTmoRlFHuU+CKs9C0YXtGNERAyHqF/TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2uEUxX41ZlmL8yO5lveogj9xZ7JYR+w1/cxisLotAI=;
 b=hD4cSde3Yh3QJrItLxvQAXMQq81unXjtjWq4sd3XLwBmHiFaYzFrAmkZ6Qdk0vU9ACKAJJFof3rJ5Q17z1wbqp44o/uUW8L7WxMeUK+W5PWAbZO7oSM6AQ7fbF2XGP8Foq+RTJsExFUOdq5OwMRkfPeDee1a/R1f2hwMHgM5IItinX54ne0jUafjiupmUzil/t3sC0pplj7vlhrAKMoKBd4JKWHW9b9gjQFZkNCfsYMGsQS0xmL0JSbEDRG4VJ0/0671L1c/gj7HO1tpqUaDd8Tm5bokRvnn7icSgw9TVUYJODv2SU14j3x9TDi+AAJoHaKQO7LEZBQa3VKIzAaPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2uEUxX41ZlmL8yO5lveogj9xZ7JYR+w1/cxisLotAI=;
 b=c6PN7FOOTzLcbKcKxbUTUgz/2KbttsmPUEOvVlvbG1Grkczm96gZfB+a7HF87DHxb6vs/MhVWngTLIaNl6kgfW5zgC3NQqf2HYIsxUuoHs6M7rDCj8JvQlNA5cfsryafOKUgHphVSU76tNu1Z+3YQbcZYAC80rrwgMJeFLbv0lA=
Received: from CY5PR22CA0036.namprd22.prod.outlook.com (2603:10b6:930:1d::8)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:54 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::65) by CY5PR22CA0036.outlook.office365.com
 (2603:10b6:930:1d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
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
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:50 -0600
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
Subject: [PATCH v10 10/13] x86/resctrl: Add interface to read mbm_local_bytes_config
Date:   Thu, 22 Dec 2022 17:31:24 -0600
Message-ID: <20221222233127.910538-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8084fcac-11fa-4e6b-e09a-08dae474b56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RQrqby/xZRLIPA5GrGFRJAkEIai3bYBVOoTTumOaNdq8A5zUMC4S46FYSEK1WhmM+WhgXwU9+jPPD7XHSEVy5o/GxSViJVH/eZ2X8ylAhxnH2+/EAUxV8IZU03gMAcXms87KaXB+s9Fy35m8Zma4MoaK8+CV9FmnqTxSX3nEEX09YeFUePLmvqm9G7RN5chonV41l2nUmuF2NudtIiwHF2VgqIvVsQtF/C6MHUzvYEV0/PM390MBrC4uhf266RYLDcvYvDGfNn/QWEIMQ+JdsoWxxQZ9G6HmtSnIvDx+IN31GPs9H/Xawo3dBFiDGcbvTbFGiTs0ns8V5mDVjq7uI5lE+uzNOKPv0by1OdtVV0DBI6O/tDwUX1Qajpdb3GfR0odke4HoNxFOzrfULjEvdxR1OO9Hr5pfsP+2vxND5WMFHRV5BHZ6nIhjSfHaE2Y11k5GTMsz371lNs0byHAAIMnRI/Orn6G/Mek8p8AF7PIBUq9ljEduwcD1310fLs1XgnIZ1hJSwDLFb8zTo+nhQG1a1HHEabOpoIhBgCyKlD2qEVC23SbFZ264idtiiYQNSDjitK4jUMsBc1zNMW8iM+OI8tu4RYFf90oYIeILW3/AFivB75Opy1Scpd0kHXNjs+hy0o7ZNVZEzAuw8YsbUdDzdwALlY3Hj8QTaMgBn8SvlwlJbJzNm0xdpEaMTv7WL/o4V+8VIulyKby/m/hpaKeaK1CNhGtGeAQvocaBoE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(316002)(110136005)(7696005)(478600001)(54906003)(6666004)(8676002)(16526019)(26005)(4326008)(70206006)(1076003)(186003)(2616005)(70586007)(47076005)(336012)(426003)(5660300002)(7406005)(83380400001)(2906002)(44832011)(7416002)(41300700001)(40460700003)(36756003)(356005)(82740400003)(81166007)(40480700001)(8936002)(36860700001)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:53.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8084fcac-11fa-4e6b-e09a-08dae474b56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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
index 2afddebc8636..7c8a3a745041 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -788,8 +788,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
index d47c675a856f..43e2a866e8e0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1505,6 +1505,16 @@ static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
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
@@ -1609,6 +1619,12 @@ static struct rftype res_common_files[] = {
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

