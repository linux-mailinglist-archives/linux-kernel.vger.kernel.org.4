Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D6688934
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBBVsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjBBVrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5366A313;
        Thu,  2 Feb 2023 13:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDMAh42Vp6xpjchYl/prMtl9S2d1bU6nNOcAjIenKP06kh7iqD0X8uABLnUBOz3S1o91GLutYxLL2EM3nk+ayM9PX7EBPCrIEN44EGR6eVZ/wxaJb0xMgqhTMRMWv2fqffQB66+njPrO/FA8pVs9/kQKvHfWHa+9J2sZvznPUT7NE81kfG01scOYh6nYkD96nDLZNFC5/Et5Ki3QGR/bQo2o22CMsvWcWfo603LXcP7czfGekqluQXviftfHqDYNPwc2noCHVfSWhrIkC892yvuRQiI+IpeIaC4/2t3aT3kekB0/Xy+4giNCCnFBe7ZXp4couhV8DSe5E1qiHZhuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lbQnT64KQPvkuOiU+KLSzU7ho039kXH4xuvrICmMgc=;
 b=af0xT8JQaunrZGFcDI8VlW8uyKj8GbMCg/dnEfjj4f1piaaCMEF6aSZwgjGV9MXd+X5kcqtOoiqZFhq6S89T3JNXTygWxDXEHjVOOT1V6TYqKqwwS/a+lwdHoCdMqJ5KyNgzeAR1JEB0XYEyxWBI+Uha0dNT7sYW8vwytA4gBkQwk1D/ShDie+E6gbSEYUQX4zIT2r15E4i3HTo+4pY+I5lPOj7wneCaQcDQXd6NsAH+b97d+etgeVmNBdDWDpd9j3Z2vFilB5BcPKnRVkQ0JcNWdp7kXG9cF5KRkIyUYk7bjnhxa3s8+OgZwBb9ENllEivZZ0ikp4GBSpcN2avSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lbQnT64KQPvkuOiU+KLSzU7ho039kXH4xuvrICmMgc=;
 b=tErftWnYaNo060vGkCtXViR+ThnokInVwUl4T/k7fR0TRGo2Ca1LSKB5oIAqsuTINYMfoIT+ER9GfyNJ4vXDdBm53QBCBywFOYkd0SeRft+7DcvqiMEt2yh2p7L8CemzECTtRL2ykPql2L4H95H1qfFP1HN96+oL48rGIkarDHY=
Received: from MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 21:47:40 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::6e) by MW2PR2101CA0013.outlook.office365.com
 (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.4 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 21:47:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:38 -0600
Subject: [RFC v2 PATCH 7/7] x86/resctrl: Add debug files when mounted with
 debug option
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:37 -0600
Message-ID: <167537445777.647488.12333202522131465679.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb0c058-55f1-4fde-c252-08db05671b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoR4CUaAHVQELfevWWeOF1Z6bU0t9UAL0t/66a4wQjU5lLUwfpfZA0ii6sdF/RR8bIipUVDnGCwVm8kmOPzfh54z99nI88qWO1agZRvZO5etzlG3VOspdUMvosK0zQLz5YYGOYgcGAqOxAOblLAJ1vP3gdehBH2s8dkkqP/0sS+CnyA5imzfrO8Qc74lcKChZb2YXZZDn0CaxMl2h34leJyHdte0DbA++R9eLus5GINZX0HqNkVYnv0ub1ZbOa872anHdEvmwlJmDM23iwmvLfjPG4rFhWAfaPUUvID4715KrAaLv6ikFTwsK1Qkh2ScADGNieL3BHEd800CsjPQnxwMyEzsDeLanzA5Bl0cqZ9FVm7cFsNyBRlQQRPPKCPNetUXkf57/wGFwfFVy4c/Dlzh3GGlBm7IIda3xOrkbp5yrLC1OKA2XBoHjhsxR5/GvpgKD9apr+1g0y5SJMb8JayXzu9ZfTDQziWeD1nIoPfpaJZkFnf7R3228ysiUtC9hsshBePx7yarwuk2WnZGhXm+kVNR7dyrzHWR6ZllE21b9jnm+xcwjCi+yOtz5O9xVRB3JiRIyWE9T4t59cay5IsV2r5Rl7e3QI2eUrDvykSPlCerVlj1mLbhPpbaUzFgIxGFTTfM93zrbdN+bmeXfpsk2tZQZl5ZsCfHb8hUwFtE2W77fhTHqzyON/7Y3A16YvKm9FHWxfkSFZ+pKrJKcS4T+xzuo7P2P1xKHOLesG21g6IH7llO3AAy2U6DizTG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(26005)(82740400003)(103116003)(40460700003)(81166007)(86362001)(40480700001)(36860700001)(336012)(186003)(82310400005)(426003)(356005)(33716001)(47076005)(9686003)(16526019)(478600001)(316002)(54906003)(16576012)(110136005)(70586007)(41300700001)(5660300002)(4326008)(8936002)(7416002)(2906002)(44832011)(8676002)(70206006)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:39.9960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb0c058-55f1-4fde-c252-08db05671b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   27 +++++++++++++++++++++++++++=
=0A=
 1 file changed, 27 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index c35d91b04de6..b7c72b011264 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -2398,6 +2398,31 @@ static int mkdir_mondata_all(struct kernfs_node *par=
ent_kn,=0A=
 			     struct rdtgroup *prgrp,=0A=
 			     struct kernfs_node **mon_data_kn);=0A=
 =0A=
+void resctrl_add_debug_file(struct kernfs_node *parent_kn,=0A=
+			    const char *config, unsigned long fflags,=0A=
+			    bool debug)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
+	if (debug && rft) {=0A=
+		rft->fflags |=3D fflags;=0A=
+		rdtgroup_add_file(parent_kn, rft);=0A=
+	} else if (rft) {=0A=
+		rft->fflags &=3D ~fflags;=0A=
+		kernfs_remove_by_name(parent_kn, config);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void resctrl_add_debug_files(bool debug)=0A=
+{=0A=
+	resctrl_add_debug_file(rdtgroup_default.kn, "rmid",=0A=
+			       RFTYPE_BASE, debug);=0A=
+	resctrl_add_debug_file(rdtgroup_default.kn, "closid",=0A=
+			       RFTYPE_BASE_CTRL, debug);=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+}=0A=
+=0A=
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)=0A=
 {=0A=
 	int ret =3D 0;=0A=
@@ -2411,6 +2436,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
+	resctrl_add_debug_files(ctx->debug);=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
=0A=

