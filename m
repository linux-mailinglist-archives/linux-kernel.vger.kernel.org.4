Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223106A8A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCBUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCBUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:25:02 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411555060;
        Thu,  2 Mar 2023 12:24:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUKm74O44RkBqIp71/ZnN3xCFgszgenCse/QlrxO2LX6ZNNesS04N61jEt1DhKM009/JlCCskX3PbWhavFnJKki8BrlzKwPk0iic3e47jn8heifITPDjph89xoGV3UyWCGIpJaM1k6PRqE3MKoKJV8zITkl368Hq0CsJBVCiXbtLyVD4MRmC7X+ys50aNFo9N6nchl9eOG3folt0WG7C3m+ceuMnoWC9PkvJX+UDHCBuCnAB976U303z8vaPKD+rjpbab6jzm9DdCCCEYo00xtGusY456oE+TCjy28I2vxJIAgAIQR1nUcE5rPsC/wVekC1HCoZi+LpcGV8yqvVJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdTd8HNBAa7A+5TsTnvnb1X4tNBgd+K9CEuP23cV5LE=;
 b=L4HFh7Btr64sMaj1ZRw8bZ126lJZN/MkFGBnSHdbSuURKM8fZUV1KMBo7O5TtxptSxa7JXUIpAwmWvz+X7N589+ThoU/iWoaw4LroeMA9s0NzXj7fbEWglLYwFKinZlWpxLLLi1CnViokrR02IpwJLm3PplTzFb4CvD3VpbLCiAH8VYZ/oiOq9qnpMXonu6lMSQ1p6yhoqTsYYdN2L/kewkhXNcjNNOHavFtAR0Axma5+MwuxZMPHPvxYy8CxpgCDC6eLb6X72XF6LhOhnQi148jSAP3feur45sWSYrYf8a03jpQTxpBYBopedYMw4ECOwuFhvF9DByxwTlaDcSmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdTd8HNBAa7A+5TsTnvnb1X4tNBgd+K9CEuP23cV5LE=;
 b=Xyt05WYDZ+tdTOlsTI1AZpBnDIwS0bwNDe45K+Tfd2AzLSWQiQqzU9t4IcCDh4dJxNGs0JsamQy0XRDNX2psNwj+/xYVE2PHcb8b7qdh209vySxpqdKNQ6iuPG8PSphqGV6yhkls7dXV7osrLvwKcBFlYDyNAi4+IY3KJ6kaV9k=
Received: from DM6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:5:60::43) by
 DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.17; Thu, 2 Mar 2023 20:24:42 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::54) by DM6PR10CA0030.outlook.office365.com
 (2603:10b6:5:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:24:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:40 -0600
Subject: [PATCH v3 3/7] x86/resctrl: Rename rftype flags for consistency
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
Date:   Thu, 2 Mar 2023 14:24:39 -0600
Message-ID: <167778867966.1053859.17317446376632380238.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 355c1a32-e162-4ec2-e6d7-08db1b5c280c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaV05FEy2Dgm1lsX+24cQ9p0h0fS+OcQ66dwufocjRxxr76LoX2VS5Ytst+ti8aQwXljF418meeK0fQcbZyiqUyoLgb98reEhBLPUqXCOc6tfxcKUZwgimJ+huoa2PYsEDvH+8cjvjyQ1hqXP0n6/VdGFZrc+PAypq3CAYACOqMEXVs9CXvWFgkMGnf53gqD4eR3ABTAPpYYrV88xcZ9bBGVBVndwcB4bOLgFiFf44yywea6Px6CHmhZiLKk6HHiGqkYVt7DJz2x3WZnF5/nDCjvFrl74jclAk7KIZ2LVENX2bZQphswbC2VNHtTPLKXYrUaK0JW/Iun7P/qfe3RJH6x80y2Srf4UuT4IqiskOauVi6ptpmJzKuZWIIBr0ZLIWO9RGDQ00tfvaAJExbKXAOgcukM6jkbqHJ0xf8y9YpO+VLwguAf4xtwOLrKd2ojve7wPvH9IqD2dOu2H+cmPXuCWuB3Whcdxaq8Zm+JYVbsHAUsMQw0U5b7AJB+wLEBboorLrfoBk7zDxvqvAdeoBkcxvk0j0kgWPG7hgnizEoiuywZfFSvNxwbwjIYA8AmucG5ntOiU+3aw0IcMS4JWLaCNA3z3iN5bjeou3dgpjnuxv29JaPRqxWw8BAUjhtNJG4te9do1Vn19z2wNHheGEVYlU/wxO/2v8ni8tlHRMf7bnv/L85bQ6no5iglEyyHU05HahB/WPIm2ZeUHjyRU36db0Mk1c5TD7AKwYQ6CVQERn1NCrb1R/Dxw32yr9OciEQOBuSsM1WVCFfzHSomdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(103116003)(5660300002)(4326008)(44832011)(2906002)(7416002)(41300700001)(40480700001)(7406005)(8936002)(70206006)(86362001)(81166007)(356005)(8676002)(82740400003)(36860700001)(54906003)(82310400005)(316002)(16576012)(478600001)(110136005)(33716001)(70586007)(83380400001)(426003)(47076005)(186003)(336012)(40460700003)(26005)(9686003)(16526019)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:42.5151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355c1a32-e162-4ec2-e6d7-08db1b5c280c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
index 3c86506e54c1..fc7d1e778bff 100644=0A=
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
+		fflags =3D r->fflags | RFTYPE_CTRL_INFO;=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 	}=0A=
 =0A=
 	for_each_mon_capable_rdt_resource(r) {=0A=
-		fflags =3D  r->fflags | RF_MON_INFO;=0A=
+		fflags =3D r->fflags | RFTYPE_MON_INFO;=0A=
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

