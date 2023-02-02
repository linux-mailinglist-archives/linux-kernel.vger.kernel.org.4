Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C9688930
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjBBVrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjBBVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:40 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633163857;
        Thu,  2 Feb 2023 13:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBzGt556nL+fzq9a1EeDbOxN2Qiog/IcIor/DypOV8Tmr9MXY3j6qvEcS1cnivMz5Td6uRbayQh0Sa81U/AZZQGq33w0N8w0JD9Fk32bM0GplxCIsJzkkjRJT/sNhlUXnF+E0rqG1aDboI68d0sUee5VrC/eJH4r2sWiqu2s/QndWYBY2XH1fxHMR1FIeZatLaVvZva0oCzOz/szQjXhFkcr3fEkkxNpmL3AuqBw3FIqeYdivXtlOPfiRXcgJWUFXjvFY3QpLsdrw/FRSErzyARjTWKb6I4xgmOKYhugFjfLh6Jnudm0KI0O0Plonvls/YEW8y2AAKk2d0QBpJGzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYuMDmsod6qrAXR4MZtDY2ef7GMEydcm5u/0TIGk89I=;
 b=J+/JyF5qC04kKYgsDR6uttYncnMbVNaxJgtkFUXq8BIznqdS5bUEUV3OJIRQnCRvd6lEoS7VDIfuIw1asTojVQzIfwCKZ+vDjXHlZ7fNwgJgTCW0uv3HXXtiq3WfOeYrSKMy8uucjbcmV92i/1tXmIiUbm28d3uWPcJA21fHXOuBSBaOs7VKq0E7m7XMgvhaAdYJYjigTpWt/CEIwmf+efQP7XjT9VYm6apSlNhRqmifuLS7KCgp90PNwKEeorl24VOmdYQoXIs9ENMKvXKUX6xSbcaPjffR3Pyz4cSm5PFiP5WaUq/eFUJi57Ju4gOM1zt1Szm35sQYT/aNxzNeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYuMDmsod6qrAXR4MZtDY2ef7GMEydcm5u/0TIGk89I=;
 b=Hfqc8VibCgEQ/uh04P5hEB00bKsWBd6XFvmIdiCaDziSYeBalisRsbxODyy8OZcRVQVtpnMsVxmubOiaa7Kl6uqZAl20JytVGyP/7NUX44LphmQiYYIlQ3WSTUwhKMFtrsLlSH7aZuUuhBKPgnd4TCc+Ig5rCtK4KpYksa2mesY=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Thu, 2 Feb
 2023 21:47:27 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::f9) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.20 via Frontend Transport; Thu, 2 Feb 2023 21:47:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:25 -0600
Subject: [RFC v2 PATCH 5/7] x86/resctrl: Introduce -o debug mount option
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:24 -0600
Message-ID: <167537444491.647488.11815488030989406143.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac4023d-c985-4fa9-1185-08db0567138f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Snn7oB1VtKuVQU/2DodpY1ynsi9NWhAEuW/jhLxrPDG14dJwVFOLz1CT2Z5ILdaG49vQkaDFr+1x2q/kyfUheE3GNnsdfQjc7RLuQbzSVaXu0zlsh1A+J68gZsPPkI3DS1QWYJjy+sFiPjFLPTLgeGZ0FWgh/9V8OzrJMdddGd+hLmJT3T8QBf+QSo7xesEI6JvncnmLs190KVmuPqc6cHdOPpNOXgGWOPE/tSL5w7J0MAFNQQLGWS3P82IkESQACCFpmWNvSwQK5iX9+O0Z3nWCVKd0TTEBlaAnqtNdsjoQGQpt7CKObhXdEpkSPef6TdMgDxuNgnKVyhvd8c/MRbIHxNjvgfHQ6tjwJtIw9gdIxBTnnZNKtUclQ4FTNYsxd0AvT5OmBQA9FMeSw+5bUju30pf5Np3ATsDtesflnR2gnPlBlisgcs3JgQsvNm8VqCvTNva5C8wuIVOqTaqIiNIMi4JE463BYUvpKnw1B3/uA/s2WHM4uZWWpEuIw8PrsAnQibbQQKYg/pOupu6tDzBml42+Z/Io+2VKidBRBAbfJa3dS2uCFrP2jIdlg8MV7oG+6pKelClE4w77axGiOjFf+kFc9Ajx4u4d1YbAvO0VRIfpKrCuYTIkvJcEmxJrGSUJPs7WBmxK4uYZf8AaLdTSz5tnV5fREPewDtGx0rt/uehbavnmUvSV6We0bvMtKLyU+Pat4FIG/rRacIltWfxLsBMibN5EKJ3M6F0F2vC5hGp+F5TozWCJShLc+6hn7u5ltIChtUTifRAwOClpgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(70586007)(4326008)(41300700001)(70206006)(8676002)(40480700001)(8936002)(16576012)(110136005)(316002)(5660300002)(54906003)(103116003)(44832011)(356005)(7416002)(186003)(81166007)(2906002)(9686003)(36860700001)(478600001)(40460700003)(16526019)(26005)(426003)(86362001)(82310400005)(47076005)(33716001)(82740400003)(336012)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:26.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac4023d-c985-4fa9-1185-08db0567138f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -o debug option to mount resctrl filesystem in debug mode. Debug=0A=
option adds the files for debug purposes.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    7 +++++++=0A=
 3 files changed, 10 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 58b76fc75cb7..2c013c5d45fd 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -46,6 +46,8 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Lists the debug files in resctrl interface=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 6767c85b9699..35a9ee343fe0 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 18d458a3cba6..9b7813aa6baf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2555,6 +2555,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2562,6 +2563,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2587,6 +2589,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -3525,6 +3530,8 @@ static int rdtgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf)=0A=
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))=0A=
 		seq_puts(seq, ",mba_MBps");=0A=
 =0A=
+	seq_puts(seq, ",debug");=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
=0A=

