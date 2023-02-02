Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD168892B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjBBVra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBBVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCBF86615;
        Thu,  2 Feb 2023 13:47:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKFKqhaPmyEliPWHszF7EmlUiWTSMqRi9YrKNOqoWYo1Hrc1w4OMNlRV+D98I1lYDbRHQDOB8u3eIbL71sk2fKQjdFcZ4/TsP1qdzYyRf3rK1tQFXT62nwzmP+QLBdpah7m1ohBTYDuvbu38aVTMCKc0X5jYEB+iNY+IE/CXHkDY9Q2+NVWtzVhX4IqnZSuP8LOwhujmvwtd30Bi7DepOIz2yRKiiAdeSB91PQ8R1WC0es568+g5ifg1i7MsEb2FiehRFWmnj820MvpmTbq9F86jwvaCKEPJVMLqlPyjTFn4stQzWT9lxjZKnRgQwwEErwKHvhWICA3jNfqUtack1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ovAuZpiTt1LtCVS4njkKI3b17HTdRLm1SUu+c4lkvo=;
 b=Zuht6BLAk13NPPdiAB0Tbym3GcAd/eWb/qkz5rboeWLqEBvD1DIo9IM/v+jKLZU1aG4OReg7cdCCPpEVVFR1joRvK45TptcYEANsxa9o4Tum/em5T8E/P8/RQmzQQrDf2L0GlkdE4nw4JuEYOPFUnzJHAyU4u1pEDCc99NYC0fGtaGE10jk84F2K/kzDyKsMc2DJ18tOCHlqSmL/hbGRgoVxMpg1NNn/wetsvgk/bGqscdU60KlwK6H/+ndxxAgvupZPUjwTdXakqwYJ0YAEDUhkwhO7Ot2vxPCFiD6f+4z+KKTi4BERKZ7qYAhEzqjEZnQ8rYnv4kQqgVLW1+Ebcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ovAuZpiTt1LtCVS4njkKI3b17HTdRLm1SUu+c4lkvo=;
 b=nNUl5Jh9samnXi9aSO2ZtBhJlIptZ0Gyd4lCapvxmxiHqowuMZQT7FfjKpUSXrwV3z2FKy1nhaV3QBfkyojjfdjvQrDtCEsnibUrRst56ds+LC3Gml8IIKLKZKcvfbf/rohgueXBnDWQwBToHZFIvh2PCa1kZtUGEX7YYsn3HhI=
Received: from MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 21:47:14 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::64) by MW2PR2101CA0007.outlook.office365.com
 (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.7 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 21:47:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:12 -0600
Subject: [RFC v2 PATCH 3/7] x86/resctrl: Rename rftype flags for consistency
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:12 -0600
Message-ID: <167537443207.647488.2343865571652545811.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|DM8PR12MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 40599279-a371-4446-dc3d-08db05670c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUH6fObmYkzPpjUlqdyHrEZfQ4YOEN068tMe46qu3LqZI2ZzFIA+jX7XHA13b4/IRNUKUsKKFRdj08C9Tz4Yf7GP5TTYOwiqGFvNmlv6Ggm83RMLDhoYjZncwwQYldbPd1P4h0gvIe8+Dgtb1mlE+pXDHQXWshqnjtT1r9BUbGWH9HZfjd8aYYyNWzWz4zYFunEo9zssXQylZIT/BBpH+C6ZchNTn4IPU2eYOEcwpvy2/Rupc7AGadBvRyo0hn7m5qtIweH93jfnb122m8na42rEpcYD73SZrSyfqkjhU5+3awNJYJMkaJsb8bWRH/9oDEFKHqPAWepfBxAsI0T/u93DfGK3d0S9umCZU4oqrp+OMqqFfZ7RlCPwKNgH6Gf2RyqUuGXD/fse9eWLRgH1lKVQTiYFPMhrtLJzEgCXO8hzc8y17w/58ysytee7eHpMPJroV4xBogIsnWCPa+wjfsOdODXNfRfv0KK10VQ1UqXV94CsohJKAPHoBgpbmkSuZXxCT50a4vm2oSYpCQ4MRy51d0j2dkSQ77KsGmioGff52N3MceplmACjRUgr4r0makV9YIKYIu+M9csXcdCXEVonIoR4qxnL5CHJM/o6SJAExanuGeT4SllndcZ3Y45nHLa1rIT/8IYPXcvXetfb6M9gmEBLUDTfFNoZn4T4vqUCiEj8WsnZP9n4Xd+5vqLsQguG+kLQNOrNcGG9B0O3V2pqjgNMGmPpW/uaarhbs6LF0dVJftKf1hSzDr7S1DWit18MAdTjo2HzUqNnreuKzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(47076005)(356005)(81166007)(82310400005)(103116003)(86362001)(40460700003)(40480700001)(36860700001)(82740400003)(33716001)(16576012)(44832011)(5660300002)(54906003)(110136005)(316002)(2906002)(4326008)(8676002)(41300700001)(70586007)(70206006)(7416002)(9686003)(16526019)(26005)(8936002)(83380400001)(336012)(478600001)(426003)(186003)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:14.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40599279-a371-4446-dc3d-08db05670c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rftype flags have two different prefixes even though they are used=0A=
for the same purpose. Change the prefix to RFTYPE_ for all the flags.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    8 +++---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   42 ++++++++++++++++------------=
----=0A=
 2 files changed, 25 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 571145d75d29..2cfc3c431d5b 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -248,10 +248,10 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
-#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)=0A=
-#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
-#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
-#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)=0A=
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)=0A=
 =0A=
 /* List of all resource groups */=0A=
 extern struct list_head rdt_all_groups;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index cccf3fb84b26..018a26b58154 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1691,77 +1691,77 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_last_cmd_status_show,=0A=
-		.fflags		=3D RF_TOP_INFO,=0A=
+		.fflags		=3D RFTYPE_TOP_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_closids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_closids_show,=0A=
-		.fflags		=3D RF_CTRL_INFO,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mon_features",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_mon_features_show,=0A=
-		.fflags		=3D RF_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_MON_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_rmids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_rmids_show,=0A=
-		.fflags		=3D RF_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_MON_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cbm_mask",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_default_ctrl_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_cbm_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_cbm_bits_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "shareable_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_shareable_bits_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bit_usage",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bit_usage_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_bandwidth",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_bw_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bandwidth_gran",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bw_gran_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "delay_linear",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_delay_linear_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	/*=0A=
 	 * Platform specific which (if any) capabilities are provided by=0A=
@@ -1780,7 +1780,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D max_threshold_occ_write,=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
-		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_total_bytes_config",=0A=
@@ -1827,7 +1827,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_schemata_write,=0A=
 		.seq_show	=3D rdtgroup_schemata_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mode",=0A=
@@ -1835,14 +1835,14 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_mode_write,=0A=
 		.seq_show	=3D rdtgroup_mode_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "size",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 =0A=
 };=0A=
@@ -1899,7 +1899,7 @@ void __init thread_throttle_mode_init(void)=0A=
 	if (!rft)=0A=
 		return;=0A=
 =0A=
-	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;=0A=
+	rft->fflags =3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB;=0A=
 }=0A=
 =0A=
 void __init mbm_config_rftype_init(const char *config)=0A=
@@ -1908,7 +1908,7 @@ void __init mbm_config_rftype_init(const char *config=
)=0A=
 =0A=
 	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
 	if (rft)=0A=
-		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+		rft->fflags =3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -2043,21 +2043,21 @@ static int rdtgroup_create_info_dir(struct kernfs_n=
ode *parent_kn)=0A=
 	if (IS_ERR(kn_info))=0A=
 		return PTR_ERR(kn_info);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kn_info, RF_TOP_INFO);=0A=
+	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);=0A=
 	if (ret)=0A=
 		goto out_destroy;=0A=
 =0A=
 	/* loop over enabled controls, these are all alloc_capable */=0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		fflags =3D  r->fflags | RF_CTRL_INFO;=0A=
+		fflags =3D  r->fflags | RFTYPE_CTRL_INFO;=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 	}=0A=
 =0A=
 	for_each_mon_capable_rdt_resource(r) {=0A=
-		fflags =3D  r->fflags | RF_MON_INFO;=0A=
+		fflags =3D  r->fflags | RFTYPE_MON_INFO;=0A=
 		sprintf(name, "%s_MON", r->name);=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);=0A=
 		if (ret)=0A=
@@ -3554,7 +3554,7 @@ static int __init rdtgroup_setup_root(void)=0A=
 =0A=
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);=
=0A=
+	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BAS=
E);=0A=
 	if (ret) {=0A=
 		kernfs_destroy_root(rdt_root);=0A=
 		goto out;=0A=
=0A=

