Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD794662B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjAIQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjAIQo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:28 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C77E0DC;
        Mon,  9 Jan 2023 08:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9d3k2olytywZemSz5F9RbpbcPGdA7wdZ5Fvnb4KYBvq1MI6IcT6mpAwU5rTn22lX2YRleieilZAHyOoM7AdvGT4oQLEMzc1VCTbM+cPorhvlrgWUaKXUuQCXgxP2+eV0zTGgyuIOCqz4PT6aoOUfXDdH87DL1UeI4A3GxhcQwVn7UIQiqeT2oSmHU1mX7ELwOMOA3kKfcJyyx3iTh4uw2DJpZpYcaLhr/7/G+C30bVXnKnPlc5t/bIVkHWClSd49PVl4O8wfLav673RCx2hqf+k2ACKwcS5/MQxnixH4wRbF2bO0lC30eeUWYnyXCwA649npuNwJ5ETYL/r4rqgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jkUFf1gvYK/SZx7CijuTqt+imvr4lxr+zPkVdz7ka8=;
 b=Ehe/R0ylIyWQ8dJpidP3FM5mGPZG8MZ36WwiOFpOoRQlZiyUND52c9AfZ+kkHoubF2CNILLG1ShfbzV3rwyj7pAJRwFiIEyXz5mcZOz/meq2i/0yk3sczfo64k7aOjBT788aCayUVMwJbkYj5XNJUiLJQNOV3Ror1iBAUE04o+XlXtjWreb4ttVfxPFAv3SMjKna5tebCVaVfNywxk2St3iAzUsPtpgJjQCYxHoviMlsSUPeGvW27dlN4EorCL8Gk2Ch6NXvbAIgmccbFyp5Z1asV9ZyRKM9GRy6tUT3UfeXXUynlKCmhTtI2lWsTYQTvHs+8vmuwoLLMdI5msto1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jkUFf1gvYK/SZx7CijuTqt+imvr4lxr+zPkVdz7ka8=;
 b=D+u3Ol31HYJrtH7aqODGkB5WqWYUvmO7VI7etaZO4U6LVGUOKe4ohuyguBuMxao3xjYzaYcTjD6wplfg8lpX4CozLWfW7lb8zsJkSKFv3iP/9oz3P1GzZe41kDbVRMwIKrtdYnIxGS+qR6nJyu0ABmCSBvfCjwhn2XtKlEVKu3g=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 16:44:24 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::cf) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:22 -0600
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
Subject: [PATCH v11 07/13] x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()
Date:   Mon, 9 Jan 2023 10:43:59 -0600
Message-ID: <20230109164405.569714-8-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b76698-7489-4792-f12c-08daf260c428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkKCb/hikZKpYJ+OMHkFGI5c8BMwf0JYOjGSRel75aehfgT/ACM8RxDTDa90EmwJzyIcv02kz/aqaLs1XcDJAS0l/Hp4WUaZERtgzZFwx3JY1vtGq9L4sVHWZMeiBHnIuHDB8wDnfJNUmg0ACsnbJ5rkgX1SqSPRcBEq05MmEhDPZmc4mlCdZ4s+aa9mVgaF/ylILYi54cLyJx2xtj0jWWevtga8Ic1UVxv38evxJpJe9RnXKcMW2Kct1PmF3XxIXfZO8iBCyFs3Qog8zUXDjJSKjgIsfq9e13pxSEc85FxIxOKASYD9YTfLsjWGQ+dDmn0nt1xOM25LIBd57ExRAqIFmiRaGG96e8BKsS6G/Yxf859hD0p39NxeTo5Vi+DcoVNvpAym/z0Yz1kDPPIdwdRx/e7u1GvfdpD4Asfcbp4eFHeg34aeBjwGO+o3D6XudKsUw+xqg77MciYgS7IeY8m4MmfqBAEKzvXPBNCtYglsWvCoo5JAd0urpXuHO42FiMYHaA1SNJ89hit9oxo6fKpRibRxNAV4bvjcMWmfUzi/V1M6lDH1o3yRgtRODMTz1otjLCWYpE0AM4nWDaJ0B2M7hn/9hs6MyU7uatc1RvdmeHR/lGEczMq4aUK2mYcJ/TNLk4KwMicnLq5xKgYj5lI7ppCn8VvDnQF/O5pKNiCE8NNNiP1GPdHx/zLOzJvUgrFrQ0N36y8z8Pw0LUJfKr9VCOzV8BAUx1lKirWiYBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(8936002)(40460700003)(2906002)(7406005)(5660300002)(426003)(47076005)(41300700001)(81166007)(7416002)(7696005)(70206006)(4326008)(70586007)(8676002)(316002)(356005)(44832011)(110136005)(54906003)(186003)(16526019)(82740400003)(26005)(40480700001)(1076003)(2616005)(336012)(86362001)(83380400001)(36860700001)(36756003)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:24.7365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b76698-7489-4792-f12c-08daf260c428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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

