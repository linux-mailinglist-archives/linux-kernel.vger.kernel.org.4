Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFE6A8A36
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCBU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCBU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:26:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F462521FA;
        Thu,  2 Mar 2023 12:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp0XneEosqS8ohwEmaBNwian4YyAs+ZkNrgw5h5wCkX13D+SveZjoFPGPKWQlSVJ78Wp0rTjuWWbqp3x91akhfHVVQKsMDZ2UA3XNycbcxFVbTvcyyz2jD7sRrk+iAbRHFqdYALkugBlO+371Rzi0TqU4Y83oBemovCCVd4NwFgjnIYin6sg0EYVRqiL1zY/yRQRlmZIVEjjPkz1et7v+WboRt6wSSfTbQpRJthjdloMJxplJLv+aZZCYMJUPthtWrR6lRHqGwxcrMlaISKA0mVgcI6t+bUu/V4hbCnoSIRYynigC+Qu5T94BbyzXtYwfK9PiIKdlMBtATE1htDgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO6qZ4CmidKPoh+G1DsI+9CoKSqfSijLIjt12ZB+cu4=;
 b=OLS4MXBqKxCLoIuIpg2HIKoPmuiTdgxW8sAbEFJibom86Ebi82Lr2AJUUz4wdyedQQZOTHWYbnfZvDVtIoAp0N8sg4JDGz623kXuGx4ZTc288VSPDBMOVRwbJg3uTicBf4v8teW+1KW8FyAXGfBYLhHGbVbFJzrVU2P/6MdMT16AjzaHsgTOXOZcLSTpC9JEM1oLxgRxrDcLusZ6wOZhqtVh7NjW9MKbvfpUl+GyHNx5JsLZeQrO8GpQ5p5gS35lovWwvOTofI1s+P8g9xe+/HfvaayocUEBy8gOGMbN32duxw4lSjpG4n/CpMf6Qb1GniV/dw8DTiYzEF3WLVOksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO6qZ4CmidKPoh+G1DsI+9CoKSqfSijLIjt12ZB+cu4=;
 b=B8gwZZLpxz/69Lnilcm+I0qawck1JukfqAQCNOVuZVNlF4vhBrpFmVeH7krWrGBTj4ycifwP+GR4IUGyYnjLePoLJjQOhteoKTB5rmcCpHe0LZLxJyoJ8V7HRZujx+2hE+02Ll4dR4DHqXqFirQAEbLV53uoYzW48hM1oA0/Tts=
Received: from CY8PR19CA0037.namprd19.prod.outlook.com (2603:10b6:930:6::11)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 20:25:48 +0000
Received: from CY4PEPF0000C970.namprd02.prod.outlook.com
 (2603:10b6:930:6:cafe::b) by CY8PR19CA0037.outlook.office365.com
 (2603:10b6:930:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20 via Frontend
 Transport; Thu, 2 Mar 2023 20:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C970.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:25:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:25:08 -0600
Subject: [PATCH v3 7/7] x86/resctrl: Add debug files when mounted with debug
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
Date:   Thu, 2 Mar 2023 14:25:08 -0600
Message-ID: <167778870823.1053859.9940104139782066465.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C970:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: c51c3882-3c0b-4167-f604-08db1b5c4f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5m3pFvpMKl7PKA0A+xgTpoZAf+zFjoWX+8Qza/ARnlH0wWHflm6h3ytLPc9/xCxrjPtyDJMO1+PR1UBfD2phOcfrdsx7/n5naMDcFImzwn2m3zljmKsf6s7L1lko/7bryqhe2hWYDhpXhOAloJ8Q7lacgYi6hWqBCVe6bTuJSW0y50eIdKtxu3J8UbroGIxQHPKIf02lI5czOBAKNeu4LCzYbjZ53Nq5KexxPqzTm2qd7N62NnS5D86kP2jaXPnz8Fh/EYjU7y855M7h+KCAfrX4d0uqcLhXG6stPp0ZmSzyRFEyYbah+8JM5Y1GtcD6/pinJIS5+7owfpID1wV3NmYdyTTMyPpnwViFD+ciPlbBaZjEJ+Je+GrI5KKYbDbfs7n1KaHq3iXvpaEor5iFmHFQUS4SkAF5o6UnPoDkunp49fhGNbsA8ebIL37kRZ7LggyXxOK+oCl8cCbRxOChVHVjhB+1U4wqYuJx/BKsmeiRzXx4puqb94mKEa4pxax8adTmuTOe74Me9y91rcSudxX1LksWcseLFsT3lZAGJnwVD0uerZSPhw5Cj/u2wTkGpuD6AnZypk8gIba0gxmUkQ/29crokYH1dXCzOgmlUnhrEX/NxxRSkcq/CsLiB9W2iQx6FtSmrAgaxpHhGnSPjICfgkk3I5NCTqUoBltFloFta5KoOHxm2ICkmmV2z0VMz1luELZTomV8S4f2+GlawvPmBA+bJB0aI0BqnytoslC8yhfr6QlKXvQ8TwA9Piu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(33716001)(41300700001)(8936002)(54906003)(40480700001)(16526019)(40460700003)(336012)(9686003)(70206006)(70586007)(186003)(4326008)(86362001)(8676002)(103116003)(2906002)(47076005)(36860700001)(44832011)(83380400001)(7406005)(426003)(7416002)(316002)(26005)(5660300002)(110136005)(478600001)(16576012)(356005)(81166007)(82740400003)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:25:48.1996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51c3882-3c0b-4167-f604-08db1b5c4f35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C970.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the debug files to the resctrl hierarchy.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   48 ++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 47 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index a1f13715a65c..790c6b9f9031 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2400,6 +2400,45 @@ static int mkdir_mondata_all(struct kernfs_node *par=
ent_kn,=0A=
 			     struct rdtgroup *prgrp,=0A=
 			     struct kernfs_node **mon_data_kn);=0A=
 =0A=
+void resctrl_add_debug_file(struct kernfs_node *parent_kn, const char *con=
fig,=0A=
+			    unsigned long fflags)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
+	if (rft) {=0A=
+		rft->fflags |=3D fflags;=0A=
+		rdtgroup_add_file(parent_kn, rft);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void resctrl_add_debug_files(void)=0A=
+{=0A=
+	resctrl_add_debug_file(rdtgroup_default.kn, "rmid", RFTYPE_BASE);=0A=
+	resctrl_add_debug_file(rdtgroup_default.kn, "closid", RFTYPE_BASE_CTRL);=
=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+}=0A=
+=0A=
+void resctrl_remove_debug_file(struct kernfs_node *parent_kn,=0A=
+			       const char *config, unsigned long fflags)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
+	if (rft) {=0A=
+		rft->fflags &=3D ~fflags;=0A=
+		kernfs_remove_by_name(parent_kn, config);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void resctrl_remove_debug_files(void)=0A=
+{=0A=
+	resctrl_remove_debug_file(rdtgroup_default.kn, "rmid", RFTYPE_BASE);=0A=
+	resctrl_remove_debug_file(rdtgroup_default.kn, "closid",=0A=
+				  RFTYPE_BASE_CTRL);=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+}=0A=
+=0A=
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)=0A=
 {=0A=
 	int ret =3D 0;=0A=
@@ -2413,8 +2452,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx=
)=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
-	if (!ret && ctx->debug)=0A=
+	if (!ret && ctx->debug) {=0A=
 		resctrl_debug =3D true;=0A=
+		resctrl_add_debug_files();=0A=
+	}=0A=
 =0A=
 	return ret;=0A=
 }=0A=
@@ -2831,6 +2872,11 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
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

