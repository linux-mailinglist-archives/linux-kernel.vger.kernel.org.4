Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60171F290
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjFATCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjFATCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:02:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7CE13E;
        Thu,  1 Jun 2023 12:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB0kH+/h5zfhsRMnWFNZCfpVpdpe3WN9igjZ8+EWjD6haeamK96kdxu6yqbzea+MoUQD2xE2FOeXgZRyR4DxSBL9v7r/OvJDCr5thXYCkx5WZVBxrT3kDFTU9J1HHdbENPaeoiGeuUKkdO9VOMkjpOLaR12spVM8bCNRl5PxePuLZ5tIos/xFK3SnLCStT/idq74nMxmCdMlBzQNhdYIl4vDbbz3YVoGDCk5ggad6I5TCAJlAWOFn9T6hCtI9cEueVPrf52zISVMFStTuBeYtmHM1XieyNN9yikfCe7ouKkf9BIfh3C7LvIPW/iOqt+6bi2HQsIRCBTqMO+dggnS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM+u9qPh9p1d/oY1rC3cLQAN+jtCywVZGoNJo2u42+Q=;
 b=NyCNfYYhpoS2It8t66+VohiUgUdL6YFH2ytdzoYw8LEn8I4x5TeR5uTpfNlPjA1B+wuIJMPFWCCvylkZtz+3201gXxmk4pgWl9KaDkFTyLAIiQUtXjrf6HLO1cA6XyUK9WYc/2MFMRafcVllbEfw/GixN/LEUSN01THlihSDP4xUlm3/EIOnn2O24e2tPCuquuMN4YaoYfvvePyfpNCPzFY6aAsR7N7G2XIJBbwXIM9P1La5LCD44kZRnS6NtNf9N0xGaCRLrKK2Le5B82GXK6u2u6Rl5UT+l4zWritrIgFIhyUh1xUPYmduwUo15R2gpgevmH6VodERrkd7f1Jmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM+u9qPh9p1d/oY1rC3cLQAN+jtCywVZGoNJo2u42+Q=;
 b=DZFBtwZwfAF7wkimePycfQwPhy76tZQPOP5kjhJqFiy0v05pM/TjWXhSAQ9ryumEiNb0LPrdEiSxXEnEZUb2bEAWe4Of6BbPYu1WQG61+XoZVwGHlyRCgudtc2kl/D9+McUr3B8fD4KVXtQv0MIIwSC3k0HWGKJnfTFNrGsep2k=
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 19:01:48 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::c2) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:01:47 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:01:42 -0500
Subject: [PATCH v5 5/8] x86/resctrl: Introduce "-o debug" mount option
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
Date:   Thu, 1 Jun 2023 14:01:40 -0500
Message-ID: <168564610093.527584.3413729327027786408.stgit@bmoger-ubuntu>
In-Reply-To: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c52d751-95b0-4b64-2aee-08db62d2a621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvNK7/yy2hIB8Iob0KMsqRvfxhuIYdnQ9JmcJtLpDoHl+zGq8N8YldUbTmq/CW2xrNkQ2oEy8rAgc1Zx/bD7d46G2ofdxom1we38T9n6F2WM/x/lEB69HWWGkSo8bRa3sFjD2v50qux2F6TmSIJk88/2emYpQ9oihIPe6xYDn6dNIikb2M2GbPhXUrstK39LnkxZ4z+UdgzjQsSVGb1RSnVXjcIkyAVuXiNI9TSl6Zenu/45o9eiO2tBDFD2aLJ3Mr/AYL25ygQ2QA8HsVFFidv4o7ZWsPSPPq6b+5Lf4HjWdwvcfaJHA5Swo+uUbHL6qZ1uXEYloN7i6OFYL+ez6I3wI4itjNwni9xSnuYG7SyTNmvohsZKHkxjnm5kSR/l5H33Iu/EkUyVRrv5mOkUTUFxvWCnW4s/pqoWSYasQdy9wNlvRdjFoxYi74FXhElfjXYgqlfEaIeQSYPPReMF96azneSq/Xf9+f2DM9BtX6zYCfeaei12MYssScxNQGWmmUlcHZKQV+77PldZuaFt2JSBlguPt134SllimYYJRjusx11mo4LFvhezCC6UPFtJbt/QayINRbi5eltk4l7UBkXG2xGllah1g0oIxbJGy6fKXc/8w29vBLMV593HTTFmnam5nNWsHPvxS/pnIxUJp/cvBVkTGxBrLZDIp6HBzGfLbyQlNswYgo6YfCBxDJHNhudeF9PdPquBt9j8PcAoxPb+1pcIybgZ9pGyFFDwq2o1ewIs5+AN1MXqSgvPXSDAjMt5BlLf9l7SqVxrYUp3aWj78a/xB5KCTl/6CPilBEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(36860700001)(356005)(47076005)(83380400001)(33716001)(70206006)(426003)(86362001)(4326008)(70586007)(54906003)(336012)(110136005)(16576012)(82310400005)(103116003)(2906002)(186003)(16526019)(316002)(26005)(9686003)(44832011)(5660300002)(41300700001)(8936002)(7416002)(7406005)(478600001)(8676002)(40480700001)(40460700003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:01:47.2277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c52d751-95b0-4b64-2aee-08db62d2a621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode.=0A=
This option can be used for adding extra files to help debug=0A=
resctrl issues.=0A=
=0A=
For example, hardware uses CLOSID and RMIDs to control and monitor=0A=
resctrl resources. These numbers are not visible to the user. These=0A=
details can help to debug issues. Debug option provides a method to=0A=
add these files to resctrl.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    3 +++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   15 +++++++++++++++=0A=
 3 files changed, 19 insertions(+)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index 290f01aa3002..afdee4d1f691 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -46,6 +46,9 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Make debug files accessible. Available debug files are annotated with=0A=
+	"Available only with debug option".=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c20cd6acb7a3..c07c6517d856 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				enable_debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index baed20b2d788..be91dea5f927 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];=0A=
 =0A=
 struct dentry *debugfs_resctrl;=0A=
 =0A=
+static bool resctrl_debug;=0A=
+=0A=
 void rdt_last_cmd_clear(void)=0A=
 {=0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
@@ -2368,6 +2370,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
+	if (!ret && ctx->enable_debug)=0A=
+		resctrl_debug =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2556,6 +2561,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2563,6 +2569,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2588,6 +2595,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->enable_debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -2778,6 +2788,8 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 =0A=
 	set_mba_sc(false);=0A=
 =0A=
+	resctrl_debug =3D false;=0A=
+=0A=
 	/*Put everything back to default values. */=0A=
 	for_each_alloc_capable_rdt_resource(r)=0A=
 		reset_all_ctrls(r);=0A=
@@ -3530,6 +3542,9 @@ static int rdtgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf)=0A=
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))=0A=
 		seq_puts(seq, ",mba_MBps");=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		seq_puts(seq, ",debug");=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
=0A=

