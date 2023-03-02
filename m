Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D26A8A31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCBUZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCBUZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:25:14 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379857D13;
        Thu,  2 Mar 2023 12:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvxUI3rxv6n/I1a+cwdKuPCALUW14rjPAtR5cV0/lcPS3htso0LtEXadnUQhQOmG/sG3/pmlu4RDMYrGPo+YUX0qKuWH0BptBA7hfGcoWDpVj4/FbNdUWvo2KR8vVlsHMJuMAMVCQkVw32O23rABLZO8I6kj0f8xA7ZoLvaYnz+h3rasDMoaJVkroAspOHACO9AO+GSuHJsBjHR2lMLtbcfHeIq1uB+z0WCcu/ycR9Nokm6nA5NfGla0UVCQQ5c9oo/DkJ5ktY4po0ZgkZYveGNQXCWN7oUUk5yh+0xCmso2NOH9qU7qq8SUaRy84kbuPJfFQtz9UUL2u5556XB8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuBQ+BwcsjFgt2n25b4Jx3ABbjC1XMRl0btoiXYYkXU=;
 b=MKkfRY7nb2tSQbNswfLyoTES5IYNFulatEcULKbo2/SZ7HR0pnBWuLmDIiXUmk16tBTLMq1/a2JF4h3y4CpRqa66/aOZMxb9voH3VOBCU6/mqezP7YCpHAahzvvfDoDCpX10TDkG9BxqdJY0CRbx3YluGoqlETLeUevVuuG7XivkOUoRLrOCEMA4CAj/NInFzZ67WqSEAMoAVcNL2fYa7AQH4XhIxv8df3uAyuLpDdcxsBp1FRMAK5jCnQfNH5E99UZ3dQmjNIUYkfF7FrZeJoHUSoXeqbWkiZnIpkRP8kDnm48eovi8hsGTYkE1BjF66NaT6chYqy22EtguQSveSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuBQ+BwcsjFgt2n25b4Jx3ABbjC1XMRl0btoiXYYkXU=;
 b=4mpdd+8lDmAPMette5rUzv0alrtuX5GdT/jVUnC050xZbxxks7buw7dkGOcQdKCHZXIihElNsiekYXMyDsgEFLKJTdcrRowNzwWv3ahSNEg7KtpYDMuWBeeoYNrtKYY7IZh664jo5q9tPHalMrcl8JPXUk3HWVvU6vCQypqNQE8=
Received: from DM6PR07CA0123.namprd07.prod.outlook.com (2603:10b6:5:330::24)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 20:24:50 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::a2) by DM6PR07CA0123.outlook.office365.com
 (2603:10b6:5:330::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:24:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:47 -0600
Subject: [PATCH v3 4/7] x86/resctrl: Re-arrange RFTYPE flags based on
 hierarchy
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
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Thu, 2 Mar 2023 14:24:46 -0600
Message-ID: <167778868692.1053859.13490646651097380957.stgit@bmoger-ubuntu>
In-Reply-To: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e7a836-7679-473a-2921-08db1b5c2c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F5p2xx3I9QPpF3flnYttoPVz/nmCnuB8yqrR1ndUPdm8AuqUquuw6CGoRUf8D0pWkZeXb5DF3mo1/CiEwFz1Sa/XZNKgnLKyv0rGKgYiPiy7ooFioPUKjcd4pUdt8yS4G4mwpQhkt55s5ZHP3/hqozmhe6ukwX/AHzFCRlvjGjG8WF5Jcb1kwoPr5wIvMfAwDMoxmYLVpF/IRAO4KoMlsTv/6zAi2InhQogacgR0m5U4LeOkyLmV4aOsiDpLGwC+Nu91YCZb86qt0DGGk/CyGVBLGmrxejMgzgzRE7Ws757X+rRmNfGGty7FloRU/GaMcA4WRB3bhC4HTBA53IqezamOeU8zIfdi21P/AdYjiW1pcjUTjzuU7yoFpgC0Sfp9byyAZGmsYUzSQAhBJIoywS09iTkd6Vmdg8sR7nmX9atib4UajBjMbz216PutaYd7RDw5smu7jWVO+1FjcwMiQT449/xbMsvycdkJ2I9B/8fmyGtnCpPCTw7WolJdvi1946C36OZwyM0+067v5JuwLmah8f5IVN6BGrGOxFnM3gYWbmPzHgzb+q54JWH6eI+RVMmWUZH7ZV79/kSnqYcQjjfBPIQRnbJEWWsAbp8Cbfo7I3EuBShuqrCisnfr8LQD1t7dKXMhSodkUCuqzsihCOt847oqGHYnEBNQDMTUSik51U7MGycadUX0Q9we0T0H7j3dRDkQ0S5AFlTeQNC+sWEPGSW7ONdk+4hd9bNM6Mgcuyy5yOAADUT4P/JXdpGY+xtveRli64P9ai6w7rTGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(47076005)(426003)(40460700003)(33716001)(356005)(5660300002)(8936002)(81166007)(478600001)(7416002)(82740400003)(7406005)(86362001)(40480700001)(103116003)(82310400005)(9686003)(16526019)(186003)(26005)(336012)(44832011)(2906002)(8676002)(4326008)(70586007)(70206006)(41300700001)(54906003)(16576012)(110136005)(316002)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:50.0206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e7a836-7679-473a-2921-08db1b5c2c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 +++++++++++-----------=0A=
 3 files changed, 81 insertions(+), 35 deletions(-)=0A=
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
index fc7d1e778bff..1eb538965bd3 100644=0A=
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
-		fflags =3D r->fflags | RFTYPE_CTRL_INFO;=0A=
+		fflags =3D r->fflags | RFTYPE_INFO_RES;=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 	}=0A=
 =0A=
 	for_each_mon_capable_rdt_resource(r) {=0A=
-		fflags =3D r->fflags | RFTYPE_MON_INFO;=0A=
+		fflags =3D r->fflags | RFTYPE_INFO_MON;=0A=
 		sprintf(name, "%s_MON", r->name);=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);=0A=
 		if (ret)=0A=
@@ -3218,7 +3218,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,=0A=
 	if (rtype =3D=3D RDTCTRL_GROUP)=0A=
 		fflags =3D RFTYPE_BASE | RFTYPE_CTRL;=0A=
 	else=0A=
-		fflags =3D RFTYPE_BASE | RFTYPE_MON;=0A=
+		fflags =3D RFTYPE_BASE;=0A=
 =0A=
 	ret =3D rdtgroup_add_files(kn, fflags);=0A=
 	if (ret) {=0A=
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

