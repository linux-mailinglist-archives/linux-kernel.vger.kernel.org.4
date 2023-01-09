Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA7662B88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjAIQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjAIQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652DE0DC;
        Mon,  9 Jan 2023 08:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAfiWBN1MLi5jTID6+VICULCBzf7ZZKeF5yc2RTDNy5uNuMKWObFUxUA3hAUF1+JNPxcFvmA/M0UsWVbPH9pg4MuPeS115lF+Yr3fCVjedM9RFCSDzVUmFLTC17g7xhxGhZKQOtqSKZEnE64T2QzO2XlvKAZ0v956s0Q+MmTv7g8tvEWBeCIyoRuaK8ninbeAK8XxnCodeA7y8OVYXoehxfSBrudp+TkDkhqo1Lb0Mk/Zm675qGMwc6Ma86G25HC8sngbA9zrpxD1G4OltvkYil5fBFUyzTtDTGkEVpYpt1+EUam9RjtmTfpO+JaXZv2Qd8UQrf/jpOvZdZHhkKUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2uEUxX41ZlmL8yO5lveogj9xZ7JYR+w1/cxisLotAI=;
 b=JK6Pe0QeOHKpqlC56KjzdqoiyUC4lFQCZ6BbzapNsDcEBzw/tUjE3vSeAZCBPRA6uVCOUEFL4YPuVe4a4gAqhpsnfDV4oKuQwak2iAYeenZbwkNdrRkaZTxlYnmgw63NQhWgQoPs/2Vd1DC7mxhVWjtKDjhDbmv8CykyTK0xJJmUf+pJnh80fHH/6KiO/l9wGttcnbsjEJ3B9c+Qwq4LWD1SOR9N5V1yVv658xpx85LOkf8GOfdxQfa8PAknUV+/Q0i9jBFMe+mzgQVVxdKT8SF/k/egs+VfRb88mbsXDv7dxxfGZXzv3U5PrEfzDdP6e2tCTEzcxNFn4Ht8SAt3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2uEUxX41ZlmL8yO5lveogj9xZ7JYR+w1/cxisLotAI=;
 b=T3MGwFaBDu0JA+SbWtIUCK+6QzH0oKQPVLV7PlAV5cVudST7g+Gb9PI8ZHPClw2Ve4MAo9ZV85GZ6tpZoKE2r19rFf3ufuOWzgdTqBl0OwzVpXeuETa4HLqTEZP5/couHapK2hRaFi3D1vHK+M1KNpZV0na+wbms5P0zisX+xBY=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:30 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::75) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:27 -0600
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
Subject: [PATCH v11 10/13] x86/resctrl: Add interface to read mbm_local_bytes_config
Date:   Mon, 9 Jan 2023 10:44:02 -0600
Message-ID: <20230109164405.569714-11-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 05948bf8-1f51-46fc-241e-08daf260c749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPYjEUssdF6k+9UnCCKwP95EeJhVkMnOHEjColgzx6FZsQywkHmgySVyXG0AV6MeK4aogpodNIsn1g9T6QReYi4clJUfqigp5/9kfxnCC9p5kG5wWwZHmu61l1Wt+fgy1YcM+2qVv9P9Jj1WAoBWtgRX4HCgXOTEqcZ3xcjU/9BL+u9GA4f77gfzinbX8BD+h/V5mqs28fpneIBl0svogcZXinJsuoVXhNHGMJKlGK0HP31jrAtWtKUxrKtqAaOI3eyfm932+44o84Ii9/S5YRm4pFtgqx6yG/CR8zNefXgV1TIySj/jGu4QsXAAe5XM2DUIm7TpR+MaJ7NkcHskuKxyf+OlSrU0PP2WHuotu0CcdvHemBH+V1u5sYgMuhNsylY6GgtivBCL9fCWDZzVX5/c+uhG/EYNq9udegt5ozUmYl45qhhbD846gpEzB62lsO5u66enFexD1n2pYJcgGUH8D1q/f+gdH+x8CGBIpY43Cz8QFmOPuFWDc0SbNpfm92+aMqDdneVG8UbhTgsZGnSCWneOSaz0cN/ShSD3K2ebpgzHrdqIB8j75WfxRi48QpgpSkFEw/HbR86yZNGqZpx+7+htWndr9YE30DhZb/H1g1xtacj/umGUjvR/CAuDZjzid9eFYHnytiUZAZirr28FC5QVdPO2VBPaEsr45E3Opl5vZhVv726o303sZFEK8/3ddmoADCiFwC77UqoiqSrmedRIETkXbT93OZ1HsuA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(426003)(47076005)(36756003)(86362001)(110136005)(82740400003)(54906003)(40460700003)(7416002)(5660300002)(4326008)(70586007)(70206006)(8676002)(7406005)(41300700001)(8936002)(356005)(81166007)(26005)(316002)(7696005)(83380400001)(36860700001)(2906002)(44832011)(186003)(16526019)(1076003)(2616005)(336012)(6666004)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:29.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05948bf8-1f51-46fc-241e-08daf260c749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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

