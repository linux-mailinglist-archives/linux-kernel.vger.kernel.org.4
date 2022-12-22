Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C0654957
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiLVXch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiLVXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EFE2EF97;
        Thu, 22 Dec 2022 15:31:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNU8vNYt+FeMCbOp0JRVT9ipEXgBEs/yUk/kpf5grjmhOu/7LgfoGh+CJkMgW2P3Sz2WrSYXUXYiCewEGWAqGIcm29PnexvgbFTW4XZJCbVgUONfoBQlLVZfdz6xa8pYdkE2knprlD6WeEyUasegMIp8i07zbgWQC5GdWC70fAR0F0n26wjrzd6DOdjD8KZFPGYbtP90zuhRQ7+V/Z4lLzHYJSj274ajch/zuj5Iz/e2X3t7Y/8/xuS5NNbdYz9TLkl/p9syEypcbV6xDjOm35v+HjmmbpFKEjTX2Ewf0Sijab+3gZMV99G0u3hLcJ0g3LaotJAo8xv3iZxOduoQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa6/5e8Q+ea0MtrnTFyKe1Iypqb/yKY9UhedJkMjOdQ=;
 b=V88ZCB88asrwmJg4xVRb52p0ZopmkI0nS6znLJq7uvfURanSp9HO5wFtThfXipJDl52EOQHLrJG11zkL04GgH+3uNEIicUemJIuocL3EUQyNyLq2u5zvIMKLRcjOP7dQzSjuU1mK98A1Q/zJY8sQC2Psldi9KN49KPrIiP+T+BOr+JKusj1lwnbXxhR1aTvnDduMVuF+/LSEeSVlAwbYsxTUxFoQ6hVHqWa+R/TY0fbBdxrqdmpRuMqoJhpD9cY584/mVDSxYJVWCZClFieDlwLz7IdwcSW1tXDSbsaPeE7IqFJEyj6bB2Kn+WQNEXAHu0mp3stl/XpSs+gEzmBUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa6/5e8Q+ea0MtrnTFyKe1Iypqb/yKY9UhedJkMjOdQ=;
 b=A9LTZ2hjTlNuYSLdWazYpS+17LaW/3czPZF9N0XYsBB41fcedKJl40Od9ga/bRSmHpvsBwPMMA8SqROfg5tq1mdCtXOs/sJPA9p4OU8ycWYgzWDOOT/ewau8mpfDikpiuX1aWQEZIgCAEhpClaBWbMyuG+NJHOY87ClqmI5MAzw=
Received: from CY5PR22CA0052.namprd22.prod.outlook.com (2603:10b6:930:1d::25)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 22 Dec
 2022 23:31:50 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::49) by CY5PR22CA0052.outlook.office365.com
 (2603:10b6:930:1d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:45 -0600
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
Subject: [PATCH v10 07/13] x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()
Date:   Thu, 22 Dec 2022 17:31:21 -0600
Message-ID: <20221222233127.910538-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 84898b30-47eb-413b-8034-08dae474b3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD05j/dHHUL5xns6Z5EVB9Wp+U/9laZa+WkNQguEVuanmNMmfEeH4TtSgNlq01d2CaTreCSE3eDyCksPeClZtmuXetPVMgr22BWDtSU+E73dBjisO43YXBcza803rFezfhPfBSZqEF4SqspNum6e3fNlM0I3ak+LkofVibLVRk0rvdNbOFjCo97S2lV5+Jf+hxb/Y/15qPTTPFyseBsjREok/71RMZFF0aJ7nRH73Bno0AVB19zlt7Y/iC7rb12lsvarFtz9deT/5ZDNMBmSqicYZ9Ty5H5hm6WJstTokLdatPF0wp7rHKFKFT3XKLzafpNqAUMGepjX/hosNtFSqpxxlLBO3ZpjFg1CYc3uqscqFTryb1YoPPdIoQ9QGQrzYBOs6NMl4AY2DSmaC2ZXLD3eM+sJJxGOueykg8D7hbo1umUoShhgY2NKK9+SneGFufOnOyD9UJiMzd/oe4Z5Y3LUtmcE9i56i4D2si7pz+6Rk7/qKbJqXYHkSwihKfkFqTNeBzIFPgn5moMFMSaG9SSgUkebFCp9nrosxiuwj+CsVf07ETx3J8CVSBGlgSs/tdzxcgwqZfVS8vOSrJGaLc0WWEUW+y8tr6J/yrKWBDDHyzsHB2jyofrhcpTxDvOzeEbI9cUWN4Bi2s/KdNmL5zkqSn1KuhcxMaXgOLx65dCUD+oktD7muzL3o4AYfXCs9oPtSiHXQaUJ9hXmh18K8/AnTpMyxIiSIqBKHiEsr0I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(82310400005)(40460700003)(86362001)(81166007)(40480700001)(82740400003)(356005)(4326008)(8676002)(70206006)(70586007)(54906003)(41300700001)(316002)(44832011)(5660300002)(16526019)(8936002)(7406005)(2906002)(7416002)(26005)(426003)(47076005)(186003)(2616005)(1076003)(110136005)(336012)(7696005)(6666004)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:50.6469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84898b30-47eb-413b-8034-08dae474b3a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an upcoming change rdt_get_mon_l3_config() needs to call
rdt_cpu_has() to query the monitor related features. It cannot be
called right now because rdt_cpu_has() has the __init attribute but
rdt_get_mon_l3_config() doesn't.

Add the __init attribute to rdt_get_mon_l3_config() that is only called
by get_rdt_mon_resources() that already has the __init attribute. Also
make rdt_cpu_has() available to by rdt_get_mon_l3_config() via
the internal header file.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4fc851f6489..030d3b409768 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-static bool __init rdt_cpu_has(int flag)
+bool __init rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index fdbbf66312ec..f16b8bc5448c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -512,6 +512,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index efe0c30d3a12..e33e8d8bd796 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
-int rdt_get_mon_l3_config(struct rdt_resource *r)
+int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-- 
2.34.1

