Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB56F654959
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLVXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiLVXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC962EFAC;
        Thu, 22 Dec 2022 15:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaNhna5z9v0binM3qFf49zf+i+IZpp79KDybLy8q0Utsstp/a1HDyy6IyRdFZylB54prxDZL/gmbEwPmJUMCzW8McgpALFnSvXeLbpByL/yCJfCy+VVpXyOXuXRBeJRrF4FrMndhBpZ/WHElFBsU2A3+xEBoi43xTJvJYV1dRd0YWUeijHIWHZbnCoaGLvj8u+nEfzj1kMisLiJXFe31XClAifS/t5aD5P5jErnb9URisr14C/KJoik4mOQN2ZP67SwxRx9Q8J3ddTybrTsKSAxBq1YA6PmKcniA871B2SEOiLoTUT72FH8n5OLHXjm8eB1cmXh0N0szdPM+TETyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0bR2q0emfUDh7SYHWelwMKwpBqpUM7KkxYqPZ2X+e8=;
 b=XZIh7+pNAA+ezVEv1M4WSShw5TR315UR/gGnfJNpXZj+d8THP690Y7ZwJGtdUW5j9vn+RlZp4VJSJGgf5g/F8K60KpWCS38Dltg79WUC6310O5qX49gifPQRVvp7UttXr30kcU9dcYQKo4tAQF+ndIuAKMWQapl6+pQbACEv9gcYQB3hwWErDlIln1W+NV16Hfv/eq16jGk44BiC8AVCAyZx/H2tEkO4k4TziYZM8W2/dbYVPgo0rveist9c/RjpgPgj/CDRgRk1nFwNRcrTCIADBsQQp5hl9jYq6tc/RyIPEwwJyLvitvR2GSGmyUYxkrfASWVVQJtvIPPeRWwtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0bR2q0emfUDh7SYHWelwMKwpBqpUM7KkxYqPZ2X+e8=;
 b=bWbDAwd1oMKtiDvJQj3DeGHvswb70pnqG5aWoo/1UHhVSLNnbreVDmNNRmI2MCnQFTUmWpJ8mSpR1u9ifoxamPpEAIqC01CRBQTVs5AGeNhbrxA2e81leRwWZVvnxx8tbbUx8X7uyx+mBPb8yPZv1Hyrg9tp6WExOCTIE9yEbsE=
Received: from CY5PR22CA0035.namprd22.prod.outlook.com (2603:10b6:930:1d::11)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:52 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::15) by CY5PR22CA0035.outlook.office365.com
 (2603:10b6:930:1d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:52 +0000
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
 2022 17:31:47 -0600
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
Subject: [PATCH v10 08/13] x86/resctrl: Support monitor configuration
Date:   Thu, 22 Dec 2022 17:31:22 -0600
Message-ID: <20221222233127.910538-9-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 281d5a03-3ad8-4269-af75-08dae474b47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfpQdnO7zOzFkXEOQY9C/rmuCNmCrBrSbEKU70KxaqeEhk/19pwdyuUKOeclc/Hiw1lRtOlNC1rtnC99EynlBwxT6LuaW3dVSzXn0zVQxhMq8Uo8eTFn9ABDlAWzDKj0vYEFqhuPFJmtOg6BOO0vbAg5kkny58cBDDX9TP/1jptg1DWR4vKtUx7gwSeVrNlT+Lm7X3EN+TBQUVe2zlNoCv6mgQAUcf4GBbcz6qEQ9iaYJwMxv2wMhlfFnuEfuL5Bu+wzrC0o32s1qeOeeTzQAQpe6U+fw3UBB0hnZkYWRbLBTcS/4EbWHK+aFyq4rvTSC7NOHEC196qn0sAvCvUiG1+3+2aErVIspVmP/VSMVrM1Btm3oukvZ6C90VxhD2vSlPjHG4T6Gnx4ogDdQyw61salJUv7KLakhlIqYJq+ZtmuBzplUAOK41gGPuQd5+upp065W17NqhFEnTNxRIv5hScFlYw0bpOe6jDovbjuvlSvMkVC4TMFz3q/CjQDwwRRIsnqfD0l2GGRPK8yJAUrYFVf8qhQ4zDeRHiXtoflL41c1Glp9IBqmU/IXLR4YQ+nHuYIYBPQpbXLIf0eT7PbrfNsOpgtJjptjQGRqrVwaqxNVK/bzmQvhpRVqRGYfBE+h8176G5KwbB6i7SImFYvvwPRNu/Ov2eCePlBXrH6XPZ0fESPpiYPff0SI68BDfSm0W73U/0LTNMeDwAJlad6bwWIRkA6htpb0ucRMFKdc84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(54906003)(316002)(6666004)(36860700001)(110136005)(70586007)(40480700001)(2906002)(426003)(2616005)(40460700003)(70206006)(47076005)(86362001)(186003)(16526019)(26005)(8676002)(4326008)(36756003)(8936002)(44832011)(81166007)(82740400003)(478600001)(7696005)(1076003)(41300700001)(83380400001)(82310400005)(5660300002)(356005)(7416002)(7406005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:52.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281d5a03-3ad8-4269-af75-08dae474b47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field in struct mon_evt to support Bandwidth Monitoring Event
Configuration(BMEC) and also update the "mon_features" display.

The resctrl file "mon_features" will display the supported events
and files that can be used to configure those events if monitor
configuration is supported.

Before the change.
        $cat /sys/fs/resctrl/info/L3_MON/mon_features
        llc_occupancy
        mbm_total_bytes
        mbm_local_bytes

After the change when BMEC is supported.
        $cat /sys/fs/resctrl/info/L3_MON/mon_features
        llc_occupancy
        mbm_total_bytes
        mbm_total_bytes_config
        mbm_local_bytes
        mbm_local_bytes_config

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f16b8bc5448c..0605b04f1b7a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -52,11 +52,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @configurable:	true if the event is configurable
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
 	char			*name;
+	bool			configurable;
 	struct list_head	list;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e33e8d8bd796..b39e0eca1879 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -783,6 +783,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	if (ret)
 		return ret;
 
+	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+			mbm_total_event.configurable = true;
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+			mbm_local_event.configurable = true;
+	}
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aa469d708991..f34c70c7a791 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -996,8 +996,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = of->kn->parent->priv;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list)
+	list_for_each_entry(mevt, &r->evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
+		if (mevt->configurable)
+			seq_printf(seq, "%s_config\n", mevt->name);
+	}
 
 	return 0;
 }
-- 
2.34.1

