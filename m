Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A163F432
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiLAPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiLAPhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:55 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB963E3;
        Thu,  1 Dec 2022 07:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7OH1MZaoWJfQWQuyTiwKfMBGbr6kzCCON3GF5bzwySqM5j6j7jslJmVeIdK/ZNIwdFiG9Gk7jrGJD+SweuP+vCSziQxawCsBUsmkhzz6Zz7YMCnZsT1ZzeCfQ9398M0LAonauTh79VVCGcaDmHnlL1hgd3MQqYrlkA4rqsjIwR+YnLdDozjomhlvDmDxg8LlASYlFjhyDW5NIl3FSCIRag5GpNDs5bAxaybz+KdLmXVO9Oql+f3F53tBC5pd94tquXqfLis8N/nRjh2eKHAZDCCD94ntMBimmXMbrSf2IhliWlXQcGyVcO0yKKbWss2TZcuSY086Y/xooNu9SPK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTpIL32GJ01HUKHGeylEy8GDHtTnvjCumguab5h/8Eo=;
 b=PlURp6EmIm+JXIjiFiwQ1+1J3byB4J/iLLtrouKk0iqIOE4jqulz8xFGSsepRtnHrmSz/vrCbXd+0DjrYFskAdXGCX1bcL9OCrDe5WNdGN7yH+mTmjX/h8VM/KQEfvPVBcvOpBgYl8RwFOOEb/6VHHqsLKZZ+fCx33VDEAWZQ7wP2U30yz8CZ5z067dxXYGYmA5mtxjQwFajExMDfcHnmrivNwHDnPQ7F/X8Xyc30/pbcRu98/RCAS0K2FH7lxMqEJQ2lp71ypvxBaR9UjHzubdszEF3xtqkmqCYlFNpAiVBtPU4NxM/+ZF6b0/EWxpwzP5IDfhFSM2otHOZE3cdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTpIL32GJ01HUKHGeylEy8GDHtTnvjCumguab5h/8Eo=;
 b=ASZZZeKdYtN181P9NK8QjkhtGHYkgf+BfS2lBqn43IsgoYGdPNm4svQ2U2XQHOnaTkU4Kn4FjjzoCyreG9991RvSETzma3XVkOGpZ1o0TiNdhqMnPZUbWKe2VAuvBQGyVfgXeSifGVJIYyHhVQU1XIHL5AkaLeSCUsRawj+IJzk=
Received: from MW4PR04CA0049.namprd04.prod.outlook.com (2603:10b6:303:6a::24)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:37:33 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::4a) by MW4PR04CA0049.outlook.office365.com
 (2603:10b6:303:6a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:37:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:37:30 -0600
Subject: [PATCH v9 12/13] x86/resctrl: Replace smp_call_function_many() with
 on_each_cpu_mask()
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
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:37:29 -0600
Message-ID: <166990904972.17806.4220672882391241296.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: cef50bf5-ee6c-4fd3-4a7c-08dad3b1f6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ybv5jYUgb+FhuLjFgbOwA96dtwFTOgzBPKitzPVcv6U84zU3t3plS8zkLzG9CP2yELN9o7wZJLXn/5qtSwcj9rgY/4k4QSGPBMHdwf0duWJRPs5dyg/YFgLOHAl2r8zH7VK6SJbg0efORI0VxKdDxzuVBOyfEzK/aJuzO/QfiRfHMC16qrXjdDmjYPb2qnR1T3HPo5JyouYeuGcYQBb6roNaGovJh4pytvHYlPcNf2otz4WW1ARV/uu6RZNLJB81V8mEtQItaBjbBfUmZv76JDBfLlo3eaELBFtfZTsGra5hWxErb5zcPWGZNoORULS1hmC6T4k7prtNAP/VANPjol6Ava3IY0xL23ZB6jPpmqqEGjMfMDNDVwGIlqmcrqdSLS6wrIiADFW5McyUsmEs2ZOrRjg3rU1/rzgvhCs+3JSkLp0j3EGlUl4DAh5Ot49vht+v0ljzR/op31wg48RaJ8ETWJmO9XNwqCn1ZsyqGLmt4xrtILFWCeaV1VQhy5SwNUDC/3ALV7DnKDOB+9zIW9IjaAEOCW9CddzC8isPoVyFjkVl0Pq9HV+ajElqya9Pfnck3WsLMTMW1aqUHcAccQiXCWl/E6L9RlI8yHa6sGYISApsYoqunl+VaModBUc2hsptx6SFmHkdeuRM2NcR5g2UEIc8qoK9DvxWhEZGdG38U2o2UC6EracFTf4X/QseThFEDpJh/vLR0teWuVKmTYf8GDtM4M5S9Mk+ZNsjH5aTR650uG5stiagF1CNxvynfdbnL7/4OK9MHQXPSiAtgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(36860700001)(478600001)(103116003)(16576012)(9686003)(41300700001)(40460700003)(8936002)(336012)(110136005)(47076005)(26005)(7406005)(7416002)(82740400003)(5660300002)(426003)(44832011)(40480700001)(33716001)(81166007)(356005)(2906002)(316002)(186003)(54906003)(4326008)(8676002)(70586007)(70206006)(16526019)(82310400005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:32.7253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef50bf5-ee6c-4fd3-4a7c-08dad3b1f6c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call on_each_cpu_mask() runs the function on each CPU specified=0A=
by cpumask, which may include the local processor. So, replace the call=0A=
smp_call_function_many() with on_each_cpu_mask() to simplify the code.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++--------------------=
-=0A=
 1 file changed, 8 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 6897c480ae55..68e14831a638 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)=0A=
 static void=0A=
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)=0A=
 {=0A=
-	int cpu =3D get_cpu();=0A=
-=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update_cpu_closid_rmid(r);=0A=
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
-	put_cpu();=0A=
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
 }=0A=
 =0A=
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,=
=0A=
@@ -2135,13 +2130,9 @@ static int set_cache_qos_cfg(int level, bool enable)=
=0A=
 			/* Pick one CPU from each domain instance to update MSR */=0A=
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update(&enable);=0A=
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, update, &enable, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
@@ -2618,7 +2609,7 @@ static int reset_all_ctrls(struct rdt_resource *r)=0A=
 	struct msr_param msr_param;=0A=
 	cpumask_var_t cpu_mask;=0A=
 	struct rdt_domain *d;=0A=
-	int i, cpu;=0A=
+	int i;=0A=
 =0A=
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))=0A=
 		return -ENOMEM;=0A=
@@ -2639,13 +2630,9 @@ static int reset_all_ctrls(struct rdt_resource *r)=
=0A=
 		for (i =3D 0; i < hw_res->num_closid; i++)=0A=
 			hw_dom->ctrl_val[i] =3D r->default_ctrl;=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update CBM on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		rdt_ctrl_update(&msr_param);=0A=
-	/* Update CBM on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update CBM on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
=0A=

