Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938135ECE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiI0U0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiI0U0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:26:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12989CE6;
        Tue, 27 Sep 2022 13:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLeDoR/l5w258MQbeKYQBIcexea4KWRmJzdxbfJIDl+p3qv8tXPP3xP9B1XWDOu/fkWwIVgsi9QBGek9jU8X7oGnxSuoybk1343iTjQPFu9MAcuKbdEhUF2Ry4CeJ1j6W88nR7Ra/hcNcFNJ2afcx3U16fsSfgnCxKfEmRxf26gxF4KGem+LH0BZB9yqEj0Qvdr13Eg+sQrW1Rhc4lHF2QSElzQ56Qo6vUEBKFBWb/6iXphyCHWnhwu+l6YrXut3eTiXPBhnES9kWXzA/sOgZZGUlzoVom6iFYlK+zaGiXUoh+ZhOHsRuqkD5XcWa4L5Fl98JiaqS1wmwf51FpLlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdW6rOLipQec9mcRIhcEv+a7kf4ens5ewgNF4fUWFV4=;
 b=HzOhfDJStGJlXTHrYDBX4NmrXR7PUxC7+mTK0xkGZfdichM4pe0n9g84w+oS7AuqDzQh2C7SGukvdexDUqVdtwVsmD9LBpygrtPS9fBGiqBfGFqjv0Eot9gKO6PfSaGSjWR2tDqI04ORfvsDiE+9cWGoE7SNcFgu8Uki3ScvKdaOHWsrqBcDjim4IRe+qH/7c3JYA41933wrFBZONK2nrXI8LAqHST0Nf0LE3bA8HzXRp0A03V4jNKRGvDo1BBVJNZjly2nXckhDCAP3mS5l5ej3297LeCevD0wauVn3EFB/l9TddO+/hSlSegQAFngmgmINk7J481uiNmEYuOItmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdW6rOLipQec9mcRIhcEv+a7kf4ens5ewgNF4fUWFV4=;
 b=exbJJccS3vkwi6yEHUG2MtkotEqyYSB3QM/HMU1Cz2qxmgTrj7+CD15MQfO0FaPVyafBX2pTkXGK0upMT6wF68LEAmZMonjQRq6uvGlLo2ZWKDQq8uosFlel/8pG+T4dNJedWTiILGjPZXgABksnAQwVznrQtaAYBWB11/03KJg=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 20:26:09 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::83) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:09 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:07 -0500
Subject: [PATCH v5 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
        <eranian@google.com>
Date:   Tue, 27 Sep 2022 15:26:06 -0500
Message-ID: <166431036678.373387.1230453387335709239.stgit@bmoger-ubuntu>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 661f3d01-db7a-4e57-6309-08daa0c6833a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcMZvBPe/7Ua9r+cE8jAm5IJSzbzeb2KBQmQXFHsNyf1h34uQKloElJhzOl844isWAz6DOYUbGe7LintvNr98+f6Sar/VXchVDsrZOy8oJKYxhW7KBmu39qq8lslw3Dc8mwB/grfkRqT9pWRo1qkAFpMQNLX0NijamSywO9zhUzdTpiE8LPHQ5Mymc0GtLuPl3owfLM7yvlEM6ulA1BaAcyvLY2zT7MfHIsSc/pNrz0qEEMX5ydkR1il5rvjsGM5VhR81sMUUeo/puzfxyUZ4QVl/MKVJH54vcNub1FIErxdvuu6XXrI2PXpuRlevmVofeLn6ifcMEFu+VCl78y+hlCId4a0kSpN7zLInao0Q8T/E5y0B0r3KQkeetqMjY1Yk9rd3bdPG2jJW2u5cFliq6Snm4aR58f2uz8ImujeJaqxYS7Ge83aXkRxOK0hSGjr/IPo0uyB2fDxvABM1ygVp2KDeyLg1DSlo8zkWV/yqQdPVPL2zeWd0VnQLfs7RWkaSMGDf2EOhbcbGloVg+b6gzzkhLECwX5i6vlgxBEKu2V/WYfUa5TXYs85vv0wluIObiLUjmk/lADoDqd/S4ZJdNX9hS4Cvt3tL8v3Ck3nzxB8jmH9p1hIRoUcZx1S4Ueb9qXBGJCrnQHD9FKnd2MqL9StA4FeWbAnalRY5bfFHlUcSx1aGTGLpUu65t9qGF+xANzoUwQ5n3H8qYYsjm92GGGxep+X01wyZYquRKWSphOlsWHXiQMgOOw1cQSeCqZvjfvJUaNqhryODJw2pTyjMTF9G/HbJneFIgb08INBmkg2fe1CdXOsnjOtP0Ox/L3L6P3lLPWzeIkGwIhLfM1uWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(103116003)(16576012)(44832011)(36860700001)(54906003)(110136005)(86362001)(356005)(2906002)(9686003)(81166007)(316002)(26005)(8936002)(40460700003)(41300700001)(40480700001)(478600001)(70586007)(70206006)(4326008)(5660300002)(336012)(7416002)(186003)(16526019)(47076005)(8676002)(426003)(83380400001)(82310400005)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:09.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661f3d01-db7a-4e57-6309-08daa0c6833a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS slow memory configuration details are available via=0A=
CPUID_Fn80000020_EDX_x02. Detect the available details and=0A=
initialize the rest to defaults.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |   29 +++++++++++++++++++++++++=
++--=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 +++++---=0A=
 4 files changed, 34 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 53fbc3acad81..56c96607259c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -227,9 +227,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
ce *r)=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	union cpuid_0x10_3_eax eax;=0A=
 	union cpuid_0x10_x_edx edx;=0A=
-	u32 ebx, ecx;=0A=
+	u32 ebx, ecx, subleaf;=0A=
+=0A=
+	/*=0A=
+	 * Query CPUID_Fn80000020_EDX_x01 for MBA and=0A=
+	 * CPUID_Fn80000020_EDX_x02 for SMBA=0A=
+	 */=0A=
+	subleaf =3D (r->rid =3D=3D RDT_RESOURCE_SMBA) ? 2 :  1;=0A=
 =0A=
-	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);=0A=
+	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);=0A=
 	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
 	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
 =0A=
@@ -791,6 +797,19 @@ static __init bool get_mem_config(void)=0A=
 	return false;=0A=
 }=0A=
 =0A=
+static __init bool get_slow_mem_config(void)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_SMBA];=
=0A=
+=0A=
+	if (!rdt_cpu_has(X86_FEATURE_SMBA))=0A=
+		return false;=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static __init bool get_rdt_alloc_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r;=0A=
@@ -821,6 +840,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_slow_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -910,6 +932,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
+		} else if (r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
+			hw_res->msr_base =3D MSR_IA32_SMBA_BW_BASE;=0A=
+			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
 		}=0A=
 	}=0A=
 }=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c=0A=
index 7f38c8bd8429..480600b8e4cf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -202,7 +202,7 @@ static int parse_line(char *line, struct resctrl_schema=
 *s,=0A=
 	unsigned long dom_id;=0A=
 =0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&=0A=
-	    r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)) =
{=0A=
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 24a1dfeb6cb2..c049a274383c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -14,6 +14,7 @@=0A=
 #define MSR_IA32_L2_CBM_BASE		0xd10=0A=
 #define MSR_IA32_MBA_THRTL_BASE		0xd50=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
 =0A=
 #define MSR_IA32_QM_CTR			0x0c8e=0A=
 #define MSR_IA32_QM_EVTSEL		0x0c8d=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index f276aff521e8..04b519bca50d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1218,7 +1218,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgr=
oup *rdtgrp)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)=
=0A=
 			continue;=0A=
 		has_cache =3D true;=0A=
 		list_for_each_entry(d, &r->domains, list) {=0A=
@@ -1399,7 +1399,8 @@ static int rdtgroup_size_show(struct kernfs_open_file=
 *of,=0A=
 				ctrl =3D resctrl_arch_get_config(r, d,=0A=
 							       rdtgrp->closid,=0A=
 							       schema->conf_type);=0A=
-				if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+				if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+				    r->rid =3D=3D RDT_RESOURCE_SMBA)=0A=
 					size =3D ctrl;=0A=
 				else=0A=
 					size =3D rdtgroup_cbm_to_size(r, d, ctrl);=0A=
@@ -2807,7 +2808,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+		    r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
 			rdtgroup_init_mba(r);=0A=
 		} else {=0A=
 			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);=0A=
=0A=

