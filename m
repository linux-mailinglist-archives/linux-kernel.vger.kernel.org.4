Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132161A1B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiKDUAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKDUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABBE49B68;
        Fri,  4 Nov 2022 13:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg/KE5vWXwd4nJkMm6CIEe7MTi71MfyAC5YIQRIyMiXdlNORlHDjh5qSWXF04Zh7PEKyPS9lgCSIJuwBuce14IILwMvsf7/ZZwM1txWJEwmixpGBT8XEnIjm/bKnlCJKhroHxlXEPAXpf2gXiqkveOZUu1BLz0vhbVvD4EB372UlzxzOOKbQRxa7c/qFPz3+B71fIim0uvaZzLNodYzd+3Qt2xL6dDQvsm8XT7CyS0ZppPB06b7mWbdroqtwYHddMy8IBj/fvRjExeZas7w5bVRLq5ouRKPths1SPcG4WOpzkGbrmVCHFXXivOgIeYU5oRzqdAd2a7mesCiYycw/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCKm/SDQ0q4pCk0+0bzeM5Il0UmQw+4Ee6tUR4g01cs=;
 b=mE0Cl9BTlIOYWhtuRblGV7gg3OMSwodZaROKW8wy0xedkkIta+g8ZgjBR/Zl/xWXl1nk3YoF5lvRH5lpD1fOouD9vxtO+PH7bw7goZL5ztfREUXdfkPprmA3x/fgY3yLabO27Dsi7jff/KqU7RwsxR/yV36bH3imaKOyEhxnyoth7wn/PNTtnRPTckc0EX0GyzoGYM2w+oqXUibaV57qAzJ3v1IN8tixxaLPQ19mnRvy/Ut5/ZeU1zleJQH0q2FE10sFNpmfKf67XwDHnhwC9JA0PQwKTtPJQr5eVLcfq143QLVyijdKPQkk3/nLB02bjEwmBCBEXkRV3OhWO9KljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCKm/SDQ0q4pCk0+0bzeM5Il0UmQw+4Ee6tUR4g01cs=;
 b=3soBWCHsMJjtRO2NylqsK41acKQbudf3C3qJAWm5c/9af1vywONy+ZkbrjDxdJZKVL/dEUXi3cC2VSewYwgCugSrSogDBFLmB7xiq5r+oIAKoDweHZbxnIGYLSoyhu3HpvAtUWpvaBQccfIKRcRUgE32KMfw0+haPAnmmhZSWck=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Fri, 4 Nov 2022 20:00:31 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::7f) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:31 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:29 -0500
Subject: [PATCH v8 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
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
Date:   Fri, 4 Nov 2022 15:00:29 -0500
Message-ID: <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d634fd3-4c49-4906-5333-08dabe9f3a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QisL0pUCQsE3L1+wSbZ+it6KeZsn8/NLlFSVSkfJfwDL7K3BvaBLz0/qVxzCyGVRM9eCw8nFTLevXln8wpeXf1X5y/MK7cVdBfIbP/uOL3kfptUT8VzEuz3A15tlZOjAI2LdGWiPpckp+is9roX1+7uwecYESK8Bwshp6me2HgzIjs0kDLN3azznAubvDXejbxrkzrvxCnCCWlLcm4001dcTnzGAMx/uubpkztpi1Ty9XzOrMihtxIo+j03NEUfHn4HuQEGjPiusB5CwQnAQEdb+CvtQ+XS1pOrPrc8HufA/SpaxiHy35EpTFtu6FT8LDEI5l5jdx9dMPr7TwFGkQH7oS5zSjKUZtXeiwZGSY5OAvfDoygp+IPqWXH9+HxgL1525lebrZZiz9puHgv8L3nIQ7nlsXVZsrRfV8NzwYPyTOiS9j5b0hYMjdT2fIBHicNFrRpef+YXjY9fI0OIWfcNMNYcWGB3NZdlK9GihzAsvshhhkFstvR1bzUG5QYCwp1G8ePqlz7jbC90yz/WDn6bGWpZvtkddBBFIHVUA9yv376JpV96vRrW5CgIch7VHWS/3SYBaHjhT+H1njmVmv+NSw0xglbFDvl8SLGO3UY1zaGHfJNSgmTQj9YBnnGF3rJfJDkN2VHel7kBw/thIntlVfUmtpTpmZ/24nyuSE9wPRTOYasvDHbyfyjIm9BhED0P7jIlW3ytMEpJefY7qIGIGWSSbibEl1aSxc9h1fyH/EGV8t20UAXoYHkp/RG+IJ7N1Dj5teYN2SLRABcbzfvR1rGuKNPu8WPrl9cim77NpwjcciqEzVJF39YoibKMOaH+0/Oja1NGUVv3G/OjPUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(110136005)(426003)(9686003)(33716001)(186003)(26005)(54906003)(16526019)(40480700001)(336012)(40460700003)(36860700001)(83380400001)(44832011)(47076005)(2906002)(7416002)(16576012)(70586007)(8936002)(8676002)(70206006)(4326008)(5660300002)(316002)(41300700001)(82310400005)(86362001)(103116003)(356005)(82740400003)(81166007)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:31.6852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d634fd3-4c49-4906-5333-08dabe9f3a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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
 arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++=
++--=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--=0A=
 4 files changed, 41 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index e31c98e2fafc..6571d08e2b0d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)=0A=
 	if (!r)=0A=
 		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;=0A=
 =0A=
+	/*=0A=
+	 * The software controller support is only applicable to MBA resource.=0A=
+	 * Make sure to check for resource type again.=0A=
+	 */=0A=
+	if (r->rid !=3D RDT_RESOURCE_MBA)=0A=
+		return false;=0A=
+=0A=
 	return r->membw.mba_sc;=0A=
 }=0A=
 =0A=
@@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
ce *r)=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	union cpuid_0x10_3_eax eax;=0A=
 	union cpuid_0x10_x_edx edx;=0A=
-	u32 ebx, ecx;=0A=
+	u32 ebx, ecx, subleaf;=0A=
 =0A=
-	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);=0A=
+	/*=0A=
+	 * Query CPUID_Fn80000020_EDX_x01 for MBA and=0A=
+	 * CPUID_Fn80000020_EDX_x02 for SMBA=0A=
+	 */=0A=
+	subleaf =3D (r->rid =3D=3D RDT_RESOURCE_SMBA) ? 2 :  1;=0A=
+=0A=
+	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);=0A=
 	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
 	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
 =0A=
@@ -750,6 +763,19 @@ static __init bool get_mem_config(void)=0A=
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
@@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_slow_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
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
index 1df0e3262bca..2dd4b8c47f23 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -209,7 +209,7 @@ static int parse_line(char *line, struct resctrl_schema=
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
index 43d9f6f5a931..16e3c6e03c79 100644=0A=
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
index e5a48f05e787..8a3dafc0dbf7 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1213,7 +1213,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgr=
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
@@ -1402,7 +1402,8 @@ static int rdtgroup_size_show(struct kernfs_open_file=
 *of,=0A=
 					ctrl =3D resctrl_arch_get_config(r, d,=0A=
 								       closid,=0A=
 								       type);=0A=
-				if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+				if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+				    r->rid =3D=3D RDT_RESOURCE_SMBA)=0A=
 					size =3D ctrl;=0A=
 				else=0A=
 					size =3D rdtgroup_cbm_to_size(r, d, ctrl);=0A=
@@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+		    r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
 			rdtgroup_init_mba(r, rdtgrp->closid);=0A=
 			if (is_mba_sc(r))=0A=
 				continue;=0A=
=0A=

