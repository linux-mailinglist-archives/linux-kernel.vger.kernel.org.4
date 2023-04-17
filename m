Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A246E5551
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDQXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:36:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ABB6196;
        Mon, 17 Apr 2023 16:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXYpO5vz5rflvpurzmw7RTLsee2kLfPfVfRZFlWgHcNAfxRYWJrUV+08XB6cwSCYF8WpbzV7pe7fjpdPCQECulxGa86+NAGMIzzZu28f2XODLEFurw0xhMNMBGk7xrwleTHmiCOU1BprN9VDjM8V1nX53RJuZpuRD/J66Ajv/gfCkyvU6xbZZy/bL3Kwtc10ydEnemwPxTXkopNyUHUAJT63RnkA6/9ZlycC1qS45JKf+O2tAfX2ol87Lb3I/ycPamsFJB6f3q4equfusLqwbIufpdXVzwZoM7BDGDK1LsJUhlSRit38RGcMhzMDE2iCzTM6E+kqrSChK41Jt6eSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QEdeBYOcFQXPHhAU/bv6izaEr6SsDBieE7N+ywkJK0=;
 b=aGhldIrSx2wN/nZo2lLpG0elQGzHtyNNfjAqB2DpogPLEP3l3sEpZafw9b+HycMY6mfHG6gBIJqtu7uaIUmSd1zv4vY4mWF5Mo/D6Wrb63mNq0wmfXYizgiM/7yOiKibSdheFu0ScdvjUloTtMzCl/RbtX8pbf2SzfaEZdvIYleGuZUEJjdITHMBPHM+1e8aFoeu0RuUBpQCTU8aeohBAX8Q5VLfoYSVuiNyjnv90I5X5KPxQU48dKm27C+A7mb+xY2D/qS3CNl1XAV27Dd8vfQG5UF40/3ubU01z8LxAJvsHuXIUyBvNoQmxaTd87E7sT2iU6secKvY/hd6H1KEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QEdeBYOcFQXPHhAU/bv6izaEr6SsDBieE7N+ywkJK0=;
 b=MAAcyFCunrjOVvnH4nc4KpA9iUISPzDLGVKseYSe1WS0rwWxaU9ZPN6JCd0b3N3jYez/PUsoAGpfZvch21t7LysS5jjDwLS8DDfyRKYXaRjm0cYmZoKFBalVYGvBzjejpHHNTQUmcwxMXUESO4HFZyVjDbM1ldkNSablvO2NubA=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 23:35:14 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::37) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 23:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:35:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:35:11 -0500
Subject: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with debug
 option
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
Date:   Mon, 17 Apr 2023 18:35:10 -0500
Message-ID: <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b602508-6733-48a4-b8d8-08db3f9c64ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ka3bysb9n3W17QxqgfImunfbwxrB4lFLonykVtms1qFBSScHLahfKLnK+AWT819jtsmqSTSiqQ3dc5ZmJSz7tp0DVkx7wdmUps8WvXIlXwbVJmfuJawKH7Tpsudo90iwrL4DSzU/TfUQ3+clgM2Y8SbXZ0eKay9fYEyiFdW0M0r6DPC61cylIX2+SF/jT3U1vMhd+MEZZw0xVblxs65RCplwMx2RPZymO+Rs8KyLRepk9L9fmdH7kxkjfaceK5SlAkJ2XLvVafuoXOrlHW0YeqEKIsHCVv6YrAoE4skNB0CncVmhydz17vcQcC80ETdt6DMsZES84pzbt3mS1NkdSxJr8pjnFS7HYPKRk8asprpLXJYYFNv5btPAFiyzXhFDpzbiBzAGZ/6wDwmvWlAHDW4KrS4Il4UylIqU1Cyx/y1IBAFRxqPEPPjEBYoORSN9D0SWHQxyS6+Z8dWo5SuUpQq60IhQbL7exEHkeCdyuKRAM9u4z9g5eh2kvg2QLvoI8nGKp8V+rdu6ccA7JjwqkTipK3VCl10btZNUyRM4yCOy1B8mTBpsgstNHPdS9l/2NLgpImtjUytY4ZCNs2oLVuM/Ofq5Iu1rny6Gvr/LSjqUz8WDL6WQOIGDZ0CvduHIedNS309Bnos9tN4XZcJqhwuoSaiYRyaZAdUAckumcFQkQwtK2GP+hN9G/xVzIVxqLW8xW85aN+KIMu+XhB5xw7pHB36tVumNULFMFiUpWTada6EwhDL/Q9LQZNGFnpGV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(336012)(426003)(82310400005)(16576012)(110136005)(40480700001)(82740400003)(47076005)(356005)(2906002)(44832011)(5660300002)(103116003)(316002)(41300700001)(54906003)(8676002)(70206006)(70586007)(81166007)(8936002)(478600001)(7406005)(4326008)(7416002)(86362001)(36860700001)(40460700003)(186003)(16526019)(9686003)(33716001)(26005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:35:14.3024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b602508-6733-48a4-b8d8-08db3f9c64ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the debug files to the resctrl hierarchy.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54 ++++++++++++++++++++++++++++=
+++-=0A=
 2 files changed, 54 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 1eac07ebc31b..855109abb480 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -288,6 +288,7 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(4)=0A=
 #define RFTYPE_RES_CACHE		BIT(5)=0A=
 #define RFTYPE_RES_MB			BIT(6)=0A=
+#define RFTYPE_DEBUG			BIT(7)=0A=
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 15ded0dd5b09..1ec4359348c2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_rmid_show,=0A=
+		.fflags		=3D RFTYPE_BASE | RFTYPE_DEBUG,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
@@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_closid_show,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,=0A=
 	},=0A=
 =0A=
 };=0A=
@@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct kernfs_node *par=
ent_kn,=0A=
 			     struct rdtgroup *prgrp,=0A=
 			     struct kernfs_node **mon_data_kn);=0A=
 =0A=
+static void resctrl_add_debug_files(void)=0A=
+{=0A=
+	struct rftype *rfts, *rft;=0A=
+	int len;=0A=
+=0A=
+	rfts =3D res_common_files;=0A=
+	len =3D ARRAY_SIZE(res_common_files);=0A=
+=0A=
+	lockdep_assert_held(&rdtgroup_mutex);=0A=
+=0A=
+	for (rft =3D rfts; rft < rfts + len; rft++) {=0A=
+		if (rft->fflags & RFTYPE_DEBUG) {=0A=
+			rft->fflags &=3D ~RFTYPE_DEBUG;=0A=
+			rdtgroup_add_file(rdtgroup_default.kn, rft);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+}=0A=
+=0A=
+static void resctrl_remove_debug_files(void)=0A=
+{=0A=
+	struct rftype *rfts, *rft;=0A=
+	int len;=0A=
+=0A=
+	rfts =3D res_common_files;=0A=
+	len =3D ARRAY_SIZE(res_common_files);=0A=
+=0A=
+	lockdep_assert_held(&rdtgroup_mutex);=0A=
+=0A=
+	for (rft =3D rfts; rft < rfts + len; rft++) {=0A=
+		if (!strcmp(rft->name, "mon_hw_id")) {=0A=
+			rft->fflags |=3D RFTYPE_DEBUG;=0A=
+			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);=0A=
+		} else if (!strcmp(rft->name, "ctrl_hw_id")) {=0A=
+			rft->fflags |=3D RFTYPE_DEBUG;=0A=
+			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+}=0A=
+=0A=
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)=0A=
 {=0A=
 	int ret =3D 0;=0A=
@@ -2433,8 +2478,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx=
)=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
-	if (!ret && ctx->enable_debug)=0A=
+	if (!ret && ctx->enable_debug) {=0A=
 		resctrl_debug =3D true;=0A=
+		resctrl_add_debug_files();=0A=
+	}=0A=
 =0A=
 	return ret;=0A=
 }=0A=
@@ -2851,6 +2898,11 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 =0A=
 	set_mba_sc(false);=0A=
 =0A=
+	if (resctrl_debug) {=0A=
+		resctrl_remove_debug_files();=0A=
+		resctrl_debug =3D false;=0A=
+	}=0A=
+=0A=
 	/*Put everything back to default values. */=0A=
 	for_each_alloc_capable_rdt_resource(r)=0A=
 		reset_all_ctrls(r);=0A=
=0A=

