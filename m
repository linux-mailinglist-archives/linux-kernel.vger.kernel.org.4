Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3085FA648
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJJUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJJUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD8165B5;
        Mon, 10 Oct 2022 13:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYEDKLrQ+EG2RdsNvo9lo9rS8wUFgTp3rObNx/lIfbDWQAfsiHUQOz1ZuX4g0YNtKUqV4qpM/706cojjXYIOB82jsmGfuqhLwXftMVw9I1Ldj+Eqm0nsHOOXu4oH7FFnqLh45ftNRm45MUJuVstSEfhJLbBLZXLZj49Y02hR5RQOA3DNNY5tqfQ3/4dM59f88UbXV9sUyLkksdjJq/jJsck9xEG7UCQTNNglN3ED/HTeXqPJKyvhoQE0n1oL9Px0WwzoPEp2D8AjlLrvS/7G9JnuYUJCRo6h6VG1rguVAdUaDZ22C6IPbs9e8+XZpN+sy4G9iW8ctKpoLR4LmY8ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfBGki9HRVqT7przs0JHfyPLhzpAd1Zf8oMs+cVxOWY=;
 b=lgVA1SsB1FqQn7WEf813QtJQxgRp+dCQSrICOZTIfwbm6yK+kL33VwVgnL87g06I9wh2CbvgvbzwhzzWEQbaUfewjT/0IcxWVUrweltDs0K7mNLwUPhE6U4Tz2Z4YCR5YrFNVjvlAwdRxkmbH+4b1Ct32MKh3S57xoWUz9ccZgeEhNOO4kXwn8/SuHnOh9h7UdybvzUYeaQUO6aJBHIYex8J2AHPOmkhTetKeffUMwdYR5VzRawAof5yLAVrqrYdregtNgHk73ZAf+T0qlTRJH8AuJlyBSAHsiRdG3ZCaXvks+AlkWHSx3R7j2R847z7n2b0oSWfnuuiw7cM6vYy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfBGki9HRVqT7przs0JHfyPLhzpAd1Zf8oMs+cVxOWY=;
 b=EssMwyDpz/iBAsK0EVeZN6o3vqQkVMNYoHBtvmQYxDTbeoogn3nfpkc1Z3+oPCNvOkxFJqDxkirty6hNIOhXsx+UbVOknearmu7W3KwKRPUNxl9NP+oCGDhHq5bflM1DImDwySty61n4R7PDvHl1YFal0emP6YYJO57st5vc6gM=
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Mon, 10 Oct 2022 20:29:22 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::12) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:29:21 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:29:19 -0500
Subject: [PATCH v6 05/12] x86/resctrl: Detect and configure Slow Memory
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
Date:   Mon, 10 Oct 2022 15:29:19 -0500
Message-ID: <166543375907.23830.9540051258372039106.stgit@bmoger-ubuntu>
In-Reply-To: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: b81e9dd2-e92c-4f52-5a9c-08daaafe1d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KywLPPe3p5jPmzgabwoz5ueE6oAukxqCIXP9ky4hk0gLWZB6AnYP3ceJEtLO9rYzQKaL4Xcuv4dvXkvQMtfE1MXnFWKDw76Cqfu0yCQPCwVh2zOVjtGydITMoWlg0Qe6nJvqkBjRjKf/eFPrl3xTLrtja/awqxrOxvQudhhMrbYI/Yqoi14D6CLqCeLDq3zxevmfe4McuWz/vr6bp+/XECnuQgcpTPkk8SwHRMprCyTeDTMuKjdZHGAOhBkdyqiqFkcGKSK24rI1+N2JecO5rZ6Sxw5ynQWuDIcH/APMvz9QrV1NSdyXExMWyiPO4PK6S5q3r6P1BKJrvX5kRhkF1gWF/fqtl/Fl2uwbmcOQDV3zhPoAVEXW+z5sisJKy3BgfBVI/lY8eTDWiQdv1X35yR32k2cIQdPt3XwBJWqC3P2KWZM8YV6TdM4AWru7X1KSeHK+CkQr8k5rdBjugy7+gElve2VEeqv803YX9n6zku7CBi2nXRRJOz0xbsrYE92lyDG3vOC3XE95u1BFKlP/yjTkn23tz1KigOycXYD7WZAAf6UAIVEZKPAEr1N7k1uuXQXwPWBBEBXU7zcxbsAYkFbOrC27WHEN2tUYTYv951CLrJQBBYM2/k6io88BAH2AqNDm5zUtF+NQ/i1Y+tEM34gyTvnHsMYpKVK4x0+r2mAYmaPnOOpEDhP8MrIZBFBs7NghFSGB8v6i9cOr+Igcz8hC5aUpihLnD4qXyB3lBX2Z6Rgq9ZlKO3VVDyfHpnhZvsZzvWkuASzs2yt7UgypKPnYj2cPVw5mvs3Tyi5dtQqtCYDDvwfEVwqtpW1Kn9pyuRtOl6vnSUa7y5T+HamAaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(103116003)(7416002)(8936002)(2906002)(33716001)(36860700001)(41300700001)(44832011)(5660300002)(4326008)(70586007)(8676002)(70206006)(86362001)(16576012)(54906003)(316002)(40460700003)(82310400005)(110136005)(9686003)(26005)(478600001)(47076005)(40480700001)(16526019)(186003)(336012)(426003)(81166007)(83380400001)(82740400003)(356005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:29:21.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81e9dd2-e92c-4f52-5a9c-08daaafe1d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   16 ++++++++++------=0A=
 4 files changed, 39 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index c7561c613209..d79f494a4e91 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -231,9 +231,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
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
@@ -756,6 +762,19 @@ static __init bool get_mem_config(void)=0A=
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
@@ -786,6 +805,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_slow_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -875,6 +897,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
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
index 1dafbdc5ac31..42e2ef6fbdb8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -210,7 +210,7 @@ static int parse_line(char *line, struct resctrl_schema=
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
index e5a48f05e787..1271fd1ae2f3 100644=0A=
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
@@ -3287,7 +3289,8 @@ void resctrl_offline_domain(struct rdt_resource *r, s=
truct rdt_domain *d)=0A=
 {=0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
 =0A=
-	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+	if (supports_mba_mbps() &&=0A=
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA))=
=0A=
 		mba_sc_domain_destroy(r, d);=0A=
 =0A=
 	if (!r->mon_capable)=0A=
@@ -3354,8 +3357,9 @@ int resctrl_online_domain(struct rdt_resource *r, str=
uct rdt_domain *d)=0A=
 =0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
 =0A=
-	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
-		/* RDT_RESOURCE_MBA is never mon_capable */=0A=
+	if (supports_mba_mbps() &&=0A=
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_MBA))=
=0A=
+		/* RDT_RESOURCE_MBA (or SMBA) is never mon_capable */=0A=
 		return mba_sc_domain_allocate(r, d);=0A=
 =0A=
 	if (!r->mon_capable)=0A=
=0A=

