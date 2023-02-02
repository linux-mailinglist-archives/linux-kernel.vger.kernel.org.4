Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7468892F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBBVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjBBVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097686255;
        Thu,  2 Feb 2023 13:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mncR11tgbfKFNANlf+TVIgr7WmgBdr2BKbJVa0lMrpNktfyNCkQ3d2zF95spYPx9cHUtc4vAOHbfqK91/tTkG1TQe8YCscokahbTA3xBcoSTyywV8miyynsodpL9IKd1SUh2DVQ4NDcMRn0R3X2oH+KGmeCwy4gxcmaRIWRf8jFfNQ+DgOpbdvsyZauQXnsBI99CeEnrpLfvaIxCmhGyVp8vYbBgA1FWyGB34B6sJAZlW2Z/eOKRQNjy3FPI5gncj793AQjYzaMaDsXXmE/dBnJvh1nuFaNMDcECao48/gBmA1DonBFUdzjjN+tHDkWeWMxDzd7g7MYTSebNBmsEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnAN7k5e6XsUD4VWgunnxWbcjaSIjDkBs/wXuwv16Tg=;
 b=jNwwj41I3rMFrYuulGI9PWQj4n0ileSICUsmalDcvbR+KHv8PVDYExrWQYpqinRYYAj4cAu2ethDI80a335pPO7ha7frBFFEkHy7FrmkViIN1rCZBgiyXBo7sgvGLkj/G61W7RXJX0zhaDEfw4BZ2n4GlAOExnPM76Xd4S5WwVaOkgbVr8jRkHuzLq3DguzhW65A+uZTLDyryc8jxSYnPo9n0xgy2fx+59yfxX7er5hZepl0huXFdi6K8oaL04grgMlSC5byyHiOKWAlJOZ0piU3kyhJOUUU40SPacEcg+eV0lHIJVbm2LfwDP+u+9qAGQMHlIcDbpDQG7lneHdBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnAN7k5e6XsUD4VWgunnxWbcjaSIjDkBs/wXuwv16Tg=;
 b=x7GXY/hJx58jFEC3+yq+hcRLXRPpdhzvxt/C6vVrL3+/xrbwMzlWHe3EIK2XXrWUMPpuGPYMoiounMQC/4/04bRIkwua6sFJRh5GiMUifSPiPnKAhpP7ufNo5WKvRbfmWtgWdT8L3SrW1lITi/xTlkLC9UhGSJRledHcjDx75TQ=
Received: from BY5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:a03:1a0::26)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 21:47:21 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::88) by BY5PR16CA0013.outlook.office365.com
 (2603:10b6:a03:1a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 21:47:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:19 -0600
Subject: [RFC v2 PATCH 4/7] x86/resctrl: Re-arrange RFTYPE flags based on
 hierarchy
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:18 -0600
Message-ID: <167537443852.647488.1158619967633364811.stgit@bmoger-ubuntu>
In-Reply-To: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaeb5af-5729-4522-1f5d-08db05670fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vecUbxAoJeBL57azhKk4h5NvhSyizgIBjOBR9GvLqot6tEhmUpmzFq6mFkP3WpuORJHntHFV3FrlWxeDsFQY6BN9SqZiCE+bGzOR++HUcwfawS8Lu0hqtF6z5WN9WhHiid+HQkY3SQ3hgC/rkN8gVkgYcDdTvDGeb3DzhZyXpsNDin2X1n/9PO9IIk4oRx1LqKeKDwGCdgBn0KRgh6uwB5S+mRDJlqNM92B0lTc2jsE94N8vpWyAj5T2zLSx0NF5XOVFW2MlC+BQJk7engQh/hDjhTc6PvoYnFEFEqmAP04ljVkD8Ga6GvF6uv3epnXb/yvE60N/I5DH820+lffmVkWBeA+1lE/oalC/xq4TgmdmAAgvUf5GYA+zlHE630RJe30StM62gOnm+63CHBpjDfZDCbriAJoTiHPSoK17BbrbmmyPofYlv03727vPUC+Av7PnT7nZR/K7mKtpa30Um95URe+tvpWT/gaX5EktzFAYMkWE7/K8ny8qrBrFk6lfpOz9ToTb6tgzmSdF6TEDturAA5tVICUQMrdhorcYo/zk6TcNiqiSWabt0iznsfBUNHf2ex6FYKXTvm9rtzZSYbob2cndEnRAPng/WmA5LdJI6hNIprDeGZRUkM2kGN00uEEQrlJSMDN02ESqQgUXJqU0JX4WTY0nTcausDWu6Pes/7A6nQxIkMLVaG12pqWui01bddiZDb+KcmlZ8nmkUeM6ImdpIvoi4WDP9XudfpEoMUgcgleGhWkbHlwuTHJ25/ow5CU+yA3ECUWySHlxQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(426003)(44832011)(40460700003)(8936002)(478600001)(336012)(83380400001)(33716001)(186003)(26005)(103116003)(16526019)(70586007)(110136005)(4326008)(7416002)(316002)(41300700001)(16576012)(8676002)(70206006)(2906002)(5660300002)(9686003)(54906003)(86362001)(40480700001)(47076005)(82310400005)(36860700001)(356005)(81166007)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:20.6103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaeb5af-5729-4522-1f5d-08db05670fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RESCTRL filesystem has two main components:=0A=
a. info (Details on resources and monitoring)=0A=
b. base (Details on CONTROL and MON groups)=0A=
=0A=
The rftype flags can be renamed accordingly for better understanding.=0A=
For example:=0A=
RFTYPE_INFO     : Files with these flags go in info directory=0A=
RFTYPE_INFO_MON : Files with these flags go in info/L3_MON=0A=
RFTYPE_BASE     : Files with these flags go in group's(control or mon)=0A=
                  base directory=0A=
RFTYPE_BASE_CTRL: Files with these flags go in only CONTROL groups=0A=
=0A=
Add comments to make it easy for future additions.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    8 ++--=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   64 ++++++++++++++++++++++++++++=
----=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   42 +++++++++++----------=0A=
 3 files changed, 80 insertions(+), 34 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 030d3b409768..d1c6b2cc8611 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -69,7 +69,7 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L3),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
-			.fflags			=3D RFTYPE_RES_CACHE,=0A=
+			.fflags			=3D RFTYPE_CACHE,=0A=
 		},=0A=
 		.msr_base		=3D MSR_IA32_L3_CBM_BASE,=0A=
 		.msr_update		=3D cat_wrmsr,=0A=
@@ -83,7 +83,7 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L2),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
-			.fflags			=3D RFTYPE_RES_CACHE,=0A=
+			.fflags			=3D RFTYPE_CACHE,=0A=
 		},=0A=
 		.msr_base		=3D MSR_IA32_L2_CBM_BASE,=0A=
 		.msr_update		=3D cat_wrmsr,=0A=
@@ -97,7 +97,7 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_MBA),=0A=
 			.parse_ctrlval		=3D parse_bw,=0A=
 			.format_str		=3D "%d=3D%*u",=0A=
-			.fflags			=3D RFTYPE_RES_MB,=0A=
+			.fflags			=3D RFTYPE_MB,=0A=
 		},=0A=
 	},=0A=
 	[RDT_RESOURCE_SMBA] =3D=0A=
@@ -109,7 +109,7 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_SMBA),=0A=
 			.parse_ctrlval		=3D parse_bw,=0A=
 			.format_str		=3D "%d=3D%*u",=0A=
-			.fflags			=3D RFTYPE_RES_MB,=0A=
+			.fflags			=3D RFTYPE_MB,=0A=
 		},=0A=
 	},=0A=
 };=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 2cfc3c431d5b..6767c85b9699 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -240,18 +240,64 @@ struct rdtgroup {=0A=
 =0A=
 /*=0A=
  * Define the file type flags for base and info directories.=0A=
+ *=0A=
+ * RESCTRL filesystem has two main components=0A=
+ *   a. info=0A=
+ *   b. base.=0A=
+ *=0A=
+ * /sys/fs/resctrl/=0A=
+ *     |=0A=
+ *     --> info (Displays information about control and monitoring)=0A=
+ *     |=0A=
+ *     --> base (Displays the details on resctrl groups)=0A=
+ *=0A=
+ *    -------------------------------------------------------------=0A=
+ *     info directory structure=0A=
+ *     --> INFO=0A=
+ *         --> TOP=0A=
+ *             last_cmd_status=0A=
+ *=0A=
+ *         --> MON=0A=
+ *            --> (L2_MON)=0A=
+ *            --> (L3_MON)=0A=
+ *                max_threshold_occupancy, mbm_local_bytes_config,=0A=
+ *                mbm_total_bytes_config, mon_features, num_rmids=0A=
+ *=0A=
+ *         --> RES=0A=
+ *            --> CACHE (L2, L3)=0A=
+ *                bit_usage, cbm_mask, min_cbm_bits, num_closids,=0A=
+ *                shareable_bits=0A=
+ *=0A=
+ *            --> MB (MB, SMBA)=0A=
+ *                bandwidth_gran, delay_linear, min_bandwidth,=0A=
+ *                num_closids=0A=
+ *=0A=
+ *     group structure=0A=
+ *     -----------------------------------------------------------=0A=
+ *     --> BASE (Files common for both MON and CTRL groups)=0A=
+ *               cpus, cpus_list, tasks=0A=
+ *=0A=
+ *     --> CTRL (Files only for CTRL group)=0A=
+ *               mode, schemata, size=0A=
+ *=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
-#define RFTYPE_CTRL			BIT(4)=0A=
-#define RFTYPE_MON			BIT(5)=0A=
-#define RFTYPE_TOP			BIT(6)=0A=
-#define RFTYPE_RES_CACHE		BIT(8)=0A=
-#define RFTYPE_RES_MB			BIT(9)=0A=
-#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
-#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
-#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
-#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)=0A=
+=0A=
+#define RFTYPE_TOP			BIT(2)=0A=
+#define RFTYPE_MON			BIT(3)=0A=
+#define RFTYPE_RES			BIT(4)=0A=
+=0A=
+#define RFTYPE_CACHE			BIT(5)=0A=
+#define RFTYPE_MB			BIT(6)=0A=
+=0A=
+#define RFTYPE_CTRL			BIT(8)=0A=
+=0A=
+#define RFTYPE_INFO_TOP			(RFTYPE_INFO | RFTYPE_TOP)=0A=
+#define RFTYPE_INFO_MON			(RFTYPE_INFO | RFTYPE_MON)=0A=
+#define RFTYPE_INFO_RES			(RFTYPE_INFO | RFTYPE_RES)=0A=
+=0A=
+#define RFTYPE_BASE_CTRL		(RFTYPE_BASE | RFTYPE_CTRL)=0A=
 =0A=
 /* List of all resource groups */=0A=
 extern struct list_head rdt_all_groups;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 018a26b58154..18d458a3cba6 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1691,77 +1691,77 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_last_cmd_status_show,=0A=
-		.fflags		=3D RFTYPE_TOP_INFO,=0A=
+		.fflags		=3D RFTYPE_INFO_TOP,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_closids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_closids_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO,=0A=
+		.fflags		=3D RFTYPE_INFO_RES,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mon_features",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_mon_features_show,=0A=
-		.fflags		=3D RFTYPE_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_INFO_MON,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_rmids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_rmids_show,=0A=
-		.fflags		=3D RFTYPE_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_INFO_MON,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cbm_mask",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_default_ctrl_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_cbm_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_cbm_bits_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "shareable_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_shareable_bits_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bit_usage",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bit_usage_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_bandwidth",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_bw_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bandwidth_gran",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bw_gran_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "delay_linear",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_delay_linear_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_INFO_RES | RFTYPE_MB,=0A=
 	},=0A=
 	/*=0A=
 	 * Platform specific which (if any) capabilities are provided by=0A=
@@ -1780,7 +1780,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D max_threshold_occ_write,=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
-		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_INFO_MON | RFTYPE_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_total_bytes_config",=0A=
@@ -1827,7 +1827,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_schemata_write,=0A=
 		.seq_show	=3D rdtgroup_schemata_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_BASE_CTRL,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mode",=0A=
@@ -1835,14 +1835,14 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_mode_write,=0A=
 		.seq_show	=3D rdtgroup_mode_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_BASE_CTRL,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "size",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
-		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_BASE_CTRL,=0A=
 	},=0A=
 =0A=
 };=0A=
@@ -1899,7 +1899,7 @@ void __init thread_throttle_mode_init(void)=0A=
 	if (!rft)=0A=
 		return;=0A=
 =0A=
-	rft->fflags =3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB;=0A=
+	rft->fflags =3D RFTYPE_INFO_RES | RFTYPE_MB;=0A=
 }=0A=
 =0A=
 void __init mbm_config_rftype_init(const char *config)=0A=
@@ -1908,7 +1908,7 @@ void __init mbm_config_rftype_init(const char *config=
)=0A=
 =0A=
 	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
 	if (rft)=0A=
-		rft->fflags =3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE;=0A=
+		rft->fflags =3D RFTYPE_INFO_MON | RFTYPE_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -2043,21 +2043,21 @@ static int rdtgroup_create_info_dir(struct kernfs_n=
ode *parent_kn)=0A=
 	if (IS_ERR(kn_info))=0A=
 		return PTR_ERR(kn_info);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);=0A=
+	ret =3D rdtgroup_add_files(kn_info, RFTYPE_INFO_TOP);=0A=
 	if (ret)=0A=
 		goto out_destroy;=0A=
 =0A=
 	/* loop over enabled controls, these are all alloc_capable */=0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		fflags =3D  r->fflags | RFTYPE_CTRL_INFO;=0A=
+		fflags =3D  r->fflags | RFTYPE_INFO_RES;=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 	}=0A=
 =0A=
 	for_each_mon_capable_rdt_resource(r) {=0A=
-		fflags =3D  r->fflags | RFTYPE_MON_INFO;=0A=
+		fflags =3D  r->fflags | RFTYPE_INFO_MON;=0A=
 		sprintf(name, "%s_MON", r->name);=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);=0A=
 		if (ret)=0A=
@@ -3554,7 +3554,7 @@ static int __init rdtgroup_setup_root(void)=0A=
 =0A=
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BAS=
E);=0A=
+	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_BASE_CTR=
L);=0A=
 	if (ret) {=0A=
 		kernfs_destroy_root(rdt_root);=0A=
 		goto out;=0A=
=0A=

